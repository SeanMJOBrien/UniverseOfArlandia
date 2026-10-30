// mod_chat - Module OnPlayerChat handler: player ".web" command and DM
// world-builder ".w" commands.
// ---
// Language commands (.lang window, .languages/.speak/.learn/.teach, see
// dmfi_lang_inc and dmfi_lang_nui) are
// handled first. Otherwise it only reacts to messages starting with ".w";
// everything else passes through untouched. Recognized commands are
// suppressed from broadcast and dispatched:
//   .web                      (any player) issue a one-time website
//                             registration code for this CD key
//   .wjump <X_Y>              jump to a coordinate on the current planet
//   .warea <tagprefix> [X_Y]  set a tile's code to a hand-built area prefix
//                             (or a 2-digit terrain code), persisted
//   .wcluster [X_Y]           open the cluster editor NUI (dmb_nui_inc)
// Every command except .web is DM-only.
// Coordinates use the world's "m = negative" form, e.g. m3_5.

#include "dmb_inc"
#include "dmb_nui_inc"
#include "_webmap"
#include "_unitrent"
#include "_domaintransfer"
#include "dmfi_lang_nui"
#include "dmfi_lang_teach"
#include "dmfi_lang_nwnx"

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
    SendMessageToPC(oPC, "World-builder commands: .wjump <X_Y> | .warea <tagprefix> [X_Y] | .wcluster [X_Y] | .wunits <count> [sizes]  (coordinates use m for negative, e.g. m3_5)");
    SendMessageToPC(oPC, "Domain commands (stand in the domain): .wdomain | .wowner <Character Name> [keep] [force] | .wgrant <Character Name> [slot] | .wrevoke <Character Name> [slot]");
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

// .web - issue this player a one-time code for registering on the website.
// The code is written to pwdata (WebCode_<cdkey>); register.php accepts it for
// a short window, proving the person on the site is the person holding the key.
void WebCmdCode(object oPC)
{
    string sCDKey = WebMapKey(oPC);
    if (sCDKey == "")
    {
        SendMessageToPC(oPC, "No public CD key found for you - website registration needs a multiplayer CD key.");
        return;
    }

    string sCode = WebMapIssueCode(oPC);
    SendMessageToPC(oPC, "Website registration - CD key: " + sCDKey + "   code: " + sCode);
    SendMessageToPC(oPC, "Enter both on the site's Register page within 30 minutes to pick your password. The code stops working once used, and .web issues a fresh one.");
}


// .wunits <count> [sizes] - configure the nearest multi-unit rental door.
// sizes is an optional comma list, one entry per unit: 1 small, 2 medium,
// 3 large. Missing or short lists default the remainder to small.
//   .wunits 6 1,1,1,1,3,1     six units, the fifth large
//   .wunits 4                 four small units
//   .wunits 0                 clear the configuration
//
// Saved to the database, not to the door: a local variable set in-game would
// not survive a restart. A door configured in the toolset still works - its
// own "Units"/"Unit<n>" locals are used whenever no database row exists.
void DmbCmdUnits(object oPC, string sArgs)
{
    object oDoor = GetNearestObjectByTag("unitdoor", oPC);
    if (!GetIsObjectValid(oDoor))
    {
        SendMessageToPC(oPC, "No rental door (tag 'unitdoor') found nearby.");
        return;
    }
    if (GetDistanceBetween(oPC, oDoor) > 10.0)
    {
        SendMessageToPC(oPC, "Stand closer to the rental door you want to configure.");
        return;
    }
    if (sArgs == "")
    {
        SendMessageToPC(oPC, "Usage: .wunits <count> [sizes]  e.g. .wunits 6 1,1,1,1,3,1");
        return;
    }

    string sCount = sArgs;
    string sSizes = "";
    int iSpace = FindSubString(sArgs, " ");
    if (iSpace != -1)
    {
        sCount = GetStringLeft(sArgs, iSpace);
        sSizes = DmbTrim(GetStringRight(sArgs, GetStringLength(sArgs) - iSpace - 1));
    }

    int iCount = StringToInt(sCount);
    if (iCount < 0) { iCount = 0; }
    if (iCount > UNITRENT_MAX)
    {
        SendMessageToPC(oPC, "At most " + IntToString(UNITRENT_MAX) + " units per door.");
        return;
    }

    if (iCount == 0)
    {
        UnitSetConfig(oDoor, 0, "");
        SendMessageToPC(oPC, "Rental door cleared - it now offers no units.");
        return;
    }

    // Pad the size list out to the unit count so every unit has an explicit
    // entry, rather than relying on the reader's default.
    string sFull = "";
    string sRest = sSizes + ",";
    int n;
    for (n = 1; n <= iCount; n++)
    {
        int iSize = 1;
        int iComma = FindSubString(sRest, ",");
        if (iComma > 0)
        {
            iSize = StringToInt(GetStringLeft(sRest, iComma));
            sRest = GetStringRight(sRest, GetStringLength(sRest) - iComma - 1);
        }
        if ((iSize < 1) || (iSize > 3)) { iSize = 1; }
        if (sFull != "") { sFull = sFull + ","; }
        sFull = sFull + IntToString(iSize);
    }

    UnitSetConfig(oDoor, iCount, sFull);
    SendMessageToPC(oPC, "Rental door set: " + IntToString(iCount) + " unit(s), sizes " + sFull + " (1 small, 2 medium, 3 large).");
}


