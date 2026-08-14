////////////////////////////////////////////////////////////////////////////////
// Universe of Arlandia - String Parsing Utilities
//
// Provides Between() and field-extraction helpers to replace the verbose
// nested GetStringLeft/GetStringRight/FindSubString chains used throughout
// the codebase.
//
// Usage:
//   #include "_string_utils"
//
//   string sName  = Between(sRecord, FIELD_A, FIELD_B);
//   string sPlace = EncodedField(sPlanetData, 2);  // value between &001& and &002&
//   string sHench = LetterField(sHenchData, 3);    // value between &B& and &C&
//
// All three functions mirror the PHP helpers in helpers.php on the web side.
////////////////////////////////////////////////////////////////////////////////
#include "_constants"

// ---------------------------------------------------------------------------
// Between(sData, sAfter, sBefore)
//
// Returns the substring of sData that lies after sAfter and before sBefore.
//   sAfter  = ""  ->  start from the beginning of sData
//   sBefore = ""  ->  read to the end of sData
// Returns "" if a non-empty delimiter is not found.
//
// Replaces patterns like:
//   GetStringRight(GetStringLeft(s,FindSubString(s,"&002&")),
//     GetStringLength(GetStringLeft(s,FindSubString(s,"&002&")))
//     -FindSubString(s,"&001&")-5)
// with:
//   Between(s, "&001&", "&002&")
// ---------------------------------------------------------------------------
string Between(string sData, string sAfter, string sBefore)
{
    int iStart;

    if (sBefore != "") {
        int iEnd = FindSubString(sData, sBefore);
        if (iEnd == -1) return "";
        sData = GetStringLeft(sData, iEnd);
    }

    if (sAfter == "") return sData;

    iStart = FindSubString(sData, sAfter);
    if (iStart == -1) return "";
    return GetStringRight(sData, GetStringLength(sData) - iStart - GetStringLength(sAfter));
}

// ---------------------------------------------------------------------------
// PadInt3(n)
// Returns n as a zero-padded 3-digit string: 7 -> "007", 12 -> "012".
// Used internally by EncodedField().
// ---------------------------------------------------------------------------
string PadInt3(int n)
{
    string s = IntToString(n);
    int iLen = GetStringLength(s);
    if (iLen == 1) return "00" + s;
    if (iLen == 2) return "0" + s;
    return s;
}

// ---------------------------------------------------------------------------
// EncodedField(sData, n)
//
// Extracts the nth field from a &001&-delimited string (1-indexed).
// Mirrors the PHP encoded_field() helper in helpers.php.
//
// Example:
//   EncodedField(sPlanet, 1)  ->  value before &001&
//   EncodedField(sPlanet, 2)  ->  value between &001& and &002&
//   EncodedField(sPlanet, 9)  ->  value between &008& and &009&
// ---------------------------------------------------------------------------
string EncodedField(string sData, int n)
{
    string sCurr = "&" + PadInt3(n) + "&";
    string sPrev = (n > 1) ? "&" + PadInt3(n - 1) + "&" : "";
    return Between(sData, sPrev, sCurr);
}

// ---------------------------------------------------------------------------
// LetterField(sData, n)
//
// Extracts the nth field from an &A&-delimited string (1-indexed, A=1, B=2…).
//
// Example:
//   LetterField(sHench, 1)  ->  value before &A&
//   LetterField(sHench, 2)  ->  value between &A& and &B&
//   LetterField(sHench, 3)  ->  value between &B& and &C&
// ---------------------------------------------------------------------------
string LetterField(string sData, int n)
{
    string sCurr = "&" + GetSubString("ABCDEFGHIJKLMNOPQRSTUVWXYZ", n - 1, 1) + "&";
    string sPrev = (n > 1) ? "&" + GetSubString("ABCDEFGHIJKLMNOPQRSTUVWXYZ", n - 2, 1) + "&" : "";
    return Between(sData, sPrev, sCurr);
}

