// dmb_inc - DM Area-Builder shared helpers
// ---
// Support for the DM ".w" chat commands (mod_chat.nss) and the cluster
// editor NUI (dmb_nui_inc.nss): coordinate parsing, tile-column writes,
// cluster records, member-area stamping and live-tile eviction.
//
// Data model:
// - A DM-assigned tile code is the target area's tag PREFIX (tag minus its
//   "000"/"001" suffix) written into the <Planet>AreasX<iX> column with
//   SetColTile(); non-numeric codes flow through transitions.nss untouched
//   (precedent: "citya" at 0_0). Every DM write also flags the tile
//   discovered, because _galaxy.nss re-rolls undiscovered tiles at boot.
// - A cluster tile carries the sentinel code DMB_TILE_CLUSTER plus a pwdata
//   record "<Planet>&<X_Y>&Cluster" = "<Ntag>&1&<Etag>&2&<Stag>&3&<Wtag>&4&"
//   mapping each cardinal side of the coordinate to one member area's full
//   tag (empty field = that side is blocked).
// - Because pwdata keys cannot be enumerated from NWScript, cluster records
//   are indexed by "ClusterTot" + "Cluster<n>" = "<Planet>&<X_Y>" (the same
//   pattern as Objects<n>/ObjectsTot).
// - Runtime caches on the module (rebuilt at boot by dmb_cluster_boot):
//   "CluRec_<Planet>_<X_Y>"  = copy of the cluster record
//   "CluMember_<areaTag>"    = "<Planet>&<X_Y>" reverse lookup

#include "aps_include"
#include "_module"
#include "_string_utils"
#include "area_pop_inc"

// Tile code marking a coordinate as a DM-built cluster (never matches a
// "<code>000"/"<code>001" tag lookup because transitions.nss intercepts it
// before tag resolution).
const string DMB_TILE_CLUSTER = "cluster";

// Sentinel returned by DmbParseCoord for malformed input.
const int DMB_COORD_INVALID = -999;

// ---------------------------------------------------------------------------
// Coordinate parsing
// ---------------------------------------------------------------------------

// Parse one axis token ("5", "m3") to its signed value; DMB_COORD_INVALID on
// anything malformed ("", "m", "3a", "--2", ...).
int DmbParseAxis(string sToken)
{
    if (sToken == "") return DMB_COORD_INVALID;
    int bNegative = FALSE;
    if (GetStringLeft(sToken, 1) == "m")
    {
        bNegative = TRUE;
        sToken = GetStringRight(sToken, GetStringLength(sToken) - 1);
        if (sToken == "") return DMB_COORD_INVALID;
    }
    int iLen = GetStringLength(sToken);
    int i;
    for (i = 0; i < iLen; i++)
    {
        if (FindSubString("0123456789", GetSubString(sToken, i, 1)) == -1)
            return DMB_COORD_INVALID;
    }
    int iValue = StringToInt(sToken);
    if (bNegative) iValue = -iValue;
    return iValue;
}

// Parse "X_Y" (negatives via "m", e.g. "m3_5") to X (bOutX=TRUE) or Y.
// Returns DMB_COORD_INVALID on malformed input.
int DmbParseCoord(string sCoord, int bOutX)
{
    int iSep = FindSubString(sCoord, "_");
    if ((iSep <= 0) || (iSep == GetStringLength(sCoord) - 1)) return DMB_COORD_INVALID;
    string sToken;
    if (bOutX) sToken = GetStringLeft(sCoord, iSep);
    else       sToken = GetStringRight(sCoord, GetStringLength(sCoord) - iSep - 1);
    return DmbParseAxis(sToken);
}

// Inverse of DmbParseCoord: (-3,5) -> "m3_5".
string DmbCoordString(int iX, int iY)
{
    string sX = IntToString(iX); if (iX < 0) sX = "m" + IntToString(-iX);
    string sY = IntToString(iY); if (iY < 0) sY = "m" + IntToString(-iY);
    return sX + "_" + sY;
}

// Planet grid size from the pwdata "<Planet>" record (field 2, see
// _galaxy.nss); 0 if the planet record doesn't exist.
int DmbPlanetSize(object oModule, string sPlanet)
{
    if (sPlanet == "") return 0;
    return StringToInt(EncodedField(GetPersistentString(oModule, sPlanet), 2));
}

// TRUE if (iX,iY) is a valid coordinate on sPlanet: |X| and |Y| <= size/2.
int DmbCoordInBounds(object oModule, string sPlanet, int iX, int iY)
{
    int iHalf = DmbPlanetSize(oModule, sPlanet) / 2;
    if (iHalf <= 0) return FALSE;
    if ((iX < -iHalf) || (iX > iHalf)) return FALSE;
    if ((iY < -iHalf) || (iY > iHalf)) return FALSE;
    return TRUE;
}