// --- Domain ownership and access ------------------------------------------

// The domain the DM is standing in: its world coordinate and the outdoor area.
// Sets bInterior when the DM is inside a structure, where the owner cannot be moved.
string DmbDomainSummary(object oPC, object oArea)
{
    string sOwner = DomainOwnerName(oArea);
    if (sOwner == "") return "";
    int iAway = DomainDaysAway(sOwner);
    string sAway = "last seen unknown (not recorded yet)";
    string sSale = "";
    if (iAway == 0) sAway = "online or seen today";
    else if (iAway > 0) sAway = "away " + IntToString(iAway) + " day(s)";
    if (DomainIsAbandoned(oArea)) sSale = " FOR SALE at " + IntToString(iDomainAbandonedGP) + " GP";
    else if (iAway >= iDomainAbandonedDays) sSale = " INACTIVE, sale opens in " + IntToString(DomainSaleAfterDays() - iAway) + " day(s)";
    string sMail = "no email registered";
    if (DomainEmailFor(sOwner) != "") sMail = "email alerts on";
    return "Owner: " + sOwner + ", " + sAway + sSale + ", " + sMail;
}

// Split "Name With Spaces 3" into the name and a trailing word. A trailing word is
// only taken when it is one of the allowed flags or a number, never part of a name.
string DmbTrailing(string sArgs, int bNumber)
{
    int iLast = -1; int iAt;
    while ((iAt = FindSubString(GetStringRight(sArgs, GetStringLength(sArgs) - iLast - 1), " ")) != -1) { iLast = iLast + iAt + 1; }
    if (iLast == -1) return "";
    string sWord = GetStringRight(sArgs, GetStringLength(sArgs) - iLast - 1);
    if (bNumber) { if (IntToString(StringToInt(sWord)) == sWord) return sWord; return ""; }
    string sLow = GetStringLowerCase(sWord);
    if ((sLow == "keep") || (sLow == "force")) return sLow;
    return "";
}

string DmbStripTrailing(string sArgs, string sWord)
{
    if (sWord == "") return sArgs;
    return DmbTrim(GetStringLeft(sArgs, GetStringLength(sArgs) - GetStringLength(sWord)));
}

// Is this a character the server has met? A typo guard, bypassed with "force".
int DmbKnownCharacter(string sName)
{
    if (DomainFindOnlinePC(sName) != OBJECT_INVALID) return TRUE;
    return (GetPersistentInt(GetModule(), DOMAIN_SEEN_KEY + sName) > 0) || (GetPersistentInt(GetModule(), "LastLogin_" + sName) > 0) || (GetPersistentInt(GetModule(), DOMAIN_CLOCK_KEY + sName) > 0);
}

