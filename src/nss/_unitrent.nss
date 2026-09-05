#include "nw_inc_nui"
#include "_domainuser"
// _unitrent - multi-unit rental doors (TASK-38).
//
// A door in a hand-built area can host several rental units. Using it opens a
// list of every unit: who rents it, or "VACANT: <size>". Picking a vacant one
// offers to rent it.
//
// DM configuration, as local variables on the door placeable (the same way
// spawngrab takes its GrpName):
//   int "Units"    - how many units this door serves (1..UNITRENT_MAX)
//   int "Unit<n>"  - size of unit n: 1 small, 2 medium, 3 large. Absent = 1.
//
// Sizes map onto the three home templates ported from tfndev, which differ in
// both rent and interior: slum 2x2, norm 4x2, rich 3x5 over three floors. Each
// rented unit gets its OWN area via CreateArea(), so units never contend for
// the two-instance h_house_/h_home pools that cap ordinary house occupancy.
//
// Keys are built from the AREA TAG plus the door's own position, not from
// Planet/Area: those locals belong to the coordinate travel system and are
// empty in the hand-built areas these doors are meant for.

const int UNITRENT_MAX = 12;   // NUI has no reply-slot limit; this is just a sanity bound

const string UNITRENT_WINDOW = "unitrent";
const string UNITRENT_EVENT  = "unitrent_event";
const string UNITRENT_DOOR   = "UnitRentDoor";   // PC local: door whose list is open
const string UNITRENT_PICK   = "UnitRentPick";   // PC local: unit being confirmed

// ---------------------------------------------------------------------------
// Identity and configuration
// ---------------------------------------------------------------------------

// Stable per-door key fragment: area tag + integer door position.
string UnitDoorKey(object oDoor)
{
    object oArea = GetArea(oDoor);
    vector v = GetPosition(oDoor);
    return GetTag(oArea) + "&Unit&" + IntToString(FloatToInt(v.x)) + "_" + IntToString(FloatToInt(v.y));
}

// pwdata key for one unit's tenant.
string UnitTenantKey(object oDoor, int iUnit)
{
    return UnitDoorKey(oDoor) + "&" + IntToString(iUnit);
}

int UnitCount(object oDoor)
{
    int iUnits = GetLocalInt(oDoor, "Units");
    if (iUnits < 1) { return 0; }
    if (iUnits > UNITRENT_MAX) { iUnits = UNITRENT_MAX; }
    return iUnits;
}

// Size of unit n: 1 small, 2 medium, 3 large. Anything unset or out of range
// reads as small, so a DM who sets only "Units" gets a building of small units
// rather than a broken door.
int UnitSize(object oDoor, int iUnit)
{
    int iSize = GetLocalInt(oDoor, "Unit" + IntToString(iUnit));
    if ((iSize < 1) || (iSize > 3)) { iSize = 1; }
    return iSize;
}

string UnitSizeLabel(int iSize)
{
    if (iSize == 3) { return "Large unit"; }
    if (iSize == 2) { return "Medium unit"; }
    return "Small unit";
}

// Home template tier for a size, matching the ported tfndev area names.
string UnitSizeTier(int iSize)
{
    if (iSize == 3) { return "rich"; }
    if (iSize == 2) { return "norm"; }
    return "slum";
}

int UnitSizePrice(int iSize)
{
    if (iSize == 3) { return iUnitRentLarge; }
    if (iSize == 2) { return iUnitRentMedium; }
    return iUnitRentSmall;
}

// ---------------------------------------------------------------------------
// Tenancy
// ---------------------------------------------------------------------------

string UnitTenant(object oDoor, int iUnit)
{
    return GetPersistentString(GetModule(), UnitTenantKey(oDoor, iUnit));
}

// The area tag of a unit's instanced interior, "" until it is first entered.
string UnitAreaTag(object oDoor, int iUnit)
{
    return GetPersistentString(GetModule(), UnitTenantKey(oDoor, iUnit) + "Area");
}

// Days of rent left on a unit, negative once overdue. Uses the same absolute
// game-day clock as domain house rent (see _domainuser.nss), so it is readable
// by anyone and survives reboots.
int UnitDaysLeft(object oDoor, int iUnit)
{
    if (UnitTenant(oDoor, iUnit) == "") { return 0; }
    string sKey = UnitTenantKey(oDoor, iUnit) + "Until";
    int iUntil = GetPersistentInt(GetModule(), sKey);
    if (iUntil <= 0)
    {
        iUntil = DomainGameDay() + iDomainRentDays;
        SetPersistentInt(GetModule(), sKey, iUntil);
    }
    return iUntil - DomainGameDay();
}

