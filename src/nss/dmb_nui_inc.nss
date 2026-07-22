// dmb_nui_inc - Builder + save/remove logic for the DM cluster editor NUI
// (".wcluster" chat command, see mod_chat.nss).
// ---
// One window per DM showing the four cardinal sides of a world coordinate;
// each side is either blocked or mapped to one member area. "Set to my area"
// captures the DM's current area as that side's member, so the workflow is:
// stand in a member, Set its side, walk to the next member (the window
// persists), Set again, Save.
//
// Follows the pilot_nui pattern exactly: per-window event script routed via
// NuiCreate's sEventScript (see dmb_nui_event.nss), page refreshes through
// NuiSetGroupLayout on the "_window_" root, and explicit NuiWidth/NuiHeight
// on every element (NuiCol splits leftover space evenly otherwise).

#include "nw_inc_nui"
#include "dmb_inc"

const string DMB_NUI_EVENT_SCRIPT = "dmb_nui_event";
const string DMB_NUI_WINDOW       = "dmb_cluster";
const string DMB_NUI_ROOT         = "_window_";    // NuiSetGroupLayout's magic window-root id
const string DMB_NUI_SAVE         = "save";
const string DMB_NUI_REMOVE       = "remove";

const float  DMB_NUI_CONTENT_WIDTH = 380.0;
const float  DMB_NUI_ROW_HEIGHT    = 32.0;
const float  DMB_NUI_HINT_HEIGHT   = 58.0;

// Tile code written when a cluster is removed (04 = forest terrain).
const string DMB_NUI_RESET_CODE = "04";

// Direction name for slot 1..4 (N,E,S,W - the record's field order).
string DmbNuiDir(int iSlot)
{
    if (iSlot == 1) return "North";
    if (iSlot == 2) return "East";
    if (iSlot == 3) return "South";
    return "West";
}

// One direction row: "North: <memberTag or (blocked)>" + Set/Block buttons.
json DmbClusterNuiDirRow(object oPC, string sDir)
{
    string sTag = GetLocalString(oPC, "DmbClu_" + sDir);
    string sLabel = sDir + ": " + ((sTag == "") ? "(blocked)" : sTag);

    json jRow = JsonArray();
    jRow = JsonArrayInsert(jRow, NuiHeight(NuiWidth(NuiLabel(JsonString(sLabel), JsonInt(NUI_HALIGN_LEFT), JsonInt(NUI_VALIGN_MIDDLE)), 180.0), DMB_NUI_ROW_HEIGHT));
    jRow = JsonArrayInsert(jRow, NuiHeight(NuiWidth(NuiId(NuiButton(JsonString("Set to my area")), "set_" + sDir), 130.0), DMB_NUI_ROW_HEIGHT));
    jRow = JsonArrayInsert(jRow, NuiHeight(NuiWidth(NuiId(NuiButton(JsonString("Block")), "blk_" + sDir), 62.0), DMB_NUI_ROW_HEIGHT));
    return NuiHeight(NuiRow(jRow), DMB_NUI_ROW_HEIGHT + 8.0);
}

// The editor's single page, rebuilt from the DM's DmbClu_* locals on every
// refresh.
json DmbClusterNuiPage(object oPC)
{
    string sPlanet = GetLocalString(oPC, "DmbCluPlanet");
    string sCoord = GetLocalString(oPC, "DmbCluCoord");
    string sHint = "Each side of " + sCoord + " is blocked or leads into one member area. Stand in a member and press Set to map a side to it, then Save.";

    json jList = JsonArray();
    jList = JsonArrayInsert(jList, NuiHeight(NuiWidth(NuiLabel(JsonString("Cluster at " + sPlanet + " " + sCoord), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_MIDDLE)), DMB_NUI_CONTENT_WIDTH), DMB_NUI_ROW_HEIGHT));
    jList = JsonArrayInsert(jList, NuiHeight(NuiWidth(NuiText(JsonString(sHint), FALSE, NUI_SCROLLBARS_NONE), DMB_NUI_CONTENT_WIDTH), DMB_NUI_HINT_HEIGHT));

    int iSlot;
    for (iSlot = 1; iSlot <= 4; iSlot++)
        jList = JsonArrayInsert(jList, DmbClusterNuiDirRow(oPC, DmbNuiDir(iSlot)));

    json jButtons = JsonArray();
    jButtons = JsonArrayInsert(jButtons, NuiHeight(NuiWidth(NuiId(NuiButton(JsonString("Save")), DMB_NUI_SAVE), 110.0), DMB_NUI_ROW_HEIGHT));
    jButtons = JsonArrayInsert(jButtons, NuiHeight(NuiWidth(NuiId(NuiButton(JsonString("Remove cluster")), DMB_NUI_REMOVE), 150.0), DMB_NUI_ROW_HEIGHT));
    jList = JsonArrayInsert(jList, NuiHeight(NuiRow(jButtons), DMB_NUI_ROW_HEIGHT + 8.0));

    return NuiCol(jList);
}