void DmbCmdDomain(object oPC)
{
    object oArea = GetArea(oPC);
    string sSummary = DmbDomainSummary(oPC, oArea);
    if (sSummary == "") { SendMessageToPC(oPC, "This is not a domain."); return; }
    SendMessageToPC(oPC, sSummary);
    string sPlanet = GetLocalString(oArea, "Planet");
    string sArea = DomainAreaOf(oArea);
    string sGrants = "";
    int iSlot;
    for (iSlot = DOMAINUSER_ALL_SLOTS; iSlot <= DOMAINUSER_MAX_SLOT; iSlot++)
    {
        string sList = DomainUsersList(sPlanet, sArea, iSlot);
        if (sList != "")
        {
            string sWho = GetStringRight(GetStringLeft(sList, GetStringLength(sList) - 1), GetStringLength(sList) - 2);
            string sWhere = "whole domain";
            if (iSlot > 0) sWhere = "slot " + IntToString(iSlot);
            sGrants += "\n  " + sWhere + ": " + sWho;
        }
    }
    if (sGrants == "") sGrants = " none";
    SendMessageToPC(oPC, "Access grants:" + sGrants);
}

void DmbCmdOwner(object oPC, string sArgs)
{
    object oArea = GetArea(oPC);
    if (GetLocalString(oArea, "AreaExit") != "") { SendMessageToPC(oPC, "Stand in the domain's outdoor area, not inside a structure."); return; }
    if (DomainOwnerName(oArea) == "") { SendMessageToPC(oPC, "This is not a domain."); return; }
    int bForce = FALSE; int bKeep = FALSE;
    string sFlag = DmbTrailing(sArgs, FALSE);
    while (sFlag != "")
    {
        if (sFlag == "force") bForce = TRUE; else bKeep = TRUE;
        sArgs = DmbStripTrailing(sArgs, sFlag);
        sFlag = DmbTrailing(sArgs, FALSE);
    }
    if (sArgs == "") { SendMessageToPC(oPC, "Usage: .wowner <Character Name> [keep] [force]   (keep = keep the access grants)"); return; }
    if (!bForce && !DmbKnownCharacter(sArgs))
    {
        SendMessageToPC(oPC, sArgs + " is not a character the server has recorded. Check the spelling, or add 'force'.");
        return;
    }
    string sOld = DomainOwnerName(oArea);
    int iCount = DomainTransferOwner(oArea, sArgs, !bKeep);
    SendMessageToPC(oPC, "Domain moved from " + sOld + " to " + sArgs + ". " + IntToString(iCount) + " object(s) updated. Production timers restarted.");
}

void DmbCmdGrant(object oPC, string sArgs, int bGrant)
{
    object oArea = GetArea(oPC);
    string sPlanet = GetLocalString(oArea, "Planet");
    string sArea = DomainAreaOf(oArea);
    if (DomainOwnerName(oArea) == "") { SendMessageToPC(oPC, "This is not a domain."); return; }
    int iSlot = DOMAINUSER_ALL_SLOTS;
    string sSlot = DmbTrailing(sArgs, TRUE);
    if (sSlot != "") { iSlot = StringToInt(sSlot); sArgs = DmbStripTrailing(sArgs, sSlot); }
    if ((sArgs == "") || (iSlot < 0) || (iSlot > DOMAINUSER_MAX_SLOT))
    {
        SendMessageToPC(oPC, "Usage: .wgrant|.wrevoke <Character Name> [slot 1-10]   (no slot = the whole domain)");
        return;
    }
    string sWhere = "the whole domain";
    if (iSlot > 0) sWhere = "slot " + IntToString(iSlot);
    if (bGrant)
    {
        DomainAddUser(sArgs, sPlanet, sArea, iSlot);
        SendMessageToPC(oPC, sArgs + " may now use " + sWhere + ".");
    }
    else
    {
        DomainRemoveUser(sArgs, sPlanet, sArea, iSlot);
        SendMessageToPC(oPC, sArgs + " no longer has access to " + sWhere + ".");
    }
    string sVerbWord = "revoked";
    if (bGrant) sVerbWord = "granted";
    WriteTimestampedLogEntry("DM " + GetName(oPC) + " " + sVerbWord + " " + sArgs + " on " + sPlanet + "&" + sArea + " " + sWhere);
}