// Give a unit to oPC and start its rent clock.
void UnitSetTenant(object oDoor, int iUnit, object oPC)
{
    object oModule = GetModule();
    string sKey = UnitTenantKey(oDoor, iUnit);
    SetPersistentString(oModule, sKey, GetName(oPC));
    SetPersistentInt(oModule, sKey + "Until", DomainGameDay() + iDomainRentDays);
}

// Release a unit. The instanced interior is deliberately NOT destroyed here -
// anything inside belongs to the outgoing tenant, and player storage chests
// are account-scoped anyway (see _pcstorage.nss), so nothing of value is
// stranded by leaving the shell standing.
void UnitClearTenant(object oDoor, int iUnit)
{
    object oModule = GetModule();
    string sKey = UnitTenantKey(oDoor, iUnit);
    DeletePersistentVariable(oModule, sKey);
    DeletePersistentVariable(oModule, sKey + "Until");
}

// ---------------------------------------------------------------------------
// Interior instancing
// ---------------------------------------------------------------------------

// NWScript has no "find an object by tag INSIDE this area" call, and the
// module-wide GetObjectByTag would return whichever instance it saw first -
// fatal here, since every unit interior carries the same internal door tags.
object GetObjectInAreaByTag(object oArea, string sTag)
{
    object oObj = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oObj))
    {
        if (GetTag(oObj) == sTag) { return oObj; }
        oObj = GetNextObjectInArea(oArea);
    }
    return OBJECT_INVALID;
}

// The tfndev home templates come in four door facings so the interior's own
// door lines up with the one you walked through. Same orientation bands TFN
// uses, defaulting to north rather than failing if a door sits off-axis.
string UnitFacingFor(object oDoor)
{
    float fF = GetFacing(oDoor);
    if ((fF > 85.0) && (fF < 95.0))   { return "south"; }
    if ((fF > 175.0) && (fF < 185.0)) { return "east"; }
    if ((fF > 265.0) && (fF < 275.0)) { return "north"; }
    if ((fF < 5.0) || (fF > 355.0))   { return "west"; }
    return "north";
}

// Deterministic tag for a unit's interior, so the same unit resolves to the
// same tag after a reboot without storing a counter.
string UnitInteriorTag(object oDoor, int iUnit)
{
    vector v = GetPosition(oDoor);
    return "U" + GetStringLeft(GetTag(GetArea(oDoor)), 8)
         + IntToString(FloatToInt(v.x)) + "_" + IntToString(FloatToInt(v.y))
         + "_" + IntToString(iUnit);
}

// Prepare a freshly instanced interior:
//  - link its internal staircase doors to each other (norm has two floors,
//    rich three; unlinked they lead nowhere), and
//  - turn its front door into the way out, by retagging it "door_exit" and
//    pointing its OnClick at transitions2. That script's existing exit branch
//    then reads the AreaExit/AreaExitObj/fXExit/fYExit locals set above, so no
//    new exit code is needed and no floating exit marker has to be added
//    indoors.
void UnitWireInterior(object oArea)
{
    object oUp1 = GetObjectInAreaByTag(oArea, "level1_to_level2");
    object oDn2 = GetObjectInAreaByTag(oArea, "level2_to_level1");
    object oUp2 = GetObjectInAreaByTag(oArea, "level2_to_level3");
    object oDn3 = GetObjectInAreaByTag(oArea, "level3_to_level2");
    if (GetIsObjectValid(oUp1) && GetIsObjectValid(oDn2))
    {
        SetTransitionTarget(oUp1, oDn2);
        SetTransitionTarget(oDn2, oUp1);
    }
    if (GetIsObjectValid(oUp2) && GetIsObjectValid(oDn3))
    {
        SetTransitionTarget(oUp2, oDn3);
        SetTransitionTarget(oDn3, oUp2);
    }

    object oFront = GetObjectInAreaByTag(oArea, "interior_door");
    if (GetIsObjectValid(oFront))
    {
        SetTag(oFront, "door_exit");
        SetEventScript(oFront, EVENT_SCRIPT_DOOR_ON_CLICKED, "transitions2");
    }
}

// The live interior for a unit, instancing it on first use. CreateArea() areas
// do NOT survive a server restart, so this recreates from the template using
// the same deterministic tag - the shell comes back, its loose contents do
// not. Player storage is account-scoped (_pcstorage.nss) and unaffected.
object UnitInterior(object oDoor, int iUnit)
{
    string sTag = UnitInteriorTag(oDoor, iUnit);
    object oArea = GetObjectByTag(sTag);
    if (GetIsObjectValid(oArea)) { return oArea; }