// ---------------------------------------------------------------------------
// Area tile column helpers
//
// Planet area grids are stored one X-column per pwdata key
// (<Planet>AreasX<iX>). Each column string encodes terrain codes using
// signed, zero-padded Y-coordinate delimiters: &+05&, &-03&, etc.
// Discovery is flagged by appending "*" to the terrain code (e.g. "04*").
//
// These helpers replace the repeated sCount1/sCount2 blobs scattered across
// transitions.nss, _galaxy.nss, conv_dm015.nss, and conv_dm042.nss.
// They mirror PHP's tile_key() helper in helpers.php.
// ---------------------------------------------------------------------------

// Format a Y coordinate as the &±YY& tile column delimiter.
// Mirrors PHP tile_key() in helpers.php.
string AreaTileKey(int iY)
{
    if (iY <= -10) return "&-" + IntToString(-iY) + "&";
    if (iY <    0) return "&-0" + IntToString(-iY) + "&";
    if (iY <   10) return "&+0" + IntToString(iY)  + "&";
    return "&+" + IntToString(iY) + "&";
}

// Return the raw entry (terrain code, possibly ending in "*") at row iY in
// a column string. Returns "" if iY is not found.
string _GetRawTile(string sCol, int iY)
{
    string sKey  = AreaTileKey(iY);
    string sPrev = AreaTileKey(iY - 1);
    // If the previous key doesn't exist we are at the bottom of the column.
    if (FindSubString(sCol, sPrev) == -1)
        return GetStringLeft(sCol, FindSubString(sCol, sKey));
    return Between(sCol, sPrev, sKey);
}

// Return the terrain code at (iX, iY) on sPlanet, stripping "*" if present.
string GetAreaTile(object oModule, string sPlanet, int iX, int iY)
{
    string sCol = GetPersistentString(oModule, sPlanet + "AreasX" + IntToString(iX));
    string sRaw = _GetRawTile(sCol, iY);
    if (GetStringRight(sRaw, 1) == "*")
        return GetStringLeft(sRaw, GetStringLength(sRaw) - 1);
    return sRaw;
}

// Return TRUE if the tile at (iX, iY) on sPlanet has been discovered.
int IsAreaTileDiscovered(object oModule, string sPlanet, int iX, int iY)
{
    string sCol = GetPersistentString(oModule, sPlanet + "AreasX" + IntToString(iX));
    return (GetStringRight(_GetRawTile(sCol, iY), 1) == "*");
}

// Return sCol with the discovery marker at iY set (iDiscovered=TRUE) or
// cleared (iDiscovered=FALSE). Caller writes result back with SetPersistentString.
string SetColTileDiscovered(string sCol, int iY, int iDiscovered)
{
    string sKey = AreaTileKey(iY);
    string sRaw = _GetRawTile(sCol, iY);
    int bHas = (GetStringRight(sRaw, 1) == "*");
    if (iDiscovered == bHas) return sCol; // already correct
    string sBase = bHas ? GetStringLeft(sRaw, GetStringLength(sRaw) - 1) : sRaw;
    string sNew  = iDiscovered ? (sBase + "*") : sBase;
    int iPos = FindSubString(sCol, sKey) - GetStringLength(sRaw);
    return GetStringLeft(sCol, iPos) + sNew + GetStringRight(sCol, GetStringLength(sCol) - iPos - GetStringLength(sRaw));
}

// Return sCol with the terrain code at iY replaced by sCode (preserves "*").
// Caller writes result back with SetPersistentString.
string SetColTile(string sCol, int iY, string sCode)
{
    string sKey = AreaTileKey(iY);
    string sRaw = _GetRawTile(sCol, iY);
    int bDiscovered = (GetStringRight(sRaw, 1) == "*");
    string sNew = bDiscovered ? (sCode + "*") : sCode;
    int iPos = FindSubString(sCol, sKey) - GetStringLength(sRaw);
    return GetStringLeft(sCol, iPos) + sNew + GetStringRight(sCol, GetStringLength(sCol) - iPos - GetStringLength(sRaw));
}

