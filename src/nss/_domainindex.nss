// _domainindex - which domains each character owns, who to warn when one is
// about to be put up for sale, and the mail queue that carries the warning.
//
// pwdata keys (player '~', tag 'uoa'):
//   DomainIndex&<Owner>          "|<Planet>&<Area>|<Planet>&<Area>|"  the owner's domains
//   Account&<Character>          the player account (login name) the character last used
//   Email&<Account>              the address that account registered with .email
//   DomainNoticed&<Planet>&<Area>  the owner the "going on sale" notice was sent about
//
// The index is built once from the Interests records (DomainIndexBackfill) and
// kept up to date where domains are created, destroyed and handed over. It
// lets a character's structure data be imported when they log in, and lets the
// sweep find owners who have been away without scanning the world.
//
// Mail is only queued here (table mail_outbox). tools/send_outbox.php sends it.

#include "_domainstate"
#include "nwnx_sql"

const string DINDEX_KEY = "DomainIndex&";
const string DOMAIN_ACCOUNT_KEY = "Account&";
const string DOMAIN_EMAIL_KEY = "Email&";
const string DOMAIN_NOTICED_KEY = "DomainNoticed&";
const string DINDEX_BUILT = "DomainIndexBuilt";
const int DOMAIN_SWEEP_TICKS = 3600;      // 6 hours of heartbeats
const int DOMAIN_BATCH = 25;              // rows handled per script run
const int DOMAIN_SECONDS_PER_DAY = 86400;

// --- Index ----------------------------------------------------------------

string DomainIndexList(string sOwner)
{
    return GetPersistentString(GetModule(), DINDEX_KEY + sOwner);
}

int DomainIndexHas(string sOwner, string sPlanet, string sArea)
{
    return (FindSubString(DomainIndexList(sOwner), "|" + sPlanet + "&" + sArea + "|") != -1);
}

void DomainIndexAdd(string sOwner, string sPlanet, string sArea)
{
    if (sOwner == "") { return; }
    if (DomainIndexHas(sOwner, sPlanet, sArea)) { return; }
    string sList = DomainIndexList(sOwner);
    if (sList == "") { sList = "|"; }
    SetPersistentString(GetModule(), DINDEX_KEY + sOwner, sList + sPlanet + "&" + sArea + "|");
}

void DomainIndexRemove(string sOwner, string sPlanet, string sArea)
{
    if (!DomainIndexHas(sOwner, sPlanet, sArea)) { return; }
    string sList = DomainIndexList(sOwner);
    string sCut = "|" + sPlanet + "&" + sArea + "|";
    int iAt = FindSubString(sList, sCut);
    string sNew = GetStringLeft(sList, iAt) + "|" + GetStringRight(sList, GetStringLength(sList) - iAt - GetStringLength(sCut));
    if (sNew == "|") { DeletePersistentVariable(GetModule(), DINDEX_KEY + sOwner); return; }
    SetPersistentString(GetModule(), DINDEX_KEY + sOwner, sNew);
}

// The n-th "Planet&Area" entry of an index list (0-based), or "".
string DomainIndexEntry(string sList, int iNth)
{
    int iStart = 1; int i;
    for (i = 0; i < iNth; i++)
    {
        int iBar = FindSubString(GetStringRight(sList, GetStringLength(sList) - iStart), "|");
        if (iBar == -1) { return ""; }
        iStart = iStart + iBar + 1;
    }
    string sRest = GetStringRight(sList, GetStringLength(sList) - iStart);
    int iEnd = FindSubString(sRest, "|");
    if (iEnd < 1) { return ""; }
    return GetStringLeft(sRest, iEnd);
}