// Refresh the open window after a state change.
void DmbClusterNuiRefresh(object oPC, int nTok)
{
    NuiSetGroupLayout(oPC, nTok, DMB_NUI_ROOT, DmbClusterNuiPage(oPC));
}

// Open the cluster editor for a coordinate, prefilling the per-direction
// locals from any existing cluster record so the editor shows current state.
void DmbClusterNuiOpen(object oPC, string sPlanet, string sCoord)
{
    object oModule = GetModule();
    SetLocalString(oPC, "DmbCluPlanet", sPlanet);
    SetLocalString(oPC, "DmbCluCoord", sCoord);

    string sRecord = DmbClusterRecord(oModule, sPlanet, sCoord);
    int iSlot;
    for (iSlot = 1; iSlot <= 4; iSlot++)
    {
        string sDir = DmbNuiDir(iSlot);
        string sTag = DmbClusterDirTag(sRecord, sDir);
        if (sTag != "") SetLocalString(oPC, "DmbClu_" + sDir, sTag);
        else            DeleteLocalString(oPC, "DmbClu_" + sDir);
    }

    json jWin = NuiWindow(DmbClusterNuiPage(oPC), JsonString("Cluster - " + sPlanet + " " + sCoord), NuiRect(-1.0, -1.0, 420.0, 460.0), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE), JsonBool(FALSE), JsonBool(TRUE));
    NuiCreate(oPC, jWin, DMB_NUI_WINDOW, DMB_NUI_EVENT_SCRIPT);
}

// Delete the editor's PC-local working state (window closed).
void DmbClusterNuiCleanup(object oPC)
{
    DeleteLocalString(oPC, "DmbCluPlanet");
    DeleteLocalString(oPC, "DmbCluCoord");
    int iSlot;
    for (iSlot = 1; iSlot <= 4; iSlot++)
        DeleteLocalString(oPC, "DmbClu_" + DmbNuiDir(iSlot));
}

// "Set to my area": capture the DM's current area as sDir's member. Returns
// TRUE if the state changed (caller refreshes the page). Clones and "000"
// templates are refused (destroyed on vacate / never meant to be entered),
// as is any area already serving another world coordinate.
int DmbClusterNuiSetHere(object oPC, string sDir)
{
    object oArea = GetArea(oPC);
    string sTag = GetTag(oArea);
    string sHerePlanet = GetLocalString(oPC, "DmbCluPlanet");
    string sHereCoord = GetLocalString(oPC, "DmbCluCoord");

    if (GetLocalInt(oArea, "IsCopy") == 1)
    {
        SendMessageToPC(oPC, "This area is a temporary copy (destroyed when vacated) - it cannot be a cluster member. Use a static hand-built area.");
        return FALSE;
    }
    if (GetStringRight(sTag, 3) == "000")
    {
        SendMessageToPC(oPC, "'" + sTag + "' is a template area - it cannot be a cluster member.");
        return FALSE;
    }
    string sPlanetLocal = GetLocalString(oArea, "Planet");
    string sAreaLocal = GetLocalString(oArea, "Area");
    if ((sPlanetLocal != "") && ((sPlanetLocal != sHerePlanet) || (sAreaLocal != sHereCoord)))
    {
        SendMessageToPC(oPC, "'" + sTag + "' is already in use as " + sPlanetLocal + " " + sAreaLocal + " - it cannot join this cluster.");
        return FALSE;
    }

    SetLocalString(oPC, "DmbClu_" + sDir, sTag);
    SendMessageToPC(oPC, sDir + " side of " + sHereCoord + " set to '" + sTag + "' (not saved yet).");
    return TRUE;
}

