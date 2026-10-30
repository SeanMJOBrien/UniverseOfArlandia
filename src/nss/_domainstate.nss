// _domainstate - where a domain's production state lives, and whose clock
// drives it.
//
// Until now every slot's contents ("<Planet>&<Area><Slot>") and last-production
// markers ("...Counter<i>") were locals on the goldbag of whoever was talking to
// the structure. A granted user therefore saw an empty structure, and the clock
// was the speaker's. Now:
//
//   - the state is stored per domain in pwdata, under "DS&" + the old key, so
//     every user of a domain reads and writes the same values;
//   - the clock is the domain OWNER's online ticks (see DomainOwnerTicks), which
//     is the goldbag "Counter" the heartbeat already advances, mirrored to pwdata
//     so it can be read while the owner is offline.
//
// The scripts keep their old logic and only swap the storage calls, so keys and
// string formats are unchanged. Writes go straight to pwdata (no cache, no
// separate save step), so a crash cannot lose a collected item.
//
// The owner's online time is mirrored at login, logout and every
// DOMAIN_CLOCK_SYNC_TICKS ticks; a crash loses at most that much of the owner's
// play time, never the other way.

#include "aps_include"
#include "_module"
#include "nwnx_time"

const string DSTATE_PREFIX = "DS&";
const string DOMAIN_CLOCK_KEY = "OnlineTicks&";   // + character name
const string DOMAIN_SEEN_KEY = "LastSeen_";       // + character name; real-world unix time
const int DOMAIN_CLOCK_SYNC_TICKS = 50;           // 50 heartbeats = 5 minutes
const int DOMAIN_STATE_MAX_SLOT = 10;             // domains.nss:99
const int DOMAIN_STATE_MAX_MARKER = 9;            // per-slot Counter<i> markers (see conv_domain005)

// --- Storage facade -------------------------------------------------------

string DomainStateKey(string sKey)
{
    return DSTATE_PREFIX + sKey;
}

int DomainStateGetInt(string sKey)
{
    return GetPersistentInt(GetModule(), DomainStateKey(sKey));
}

void DomainStateSetInt(string sKey, int iValue)
{
    SetPersistentInt(GetModule(), DomainStateKey(sKey), iValue);
}

void DomainStateDeleteInt(string sKey)
{
    DeletePersistentVariable(GetModule(), DomainStateKey(sKey));
}

string DomainStateGetString(string sKey)
{
    return GetPersistentString(GetModule(), DomainStateKey(sKey));
}

void DomainStateSetString(string sKey, string sValue)
{
    SetPersistentString(GetModule(), DomainStateKey(sKey), sValue);
}

void DomainStateDeleteString(string sKey)
{
    DeletePersistentVariable(GetModule(), DomainStateKey(sKey));
}

// --- Owner online clock ---------------------------------------------------

// Mirror a player's online ticks and last-seen time to pwdata. Cheap: two writes.
void DomainClockSync(object oPC)
{
    if (!GetIsObjectValid(oPC) || GetIsDM(oPC)) { return; }
    object oGoldbag = GetItemPossessedBy(oPC, "goldbag");
    if (!GetIsObjectValid(oGoldbag)) { return; }
    string sName = GetName(oPC);
    SetPersistentInt(GetModule(), DOMAIN_CLOCK_KEY + sName, GetLocalInt(oGoldbag, "Counter"));
    SetPersistentInt(GetModule(), DOMAIN_SEEN_KEY + sName, NWNX_Time_GetTimeStamp());
}

// The logged-in PC called sName, or OBJECT_INVALID.
object DomainFindOnlinePC(string sName)
{
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        if (GetName(oPC) == sName) { return oPC; }
        oPC = GetNextPC();
    }
    return OBJECT_INVALID;
}

// The online-tick count that drives this domain's production: the owner's, read
// live when they are logged in and from the mirror otherwise. A domain with no
// recorded owner falls back to the speaker's own clock, as before.
int DomainOwnerTicks(object oPC, object oArea)
{
    string sOwner = GetLocalString(oArea, "Master");
    object oOwner = oPC;
    if ((sOwner != "") && (sOwner != GetName(oPC)))
    {
        oOwner = DomainFindOnlinePC(sOwner);
        if (!GetIsObjectValid(oOwner))
        {
            return GetPersistentInt(GetModule(), DOMAIN_CLOCK_KEY + sOwner);
        }
    }
    return GetLocalInt(GetItemPossessedBy(oOwner, "goldbag"), "Counter");
}

// --- One-time import of the old goldbag data ------------------------------

void DomainStateCopyInt(object oGoldbag, string sKey)
{
    if (GetLocalInt(oGoldbag, sKey) != 0) { DomainStateSetInt(sKey, GetLocalInt(oGoldbag, sKey)); }
}

void DomainStateCopyString(object oGoldbag, string sKey)
{
    if (GetLocalString(oGoldbag, sKey) != "") { DomainStateSetString(sKey, GetLocalString(oGoldbag, sKey)); }
}

// Copy a domain's slot contents, markers and links from the OWNER's goldbag into
// the domain state, once. Does nothing unless the speaker is the owner (only
// their goldbag holds the real data) or the domain was already imported.
void DomainStateMigrate(object oPC, object oArea)
{
    string sPlanet = GetLocalString(oArea, "Planet");
    string sArea = GetLocalString(oArea, "Area");
    string sBase = sPlanet + "&" + sArea;
    if (DomainStateGetInt(sBase + "&Migrated") == 1) { return; }
    string sOwner = GetLocalString(oArea, "Master");
    if ((sOwner == "") || (sOwner != GetName(oPC))) { return; }
    object oGoldbag = GetItemPossessedBy(oPC, "goldbag");
    if (!GetIsObjectValid(oGoldbag)) { return; }

    DomainClockSync(oPC);
    int iSlot; int iMarker; int iTo;
    for (iSlot = 1; iSlot <= DOMAIN_STATE_MAX_SLOT; iSlot++)
    {
        string sSlot = sBase + IntToString(iSlot);
        DomainStateCopyString(oGoldbag, sSlot);
        DomainStateCopyInt(oGoldbag, sSlot + "Counter");
        for (iMarker = 1; iMarker <= DOMAIN_STATE_MAX_MARKER; iMarker++)
        {
            DomainStateCopyInt(oGoldbag, sSlot + "Counter" + IntToString(iMarker));
        }
        for (iTo = 1; iTo <= DOMAIN_STATE_MAX_SLOT; iTo++)
        {
            DomainStateCopyInt(oGoldbag, sBase + "&DomainLink&" + IntToString(iSlot) + IntToString(iTo));
        }
    }
    DomainStateSetInt(sBase + "&Migrated", 1);
}