// Build the index from the Interests records, in batches so no single script
// run reads too much. Runs once; DINDEX_BUILT stops it repeating.
void DomainIndexBackfill(int iOffset)
{
    if (GetPersistentInt(GetModule(), DINDEX_BUILT) == 1) { return; }
    NWNX_SQL_PrepareQuery("SELECT name, val FROM pwdata WHERE player='~' AND tag='uoa' AND name LIKE '%&Interests' AND val LIKE 'D&1&%' ORDER BY name LIMIT " + IntToString(DOMAIN_BATCH) + " OFFSET " + IntToString(iOffset));
    NWNX_SQL_ExecutePreparedQuery();
    string sNames = ""; string sVals = ""; int iRows;
    while (NWNX_SQL_ReadyToReadNextRow())
    {
        NWNX_SQL_ReadNextRow();
        sNames += NWNX_SQL_ReadDataInActiveRow(0) + "\n";
        sVals += NWNX_SQL_ReadDataInActiveRow(1) + "\n";
        iRows++;
    }
    int i;
    for (i = 0; i < iRows; i++)
    {
        string sKey = GetStringLeft(sNames, FindSubString(sNames, "\n"));
        sNames = GetStringRight(sNames, GetStringLength(sNames) - GetStringLength(sKey) - 1);
        string sVal = GetStringLeft(sVals, FindSubString(sVals, "\n"));
        sVals = GetStringRight(sVals, GetStringLength(sVals) - GetStringLength(sVal) - 1);
        string sCoord = GetStringLeft(sKey, GetStringLength(sKey) - GetStringLength("&Interests"));
        int iSplit = FindSubString(sCoord, "&");
        if (iSplit < 1) { continue; }
        DomainIndexAdd(Between(sVal, "&1&", "&2&"), GetStringLeft(sCoord, iSplit), GetStringRight(sCoord, GetStringLength(sCoord) - iSplit - 1));
    }
    if (iRows >= DOMAIN_BATCH) { DelayCommand(1.0, DomainIndexBackfill(iOffset + DOMAIN_BATCH)); return; }
    SetPersistentInt(GetModule(), DINDEX_BUILT, 1);
    WriteTimestampedLogEntry("Domain owner index built.");
}

// Import a character's structure data from their goldbag, for every domain they
// own, when they log in (instead of waiting for the first structure dialog).
void DomainIndexImportFor(object oPC)
{
    string sList = DomainIndexList(GetName(oPC));
    int i = 0;
    string sEntry = DomainIndexEntry(sList, i);
    while (sEntry != "")
    {
        int iSplit = FindSubString(sEntry, "&");
        DomainStateMigrateFor(oPC, GetStringLeft(sEntry, iSplit), GetStringRight(sEntry, GetStringLength(sEntry) - iSplit - 1));
        i++;
        sEntry = DomainIndexEntry(sList, i);
    }
}

// --- Away time ------------------------------------------------------------

// Whole real days since the character was last seen, or -1 when never recorded.
int DomainDaysAway(string sName)
{
    if (DomainFindOnlinePC(sName) != OBJECT_INVALID) { return 0; }
    int iSeen = GetPersistentInt(GetModule(), DOMAIN_SEEN_KEY + sName);
    if (iSeen <= 0) { return -1; }
    return (SQLite_GetTimeStamp() - iSeen) / DOMAIN_SECONDS_PER_DAY;
}

// --- Email and the mail queue ---------------------------------------------

string DomainEmailFor(string sCharacter)
{
    string sAccount = GetPersistentString(GetModule(), DOMAIN_ACCOUNT_KEY + sCharacter);
    if (sAccount == "") { return ""; }
    return GetPersistentString(GetModule(), DOMAIN_EMAIL_KEY + sAccount);
}

void MailQueue(string sTo, string sSubject, string sBody)
{
    if (sTo == "") { return; }
    NWNX_SQL_PrepareQuery("CREATE TABLE IF NOT EXISTS mail_outbox (id INT AUTO_INCREMENT PRIMARY KEY, created INT NOT NULL, to_addr VARCHAR(190) NOT NULL, subject VARCHAR(190) NOT NULL, body TEXT NOT NULL, sent_at INT NULL, attempts INT NOT NULL DEFAULT 0)");
    NWNX_SQL_ExecutePreparedQuery();
    NWNX_SQL_PrepareQuery("INSERT INTO mail_outbox (created, to_addr, subject, body) VALUES (?, ?, ?, ?)");
    NWNX_SQL_PreparedInt(0, SQLite_GetTimeStamp());
    NWNX_SQL_PreparedString(1, sTo);
    NWNX_SQL_PreparedString(2, sSubject);
    NWNX_SQL_PreparedString(3, sBody);
    NWNX_SQL_ExecutePreparedQuery();
}