// ---------------------------------------------------------------------------
// Cluster records
// ---------------------------------------------------------------------------

// pwdata key of the cluster record for a coordinate.
string DmbClusterKey(string sPlanet, string sCoord)
{
    return sPlanet + "&" + sCoord + "&Cluster";
}

// Read the cluster record, preferring the module-local cache and filling it
// from pwdata on a miss. "" = no cluster at this coordinate.
string DmbClusterRecord(object oModule, string sPlanet, string sCoord)
{
    string sCacheKey = "CluRec_" + sPlanet + "_" + sCoord;
    string sRecord = GetLocalString(oModule, sCacheKey);
    if (sRecord == "")
    {
        sRecord = GetPersistentString(oModule, DmbClusterKey(sPlanet, sCoord));
        if (sRecord != "") SetLocalString(oModule, sCacheKey, sRecord);
    }
    return sRecord;
}

// Write (sRecord != "") or delete (sRecord == "") the cluster record for a
// coordinate, keeping the module-local cache and the ClusterTot/Cluster<n>
// index in sync. Deleting compacts the index by moving the last entry into
// the freed slot.
void DmbSetClusterRecord(object oModule, string sPlanet, string sCoord, string sRecord)
{
    string sEntry = sPlanet + "&" + sCoord;
    string sCacheKey = "CluRec_" + sPlanet + "_" + sCoord;
    int iTot = GetPersistentInt(oModule, "ClusterTot");
    int iSlot = 0;
    int i;
    for (i = 1; i <= iTot; i++)
    {
        if (GetPersistentString(oModule, "Cluster" + IntToString(i)) == sEntry) { iSlot = i; break; }
    }

    if (sRecord == "")
    {
        DeletePersistentVariable(oModule, DmbClusterKey(sPlanet, sCoord));
        DeleteLocalString(oModule, sCacheKey);
        if (iSlot > 0)
        {
            if (iSlot < iTot)
                SetPersistentString(oModule, "Cluster" + IntToString(iSlot), GetPersistentString(oModule, "Cluster" + IntToString(iTot)));
            DeletePersistentVariable(oModule, "Cluster" + IntToString(iTot));
            SetPersistentInt(oModule, "ClusterTot", iTot - 1);
        }
        return;
    }

    SetPersistentString(oModule, DmbClusterKey(sPlanet, sCoord), sRecord);
    SetLocalString(oModule, sCacheKey, sRecord);
    if (iSlot == 0)
    {
        SetPersistentString(oModule, "Cluster" + IntToString(iTot + 1), sEntry);
        SetPersistentInt(oModule, "ClusterTot", iTot + 1);
    }
}

// Member tag mapped to one side of the coordinate ("North"/"East"/"South"/
// "West"); "" = blocked or unknown direction.
string DmbClusterDirTag(string sRecord, string sDir)
{
    if (sDir == "North") return Between(sRecord, "",    "&1&");
    if (sDir == "East")  return Between(sRecord, "&1&", "&2&");
    if (sDir == "South") return Between(sRecord, "&2&", "&3&");
    if (sDir == "West")  return Between(sRecord, "&3&", "&4&");
    return "";
}

// Build a cluster record from the four member tags (any may be "").
string DmbBuildClusterRecord(string sNorth, string sEast, string sSouth, string sWest)
{
    return sNorth + "&1&" + sEast + "&2&" + sSouth + "&3&" + sWest + "&4&";
}

// "North" <-> "South", "East" <-> "West"; "" on anything else.
string DmbOppositeDir(string sDir)
{
    if (sDir == "North") return "South";
    if (sDir == "South") return "North";
    if (sDir == "East")  return "West";
    if (sDir == "West")  return "East";
    return "";
}

// First direction (N,E,S,W order) with a mapped member; "" if none.
string DmbFirstMappedDir(string sRecord)
{
    if (DmbClusterDirTag(sRecord, "North") != "") return "North";
    if (DmbClusterDirTag(sRecord, "East")  != "") return "East";
    if (DmbClusterDirTag(sRecord, "South") != "") return "South";
    if (DmbClusterDirTag(sRecord, "West")  != "") return "West";
    return "";
}

// ---------------------------------------------------------------------------
// Member stamping
// ---------------------------------------------------------------------------

