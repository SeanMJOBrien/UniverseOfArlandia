#include "nw_inc_nui"
#include "aps_include"
#include "_module"
#include "_string_utils"
#include "inc_flight"   // FLIGHT_OWNER / FLIGHT_CABIN / FlightWaypointIn
// _spacenav - personal starship navigation (TASK-41).
//
// Two ways to travel in your own ship:
//
//   Manual flight - the pilot is the ship (appearance 338, set by
//   area_enter.nss) and flies for real, tile by tile, walking into the
//   "newtransition" edge trigger that faces the destination and letting the
//   existing transition carry them across. The leg is re-issued on arrival in
//   each new tile. The pilot interrupts simply by moving: that clears the
//   action queue, and SpaceFlyStep declines to issue the next leg.
//
//   Deck travel - the pilot leaves space for the cabin and the whole party
//   waits out a timed passage, exactly as ticketed starships already work
//   (iStarshipSec seconds per area crossed, counted in heartbeats). This is
//   also what happens when the owner dies: they are moved to the deck, and a
//   passenger may choose the destination.
//
// "Visited" is recorded PER CHARACTER and only for the player's own ship.
// Commercial flights land in the starship interior areas, never in a space
// tile, so simply arriving in a space area is proof of personal flight and no
// extra flag is needed to tell the two apart.
//
// The visit record lives on the goldbag rather than in pwdata keyed by
// character name. The goldbag is an item that travels with the character file,
// so this is genuinely per-character and sidesteps the name-as-database-key
// fragility documented in TASK-33.

const string SPACENAV_SEEN     = "SpaceSeen_";      // goldbag int, one per visited coordinate
const string SPACENAV_FLY_TO   = "SpaceFlyTo";      // PC string: destination coordinate
const string SPACENAV_FLY_NAME = "SpaceFlyName";    // PC string: destination display name

// NWScript has no "find by tag inside THIS area" call, and module-wide
// GetObjectByTag would return whichever cabin clone it saw first - fatal here,
// since every cabin carries the same internal tags.
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

// ---------------------------------------------------------------------------
// Visit tracking
// ---------------------------------------------------------------------------

// Record that this character reached a space coordinate in their own ship.
// Called from area_enter.nss on entering any space tile.
void SpaceNavMarkSeen(object oPC, string sCoord)
{
    if (sCoord == "") { return; }
    object oBag = GetItemPossessedBy(oPC, "goldbag");
    if (!GetIsObjectValid(oBag)) { return; }
    SetLocalInt(oBag, SPACENAV_SEEN + sCoord, 1);
}

int SpaceNavHasSeen(object oPC, string sCoord)
{
    object oBag = GetItemPossessedBy(oPC, "goldbag");
    if (!GetIsObjectValid(oBag)) { return FALSE; }
    return (GetLocalInt(oBag, SPACENAV_SEEN + sCoord) == 1);
}

// ---------------------------------------------------------------------------
// The galaxy: planets and moons
//
// _galaxy.nss stores one record per body as a module local,
// "<system>Planet<n>", laid out as
//   <name>&001&<place>&002&<size>&003&<type>&004&...
// where <place> is the body's coordinate in the space grid. Bodies are walked
// rather than indexed because nothing keeps a flat list of them.
// ---------------------------------------------------------------------------

string SpaceNavField(string sRec, string sFrom, string sTo)
{
    int iA = (sFrom == "") ? 0 : FindSubString(sRec, sFrom);
    int iB = FindSubString(sRec, sTo);
    if (iB < 0) { return ""; }
    if (sFrom == "") { return GetStringLeft(sRec, iB); }
    if (iA < 0) { return ""; }
    return GetStringRight(GetStringLeft(sRec, iB), iB - iA - GetStringLength(sFrom));
}

int SpaceNavBodyCount(object oModule)
{
    int iTot;
    int j = StringToInt(GetLocalString(oModule, "Systems"));
    while (j > 0)
    {
        iTot = iTot + StringToInt(GetLocalString(oModule, GetLocalString(oModule, "System" + IntToString(j)) + "Planets"));
        j--;
    }
    return iTot;
}