    string sRes = "_home" + UnitSizeTier(UnitSize(oDoor, iUnit)) + "_" + UnitFacingFor(oDoor);
    oArea = CreateArea(sRes, sTag, GetName(oDoor));
    if (!GetIsObjectValid(oArea)) { return OBJECT_INVALID; }

    // The tenant is this interior's Master: that is what chestplay_used.nss and
    // mod_unacquire.nss both check before allowing storage or furniture.
    SetLocalString(oArea, "Master", UnitTenant(oDoor, iUnit));
    SetLocalString(oArea, "AreaExit", GetTag(GetArea(oDoor)));
    SetLocalObject(oArea, "AreaExitObj", GetArea(oDoor));
    SetLocalFloat(oArea, "fXExit", GetPosition(oDoor).x);
    SetLocalFloat(oArea, "fYExit", GetPosition(oDoor).y - 1.0);
    SetPersistentString(GetModule(), UnitTenantKey(oDoor, iUnit) + "Area", sTag);
    UnitWireInterior(oArea);
    return oArea;
}

// Move oPC into their unit.
void UnitEnter(object oPC, object oDoor, int iUnit)
{
    object oArea = UnitInterior(oDoor, iUnit);
    if (!GetIsObjectValid(oArea))
    {
        FloatingTextStringOnCreature("That unit cannot be opened right now.", oPC, FALSE);
        return;
    }
    SetLocalString(oArea, "Master", UnitTenant(oDoor, iUnit));   // refresh after a re-let
    object oWP = GetFirstObjectInArea(oArea);
    location lDest = GetIsObjectValid(oWP) ? GetLocation(oWP) : Location(oArea, Vector(2.0, 2.0, 0.0), 0.0);
    SetLocalString(oPC, "PlayerAreaTo", GetTag(oArea));
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionJumpToLocation(lDest));
}

// ---------------------------------------------------------------------------
// The unit list window
// ---------------------------------------------------------------------------

// One row: "3. Amber Rose" for a let unit, "5. VACANT: Large unit" for a free
// one. The tenant's own row is marked so they can find their door at a glance.
json UnitRentRow(object oPC, object oDoor, int iUnit)
{
    string sTenant = UnitTenant(oDoor, iUnit);
    int iSize = UnitSize(oDoor, iUnit);
    int iMine = (sTenant != "") && (sTenant == GetName(oPC));
    string sLabel;

    if (sTenant == "")      { sLabel = IntToString(iUnit) + ". VACANT: " + UnitSizeLabel(iSize); }
    else if (iMine)         { sLabel = IntToString(iUnit) + ". " + sTenant + "  (yours, " + IntToString(UnitDaysLeft(oDoor, iUnit)) + "d)"; }
    else                    { sLabel = IntToString(iUnit) + ". " + sTenant; }

    json jRow = JsonArray();
    jRow = JsonArrayInsert(jRow, NuiHeight(NuiWidth(NuiLabel(JsonString(sLabel), JsonInt(NUI_HALIGN_LEFT), JsonInt(NUI_VALIGN_MIDDLE)), 240.0), 30.0));

    if (sTenant == "")
    {
        jRow = JsonArrayInsert(jRow, NuiHeight(NuiWidth(NuiId(NuiButton(JsonString("Rent " + IntToString(UnitSizePrice(iSize)) + "gp")), "u_" + IntToString(iUnit)), 190.0), 30.0));
    }
    else if (iMine)
    {
        jRow = JsonArrayInsert(jRow, NuiHeight(NuiWidth(NuiId(NuiButton(JsonString("Enter")), "e_" + IntToString(iUnit)), 62.0), 30.0));
        jRow = JsonArrayInsert(jRow, NuiHeight(NuiWidth(NuiId(NuiButton(JsonString("Pay")),   "p_" + IntToString(iUnit)), 62.0), 30.0));
        jRow = JsonArrayInsert(jRow, NuiHeight(NuiWidth(NuiId(NuiButton(JsonString("Leave")), "l_" + IntToString(iUnit)), 62.0), 30.0));
    }
    else
    {
        jRow = JsonArrayInsert(jRow, NuiHeight(NuiWidth(NuiSpacer(), 190.0), 30.0));
    }
    return NuiRow(jRow);
}