// ---------------------------------------------------------------------------
// Area coordinate <-> "X_Y" string conversion (negative values use "m" in
// place of "-", e.g. "m3_5" = (-3,5) - the same convention area tags/sArea
// locals and Interests keys use throughout the codebase, e.g. the inline
// parse at missions.nss:14-18).
// ---------------------------------------------------------------------------
struct AreaCoord
{
    int X;
    int Y;
};

// Parse an "X_Y" area-coordinate string into a struct AreaCoord.
struct AreaCoord ParseAreaCoord(string sArea)
{
    struct AreaCoord coord;
    int iZ = FindSubString(sArea, "_");
    string sX = GetStringLeft(sArea, iZ);
    string sY = GetStringRight(sArea, GetStringLength(sArea) - iZ - 1);
    coord.X = (GetStringLeft(sX, 1) == "m") ? -StringToInt(GetStringRight(sX, GetStringLength(sX) - 1)) : StringToInt(sX);
    coord.Y = (GetStringLeft(sY, 1) == "m") ? -StringToInt(GetStringRight(sY, GetStringLength(sY) - 1)) : StringToInt(sY);
    return coord;
}

// Format (iX, iY) back into the "X_Y" area-coordinate string convention.
// Inverse of ParseAreaCoord().
string FormatAreaCoord(int iX, int iY)
{
    string sX = (iX < 0) ? "m" + IntToString(-iX) : IntToString(iX);
    string sY = (iY < 0) ? "m" + IntToString(-iY) : IntToString(iY);
    return sX + "_" + sY;
}

// ---------------------------------------------------------------------------
// GetPlanetLevel(oModule, sPlanetName)
//
// Returns the iPlanetLevel (1-9) of the named planet, by scanning the
// "System<j>" / "<sSystem>Planets" / "<sSystem>Planet<i>" module-local
// records that _galaxy.nss rebuilds at every mod_load (see _galaxy.nss:112
// and the sTot encoding at _galaxy.nss:138, where the planet name is field 1
// and iPlanetLevel is field 29 of the &NNN&-delimited record). Returns 1 if
// no matching planet is found (e.g. a planet added after the last _galaxy
// rebuild), so callers always get a sane minimum difficulty.
//
// Systems and planets per system are few (galaxy-sized, not world-sized), so
// this brute-force scan is cheap enough to call from area_recall.nss.
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// StripWearSuffix(sName)
//
// Removes a trailing " NN%" wear-percentage suffix previously appended by
// SetWearName(), if present. Leaves sName untouched if it doesn't end in a
// plain "<space><digits>%" token (e.g. a fresh item, or a name ending in an
// unrelated "%" that isn't preceded by digits+space).
// ---------------------------------------------------------------------------
string StripWearSuffix(string sName)
{
    int iLen = GetStringLength(sName);
    if (iLen == 0 || GetStringRight(sName, 1) != "%") return sName;

    int i = iLen - 2;
    int iDigits = 0;
    while (i >= 0)
    {
        string sChar = GetSubString(sName, i, 1);
        if (sChar == " ") break;
        if (FindSubString("0123456789", sChar) == -1) return sName;
        iDigits++;
        i--;
    }
    if (iDigits == 0 || i < 0) return sName;
    return GetStringLeft(sName, i);
}

// ---------------------------------------------------------------------------
// SetWearName(oItem, iWearPct)
//
// Appends the item's remaining condition (100% = unworn, 0% = about to
// break) to the end of its displayed name, e.g. "Longsword 98%". Replaces
// any wear suffix left by a previous call, so calling this every heartbeat
// tick doesn't keep stacking percentages onto the name.
// ---------------------------------------------------------------------------
void SetWearName(object oItem, int iWearPct)
{
    string sBase = StripWearSuffix(GetName(oItem));
    SetName(oItem, sBase + " " + IntToString(iWearPct) + "%");
}