// Does this look like an address a person typed on purpose?
int DomainEmailLooksValid(string sAddress)
{
    int iLen = GetStringLength(sAddress);
    if ((iLen < 6) || (iLen > 120)) { return FALSE; }
    int iAt = FindSubString(sAddress, "@");
    if ((iAt < 1) || (FindSubString(GetStringRight(sAddress, iLen - iAt - 1), "@") != -1)) { return FALSE; }
    string sHost = GetStringRight(sAddress, iLen - iAt - 1);
    if ((FindSubString(sHost, ".") < 1) || (GetStringRight(sHost, 1) == ".")) { return FALSE; }
    if ((FindSubString(sAddress, " ") != -1) || (FindSubString(sAddress, "'") != -1) || (FindSubString(sAddress, "\"") != -1) || (FindSubString(sAddress, ",") != -1) || (FindSubString(sAddress, ";") != -1)) { return FALSE; }
    return TRUE;
}

// --- Notice sweep ---------------------------------------------------------

void DomainSendSaleNotice(string sOwner, string sPlanet, string sArea, int iAway)
{
    int iLeft = iDomainAbandonedDays + iDomainSaleWaitDays - iAway;
    if (iLeft < 0) { iLeft = 0; }
    MailQueue(DomainEmailFor(sOwner), "Your Universe of Arlandia domain will be put up for sale",
        "Hello,\n\n" + sOwner + " has not logged in to Universe of Arlandia for " + IntToString(iAway) + " days.\n\n" +
        "Your domain at " + sPlanet + " " + sArea + " will be offered for sale to other players in " + IntToString(iLeft) + " days unless " + sOwner + " logs in before then. Logging in once with that character is enough.\n\n" +
        "You receive this because you registered this address in game. To stop these messages, type .email off in game.\n");
}

// Walk the index in batches. Owners with no recorded last-seen time are given one
// now, so every owner has a full 365 days from the first sweep to return. Each
// domain whose owner has been away 365 days is noticed once.
void DomainNoticeSweep(int iOffset)
{
    NWNX_SQL_PrepareQuery("SELECT name, val FROM pwdata WHERE player='~' AND tag='uoa' AND name LIKE 'DomainIndex&%' ORDER BY name LIMIT " + IntToString(DOMAIN_BATCH) + " OFFSET " + IntToString(iOffset));
    NWNX_SQL_ExecutePreparedQuery();
    string sNames = ""; string sVals = ""; int iRows;
    while (NWNX_SQL_ReadyToReadNextRow())
    {
        NWNX_SQL_ReadNextRow();
        sNames += NWNX_SQL_ReadDataInActiveRow(0) + "\n";
        sVals += NWNX_SQL_ReadDataInActiveRow(1) + "\n";
        iRows++;
    }
    int i;
    for (i = 0; i < iRows; i++)
    {
        string sKey = GetStringLeft(sNames, FindSubString(sNames, "\n"));
        sNames = GetStringRight(sNames, GetStringLength(sNames) - GetStringLength(sKey) - 1);
        string sList = GetStringLeft(sVals, FindSubString(sVals, "\n"));
        sVals = GetStringRight(sVals, GetStringLength(sVals) - GetStringLength(sList) - 1);
        string sOwner = GetStringRight(sKey, GetStringLength(sKey) - GetStringLength(DINDEX_KEY));
        int iAway = DomainDaysAway(sOwner);
        if (iAway == -1)
        {
            SetPersistentInt(GetModule(), DOMAIN_SEEN_KEY + sOwner, SQLite_GetTimeStamp());
            continue;
        }
        if (iAway < iDomainAbandonedDays) { continue; }
        int j = 0;
        string sEntry = DomainIndexEntry(sList, j);
        while (sEntry != "")
        {
            if (GetPersistentString(GetModule(), DOMAIN_NOTICED_KEY + sEntry) != sOwner)
            {
                SetPersistentString(GetModule(), DOMAIN_NOTICED_KEY + sEntry, sOwner);
                int iSplit = FindSubString(sEntry, "&");
                DomainSendSaleNotice(sOwner, GetStringLeft(sEntry, iSplit), GetStringRight(sEntry, GetStringLength(sEntry) - iSplit - 1), iAway);
            }
            j++;
            sEntry = DomainIndexEntry(sList, j);
        }
    }
    if (iRows >= DOMAIN_BATCH) { DelayCommand(1.0, DomainNoticeSweep(iOffset + DOMAIN_BATCH)); }
}
