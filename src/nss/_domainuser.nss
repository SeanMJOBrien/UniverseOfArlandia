#include "aps_include"
#include "_module"
// _domainuser - per-structure access grants inside someone else's domain
// (TASK-35).
//
// A domain is a world coordinate with up to 10 structure slots (domains.nss:99)
// whose Interests record carries a Master - the owner's character name. This
// lets that owner grant another character the use of INDIVIDUAL structures,
// managed from the domain's own sign rather than from a bank.
//
// Granularity is per slot. Slot 0 is the domain-wide grant: a character on the
// slot 0 list may use every structure, which is the "approved user of the whole
// domain" case without needing ten separate writes.
//
// A grant lets its holder USE a structure - collect an extractor's output, hire
// at a caserne, rent and decorate a house. It never confers building or
// destroying, anywhere. That split is not enforced in this file: it lives in
// which dialog replies carry which condition script (see TASK-35).
//
// Storage: one pwdata row per (domain, slot), holding an &-wrapped list of
// character names, e.g. "&Alice&Bob&". Names are matched with their delimiters
// attached so "Al" never matches "Alice".
//
// Character NAME is the identifier because that is what the domain system
// already keys on everywhere (Master strings, cond_domain004/005/019). It
// inherits that scheme's fragility - see TASK-33 - and if domain ownership ever
// moves to a stable id, these lists must move in the same change. The one place
// a name is not enough is the same-account shortcut, which compares accounts
// rather than characters and so uses the public CD key (the identifier
// _webmap.nss already indexes characters under).

const int DOMAINUSER_ALL_SLOTS = 0;   // slot 0 == every structure in the domain
const int DOMAINUSER_MAX_SLOT  = 10;  // domains.nss:99

const string DOMAINUSER_SEP = "&";

// pwdata key for one (domain, slot) grant list. iSlot 0 is the domain-wide list.
string DomainUsersKey(string sPlanet, string sArea, int iSlot)
{
    return sPlanet + "&" + sArea + "&DomainUsers&" + IntToString(iSlot);
}

// The raw &-wrapped list for one slot, or "" when nobody is granted.
string DomainUsersList(string sPlanet, string sArea, int iSlot)
{
    return GetPersistentString(GetModule(), DomainUsersKey(sPlanet, sArea, iSlot));
}

// Is sName granted this exact slot? Does NOT consider the domain-wide list -
// use DomainIsApprovedName for the question callers normally mean.
int DomainIsGrantedSlot(string sName, string sPlanet, string sArea, int iSlot)
{
    if (sName == "") { return FALSE; }
    string sList = DomainUsersList(sPlanet, sArea, iSlot);
    if (sList == "") { return FALSE; }
    return (FindSubString(sList, DOMAINUSER_SEP + sName + DOMAINUSER_SEP) != -1);
}

// Is sName allowed to use this slot - either granted it directly, or holding a
// domain-wide grant?
int DomainIsApprovedName(string sName, string sPlanet, string sArea, int iSlot)
{
    if (DomainIsGrantedSlot(sName, sPlanet, sArea, DOMAINUSER_ALL_SLOTS)) { return TRUE; }
    if (iSlot == DOMAINUSER_ALL_SLOTS) { return FALSE; }
    return DomainIsGrantedSlot(sName, sPlanet, sArea, iSlot);
}

// Grant a character one slot (or the whole domain with iSlot 0). No-op if the
// grant already exists.
void DomainAddUser(string sName, string sPlanet, string sArea, int iSlot)
{
    if (sName == "") { return; }
    if (DomainIsGrantedSlot(sName, sPlanet, sArea, iSlot)) { return; }
    string sList = DomainUsersList(sPlanet, sArea, iSlot);
    if (sList == "") { sList = DOMAINUSER_SEP; }
    SetPersistentString(GetModule(), DomainUsersKey(sPlanet, sArea, iSlot), sList + sName + DOMAINUSER_SEP);
}

