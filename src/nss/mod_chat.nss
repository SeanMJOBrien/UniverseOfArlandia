// mod_chat - Module OnPlayerChat handler: DM world-builder ".w" commands.
// ---
// Only reacts to DM / DM-possessed speakers whose message starts with ".w";
// everyone else's chat passes through untouched. Recognized commands are
// suppressed from broadcast and dispatched:
//   .wjump <X_Y>              jump to a coordinate on the current planet
//   .warea <tagprefix> [X_Y]  set a tile's code to a hand-built area prefix
//                             (or a 2-digit terrain code), persisted
//   .wcluster [X_Y]           open the cluster editor NUI (dmb_nui_inc)
// Coordinates use the world's "m = negative" form, e.g. m3_5.

#include "dmb_inc"
#include "dmb_nui_inc"

// Command target: a validated planet + coordinate.
struct DmbTarget
{
    int bValid;
    string sPlanet;
    string sCoord;
    int iX;
    int iY;
};

string DmbTrim(string sText)
{
    while (GetStringLeft(sText, 1) == " ") sText = GetStringRight(sText, GetStringLength(sText) - 1);
    while (GetStringRight(sText, 1) == " ") sText = GetStringLeft(sText, GetStringLength(sText) - 1);
    return sText;
}

void DmbChatUsage(object oPC)
{
    SendMessageToPC(oPC, "World-builder commands: .wjump <X_Y> | .warea <tagprefix> [X_Y] | .wcluster [X_Y]  (coordinates use m for negative, e.g. m3_5)");
}

// Resolve the command's target coordinate: the explicit argument, or the
// DM's current world tile when omitted. Validates format and planet bounds
// and reports every failure to the DM itself.
struct DmbTarget DmbResolveTarget(object oPC, string sCoordArg)
{
    struct DmbTarget t;
    t.bValid = FALSE;
    object oModule = GetModule();
    object oArea = GetArea(oPC);

    t.sPlanet = GetLocalString(oArea, "Planet");
    if ((t.sPlanet == "") || (t.sPlanet == "Space"))
    {
        SendMessageToPC(oPC, "You must be in a planetary surface area to use world commands.");
        return t;
    }

    string sCoord = sCoordArg;
    if (sCoord == "")
    {
        sCoord = GetLocalString(oArea, "Area");
        if (GetStringRight(sCoord, 5) == "_Ship") sCoord = GetStringLeft(sCoord, GetStringLength(sCoord) - 5);
        if ((sCoord == "") || (FindSubString(sCoord, "&") != -1))
        {
            SendMessageToPC(oPC, "You are not on a world tile - give an explicit coordinate.");
            return t;
        }
    }

    t.iX = DmbParseCoord(sCoord, TRUE);
    t.iY = DmbParseCoord(sCoord, FALSE);
    if ((t.iX == DMB_COORD_INVALID) || (t.iY == DMB_COORD_INVALID))
    {
        SendMessageToPC(oPC, "Bad coordinate '" + sCoord + "' - expected X_Y, m = negative (e.g. m3_5).");
        return t;
    }
    if (!DmbCoordInBounds(oModule, t.sPlanet, t.iX, t.iY))
    {
        int iSize = DmbPlanetSize(oModule, t.sPlanet);
        SendMessageToPC(oPC, "Coordinate " + sCoord + " is out of range for " + t.sPlanet + " (size " + IntToString(iSize) + ", max +/-" + IntToString(iSize / 2) + ").");
        return t;
    }

    t.sCoord = DmbCoordString(t.iX, t.iY);
    t.bValid = TRUE;
    return t;
}

// .wjump <X_Y> - jump the DM to a coordinate (conv_dm020's teleport pattern).
void DmbCmdJump(object oPC, string sArgs)
{
    if (sArgs == "")
    {
        SendMessageToPC(oPC, "Usage: .wjump <X_Y>");
        return;
    }
    struct DmbTarget t = DmbResolveTarget(oPC, sArgs);
    if (!t.bValid) return;

    DeleteLocalString(oPC, "TransDir");
    SetLocalString(oPC, "PlanetDest", t.sPlanet);
    SetLocalString(oPC, "AreaDest", t.sCoord);
    SetLocalFloat(oPC, "fX", 50.0);
    SetLocalFloat(oPC, "fY", 50.0);
    SetLocalFloat(oPC, "fFacing", 90.0);
    AssignCommand(oPC, ClearAllActions());
    ExecuteScript("transitions", oPC);
}