// Give a member area the same Planet/Area locals a normal world area carries
// (so the vanilla neighbor math in area_transition.nss works from inside it),
// flag it as a cluster member, and register the module-local reverse lookup.
void DmbStampMember(object oArea, string sPlanet, string sCoord)
{
    if (!GetIsObjectValid(oArea)) return;
    SetLocalString(oArea, "Planet", sPlanet);
    SetLocalString(oArea, "Area", sCoord);
    SetLocalInt(oArea, "IsClusterMember", 1);
    SetLocalString(GetModule(), "CluMember_" + GetTag(oArea), sPlanet + "&" + sCoord);
}

// Stamp every member named in sRecord (skips blocked/unresolvable sides).
void DmbStampAllMembers(string sPlanet, string sCoord, string sRecord)
{
    string sDir;
    int i;
    for (i = 1; i <= 4; i++)
    {
        if (i == 1) sDir = "North"; else if (i == 2) sDir = "East";
        else if (i == 3) sDir = "South"; else sDir = "West";
        string sTag = DmbClusterDirTag(sRecord, sDir);
        if (sTag != "") DmbStampMember(GetObjectByTag(sTag), sPlanet, sCoord);
    }
}

// Undo DmbStampMember for every member named in sRecord: clears the area
// locals and the module-local reverse lookups. Used when a cluster is
// removed or remapped.
void DmbClearMembers(object oModule, string sRecord)
{
    string sDir;
    int i;
    for (i = 1; i <= 4; i++)
    {
        if (i == 1) sDir = "North"; else if (i == 2) sDir = "East";
        else if (i == 3) sDir = "South"; else sDir = "West";
        string sTag = DmbClusterDirTag(sRecord, sDir);
        if (sTag == "") continue;
        DeleteLocalString(oModule, "CluMember_" + sTag);
        object oArea = GetObjectByTag(sTag);
        if (GetIsObjectValid(oArea))
        {
            DeleteLocalString(oArea, "Planet");
            DeleteLocalString(oArea, "Area");
            DeleteLocalInt(oArea, "IsClusterMember");
        }
    }
}

// ---------------------------------------------------------------------------
// Live-tile eviction
// ---------------------------------------------------------------------------

// Retire the live instance of a world coordinate so the next entry resolves
// its (changed) tile code fresh: area_save persists dropped objects, clones
// are destroyed, and the module-local registry entry is removed (the same
// sequence as transitions.nss's failed-transition path). Returns FALSE
// without touching anything if a non-DM player is inside - the caller
// reports "occupied". A DM standing there is fine: area_save's own
// occupancy check makes it a no-op and the DM keeps standing in the old
// instance until they leave, after which it is vacated normally.
int DmbEvictTile(object oModule, string sPlanet, string sCoord)
{
    object oArea = GetLocalObject(oModule, sPlanet + "_" + sCoord);
    if (!GetIsObjectValid(oArea)) return TRUE;

    int bOccupied = FALSE;
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        if (GetArea(oPC) == oArea)
        {
            if ((!GetIsDM(oPC)) && (!GetIsDMPossessed(oPC))) return FALSE;
            bOccupied = TRUE;
        }
        oPC = GetNextPC();
    }

    ExecuteScript("area_save", oArea);
    if ((!bOccupied) && (GetIsObjectValid(oArea)) && (GetLocalInt(oArea, "IsCopy") == 1))
        DestroyArea(oArea);
    DeleteLocalObject(oModule, sPlanet + "_" + sCoord);
    return TRUE;
}

// ---------------------------------------------------------------------------
// Tile-code writes
// ---------------------------------------------------------------------------

// Write sCode as the tile code at (iX,iY) and flag the tile discovered in the
// same read-modify-write (undiscovered tiles are re-rolled by _galaxy.nss at
// every boot, so a DM-assigned code MUST be discovered to survive).
void DmbWriteTileCode(object oModule, string sPlanet, int iX, int iY, string sCode)
{
    string sColKey = sPlanet + "AreasX" + IntToString(iX);
    string sCol = GetPersistentString(oModule, sColKey);
    sCol = SetColTile(sCol, iY, sCode);
    sCol = SetColTileDiscovered(sCol, iY, TRUE);
    SetPersistentString(oModule, sColKey, sCol);
}

// ---------------------------------------------------------------------------
// Cluster arrival (called from transitions.nss when the tile code is
// DMB_TILE_CLUSTER)
// ---------------------------------------------------------------------------

// Waypoint override for arrivals from one side: "CLU_ENTRY_NORTH" etc.
// placed inside the member. Returns the waypoint or OBJECT_INVALID.
object DmbEntryWaypoint(object oMember, string sEnterDir)
{
    if (sEnterDir == "") return OBJECT_INVALID;
    string sWPTag = "CLU_ENTRY_" + GetStringUpperCase(sEnterDir);
    int n = 0;
    object oWP = GetObjectByTag(sWPTag, n);
    while (GetIsObjectValid(oWP))
    {
        if (GetArea(oWP) == oMember) return oWP;
        n++;
        oWP = GetObjectByTag(sWPTag, n);
    }
    return OBJECT_INVALID;
}