// Revoke one slot's grant from a character.
void DomainRemoveUser(string sName, string sPlanet, string sArea, int iSlot)
{
    if (!DomainIsGrantedSlot(sName, sPlanet, sArea, iSlot)) { return; }
    string sList = DomainUsersList(sPlanet, sArea, iSlot);
    string sCut = DOMAINUSER_SEP + sName + DOMAINUSER_SEP;
    int iAt = FindSubString(sList, sCut);
    string sLeft = GetStringLeft(sList, iAt);
    string sRight = GetStringRight(sList, GetStringLength(sList) - iAt - GetStringLength(sCut));
    string sNew = sLeft + DOMAINUSER_SEP + sRight;
    if (sNew == DOMAINUSER_SEP) { sNew = ""; }
    SetPersistentString(GetModule(), DomainUsersKey(sPlanet, sArea, iSlot), sNew);
}

// Revoke every grant this character holds in the domain, slot 0 included.
void DomainRemoveUserAll(string sName, string sPlanet, string sArea)
{
    int iSlot;
    for (iSlot = DOMAINUSER_ALL_SLOTS; iSlot <= DOMAINUSER_MAX_SLOT; iSlot++)
    {
        DomainRemoveUser(sName, sPlanet, sArea, iSlot);
    }
}

// Wipe every grant on one slot. Called whenever a slot is built or destroyed:
// a grant is permission to use a specific structure, so it must not survive
// that structure being replaced by a different one, or torn down and put back.
// Otherwise a character granted use of an Extractor silently keeps access when
// the owner rebuilds the slot as a Caserne.
void DomainClearSlot(string sPlanet, string sArea, int iSlot)
{
    if (iSlot == DOMAINUSER_ALL_SLOTS) { return; }   // never wipe the domain-wide list from a slot change
    DeletePersistentVariable(GetModule(), DomainUsersKey(sPlanet, sArea, iSlot));
}

// Wipe every grant in the domain, the domain-wide list included. For the
// domain being destroyed outright, not a single slot being rebuilt.
void DomainClearAllGrants(string sPlanet, string sArea)
{
    int iSlot;
    for (iSlot = DOMAINUSER_ALL_SLOTS; iSlot <= DOMAINUSER_MAX_SLOT; iSlot++)
    {
        DeletePersistentVariable(GetModule(), DomainUsersKey(sPlanet, sArea, iSlot));
    }
}

// The domain coordinate an area belongs to. Inside a structure interior,
// transitions2.nss stores the outer world coordinate as "AreaExit" while
// "Area" carries the interior's own suffixed key, so prefer AreaExit and fall
// back to Area for the outdoor domain tile itself.
string DomainAreaOf(object oArea)
{
    string sExit = GetLocalString(oArea, "AreaExit");
    if (sExit != "") { return sExit; }
    return GetLocalString(oArea, "Area");
}

// Two PCs are on the same account when they share a public CD key. This is what
// lets a player approve their own alt without a second person online: they are
// literally both sides of the transaction.
int DomainSameAccount(object oPC1, object oPC2)
{
    if ((!GetIsObjectValid(oPC1)) || (!GetIsObjectValid(oPC2))) { return FALSE; }
    string sKey1 = GetPCPublicCDKey(oPC1);
    if (sKey1 == "") { return FALSE; }
    return (sKey1 == GetPCPublicCDKey(oPC2));
}

// May oPC use (not build in) this slot? True for the owner, for a holder of
// either this slot's grant or the domain-wide one, and for DMs.
//
// sMaster is the domain's owner name, as already read from the placeable's
// "Master" local or the Interests record by the calling condition script.
int DomainCanUse(object oPC, string sPlanet, string sArea, int iSlot, string sMaster)
{
    if (!GetIsObjectValid(oPC)) { return FALSE; }
    if (GetIsDM(oPC) || GetIsDMPossessed(oPC)) { return TRUE; }
    string sName = GetName(oPC);
    if ((sMaster != "") && (sMaster == sName)) { return TRUE; }
    return DomainIsApprovedName(sName, sPlanet, sArea, iSlot);
}

// The whole check in one call, for a condition script standing on a sign or
// structure flag: every input is read off the placeable itself.
int DomainCanUseHere(object oPC, object oPlaceable)
{
    object oArea = GetArea(oPlaceable);
    return DomainCanUse(oPC,
                        GetLocalString(oArea, "Planet"),
                        DomainAreaOf(oArea),
                        GetLocalInt(oPlaceable, "Slot"),
                        GetLocalString(oPlaceable, "Master"));
}