// --- .email: a player's opt-in alerts about their domains ------------------

void ChatCmdEmail(object oPC, string sArgs)
{
    string sKey = DOMAIN_EMAIL_KEY + GetPCPlayerName(oPC);
    string sNow = GetPersistentString(GetModule(), sKey);
    string sLow = GetStringLowerCase(sArgs);
    if (sArgs == "")
    {
        if (sNow == "") SendMessageToPC(oPC, "No email registered. Type .email you@example.com to get an alert before a domain of yours goes up for sale. Type .email off to remove it.");
        else SendMessageToPC(oPC, "Alerts go to " + sNow + " for every character on this account. Type .email off to stop them.");
        return;
    }
    if (sLow == "off")
    {
        DeletePersistentVariable(GetModule(), sKey);
        SendMessageToPC(oPC, "Email alerts are off and the address is removed.");
        return;
    }
    if (!DomainEmailLooksValid(sArgs))
    {
        SendMessageToPC(oPC, "That does not look like an email address. Example: .email you@example.com");
        return;
    }
    SetPersistentString(GetModule(), sKey, sArgs);
    SendMessageToPC(oPC, "Saved. If you stay away for " + IntToString(iDomainAbandonedDays) + " days, we email " + sArgs + " " + IntToString(iDomainSaleWaitDays) + " days before a domain of yours can be bought by someone else. Anyone using this account can change it.");
}

void main()
{
    object oPC = GetPCChatSpeaker();
    string sMsg = GetPCChatMessage();

    // Language commands (.languages, .speak, .learn, .teach) are open to everyone.
    if (GetStringLeft(sMsg, 1) == ".")
    {
        string sLangMsg = DmbTrim(sMsg);
        if (GetStringLowerCase(sLangMsg) == ".lang")
        {
            SetPCChatMessage("");
            LangNuiOpen(oPC);
            return;
        }
        if (GetStringLowerCase(GetStringLeft(sLangMsg, 6)) == ".email")
        {
            SetPCChatMessage("");
            ChatCmdEmail(oPC, DmbTrim(GetStringRight(sLangMsg, GetStringLength(sLangMsg) - 6)));
            return;
        }
        if (GetStringLowerCase(sLangMsg) == ".tutor")
        {
            SetPCChatMessage("");
            LangTutorOpen(oPC);
            return;
        }
        if (LangChatCommand(oPC, sLangMsg))
        {
            SetPCChatMessage("");
            return;
        }
    }

    // Talk mode: ordinary talk and whispers come out in the chosen language.
    if (!LangNwnxActive() && LangHandleTalk(oPC)) return;

    if (GetStringLeft(sMsg, 2) != ".w") return;

    // .web is the one command open to ordinary players.
    if (DmbTrim(sMsg) == ".web")
    {
        SetPCChatMessage("");
        WebCmdCode(oPC);
        return;
    }

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
    else if (sVerb == ".wunits")   DmbCmdUnits(oPC, sArgs);
    else if (sVerb == ".wdomain")  DmbCmdDomain(oPC);
    else if (sVerb == ".wowner")   DmbCmdOwner(oPC, sArgs);
    else if (sVerb == ".wgrant")   DmbCmdGrant(oPC, sArgs, TRUE);
    else if (sVerb == ".wrevoke")  DmbCmdGrant(oPC, sArgs, FALSE);
    else                           DmbChatUsage(oPC);
}