// Fetch the nth body (1-based) across every system. Returns "" past the end.
string SpaceNavBodyRecord(object oModule, int iWanted)
{
    int iSeen;
    int j = StringToInt(GetLocalString(oModule, "Systems"));
    int s;
    for (s = 1; s <= j; s++)
    {
        string sSys = GetLocalString(oModule, "System" + IntToString(s));
        int iN = StringToInt(GetLocalString(oModule, sSys + "Planets"));
        if (iWanted <= iSeen + iN)
        {
            return GetLocalString(oModule, sSys + "Planet" + IntToString(iWanted - iSeen));
        }
        iSeen = iSeen + iN;
    }
    return "";
}

string SpaceNavBodyName(string sRec)  { return SpaceNavField(sRec, "", "&001&"); }
string SpaceNavBodyPlace(string sRec) { return SpaceNavField(sRec, "&001&", "&002&"); }
string SpaceNavBodyType(string sRec)  { return SpaceNavField(sRec, "&003&", "&004&"); }

// The coordinate of a body by name, or "" if there is no such body.
string SpaceNavPlaceOf(string sName)
{
    object oModule = GetModule();
    int iTot = SpaceNavBodyCount(oModule);
    int n;
    for (n = 1; n <= iTot; n++)
    {
        string sRec = SpaceNavBodyRecord(oModule, n);
        if (SpaceNavBodyName(sRec) == sName) { return SpaceNavBodyPlace(sRec); }
    }
    return "";
}

// ---------------------------------------------------------------------------
// Distance and time
// ---------------------------------------------------------------------------

// Tiles crossed between two space coordinates. Manhattan, not diagonal: space
// tiles carry only North/East/South/West transition triggers, so a ship can
// never move diagonally between them.
int SpaceNavDistance(string sFrom, string sTo)
{
    struct AreaCoord a = ParseAreaCoord(sFrom);
    struct AreaCoord b = ParseAreaCoord(sTo);
    int dx = a.X - b.X; if (dx < 0) { dx = -dx; }
    int dy = a.Y - b.Y; if (dy < 0) { dy = -dy; }
    return dx + dy;
}

// Seconds a trip takes, at the same rate ticketed starships charge
// (transports.nss uses iStarshipSec per area crossed).
int SpaceNavSeconds(string sFrom, string sTo)
{
    return SpaceNavDistance(sFrom, sTo) * iStarshipSec;
}

// Heartbeat ticks for the same trip - the unit transports.nss counts down in.
int SpaceNavTicks(string sFrom, string sTo)
{
    return SpaceNavSeconds(sFrom, sTo) / 5;
}

string SpaceNavTimeText(int iSeconds)
{
    if (iSeconds < 60) { return IntToString(iSeconds) + " seconds"; }
    int iMin = iSeconds / 60;
    int iRem = iSeconds - (iMin * 60);
    if (iRem == 0) { return IntToString(iMin) + " minutes"; }
    return IntToString(iMin) + " minutes " + IntToString(iRem) + " seconds";
}

// ---------------------------------------------------------------------------
// Manual flight
// ---------------------------------------------------------------------------

// Which edge trigger to walk into to get closer to the destination. Returns ""
// when the ship is already in the destination tile. Longest axis first, so a
// ship makes headway on both axes rather than tracking one edge of the grid.
string SpaceNavHeading(string sHere, string sTo)
{
    struct AreaCoord a = ParseAreaCoord(sHere);
    struct AreaCoord b = ParseAreaCoord(sTo);
    int dx = b.X - a.X;
    int dy = b.Y - a.Y;
    int adx = (dx < 0) ? -dx : dx;
    int ady = (dy < 0) ? -dy : dy;
    if ((adx == 0) && (ady == 0)) { return ""; }
    if (adx >= ady) { return (dx > 0) ? "East" : "West"; }
    return (dy > 0) ? "North" : "South";
}