// "Save": persist the record, mark the tile as a cluster (discovered, so it
// survives reboots), evict any live instance of the old tile, and stamp the
// members. The window stays open.
void DmbClusterNuiSave(object oPC)
{
    object oModule = GetModule();
    string sPlanet = GetLocalString(oPC, "DmbCluPlanet");
    string sCoord = GetLocalString(oPC, "DmbCluCoord");
    string sNorth = GetLocalString(oPC, "DmbClu_North");
    string sEast  = GetLocalString(oPC, "DmbClu_East");
    string sSouth = GetLocalString(oPC, "DmbClu_South");
    string sWest  = GetLocalString(oPC, "DmbClu_West");

    if ((sNorth == "") && (sEast == "") && (sSouth == "") && (sWest == ""))
    {
        SendMessageToPC(oPC, "Map at least one direction before saving.");
        return;
    }
    if (!DmbEvictTile(oModule, sPlanet, sCoord))
    {
        SendMessageToPC(oPC, "Players are at " + sPlanet + " " + sCoord + " - move them out first.");
        return;
    }

    string sOldRecord = DmbClusterRecord(oModule, sPlanet, sCoord);
    if (sOldRecord != "") DmbClearMembers(oModule, sOldRecord);

    string sRecord = DmbBuildClusterRecord(sNorth, sEast, sSouth, sWest);
    DmbSetClusterRecord(oModule, sPlanet, sCoord, sRecord);
    DmbWriteTileCode(oModule, sPlanet, DmbParseCoord(sCoord, TRUE), DmbParseCoord(sCoord, FALSE), DMB_TILE_CLUSTER);
    DmbStampAllMembers(sPlanet, sCoord, sRecord);

    SendMessageToPC(oPC, "Cluster saved at " + sPlanet + " " + sCoord
        + ". North: " + ((sNorth == "") ? "blocked" : sNorth)
        + ", East: " + ((sEast == "") ? "blocked" : sEast)
        + ", South: " + ((sSouth == "") ? "blocked" : sSouth)
        + ", West: " + ((sWest == "") ? "blocked" : sWest) + ".");
}

// "Remove cluster": delete the record + index entry, release the members,
// and put a plain terrain tile (still discovered) back at the coordinate.
void DmbClusterNuiRemove(object oPC)
{
    object oModule = GetModule();
    string sPlanet = GetLocalString(oPC, "DmbCluPlanet");
    string sCoord = GetLocalString(oPC, "DmbCluCoord");

    string sOldRecord = DmbClusterRecord(oModule, sPlanet, sCoord);
    if (sOldRecord == "")
    {
        SendMessageToPC(oPC, "There is no saved cluster at " + sPlanet + " " + sCoord + ".");
        return;
    }
    if (!DmbEvictTile(oModule, sPlanet, sCoord))
    {
        SendMessageToPC(oPC, "Players are at " + sPlanet + " " + sCoord + " - move them out first.");
        return;
    }

    DmbClearMembers(oModule, sOldRecord);
    DmbSetClusterRecord(oModule, sPlanet, sCoord, "");
    DmbWriteTileCode(oModule, sPlanet, DmbParseCoord(sCoord, TRUE), DmbParseCoord(sCoord, FALSE), DMB_NUI_RESET_CODE);

    int iSlot;
    for (iSlot = 1; iSlot <= 4; iSlot++)
        DeleteLocalString(oPC, "DmbClu_" + DmbNuiDir(iSlot));

    SendMessageToPC(oPC, "Cluster removed. " + sPlanet + " " + sCoord + " is now forest terrain (code " + DMB_NUI_RESET_CODE + ") - use .warea to put something else there.");
}