// Land oPC in the member area designated for the side of the coordinate they
// are entering through. TransDir (the edge trigger clicked in the origin
// area, stashed by area_transition.nss) determines that side: clicking the
// origin's East trigger means entering this coordinate through its West
// side. Empty TransDir (.wjump, tickets, recalls) falls back to the first
// mapped side in N,E,S,W order. Consumes and clears the same PC locals the
// normal transitions.nss path does.
void DmbClusterArrive(object oPC, object oModule, string sPlanet, string sCoord)
{
    string sTransDir = GetLocalString(oPC, "TransDir");
    string sRecord = DmbClusterRecord(oModule, sPlanet, sCoord);
    string sEnterDir;
    string sMemberTag;

    if (sTransDir != "")
    {
        sEnterDir = DmbOppositeDir(sTransDir);
        sMemberTag = DmbClusterDirTag(sRecord, sEnterDir);
    }
    else
    {
        sEnterDir = DmbFirstMappedDir(sRecord);
        sMemberTag = DmbClusterDirTag(sRecord, sEnterDir);
    }

    object oMember = OBJECT_INVALID;
    if (sMemberTag != "") oMember = GetObjectByTag(sMemberTag);

    if (!GetIsObjectValid(oMember))
    {
        FloatingTextStringOnCreature("*the way is blocked*", oPC);
    }
    else
    {
        DmbStampMember(oMember, sPlanet, sCoord);

        float fX = GetLocalFloat(oPC, "fX");
        float fY = GetLocalFloat(oPC, "fY");
        float fFacing = GetLocalFloat(oPC, "fFacing");

        object oWP = DmbEntryWaypoint(oMember, sEnterDir);
        if (GetIsObjectValid(oWP))
        {
            vector vWP = GetPosition(oWP);
            fX = vWP.x; fY = vWP.y; fFacing = GetFacing(oWP);
        }
        else
        {
            // The edge position was computed in the origin area's dimensions;
            // clamp into this member so differing sizes can't strand the PC.
            float fMaxX = IntToFloat(GetAreaSize(AREA_WIDTH, oMember) * 10) - 2.0;
            float fMaxY = IntToFloat(GetAreaSize(AREA_HEIGHT, oMember) * 10) - 2.0;
            if (fX < 2.0) fX = 2.0; if (fX > fMaxX) fX = fMaxX;
            if (fY < 2.0) fY = 2.0; if (fY > fMaxY) fY = fMaxY;
        }

        SetLocalString(oPC, "PlayerAreaTo", GetTag(oMember));
        location lLoc = Location(oMember, Vector(fX, fY, 0.0), fFacing);
        SetLocalLocation(oModule, GetName(oPC) + "Loc", lLoc);

        // Same population-before-arrival gate as transitions.nss's main path
        // (see area_pop_inc.nss/trans_arrive.nss) - cluster-member areas are
        // pre-placed and never destroyed (area_save.nss special-cases
        // IsClusterMember), but their locals still reset on a server restart,
        // so they still need area_recall/placeable setup at least once per
        // boot before a player should see them. trans_arrive.nss already
        // reads exactly the PendingArriveArea + GetName(oPC)+"Loc" data set
        // above, so it's reused as-is - no separate worker needed here.
        if (!AreaPopIsReady(oMember))
        {
            SetLocalObject(oPC, "PendingArriveArea", oMember);
            DelayCommand(0.0, ExecuteScript("trans_arrive", oPC));
        }
        else
        {
            AssignCommand(oPC, ActionJumpToLocation(lLoc));
            int iH = 1;
            object oH = GetHenchman(oPC, iH);
            while (GetIsObjectValid(oH))
            {
                AssignCommand(oH, ClearAllActions(TRUE));
                AssignCommand(oH, ActionJumpToLocation(lLoc));
                iH++;
                oH = GetHenchman(oPC, iH);
            }
        }
    }

    // Same PC-local cleanup as the bottom of transitions.nss.
    DeleteLocalString(oPC, "PlanetDest");
    DeleteLocalString(oPC, "AreaDest");
    DeleteLocalObject(oPC, "DestroyIt");
    DeleteLocalObject(oPC, "DestroyIt2");
    DeleteLocalString(oPC, "NewAreaSpecial");
    DeleteLocalInt(oPC, "Henchs");
    DeleteLocalString(oPC, "TransDir");
}