int GetPlanetLevel(object oModule, string sPlanetName)
{
    int iSystems = StringToInt(GetLocalString(oModule, "Systems"));
    int j;
    for (j = 1; j <= iSystems; j++)
    {
        string sSystem = GetLocalString(oModule, "System" + IntToString(j));
        int iPlanets = StringToInt(GetLocalString(oModule, sSystem + "Planets"));
        int i;
        for (i = 1; i <= iPlanets; i++)
        {
            string sRecord = GetLocalString(oModule, sSystem + "Planet" + IntToString(i));
            if (EncodedField(sRecord, 1) == sPlanetName)
            {
                return StringToInt(EncodedField(sRecord, 29));
            }
        }
    }
    return 1;
}

// ---------------------------------------------------------------------------
// GetCreatureFamilyForLevel(oModule, iTargetLevel)
//
// Scans the same System<j>Planet<i> records as GetPlanetLevel() and returns
// the resolved creature family (field 15, "self" -> the planet's own name)
// of a random planet at iTargetLevel. Uses reservoir sampling so every
// matching planet has equal odds. Returns "" if no planet is at that level.
// ---------------------------------------------------------------------------
string GetCreatureFamilyForLevel(object oModule, int iTargetLevel)
{
    int iSystems = StringToInt(GetLocalString(oModule, "Systems"));
    string sFamily = "";
    int iMatches = 0;
    int j;
    for (j = 1; j <= iSystems; j++)
    {
        string sSystem = GetLocalString(oModule, "System" + IntToString(j));
        int iPlanets = StringToInt(GetLocalString(oModule, sSystem + "Planets"));
        int i;
        for (i = 1; i <= iPlanets; i++)
        {
            string sRecord = GetLocalString(oModule, sSystem + "Planet" + IntToString(i));
            if (StringToInt(EncodedField(sRecord, 29)) == iTargetLevel)
            {
                iMatches++;
                if (Random(iMatches) == 0)
                {
                    string sName = EncodedField(sRecord, 1);
                    string sCre  = EncodedField(sRecord, 15);
                    sFamily = (sCre == "self") ? sName : sCre;
                }
            }
        }
    }
    return sFamily;
}

// ---------------------------------------------------------------------------
// Rotates a 2D offset by iRotation90*90 degrees (0-3) around the origin.
// Exact axis-swap + sign-flip - always a multiple of 90 degrees, so no trig
// needed. Used by domains.nss to rotate a structure's per-piece local offset
// (fX/fY, relative to its slot's pivot) when the player rotates a built
// structure. Returned as a vector purely as a 2-float carrier - .z is unused.
// ---------------------------------------------------------------------------
vector RotateOffset90(float fX, float fY, int iRotation90)
{
    iRotation90 = ((iRotation90 % 4) + 4) % 4;
    if (iRotation90 == 1) { return Vector(-fY, fX, 0.0); }
    if (iRotation90 == 2) { return Vector(-fX, -fY, 0.0); }
    if (iRotation90 == 3) { return Vector(fY, -fX, 0.0); }
    return Vector(fX, fY, 0.0);
}

// ---------------------------------------------------------------------------
// Rotates a facing angle (degrees) by iRotation90*90 degrees, wrapped to
// [0,360). Companion to RotateOffset90 - same iRotation90 value rotates both
// a piece's position and the direction it faces together.
// ---------------------------------------------------------------------------
float RotateFacing90(float fF, int iRotation90)
{
    float fResult = fF + IntToFloat(((iRotation90 % 4) + 4) % 4) * 90.0;
    while (fResult >= 360.0) { fResult -= 360.0; }
    while (fResult < 0.0) { fResult += 360.0; }
    return fResult;
}

