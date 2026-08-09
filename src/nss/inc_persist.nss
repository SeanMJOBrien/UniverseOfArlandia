// inc_persist - persistent "area exploration / map memory" for players.
//
// Ported from tfn-map-memory's inc_persist (itself a trimmed extract of The
// Frozen North's inc_persist, keeping only ExportMinimap/ImportMinimap).
//
// The stored explored-tile bitmap is kept in a small per-character SQLite table
// (the PC's persistent campaign DB), independent of UOA's shared pwdata/MySQL
// schema. Requires the NWNX_Player plugin at runtime for
// NWNX_Player_Get/SetAreaExplorationState (already wired in nwnx_player.nss).
//
// UOA clones most world-tile areas at runtime (see transitions.nss) and the
// engine assigns each clone an auto-generated resref that is freed and reused
// once the clone is destroyed - so a raw area resref is not a safe long-term
// key. Instead we key on the same "Planet"+"Area" coordinate pair transitions.nss
// already stamps onto every clone (stable across that coordinate's clone being
// torn down and recreated), falling back to the area's tag for static,
// never-cloned areas (cities, interiors) that never get those locals set.
//
// Behaviour:
//   * Areas with local int "explored" = 1 are fully revealed to any PC on entry
//     (an always-known area, e.g. a home town).
//   * All other real areas remember exactly the tiles a PC has walked, restored
//     on entry (ImportMinimap) and re-saved on exit (ExportMinimap).

#include "nwnx_player"
#include "inc_debug"

// Local int on an area: set to 1 to always fully reveal it to entering players.
const string MAPMEMORY_AREA_EXPLORED = "explored";

// Stable per-coordinate key for an area: "Planet_Area" for cloned/coordinate
// areas, or the area's tag for static areas that never get those locals set.
string MapMemory_GetAreaKey(object oArea);

// Saves the current area's minimap data for the PC.
void ExportMinimap(object oPC);

// Loads the PC's current area minimap data (or fully reveals "explored" areas).
void ImportMinimap(object oPC);

// -------------------------------------------------------------------------

// Create the per-character storage table if it does not yet exist. Internal.
void MapMemory_CreateTable(object oPC)
{
    string sTable = "CREATE TABLE IF NOT EXISTS pc_mapmemory ( " +
                    "area_key TEXT NOT NULL PRIMARY KEY, " +
                    "explore_state TEXT NOT NULL);";
    sqlquery sql = SqlPrepareQueryObject(oPC, sTable);
    SqlStep(sql);
}

string MapMemory_GetAreaKey(object oArea)
{
    string sPlanet = GetLocalString(oArea, "Planet");
    string sArea = GetLocalString(oArea, "Area");
    if (sPlanet != "" && sArea != "") return sPlanet + "_" + sArea;
    return GetTag(oArea);
}

void ExportMinimap(object oPC)
{
    if (!GetIsObjectValid(oPC)) return;
    if (!GetIsPC(oPC)) return;

    object oArea = GetArea(oPC);
    // GetIsAreaNatural returns AREA_INVALID (-1) for non-areas.
    if (GetIsAreaNatural(oArea) == AREA_INVALID) return;

    // Fully-revealed areas need no per-PC memory.
    if (GetLocalInt(oArea, MAPMEMORY_AREA_EXPLORED) == 1) return;

    MapMemory_CreateTable(oPC);

    string sState = NWNX_Player_GetAreaExplorationState(oPC, oArea);
    string sKey = MapMemory_GetAreaKey(oArea);

    string sInsert = "INSERT INTO pc_mapmemory (area_key, explore_state) " +
                     "VALUES (@key, @state) " +
                     "ON CONFLICT(area_key) DO UPDATE SET explore_state = @state;";
    sqlquery sql = SqlPrepareQueryObject(oPC, sInsert);
    SqlBindString(sql, "@key", sKey);
    SqlBindString(sql, "@state", sState);
    SqlStep(sql);

    SendDebugMessage("exporting minimap map_" + sKey);
}

void ImportMinimap(object oPC)
{
    if (!GetIsObjectValid(oPC)) return;
    if (!GetIsPC(oPC)) return;

    object oArea = GetArea(oPC);
    if (GetIsAreaNatural(oArea) == AREA_INVALID) return;

    // Always-known areas: fully reveal and stop.
    if (GetLocalInt(oArea, MAPMEMORY_AREA_EXPLORED) == 1)
    {
        ExploreAreaForPlayer(oArea, oPC, FALSE);
        ExploreAreaForPlayer(oArea, oPC, TRUE);
        return;
    }

    MapMemory_CreateTable(oPC);

    string sKey = MapMemory_GetAreaKey(oArea);
    string sSelect = "SELECT explore_state FROM pc_mapmemory WHERE area_key = @key;";
    sqlquery sql = SqlPrepareQueryObject(oPC, sSelect);
    SqlBindString(sql, "@key", sKey);

    if (!SqlStep(sql)) return;

    string sState = SqlGetString(sql, 0);
    SendDebugMessage("importing minimap map_" + sKey);
    if (sState == "") return;

    // Clear first so stale tiles do not linger, then apply saved state.
    ExploreAreaForPlayer(oArea, oPC, FALSE);
    NWNX_Player_SetAreaExplorationState(oPC, oArea, sState);
}
