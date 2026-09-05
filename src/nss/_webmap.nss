////////////////////////////////////////////////////////////////////////////////
// Universe of Arlandia - Per-player web map discovery
//
// The website map (galaxy.php / map-data.php) used to show a single, server
// wide discovery state: the first player to walk onto a tile appended "*" to
// its terrain code in <Planet>AreasX<iX> and the tile became visible to
// everyone. These helpers keep that global flag intact (DM tools and
// _galaxy.nss still rely on it) and add a second, per-character record so the
// site can show each player only the tiles that player has actually visited.
//
// Records written here (all in pwdata):
//
//   player='~', tag='uoa'
//     WebChars_<cdkey>   list of characters seen on that public CD key,
//                        "<account>&1&<charname>&2&" repeated. Lets the
//                        website turn a CD-key login into the (player,tag)
//                        pairs its discovery rows are stored under.
//     WebCode_<cdkey>    one-time registration code (see WebMapIssueCode).
//                        The row's `last` column is the issue time - the
//                        website expires the code from that, not from here.
//
//   player=<account>, tag=<charname>   (APS per-PC rows, written via oPC)
//     WMap_<Planet>_X<iX>  tiles this character has discovered in column iX,
//                          "&+05&&-03&..." using the same &±YY& keys as
//                          <Planet>AreasX<iX>. Presence = discovered.
//
// pwdata.name is varchar(64); WebMapColumnKey() returns "" rather than write a
// key that would be silently truncated by MySQL into another column's row.
////////////////////////////////////////////////////////////////////////////////

#include "aps_include"
#include "_string_utils"
#include "_constants"

const string WEBMAP_CHARS_PREFIX = "WebChars_";
const string WEBMAP_CODE_PREFIX  = "WebCode_";
const string WEBMAP_TILE_PREFIX  = "WMap_";

// pwdata.name column width - keys longer than this must not be written.
const int WEBMAP_NAME_MAX = 64;

// Public CD key of oPC, or "" when there is none (local/single player) or the
// object is not a player. DMs are excluded: they see the whole map anyway and
// should not accumulate discovery rows.
string WebMapKey(object oPC);

// pwdata key for one character's discovered tiles in column iX of sPlanet.
// Returns "" when the key would exceed the pwdata.name column width.
string WebMapColumnKey(string sPlanet, int iX);

// TRUE if this character has already discovered (iX, iY) on sPlanet.
int WebMapIsDiscovered(object oPC, string sPlanet, int iX, int iY);

// Record (iX, iY) on sPlanet as discovered by this character. No-op when the
// tile is already recorded, so it is safe to call on every transition.
void WebMapDiscover(object oPC, string sPlanet, int iX, int iY);

// Add this character to the CD key's character list so the website can find
// its discovery rows after a CD-key login. No-op if already listed.
void WebMapRegisterChar(object oPC);

// Issue (or replace) the one-time website registration code for this CD key
// and return it. Returns "" when the player has no public CD key.
string WebMapIssueCode(object oPC);

// ---------------------------------------------------------------------------

string WebMapKey(object oPC)
{
    if (!GetIsPC(oPC)) return "";
    if (GetIsDM(oPC) || GetIsDMPossessed(oPC)) return "";
    return GetPCPublicCDKey(oPC);
}

string WebMapColumnKey(string sPlanet, int iX)
{
    string sKey = WEBMAP_TILE_PREFIX + sPlanet + "_X" + IntToString(iX);
    if (GetStringLength(sKey) > WEBMAP_NAME_MAX) return "";
    return sKey;
}

int WebMapIsDiscovered(object oPC, string sPlanet, int iX, int iY)
{
    string sKey = WebMapColumnKey(sPlanet, iX);
    if (sKey == "") return FALSE;
    return (FindSubString(GetPersistentString(oPC, sKey), AreaTileKey(iY)) != -1);
}

void WebMapDiscover(object oPC, string sPlanet, int iX, int iY)
{
    if (sPlanet == "") return;
    if (WebMapKey(oPC) == "") return;

    string sKey = WebMapColumnKey(sPlanet, iX);
    if (sKey == "") return;

    string sTile = AreaTileKey(iY);
    string sCol  = GetPersistentString(oPC, sKey);
    if (FindSubString(sCol, sTile) != -1) return; // already discovered

    SetPersistentString(oPC, sKey, sCol + sTile);
}

void WebMapRegisterChar(object oPC)
{
    string sCDKey = WebMapKey(oPC);
    if (sCDKey == "") return;

    // area_enter fires on every area change; the list only ever needs building
    // once per login, so skip the read after the first successful check.
    if (GetLocalInt(oPC, "WebMapCharListed")) return;

    // Stored lowercase to match the player column APS writes for per-PC rows.
    string sEntry = GetStringLowerCase(GetPCPlayerName(oPC)) + "&1&" + GetName(oPC) + "&2&";
    string sList  = GetPersistentString(GetModule(), WEBMAP_CHARS_PREFIX + sCDKey);
    SetLocalInt(oPC, "WebMapCharListed", TRUE);
    if (FindSubString(sList, sEntry) != -1) return;

    SetPersistentString(GetModule(), WEBMAP_CHARS_PREFIX + sCDKey, sList + sEntry);
}

string WebMapIssueCode(object oPC)
{
    string sCDKey = WebMapKey(oPC);
    if (sCDKey == "") return "";

    string sCode = IntToString(Random(900000) + 100000);
    SetPersistentString(GetModule(), WEBMAP_CODE_PREFIX + sCDKey, sCode);
    return sCode;
}