// Completes DomainTravelRefresh's round trip (below) - split into its own
// function so the "come back" half can be scheduled via
// AssignCommand(oPC,DelayCommand(...)), re-anchoring it to oPC's own
// lifetime rather than whatever object was running the script that started
// the round trip (which may already be destroyed by the time this fires,
// see DomainTravelRefresh's comment).
void DomainReturnTrip(object oPC, string sPlanet, string sArea, float fX, float fY, float fFacing)
{
    SetLocalString(oPC, "PlanetDest", sPlanet);
    SetLocalString(oPC, "AreaDest", sArea);
    SetLocalFloat(oPC, "fX", fX);
    SetLocalFloat(oPC, "fY", fY);
    SetLocalFloat(oPC, "fFacing", fFacing);
    ExecuteScript("transitions", oPC);
}

// Away-trip destination for DomainTravelRefresh below - a fixed, known-safe
// coordinate rather than a computed neighbor tile. An adjacent tile was
// tried first and confirmed unsafe in practice: it can be a monster camp
// (area_creatures.nss populates exterior tiles with hostile camps somewhat
// often - see the uoa-world-generation skill - and there's no way to know
// a neighbor's roll without already having visited it). Planet "Sand",
// area "0_0" was confirmed by the user to be safe.
const string DOMAIN_REFRESH_AWAY_PLANET = "Sand";
const string DOMAIN_REFRESH_AWAY_AREA = "0_0";

// Forces a genuinely fresh rebuild of oPC's current domain coordinate by
// sending them to the fixed safe coordinate above and straight back through
// the real travel system (transitions.nss), instead of an ad-hoc in-place
// destroy+rebuild or client-side area-jump trick (both tried first - see
// TASK-17 in TODO.md for the full history of why neither worked). A
// domain's area is a per-coordinate CopyArea() clone (TASK-22): leaving it
// empties it, area_exit.nss's normal cleanup destroys the clone ~0.3s
// later, and the next visit to that coordinate creates a genuinely fresh
// clone, fully repopulated by area_recall.nss/domains.nss from whatever's
// currently persisted (Interests + each slot's Rot value) - clearing up
// any stale/duplicated pieces along with the old clone, not just the one
// slot that changed. transitions.nss resolves its destination from the
// PLANET+AREA COORDINATE STRINGS every time, not a captured object/
// location reference, so it doesn't matter that the original clone is gone
// by the time the return trip runs.
//
// The return trip MUST be scheduled via AssignCommand(oPC,DelayCommand(...))
// rather than a bare DelayCommand(...) - the same class of bug hit twice
// already this session (DomainSetRotation's own destroy loop, then
// ForceAreaRefresh's jump-back): NWN ties a DelayCommand to whatever object
// was running the script that scheduled it, and cancels it if that object
// is destroyed by the time it fires, regardless of what the delayed call's
// own target object is. If this function is itself invoked from a script
// running on the domain's area (at risk of being destroyed by the away
// trip) or its flag, a bare DelayCommand here would be at the same risk.
void DomainTravelRefresh(object oPC, string sPlanet, string sArea)
{
    float fX = GetPosition(oPC).x;
    float fY = GetPosition(oPC).y;
    float fFacing = GetFacing(oPC);

    SetLocalString(oPC, "PlanetDest", DOMAIN_REFRESH_AWAY_PLANET);
    SetLocalString(oPC, "AreaDest", DOMAIN_REFRESH_AWAY_AREA);
    SetLocalFloat(oPC, "fX", 100.0);
    SetLocalFloat(oPC, "fY", 100.0);
    SetLocalFloat(oPC, "fFacing", 0.0);
    AssignCommand(oPC, ExecuteScript("transitions", oPC));

    AssignCommand(oPC, DelayCommand(1.0, DomainReturnTrip(oPC, sPlanet, sArea, fX, fY, fFacing)));
}