// May oPC build or destroy in this domain? Owner and DMs only, ever - an
// approved user never gains construction rights, here or anywhere else.
// Kept as its own function so the distinction is explicit at every call site
// rather than implied by which flavour of name compare someone wrote.
int DomainCanBuild(object oPC, string sMaster)
{
    if (!GetIsObjectValid(oPC)) { return FALSE; }
    if (GetIsDM(oPC) || GetIsDMPossessed(oPC)) { return TRUE; }
    return ((sMaster != "") && (sMaster == GetName(oPC)));
}

// ---------------------------------------------------------------------------
// Rental limit
//
// A character may rent at most one house at a time (iDomainOneRental). Nothing
// enforced this before: cond_domain018 only checked that the SLOT was free, so
// one character could rent every unrented house in every domain at once.
//
// The tenancy itself stays where it always lived - the renter's name in pwdata
// at "<planet>&<area>&Domain&<slot>", written by conv_domain008.nss. What is
// added here is a back-pointer on the renter's goldbag so we can answer "does
// this character already rent somewhere?" without scanning every domain in the
// galaxy, which there is no index for.
//
// That back-pointer is a HINT, never the authority. An owner can destroy the
// house, or the whole domain, from a script that has no access to the tenant's
// goldbag - so the marker is verified against the pwdata tenancy on every read
// and silently cleared when it no longer holds. Without that self-healing, a
// tenant whose house was demolished would be locked out of renting forever.
// ---------------------------------------------------------------------------

// Which kind of tenancy the back-pointer describes: absent/0 a domain house
// slot, 1 a multi-unit rental door (_unitrent.nss). Units store their whole
// pwdata key, so verifying one needs no knowledge of that file's layout and
// the include stays one-directional.
const string DOMAINRENT_KIND   = "RentedKind";
const string DOMAINRENT_UKEY   = "RentedUnitKey";
const string DOMAINRENT_PLANET = "RentedPlanet";
const string DOMAINRENT_AREA   = "RentedArea";
const string DOMAINRENT_SLOT   = "RentedSlot";

// Who pwdata says is renting this slot ("" when nobody is).
string DomainSlotTenant(string sPlanet, string sArea, int iSlot)
{
    return GetPersistentString(GetModule(), sPlanet + "&" + sArea + "&Domain&" + IntToString(iSlot));
}

// Record a rental-unit tenancy, keyed by the full pwdata key of the unit.
void DomainSetRentedUnit(object oPC, string sUnitKey)
{
    object oBag = GetItemPossessedBy(oPC, "goldbag");
    if (!GetIsObjectValid(oBag)) { return; }
    SetLocalInt(oBag, DOMAINRENT_KIND, 1);
    SetLocalString(oBag, DOMAINRENT_UKEY, sUnitKey);
}

// Record oPC's tenancy. Called right where conv_domain008.nss takes the rent.
void DomainSetRented(object oPC, string sPlanet, string sArea, int iSlot)
{
    object oBag = GetItemPossessedBy(oPC, "goldbag");
    if (!GetIsObjectValid(oBag)) { return; }
    SetLocalInt(oBag, DOMAINRENT_KIND, 0);
    SetLocalString(oBag, DOMAINRENT_PLANET, sPlanet);
    SetLocalString(oBag, DOMAINRENT_AREA, sArea);
    SetLocalInt(oBag, DOMAINRENT_SLOT, iSlot);
}

// Forget oPC's tenancy (they moved out, or the marker went stale).
void DomainClearRented(object oPC)
{
    object oBag = GetItemPossessedBy(oPC, "goldbag");
    if (!GetIsObjectValid(oBag)) { return; }
    DeleteLocalString(oBag, DOMAINRENT_PLANET);
    DeleteLocalString(oBag, DOMAINRENT_AREA);
    DeleteLocalInt(oBag, DOMAINRENT_SLOT);
    DeleteLocalInt(oBag, DOMAINRENT_KIND);
    DeleteLocalString(oBag, DOMAINRENT_UKEY);
}