// Send the ship one tile further along. Called on arrival in each space tile
// while a flight is running. Walking into the tagged edge trigger is what
// actually crosses the boundary, so this only has to issue the move.
void SpaceFlyStep(object oPC)
{
    string sTo = GetLocalString(oPC, SPACENAV_FLY_TO);
    if (sTo == "") { return; }

    object oArea = GetArea(oPC);
    string sHere = GetLocalString(oArea, "Area");
    if (sHere == "") { return; }

    string sDir = SpaceNavHeading(sHere, sTo);
    if (sDir == "")
    {
        // Arrived in the destination tile. Head for the planet itself; the
        // existing landing option takes over within 60m of it.
        DeleteLocalString(oPC, SPACENAV_FLY_TO);
        // Planet tiles use their own "space_<type>_" template, which carries the
        // orb placeable (transitions.nss:106/165). Plain space tiles have none.
        object oPlanet = GetNearestObjectByTag("pla_orb", oPC);
        if (GetIsObjectValid(oPlanet))
        {
            AssignCommand(oPC, ActionMoveToObject(oPlanet, TRUE, 8.0));
        }
        FloatingTextStringOnCreature("You arrive at " + GetLocalString(oPC, SPACENAV_FLY_NAME) + ".", oPC, FALSE);
        return;
    }

    object oEdge = GetNearestObjectByTag(sDir, oPC);
    if (!GetIsObjectValid(oEdge))
    {
        DeleteLocalString(oPC, SPACENAV_FLY_TO);
        FloatingTextStringOnCreature("You cannot find a course from here.", oPC, FALSE);
        return;
    }
    AssignCommand(oPC, ActionMoveToObject(oEdge, TRUE, 1.0));
}

// Begin a manual flight to a named body.
int SpaceFlyBegin(object oPC, string sBodyName)
{
    string sPlace = SpaceNavPlaceOf(sBodyName);
    if (sPlace == "")
    {
        FloatingTextStringOnCreature("You have no course for " + sBodyName + ".", oPC, FALSE);
        return FALSE;
    }
    SetLocalString(oPC, SPACENAV_FLY_TO, sPlace);
    SetLocalString(oPC, SPACENAV_FLY_NAME, sBodyName);
    FloatingTextStringOnCreature("Setting course for " + sBodyName + ". Move to break off.", oPC, FALSE);
    SpaceFlyStep(oPC);
    return TRUE;
}

void SpaceFlyStop(object oPC)
{
    DeleteLocalString(oPC, SPACENAV_FLY_TO);
    DeleteLocalString(oPC, SPACENAV_FLY_NAME);
}

// ---------------------------------------------------------------------------
// The deck control
//
// A usable control placed opposite the cabin hatch. It lists every body this
// character has reached in their own ship, with the travel time, and runs the
// trip as a timed passage exactly as ticketed starships do - everyone aboard
// waits, gets the same start/halfway/arrival messages, and lands together.
// ---------------------------------------------------------------------------

const string SPACENAV_WINDOW  = "spacedeck";
const string SPACENAV_EVENT   = "spacedeck_event";
const string SPACENAV_CTRL    = "SpaceDeckCtrl";   // PC local: control being used
const string SPACENAV_TRIPTO  = "SpaceTripTo";     // cabin string: destination body
const string SPACENAV_TRIPEND = "SpaceTripEnd";    // cabin int: 1 once underway

// Is the flight owner unable to fly - dead, dying, or gone? Only then may a
// passenger take the controls.
int SpaceOwnerIsDown(object oOwner)
{
    if (!GetIsObjectValid(oOwner)) { return TRUE; }
    if (GetIsDead(oOwner)) { return TRUE; }
    return (GetCurrentHitPoints(oOwner) <= 0);
}

// May oPC use this cabin's control? The owner always may; a passenger only
// while the owner is down.
int SpaceDeckMayUse(object oPC, object oCabin)
{
    object oOwner = GetLocalObject(oCabin, FLIGHT_OWNER);
    if (oPC == oOwner) { return TRUE; }
    return SpaceOwnerIsDown(oOwner);
}

// Bring a downed owner in from space to the deck, so the party is together and
// the ship can travel without needing a move order on a body that cannot take
// one. This is what makes the dead-pilot case work at all: the ship stops
// being a creature in space and the trip becomes a timed passage.
void SpaceRecoverOwner(object oOwner, object oCabin)
{
    if ((!GetIsObjectValid(oOwner)) || (!GetIsObjectValid(oCabin))) { return; }
    if (GetArea(oOwner) == oCabin) { return; }
    SpaceFlyStop(oOwner);
    object oWP = FlightWaypointIn(oCabin, "WP_cabin_star");
    location lTo = GetIsObjectValid(oWP) ? GetLocation(oWP) : GetLocation(GetFirstObjectInArea(oCabin));
    AssignCommand(oOwner, ClearAllActions(TRUE));
    AssignCommand(oOwner, ActionJumpToLocation(lTo));
}