// ---------------------------------------------------------------------------
// Rotates an already-built domain structure to an ABSOLUTE facing (iRot 0-3,
// see RotateOffset90/RotateFacing90 above) rather than incrementing from
// whatever it's currently at - used by the domain_rot_n/s/e/w.nss compass
// replies. oFlag is the structure's own flag/signpost placeable (carries
// Slot/Structure/Master locals set by domains.nss at CreateObject time, so
// no slot-picker is needed - the player is already standing at the specific
// structure they want to rotate). Requires the caller to #include
// "aps_include" BEFORE #include "_string_utils" (for SetPersistentInt/
// GetPersistentString), matching domains.nss's own include order.
//
// Deliberately does NOT destroy/rebuild the slot's pieces in place - two
// earlier approaches both tried that (an in-place destroy+rebuild, then an
// area-jump client-refresh trick on top of it) and both hit real bugs
// along the way (see TASK-17 in TODO.md for the full history), and even
// once working, an in-place rebuild only ever fixes the ONE slot that
// changed - any other stale/duplicated pieces from earlier attempts stay
// put. Persisting the Rot value here and letting DomainTravelRefresh send
// the player through a real trip via transitions.nss instead means the
// whole coordinate gets a genuinely fresh clone, fully repopulated from
// scratch by area_recall.nss/domains.nss - cleaning up everything at once,
// using already-proven-working infrastructure instead of ad-hoc destroy
// loops.
// ---------------------------------------------------------------------------
void DomainSetRotation(object oFlag, object oPC, int iRot)
{
    object oModule = GetModule();
    object oArea = GetArea(oFlag);
    string sPlanet = GetLocalString(oArea, "Planet");
    string sArea = GetLocalString(oArea, "Area");
    int iSlot = GetLocalInt(oFlag, "Slot");
    int iStructure = GetLocalInt(oFlag, "Structure");

    if ((iSlot == 0) || (iStructure == 0)) { return; }

    SetPersistentInt(oModule, sPlanet + "&" + sArea + "&Rot&" + IntToString(iSlot), iRot);
    FloatingTextStringOnCreature("Structure rotated - refreshing the area...", oPC);
    DomainTravelRefresh(oPC, sPlanet, sArea);
}

// ---------------------------------------------------------------------------
// AdvanceCoordAxis(sCoord, iPlanetSize, iStep, bIsSpace)
//
// Advances one coordinate component (X or Y, as a signed "m"-prefixed string,
// e.g. "m3", "0", "12") by iStep (+1 or -1), wrapping at +-iPlanetSize/2.
// Space tiles (bIsSpace) never wrap - they just increment/decrement.
//
// Replaces the sXnew/sYnew ternary chains duplicated throughout
// area_transition.nss - same rationale as the tile-column helpers above.
// ---------------------------------------------------------------------------
string AdvanceCoordAxis(string sCoord, int iPlanetSize, int iStep, int bIsSpace)
{
    if (bIsSpace)
    {
        int iC = StringToInt(sCoord);
        if (GetStringLeft(sCoord,1)=="m") {iC=-StringToInt(GetStringRight(sCoord,GetStringLength(sCoord)-1));}
        iC += iStep;
        return (iC<0) ? ("m"+IntToString(-iC)) : IntToString(iC);
    }

    int iHalf = iPlanetSize/2;
    if (iStep>0)
    {
        if (sCoord==IntToString(iHalf)) return "m"+sCoord;
        if (sCoord=="m1") return "0";
        if (GetStringLeft(sCoord,1)=="m") return "m"+IntToString(StringToInt(GetStringRight(sCoord,GetStringLength(sCoord)-1))-1);
        return IntToString(StringToInt(sCoord)+1);
    }
    if (sCoord=="m"+IntToString(iHalf)) return GetStringRight(sCoord,GetStringLength(sCoord)-1);
    if (sCoord=="0") return "m1";
    if (GetStringLeft(sCoord,1)=="m") return "m"+IntToString(StringToInt(GetStringRight(sCoord,GetStringLength(sCoord)-1))+1);
    return IntToString(StringToInt(sCoord)-1);
}
