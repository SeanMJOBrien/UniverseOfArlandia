// inc_mappin - persistent player map pins.
//
// Ported from tfn-map-memory's inc_mappin (originally from The Frozen North).
// Saves the map pins a player drops (stored by the engine in NW_MAP_PIN_*
// locals) into the character's persistent campaign DB so they survive relog,
// and restores them on login.
//
// Pins are keyed by MapMemory_GetAreaKey (see inc_persist.nss) instead of a
// raw area tag: UOA's CopyArea() world-tile clones all keep their source
// template's tag forever (see TODO.md TASK-22), so a tag alone can collide
// across every simultaneously-live clone of the same tile type. The
// Planet+Area coordinate key avoids that collision and survives a
// coordinate's clone being torn down and recreated.
//
// A saved pin whose coordinate has no live area object at load time (nobody
// has revisited that coordinate since it was last torn down) is skipped
// rather than erroring; the row is left in place and resolves again next
// time that coordinate's clone exists.

#include "inc_persist"
#include "inc_debug"

void MapPin_CreatePCMapPinTable(object oPC, int bReset = FALSE)
{
    if (bReset == TRUE)
    {
        string sqlDelete = "DROP TABLE IF EXISTS pc_mappin;";
        sqlquery sql = SqlPrepareQueryObject(oPC, sqlDelete);
        SqlStep(sql);
    }

    string sqlTable = "CREATE TABLE IF NOT EXISTS pc_mappin ( " +
                        "id INTEGER, " +
                        "area_key TEXT NOT NULL, " +
                        "pos_x REAL NOT NULL, " +
                        "pos_y REAL NOT NULL, " +
                        "note TEXT);";
    sqlquery sql = SqlPrepareQueryObject(oPC, sqlTable);
    SqlStep(sql);
}

int MapPin_GetMapPinTableExists(object oPC)
{
    string sqlExists = "SELECT name " +
                    "FROM sqlite_master WHERE type = 'table' " +
                    "AND name = @table_name;";
    sqlquery sql = SqlPrepareQueryObject(oPC, sqlExists);
    SqlBindString(sql, "@table_name", "pc_mappin");

    return SqlStep(sql);
}

void MapPin_ResetPCMapPinTable(object oPC)
{
    MapPin_CreatePCMapPinTable(oPC, TRUE);
}

void MapPin_DeleteMapPinVariables(object oPC, string sPinID)
{
    DeleteLocalObject(oPC, "NW_MAP_PIN_AREA_" + sPinID);
    DeleteLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID);
    DeleteLocalFloat(oPC, "NW_MAP_PIN_XPOS_" + sPinID);
    DeleteLocalFloat(oPC, "NW_MAP_PIN_YPOS_" + sPinID);
}

void MapPin_SavePCMapPins(object oPC)
{
    MapPin_ResetPCMapPinTable(oPC);

    int nPins = GetLocalInt(oPC, "NW_TOTAL_MAP_PINS");
    int n, nPinCount = 1;

    if (nPins == 0)
    {
        SendDebugMessage("pin count is 0 for " + GetName(oPC) + ", skipping");
        return;
    }

    for (n = 1; n <= nPins; n++)
    {
        string sPinID = IntToString(n);
        object oArea = GetLocalObject(oPC, "NW_MAP_PIN_AREA_" + sPinID);

        string sPinAreaKey = MapMemory_GetAreaKey(oArea);
        string sPinNote = GetLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID);
        float fPin_X = GetLocalFloat(oPC, "NW_MAP_PIN_XPOS_" + sPinID);
        float fPin_Y = GetLocalFloat(oPC, "NW_MAP_PIN_YPOS_" + sPinID);

        if (GetIsObjectValid(oArea) == FALSE)
        {
            MapPin_DeleteMapPinVariables(oPC, sPinID);
            continue;
        }

        string sqlInsert = "INSERT INTO pc_mappin VALUES (@id, @area_key, @pos_x, @pos_y, @note);";
        sqlquery sql = SqlPrepareQueryObject(oPC, sqlInsert);
        SqlBindInt(sql, "@id", nPinCount++);
        SqlBindString(sql, "@area_key", sPinAreaKey);
        SqlBindFloat(sql, "@pos_x", fPin_X);
        SqlBindFloat(sql, "@pos_y", fPin_Y);
        SqlBindString(sql, "@note", sPinNote);

        SqlStep(sql);

        MapPin_DeleteMapPinVariables(oPC, sPinID);
    }

    DeleteLocalInt(oPC, "NW_TOTAL_MAP_PINS");
}

void MapPin_LoadPCMapPins(object oPC)
{
    if (MapPin_GetMapPinTableExists(oPC) == FALSE)
    {
        SendDebugMessage("map pin table does not exist on " + GetName(oPC) + "; skipping");
        return;
    }

    string sQuery = "SELECT * FROM pc_mappin;";
    sqlquery sql = SqlPrepareQueryObject(oPC, sQuery);

    object oModule = GetModule();
    int nPinCount = 1;

    while (SqlStep(sql))
    {
        string sAreaKey = SqlGetString(sql, 1);
        float fPos_X = SqlGetFloat(sql, 2);
        float fPos_Y = SqlGetFloat(sql, 3);
        string sNote = SqlGetString(sql, 4);

        // transitions.nss caches each coordinate's live clone under this
        // exact key on the module object; fall back to tag for static areas.
        object oArea = GetLocalObject(oModule, sAreaKey);
        if (GetIsObjectValid(oArea) == FALSE)
            oArea = GetObjectByTag(sAreaKey);
        if (GetIsObjectValid(oArea) == FALSE)
        {
            SendDebugMessage("map pin area '" + sAreaKey + "' not currently loaded for " +
                              GetName(oPC) + "; skipping pin");
            continue;
        }

        string sPinID = IntToString(nPinCount++);
        SetLocalObject(oPC, "NW_MAP_PIN_AREA_" + sPinID, oArea);
        SetLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID, sNote);
        SetLocalFloat(oPC, "NW_MAP_PIN_XPOS_" + sPinID, fPos_X);
        SetLocalFloat(oPC, "NW_MAP_PIN_YPOS_" + sPinID, fPos_Y);
    }

    if (nPinCount > 1)
        SetLocalInt(oPC, "NW_TOTAL_MAP_PINS", --nPinCount);
}