// Land everyone aboard on the destination body. Uses the ordinary travel
// contract (PlanetDest/AreaDest) rather than a captured location, for the same
// reason DomainTravelRefresh does: the destination is resolved from strings
// every time, so nothing depends on an area object still existing.
void SpaceTripArrive(object oCabin, string sBody)
{
    if (!GetIsObjectValid(oCabin)) { return; }
    object oPC = GetFirstObjectInArea(oCabin);
    while (GetIsObjectValid(oPC))
    {
        object oNext = GetNextObjectInArea(oCabin);
        if (GetIsPC(oPC))
        {
            FloatingTextStringOnCreature("You arrive at " + sBody + ".", oPC, FALSE);
            SetLocalString(oPC, "PlanetDest", sBody);
            SetLocalString(oPC, "AreaDest", "0_0");
            SetLocalFloat(oPC, "fX", 120.0);
            SetLocalFloat(oPC, "fY", 100.0);
            SetLocalFloat(oPC, "fFacing", DIRECTION_NORTH);
            DeleteLocalObject(oPC, FLIGHT_CABIN);
            AssignCommand(oPC, ClearAllActions(TRUE));
            ExecuteScript("transitions", oPC);
        }
        oPC = oNext;
    }
    DeleteLocalString(oCabin, SPACENAV_TRIPTO);
    DeleteLocalInt(oCabin, SPACENAV_TRIPEND);
}

void SpaceTripSay(object oCabin, string sMsg)
{
    if (!GetIsObjectValid(oCabin)) { return; }
    object oPC = GetFirstObjectInArea(oCabin);
    while (GetIsObjectValid(oPC))
    {
        if (GetIsPC(oPC)) { FloatingTextStringOnCreature(sMsg, oPC, FALSE); }
        oPC = GetNextObjectInArea(oCabin);
    }
}

// Start a timed passage to a body. Returns FALSE and says why if it cannot.
int SpaceDeckTravel(object oPC, object oCabin, string sBody)
{
    if (GetLocalInt(oCabin, SPACENAV_TRIPEND) == 1)
    {
        FloatingTextStringOnCreature("The ship is already under way.", oPC, FALSE);
        return FALSE;
    }
    object oOwner = GetLocalObject(oCabin, FLIGHT_OWNER);
    string sFrom = GetLocalString(GetArea(oOwner), "Area");
    if (sFrom == "") { sFrom = GetLocalString(oCabin, "SpaceFrom"); }
    string sTo = SpaceNavPlaceOf(sBody);
    if ((sFrom == "") || (sTo == ""))
    {
        FloatingTextStringOnCreature("The ship cannot plot that course.", oPC, FALSE);
        return FALSE;
    }

    // A downed owner is brought aboard first - the ship cannot be a creature in
    // space while its pilot is a corpse.
    if (SpaceOwnerIsDown(oOwner)) { SpaceRecoverOwner(oOwner, oCabin); }

    int iSecs = SpaceNavSeconds(sFrom, sTo);
    if (iSecs < iStarshipSec) { iSecs = iStarshipSec; }   // never instant
    SetLocalString(oCabin, SPACENAV_TRIPTO, sBody);
    SetLocalInt(oCabin, SPACENAV_TRIPEND, 1);

    SpaceTripSay(oCabin, "The journey to " + sBody + " begins. " + SpaceNavTimeText(iSecs) + " to arrival.");
    // Anchored to the module, which never dies - a cabin clone or a PC can go
    // away mid-trip, and TASK-17 established that destroying the object a
    // DelayCommand was scheduled from cancels it silently.
    object oModule = GetModule();
    AssignCommand(oModule, DelayCommand(IntToFloat(iSecs) / 2.0, SpaceTripSay(oCabin, "We are half of the way.")));
    AssignCommand(oModule, DelayCommand(IntToFloat(iSecs), SpaceTripArrive(oCabin, sBody)));
    return TRUE;
}

// ---------------------------------------------------------------------------
// The destination window
// ---------------------------------------------------------------------------