// Does oPC currently rent a house that still exists and still names them as its
// tenant? Clears the marker and returns FALSE when it has gone stale.
int DomainHasRental(object oPC)
{
    object oBag = GetItemPossessedBy(oPC, "goldbag");
    if (!GetIsObjectValid(oBag)) { return FALSE; }
    if (GetLocalInt(oBag, DOMAINRENT_KIND) == 1)
    {
        string sUKey = GetLocalString(oBag, DOMAINRENT_UKEY);
        if (sUKey == "") { return FALSE; }
        if (GetPersistentString(GetModule(), sUKey) == GetName(oPC)) { return TRUE; }
        DomainClearRented(oPC);   // unit gone, or tenancy ended elsewhere
        return FALSE;
    }

    string sPlanet = GetLocalString(oBag, DOMAINRENT_PLANET);
    string sArea = GetLocalString(oBag, DOMAINRENT_AREA);
    if ((sPlanet == "") || (sArea == "")) { return FALSE; }

    if (DomainSlotTenant(sPlanet, sArea, GetLocalInt(oBag, DOMAINRENT_SLOT)) == GetName(oPC)) { return TRUE; }

    DomainClearRented(oPC);   // house gone, or tenancy ended elsewhere
    return FALSE;
}

// May oPC take on a new tenancy? False only when the one-rental rule is on and
// they already hold a live one.
int DomainMayRent(object oPC)
{
    if (iDomainOneRental != 1) { return TRUE; }
    return (!DomainHasRental(oPC));
}

// ---------------------------------------------------------------------------
// Rent expiry clock
//
// Rent used to live ONLY on the tenant's goldbag as a decrementing tick count
// (conv_domain008.nss wrote 17280, domain_content.nss subtracted elapsed
// heartbeats, 576 ticks per day = 30 days). Two problems with that: nobody
// except the tenant could read it - not the owner, not a would-be renter, not
// the door - and the heartbeat counter it measured against is a module local
// that resets on every reboot, which mod_heartbeat.nss:30 schedules routinely.
//
// The tenancy now carries an absolute expiry DAY in pwdata beside the tenant's
// name, read off the game calendar. The calendar is saved at reboot and
// restored in mod_load.nss:37-42, so it is monotonic across restarts and
// readable by anyone.
// ---------------------------------------------------------------------------

// Absolute game-day number. NWN months are 12 per year, 28 days per month.
int DomainGameDay()
{
    return (((GetCalendarYear() * 12) + (GetCalendarMonth() - 1)) * 28) + GetCalendarDay();
}

// pwdata key for a tenancy's expiry day.
string DomainRentUntilKey(string sPlanet, string sArea, int iSlot)
{
    return sPlanet + "&" + sArea + "&Domain&" + IntToString(iSlot) + "Until";
}

// The day this tenancy runs out. Returns 0 when the slot has no expiry recorded.
int DomainRentUntil(string sPlanet, string sArea, int iSlot)
{
    return GetPersistentInt(GetModule(), DomainRentUntilKey(sPlanet, sArea, iSlot));
}

// Push the expiry out by iDays, from today or from the existing expiry,
// whichever is later - so paying early adds time rather than losing it.
void DomainRentExtend(string sPlanet, string sArea, int iSlot, int iDays)
{
    int iFrom = DomainRentUntil(sPlanet, sArea, iSlot);
    int iToday = DomainGameDay();
    if (iFrom < iToday) { iFrom = iToday; }
    SetPersistentInt(GetModule(), DomainRentUntilKey(sPlanet, sArea, iSlot), iFrom + iDays);
}

// Forget a tenancy's expiry (tenant moved out, slot destroyed).
void DomainRentClear(string sPlanet, string sArea, int iSlot)
{
    DeletePersistentVariable(GetModule(), DomainRentUntilKey(sPlanet, sArea, iSlot));
}

// Days of rent left, negative once overdue. Tenancies predating this clock have
// no expiry recorded, so they are seeded with a full term on first read rather
// than being treated as instantly overdue.
int DomainRentDaysLeft(string sPlanet, string sArea, int iSlot)
{
    if (DomainSlotTenant(sPlanet, sArea, iSlot) == "") { return 0; }
    int iUntil = DomainRentUntil(sPlanet, sArea, iSlot);
    if (iUntil <= 0)
    {
        DomainRentExtend(sPlanet, sArea, iSlot, iDomainRentDays);
        iUntil = DomainRentUntil(sPlanet, sArea, iSlot);
    }
    return iUntil - DomainGameDay();
}

// Is this slot rented but overdue?
int DomainRentExpired(string sPlanet, string sArea, int iSlot)
{
    if (DomainSlotTenant(sPlanet, sArea, iSlot) == "") { return FALSE; }
    return (DomainRentDaysLeft(sPlanet, sArea, iSlot) < 0);
}