json UnitRentPage(object oPC)
{
    object oDoor = GetLocalObject(oPC, UNITRENT_DOOR);
    int iUnits = UnitCount(oDoor);
    int iVacant;
    int n;
    for (n = 1; n <= iUnits; n++) { if (UnitTenant(oDoor, n) == "") { iVacant++; } }

    string sHead = IntToString(iUnits) + " units";
    if (iVacant == 1)      { sHead = sHead + ", 1 for rent"; }
    else if (iVacant > 1)  { sHead = sHead + ", " + IntToString(iVacant) + " for rent"; }
    else                   { sHead = sHead + ", none for rent"; }

    json jList = JsonArray();
    jList = JsonArrayInsert(jList, NuiHeight(NuiWidth(NuiLabel(JsonString(sHead), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_MIDDLE)), 430.0), 30.0));
    for (n = 1; n <= iUnits; n++) { jList = JsonArrayInsert(jList, UnitRentRow(oPC, oDoor, n)); }
    return NuiCol(jList);
}

void UnitRentOpen(object oPC, object oDoor)
{
    if (UnitCount(oDoor) < 1)
    {
        FloatingTextStringOnCreature("This door has no rental units configured.", oPC, FALSE);
        return;
    }
    SetLocalObject(oPC, UNITRENT_DOOR, oDoor);
    json jWin = NuiWindow(UnitRentPage(oPC), JsonString(GetName(GetArea(oDoor))), NuiRect(-1.0, -1.0, 470.0, 440.0), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE));
    NuiCreate(oPC, jWin, UNITRENT_WINDOW, UNITRENT_EVENT);
}

// Take a vacant unit. Refuses if it was let in the meantime, if the character
// already has a home (the shared one-home cap, iDomainOneRental), or if they
// cannot pay.
int UnitRentTake(object oPC, object oDoor, int iUnit)
{
    if (UnitTenant(oDoor, iUnit) != "")
    {
        FloatingTextStringOnCreature("That unit has just been taken.", oPC, FALSE);
        return FALSE;
    }
    if (!DomainMayRent(oPC))
    {
        FloatingTextStringOnCreature("You already have a home. Give it up before renting another.", oPC, FALSE);
        return FALSE;
    }
    int iPrice = UnitSizePrice(UnitSize(oDoor, iUnit));
    if (GetGold(oPC) < iPrice)
    {
        FloatingTextStringOnCreature("You cannot afford that unit (" + IntToString(iPrice) + " gp).", oPC, FALSE);
        return FALSE;
    }

    TakeGoldFromCreature(iPrice, oPC, TRUE);
    UnitSetTenant(oDoor, iUnit, oPC);
    DomainSetRentedUnit(oPC, UnitTenantKey(oDoor, iUnit));
    FloatingTextStringOnCreature("You rent unit " + IntToString(iUnit) + " for " + IntToString(iDomainRentDays) + " days.", oPC, FALSE);
    return TRUE;
}

// Extend a tenancy by one term, at the unit's own price.
int UnitRentPay(object oPC, object oDoor, int iUnit)
{
    if (UnitTenant(oDoor, iUnit) != GetName(oPC)) { return FALSE; }
    int iPrice = UnitSizePrice(UnitSize(oDoor, iUnit));
    if (GetGold(oPC) < iPrice)
    {
        FloatingTextStringOnCreature("You cannot afford the rent (" + IntToString(iPrice) + " gp).", oPC, FALSE);
        return FALSE;
    }
    TakeGoldFromCreature(iPrice, oPC, TRUE);

    // Extend from the later of today and the current expiry, so paying early
    // adds a term rather than throwing the remainder away.
    object oModule = GetModule();
    string sKey = UnitTenantKey(oDoor, iUnit) + "Until";
    int iFrom = GetPersistentInt(oModule, sKey);
    int iToday = DomainGameDay();
    if (iFrom < iToday) { iFrom = iToday; }
    SetPersistentInt(oModule, sKey, iFrom + iDomainRentDays);

    FloatingTextStringOnCreature("Rent paid. " + IntToString(UnitDaysLeft(oDoor, iUnit)) + " days remaining.", oPC, FALSE);
    return TRUE;
}

// Give up a unit, freeing it for someone else and freeing this character's
// single home slot. The interior shell is left standing; nothing of value is
// in it, since player storage is account-scoped.
int UnitRentLeave(object oPC, object oDoor, int iUnit)
{
    if (UnitTenant(oDoor, iUnit) != GetName(oPC)) { return FALSE; }
    UnitClearTenant(oDoor, iUnit);
    DomainClearRented(oPC);
    FloatingTextStringOnCreature("You give up unit " + IntToString(iUnit) + ".", oPC, FALSE);
    return TRUE;
}