// TRUE for a 2-digit terrain code "01".."23" (the transitions.nss mapping).
int DmbIsTerrainCode(string sCode)
{
    if (GetStringLength(sCode) != 2) return FALSE;
    if (FindSubString("0123456789", GetStringLeft(sCode, 1)) == -1) return FALSE;
    if (FindSubString("0123456789", GetStringRight(sCode, 1)) == -1) return FALSE;
    int iCode = StringToInt(sCode);
    return ((iCode >= 1) && (iCode <= 23));
}

// .warea <tagprefix> [X_Y] - replace a tile's code, persisted across
// reboots (discovered flag), preserving all other records at the
// coordinate (Interests/Domain/Objects live under separate pwdata keys
// that are simply never touched here).
void DmbCmdArea(object oPC, string sArgs)
{
    object oModule = GetModule();
    string sPrefix = sArgs;
    string sCoordArg = "";
    int iSpace = FindSubString(sArgs, " ");
    if (iSpace != -1)
    {
        sPrefix = GetStringLeft(sArgs, iSpace);
        sCoordArg = DmbTrim(GetStringRight(sArgs, GetStringLength(sArgs) - iSpace - 1));
    }

    if (sPrefix == "")
    {
        SendMessageToPC(oPC, "Usage: .warea <tagprefix> [X_Y] - the prefix is the area tag minus its 000/001 suffix, or a terrain code 01-23.");
        return;
    }
    if (sPrefix == DMB_TILE_CLUSTER)
    {
        SendMessageToPC(oPC, "Use .wcluster to build a cluster tile.");
        return;
    }

    struct DmbTarget t = DmbResolveTarget(oPC, sCoordArg);
    if (!t.bValid) return;

    if ((!DmbIsTerrainCode(sPrefix))
        && (!GetIsObjectValid(GetObjectByTag(sPrefix + "000")))
        && (!GetIsObjectValid(GetObjectByTag(sPrefix + "001"))))
    {
        SendMessageToPC(oPC, "No area tagged '" + sPrefix + "000' or '" + sPrefix + "001' exists in the module (and '" + sPrefix + "' is not a terrain code 01-23).");
        return;
    }

    string sOldCode = GetAreaTile(oModule, t.sPlanet, t.iX, t.iY);
    if (!DmbEvictTile(oModule, t.sPlanet, t.sCoord))
    {
        SendMessageToPC(oPC, "Players are at " + t.sPlanet + " " + t.sCoord + " - move them out first.");
        return;
    }

    // A cluster being overwritten releases its members and record first.
    if (sOldCode == DMB_TILE_CLUSTER)
    {
        DmbClearMembers(oModule, DmbClusterRecord(oModule, t.sPlanet, t.sCoord));
        DmbSetClusterRecord(oModule, t.sPlanet, t.sCoord, "");
    }

    DmbWriteTileCode(oModule, t.sPlanet, t.iX, t.iY, sPrefix);
    SendMessageToPC(oPC, "Tile " + t.sPlanet + " " + t.sCoord + " changed: '" + sOldCode + "' -> '" + sPrefix + "' (discovered, survives reboot; Interests/Domain/Objects records preserved). Use .wjump " + t.sCoord + " to visit.");
}

// .wcluster [X_Y] - open the cluster editor NUI.
void DmbCmdCluster(object oPC, string sArgs)
{
    struct DmbTarget t = DmbResolveTarget(oPC, sArgs);
    if (!t.bValid) return;
    DmbClusterNuiOpen(oPC, t.sPlanet, t.sCoord);
}

void main()
{
    object oPC = GetPCChatSpeaker();
    string sMsg = GetPCChatMessage();

    if (GetStringLeft(sMsg, 2) != ".w") return;
    if ((!GetIsDM(oPC)) && (!GetIsDMPossessed(oPC))) return;

    SetPCChatMessage(""); // never broadcast DM commands

    sMsg = DmbTrim(sMsg);
    string sVerb = sMsg;
    string sArgs = "";
    int iSpace = FindSubString(sMsg, " ");
    if (iSpace != -1)
    {
        sVerb = GetStringLeft(sMsg, iSpace);
        sArgs = DmbTrim(GetStringRight(sMsg, GetStringLength(sMsg) - iSpace - 1));
    }

    if (sVerb == ".wjump")         DmbCmdJump(oPC, sArgs);
    else if (sVerb == ".warea")    DmbCmdArea(oPC, sArgs);
    else if (sVerb == ".wcluster") DmbCmdCluster(oPC, sArgs);
    else                           DmbChatUsage(oPC);
}