json SpaceDeckPage(object oPC)
{
    object oCtrl = GetLocalObject(oPC, SPACENAV_CTRL);
    object oCabin = GetArea(oCtrl);
    object oOwner = GetLocalObject(oCabin, FLIGHT_OWNER);
    string sFrom = GetLocalString(GetArea(oOwner), "Area");
    if (sFrom == "") { sFrom = GetLocalString(oCabin, "SpaceFrom"); }

    json jList = JsonArray();
    string sHead = (oPC == oOwner) ? "Set a course" : "Emergency helm - the owner is down";
    jList = JsonArrayInsert(jList, NuiHeight(NuiWidth(NuiLabel(JsonString(sHead), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_MIDDLE)), 420.0), 30.0));

    object oModule = GetModule();
    int iTot = SpaceNavBodyCount(oModule);
    int n;
    int iShown;
    for (n = 1; n <= iTot; n++)
    {
        string sRec = SpaceNavBodyRecord(oModule, n);
        string sName = SpaceNavBodyName(sRec);
        string sPlace = SpaceNavBodyPlace(sRec);
        if ((sName == "") || (sPlace == "")) { continue; }
        if (!SpaceNavHasSeen(oPC, sPlace)) { continue; }   // own-ship visits only
        if ((sFrom != "") && (sPlace == sFrom)) { continue; }  // already here

        string sLabel = sName;
        if (sFrom != "") { sLabel = sLabel + "  (" + SpaceNavTimeText(SpaceNavSeconds(sFrom, sPlace)) + ")"; }

        json jRow = JsonArray();
        jRow = JsonArrayInsert(jRow, NuiHeight(NuiWidth(NuiLabel(JsonString(sLabel), JsonInt(NUI_HALIGN_LEFT), JsonInt(NUI_VALIGN_MIDDLE)), 300.0), 30.0));
        jRow = JsonArrayInsert(jRow, NuiHeight(NuiWidth(NuiId(NuiButton(JsonString("Set course")), "d_" + IntToString(n)), 120.0), 30.0));
        jList = JsonArrayInsert(jList, NuiRow(jRow));
        iShown++;
    }

    if (iShown == 0)
    {
        jList = JsonArrayInsert(jList, NuiHeight(NuiWidth(NuiText(JsonString("This ship has been nowhere yet. Fly to a world yourself and its space lane is charted from then on."), FALSE, NUI_SCROLLBARS_NONE), 420.0), 60.0));
    }
    return NuiCol(jList);
}

void SpaceDeckOpen(object oPC, object oCtrl)
{
    object oCabin = GetArea(oCtrl);
    if (!SpaceDeckMayUse(oPC, oCabin))
    {
        FloatingTextStringOnCreature("Only the ship's owner may set a course.", oPC, FALSE);
        return;
    }
    SetLocalObject(oPC, SPACENAV_CTRL, oCtrl);
    json jWin = NuiWindow(SpaceDeckPage(oPC), JsonString("Navigation"), NuiRect(-1.0, -1.0, 460.0, 420.0), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE));
    NuiCreate(oPC, jWin, SPACENAV_WINDOW, SPACENAV_EVENT);
}

// Put the helm on the far side of the cabin from the hatch, so the two are not
// clustered together. Mirrored through the cabin's own arrival waypoint.
void SpaceDeckSpawnControl(object oCabin)
{
    if (!GetIsObjectValid(oCabin)) { return; }
    if (GetIsObjectValid(GetObjectInAreaByTag(oCabin, "shipcontrol"))) { return; }

    object oHatch = GetObjectInAreaByTag(oCabin, "cabin_hatch");
    object oWP = FlightWaypointIn(oCabin, "WP_cabin_star");
    if (!GetIsObjectValid(oWP)) { oWP = FlightWaypointIn(oCabin, "WP_cabin_air"); }
    if ((!GetIsObjectValid(oHatch)) || (!GetIsObjectValid(oWP))) { return; }

    vector vH = GetPosition(oHatch);
    vector vC = GetPosition(oWP);
    vector vTo = Vector((vC.x * 2.0) - vH.x, (vC.y * 2.0) - vH.y, vC.z);
    object oCtrl = CreateObject(OBJECT_TYPE_PLACEABLE, "pla_shipctrl",
                                Location(oCabin, vTo, GetFacing(oHatch) + 180.0));
    SetLocalInt(oCtrl, "DontSave", 1);
}
