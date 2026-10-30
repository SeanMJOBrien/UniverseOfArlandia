// _guildroster - who belongs to a domain guild.
//
// A membership is a term on the member's own online clock (_guild.nss), which
// the server cannot read from a character that is offline. So each member's
// remaining ticks are mirrored to pwdata whenever they join, renew, log in or
// out, and every 5 minutes (DomainClockSync). A member's clock only moves while
// they are online, so the mirrored figure stays correct while they are away.
//
//   GuildMember&<hall owner>&<character> = ticks of membership left
//
// A member whose ticks have run out stays in the table with 0 until they
// renew or leave; only members with ticks left are counted.

#include "aps_include"
#include "_guild"
#include "nwnx_sql"

const string GUILD_MEMBER_KEY = "GuildMember&";
const int GUILD_NAMES_SHOWN = 8;

// Record (or remove, when iTicks is 0 or less) one member of a hall.
void GuildRosterSet(string sHall, string sName, int iTicks)
{
    if ((sHall == "") || (sName == "")) { return; }
    string sKey = GUILD_MEMBER_KEY + sHall + "&" + sName;
    if (iTicks <= 0) { DeletePersistentVariable(GetModule(), sKey); return; }
    SetPersistentInt(GetModule(), sKey, iTicks);
}

// Mirror one logged-in character's membership.
void GuildRosterSync(object oPC)
{
    object oGoldbag = GetItemPossessedBy(oPC, "goldbag");
    if (!GetIsObjectValid(oGoldbag)) { return; }
    string sHall = GetLocalString(oGoldbag, "Guild");
    if (sHall == "") { return; }
    string sKey = GUILD_MEMBER_KEY + sHall + "&" + GetName(oPC);
    int iTicks = GuildTicksLeft(oGoldbag);
    // Keep an expired member listed at 0 so the hall can see they lapsed.
    if (iTicks <= 0) { SetPersistentInt(GetModule(), sKey, 0); return; }
    SetPersistentInt(GetModule(), sKey, iTicks);
}

// "Members: 4 (2 online): Alice, Bob, ..." for a hall's first dialog.
string GuildRosterSummary(string sHall)
{
    if (sHall == "") { return ""; }
    string sPrefix = GUILD_MEMBER_KEY + sHall + "&";
    NWNX_SQL_PrepareQuery("SELECT name, val FROM pwdata WHERE player='~' AND tag='uoa' AND LEFT(name, ?) = ? ORDER BY name");
    NWNX_SQL_PreparedInt(0, GetStringLength(sPrefix));
    NWNX_SQL_PreparedString(1, sPrefix);
    NWNX_SQL_ExecutePreparedQuery();
    int iActive; int iOnline; string sNames = "";
    while (NWNX_SQL_ReadyToReadNextRow())
    {
        NWNX_SQL_ReadNextRow();
        if (StringToInt(NWNX_SQL_ReadDataInActiveRow(1)) <= 0) { continue; }
        string sMember = GetStringRight(NWNX_SQL_ReadDataInActiveRow(0), GetStringLength(NWNX_SQL_ReadDataInActiveRow(0)) - GetStringLength(sPrefix));
        iActive++;
        if (iActive <= GUILD_NAMES_SHOWN)
        {
            if (sNames != "") { sNames += ", "; }
            sNames += sMember;
        }
    }
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        if (GetLocalString(GetItemPossessedBy(oPC, "goldbag"), "Guild") == sHall && GuildTicksLeft(GetItemPossessedBy(oPC, "goldbag")) > 0) { iOnline++; }
        oPC = GetNextPC();
    }
    if (iActive == 0) { return "Members: none yet."; }
    string sMore = "";
    if (iActive > GUILD_NAMES_SHOWN) { sMore = " and " + IntToString(iActive - GUILD_NAMES_SHOWN) + " more"; }
    return "Members: " + IntToString(iActive) + " (" + IntToString(iOnline) + " online): " + sNames + sMore + ".";
}
