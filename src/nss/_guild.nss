// _guild - domain guild membership term, settled on read.
//
// The term used to live in the goldbag local "GuildMB" as ticks remaining, and
// mod_heartbeat subtracted 1 from it for every online member every heartbeat.
// It is now stored as an end point on the member's own online clock: "GuildEnd"
// is the goldbag Counter value at which the term runs out, so the ticks left
// are GuildEnd - Counter, computed when read. Nothing runs per heartbeat, and
// the term still only runs down while the member is online.
//
// A term in progress from the old scheme (GuildMB > 0, no GuildEnd) is
// converted the first time it is read.

const string GUILD_END = "GuildEnd";
const string GUILD_LEGACY = "GuildMB";

// Ticks of membership left (0 once expired or never joined).
int GuildTicksLeft(object oGoldbag)
{
    int iNow = GetLocalInt(oGoldbag, "Counter");
    int iEnd = GetLocalInt(oGoldbag, GUILD_END);
    if (iEnd == 0)
    {
        int iLegacy = GetLocalInt(oGoldbag, GUILD_LEGACY);
        if (iLegacy <= 0) { return 0; }
        iEnd = iNow + iLegacy;
        SetLocalInt(oGoldbag, GUILD_END, iEnd);
        DeleteLocalInt(oGoldbag, GUILD_LEGACY);
    }
    int iLeft = iEnd - iNow;
    if (iLeft < 0) { return 0; }
    return iLeft;
}

// Start (or reset) a term of iTicks from now.
void GuildSetTicks(object oGoldbag, int iTicks)
{
    DeleteLocalInt(oGoldbag, GUILD_LEGACY);
    if (iTicks <= 0) { DeleteLocalInt(oGoldbag, GUILD_END); return; }
    SetLocalInt(oGoldbag, GUILD_END, GetLocalInt(oGoldbag, "Counter") + iTicks);
}

void GuildClear(object oGoldbag)
{
    DeleteLocalInt(oGoldbag, GUILD_END);
    DeleteLocalInt(oGoldbag, GUILD_LEGACY);
}
