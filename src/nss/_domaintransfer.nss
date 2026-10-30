// _domaintransfer - change who owns a domain: the DM chat commands (.wowner,
// .wgrant, .wrevoke, .wdomain) and the player purchase of an abandoned domain
// both go through here.
//
// Ownership is a name kept in several places, and all of them move together:
//   - field 1 of the domain's Interests record ("D&1&<owner>&2&...")
//   - the "Master" local on every object placed in the domain's outdoor area
//   - the "Master" local on structure interiors, which transitions2.nss refreshes
//     from the placed objects on every entry, so it follows by itself
// Slot contents and stock stay with the domain. Production markers are in the
// old owner's online ticks, so they are reset to the new owner's clock: stock is
// kept, and the next item is a full period away. Access grants are cleared when
// asked (always, for a purchase). Renters keep their tenancy.
//
// Slot contents that were never imported from the old owner's goldbag (they only
// import when that owner opens a structure) stay on that goldbag, so a domain
// taken over from an owner who is offline starts with its structures unconfigured.
//
// Not moved: guild members hold the hall's Master name in their own goldbag
// ("Guild"), so a guild hall changing hands loses its members' membership.

#include "_domainstate"
#include "_domainuser"
#include "inc_sqlite_time"

const int DOMAIN_SECONDS_PER_DAY = 86400;

// Replace the owner in the Interests record, leaving the rest as it was.
void DomainSetOwnerRecord(string sPlanet, string sArea, string sNewOwner)
{
    string sKey = sPlanet + "&" + sArea + "&Interests";
    string sRecord = GetPersistentString(GetModule(), sKey);
    int iFrom = FindSubString(sRecord, "&1&");
    int iTo = FindSubString(sRecord, "&2&");
    if ((iFrom == -1) || (iTo == -1)) { return; }
    SetPersistentString(GetModule(), sKey, GetStringLeft(sRecord, iFrom + 3) + sNewOwner + GetStringRight(sRecord, GetStringLength(sRecord) - iTo));
}

// Whole real days since the character was last seen, or -1 when never recorded.
int DomainDaysAway(string sName)
{
    if (DomainFindOnlinePC(sName) != OBJECT_INVALID) { return 0; }
    int iSeen = GetPersistentInt(GetModule(), DOMAIN_SEEN_KEY + sName);
    if (iSeen <= 0) { return -1; }
    return (SQLite_GetTimeStamp() - iSeen) / DOMAIN_SECONDS_PER_DAY;
}

// Can another player buy this domain? Its owner must have been away for
// iDomainAbandonedDays. A domain whose owner was never recorded is not for sale.
int DomainIsAbandoned(object oArea)
{
    string sOwner = DomainOwnerName(oArea);
    if (sOwner == "") { return FALSE; }
    int iAway = DomainDaysAway(sOwner);
    return ((iAway >= 0) && (iAway >= iDomainAbandonedDays));
}

// The new owner's online ticks: live if they are logged in, mirrored otherwise.
int DomainTicksOf(string sName)
{
    object oPC = DomainFindOnlinePC(sName);
    if (GetIsObjectValid(oPC)) { return GetLocalInt(GetItemPossessedBy(oPC, "goldbag"), "Counter"); }
    return GetPersistentInt(GetModule(), DOMAIN_CLOCK_KEY + sName);
}

// Restart every production timer in the domain from the new owner's clock.
void DomainResetMarkers(string sPlanet, string sArea, string sNewOwner)
{
    int iTicks = DomainTicksOf(sNewOwner);
    int iSlot; int iMarker;
    for (iSlot = 1; iSlot <= DOMAIN_STATE_MAX_SLOT; iSlot++)
    {
        string sKey = sPlanet + "&" + sArea + IntToString(iSlot) + "Counter";
        if (DomainStateGetInt(sKey) != 0) { DomainStateSetInt(sKey, iTicks); }
        for (iMarker = 1; iMarker <= DOMAIN_STATE_MAX_MARKER; iMarker++)
        {
            if (DomainStateGetInt(sKey + IntToString(iMarker)) != 0) { DomainStateSetInt(sKey + IntToString(iMarker), iTicks); }
        }
    }
}

// Hand the domain over. oArea is the domain's outdoor area. Returns the number of
// objects whose Master was updated.
int DomainTransferOwner(object oArea, string sNewOwner, int bClearGrants)
{
    string sPlanet = GetLocalString(oArea, "Planet");
    string sArea = GetLocalString(oArea, "Area");
    string sOld = DomainOwnerName(oArea);

    // Bring any unimported goldbag data across first, while the old owner could still be online.
    DomainStateMigrate(DomainFindOnlinePC(sOld), oArea);

    DomainSetOwnerRecord(sPlanet, sArea, sNewOwner);
    int iCount;
    object oObject = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oObject))
    {
        if (GetLocalString(oObject, "Master") == sOld)
        {
            SetLocalString(oObject, "Master", sNewOwner);
            iCount++;
        }
        oObject = GetNextObjectInArea(oArea);
    }
    if (GetLocalString(oArea, "Master") == sOld) { SetLocalString(oArea, "Master", sNewOwner); }
    DomainResetMarkers(sPlanet, sArea, sNewOwner);
    if (bClearGrants) { DomainClearAllGrants(sPlanet, sArea); }
    string sNote = "";
    if (bClearGrants) { sNote = " (grants cleared)"; }
    WriteTimestampedLogEntry("Domain " + sPlanet + "&" + sArea + " owner " + sOld + " -> " + sNewOwner + sNote);
    return iCount;
}
