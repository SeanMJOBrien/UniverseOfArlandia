// _domaininfo - production summary lines for the domain structure's first
// dialog (conv_domain006 / domain_content).
//
// The domain clock is the per-player goldbag "Counter", one tick per module
// heartbeat (6 seconds) while that player is online. A structure yields one
// item every iTicksPerItem ticks, up to a per-container cap.

#include "_string_utils"
#include "_module"

const int DOMAIN_SECONDS_PER_TICK = 6;
const int DOMAIN_TICKS_PER_DAY = 576;          // a domain "day": guild terms are iDomainGuildMB * this
const string DOMAIN_INFO_VAR = "DomainInfo";   // local on the structure; read by conv_domain006

// Ticks until a slot yields its next item. -1 = nothing to wait for (no
// resource set, or its container is full). 0 = an item is due now.
int DomainTicksToNext(string sResource, int iHeld, int iCap, int iCounter, int iLastCounter, int iTicksPerItem)
{
    if (sResource == "") return -1;
    if (iHeld >= iCap) return -1;
    int iLeft = iTicksPerItem - (iCounter - iLastCounter);
    if (iLeft < 0) iLeft = 0;
    return iLeft;
}

// Smaller of two wait times, ignoring -1 ("none").
int DomainSoonest(int iA, int iB)
{
    if (iA < 0) return iB;
    if (iB < 0) return iA;
    if (iA < iB) return iA;
    return iB;
}

// "1 h 05 min", "12 min 30 s", "40 s".
string DomainFormatWait(int iTicks)
{
    int iSeconds = iTicks * DOMAIN_SECONDS_PER_TICK;
    int iHours = iSeconds / 3600;
    int iMinutes = (iSeconds % 3600) / 60;
    int iRest = iSeconds % 60;
    if (iHours > 0)
    {
        string sMin = IntToString(iMinutes);
        if (iMinutes < 10) sMin = "0" + sMin;
        return IntToString(iHours) + " h " + sMin + " min";
    }
    if (iMinutes > 0) return IntToString(iMinutes) + " min " + IntToString(iRest) + " s";
    return IntToString(iRest) + " s";
}

// Two-line summary for the dialog. iConfigured = number of slots with a
// resource set; iSoonest as returned by DomainSoonest(); sNoun e.g. "plank".
string DomainProductionSummary(int iConfigured, int iReady, int iSoonest, string sNoun)
{
    if (iConfigured == 0) return "No " + sNoun + " is set yet.";
    string sReady = "Ready to collect: " + IntToString(iReady) + " " + sNoun + "(s)";
    if (iSoonest < 0) return sReady + "\nNext " + sNoun + ": containers full, collect to resume.";
    if (iSoonest == 0) return sReady + "\nNext " + sNoun + ": any moment now.";
    return sReady + "\nNext " + sNoun + " in: " + DomainFormatWait(iSoonest);
}

// Slots 1-5 are stored as "bp%count_A_bp%count_B_..._E_" on the goldbag. Field
// iField (1-5) of that string, e.g. "ironore%7".
string DomainSlotField(string sStored, int iField)
{
    string sAfter = "";
    string sBefore = "_A_";
    if (iField == 2) { sAfter = "_A_"; sBefore = "_B_"; }
    else if (iField == 3) { sAfter = "_B_"; sBefore = "_C_"; }
    else if (iField == 4) { sAfter = "_C_"; sBefore = "_D_"; }
    else if (iField == 5) { sAfter = "_D_"; sBefore = "_E_"; }
    return Between(sStored, sAfter, sBefore);
}

// Summary for the stored-slot producers (extractor, farm, field, sawmill).
// Call AFTER the structure's accrual has run and written the string back, with
// iTicksPerItem and iCap as already adjusted for the structure level and bonus.
string DomainStoredSlotSummary(object oGoldbag, string sPlanet, string sArea, int iSlot, int iCounter, int iTicksPerItem, int iCap, string sNoun)
{
    string sStored = GetLocalString(oGoldbag, sPlanet + "&" + sArea + IntToString(iSlot));
    string sKey = sPlanet + "&" + sArea + IntToString(iSlot) + "Counter";
    int iConfigured; int iReady; int iSoonest = -1; int i;
    for (i = 1; i <= 5; i++)
    {
        string sField = DomainSlotField(sStored, i);
        int iPct = FindSubString(sField, "%");
        if (iPct < 1) continue;
        string sResource = GetStringLeft(sField, iPct);
        int iHeld = StringToInt(GetStringRight(sField, GetStringLength(sField) - iPct - 1));
        iConfigured++;
        iReady += iHeld;
        iSoonest = DomainSoonest(iSoonest, DomainTicksToNext(sResource, iHeld, iCap, iCounter, GetLocalInt(oGoldbag, sKey + IntToString(i)), iTicksPerItem));
    }
    return DomainProductionSummary(iConfigured, iReady, iSoonest, sNoun);
}

// Casern: one stock of henchmen per unlocked level, all fed by one clock.
// iHBPassed = ticks since the clock was last reset; the level's cost in ticks
// is iDomainCasern*20*iFactor (x1,2,3,5,7 for levels 1-5), less the area bonus.
string DomainCasernSummary(int iLevel, int iBonus, int iHBPassed)
{
    string sOut;
    int iFactor; int iTicks; int iLeft; int iLvl;
    for (iLvl = 1; iLvl <= iLevel; iLvl++)
    {
        if (iLvl == 4) { iFactor = 5; }
        else if (iLvl == 5) { iFactor = 7; }
        else { iFactor = iLvl; }
        iTicks = iDomainCasern * 20 * iFactor;
        iTicks = iTicks - (iTicks * iBonus / 100);
        if (iTicks < 1) continue;
        iLeft = iTicks - (iHBPassed % iTicks);
        if (sOut != "") sOut += "\n";
        sOut += "Level " + IntToString(iLvl) + " henchmen ready: " + IntToString(iHBPassed / iTicks) + ", next in " + DomainFormatWait(iLeft);
    }
    return sOut;
}

// Guild: the speaker's own membership of THIS guild (the hall's Master).
string DomainGuildSummary(object oGoldbag, string sMaster)
{
    if (GetLocalString(oGoldbag, "Guild") != sMaster || GetLocalInt(oGoldbag, "GuildMB") <= 0)
        return "You are not a member of this guild.";
    int iTicks = GetLocalInt(oGoldbag, "GuildMB");
    return "Your membership: " + IntToString(iTicks / DOMAIN_TICKS_PER_DAY) + " day(s) left, about " + DomainFormatWait(iTicks) + " of play time.\n"
         + "The XP bonus needs " + IntToString(iDomainGuildMin) + " guild members together.";
}

// House: who rents it and how long the rent is paid for.
string DomainHouseSummary(string sTenant, int iDaysLeft)
{
    if (sTenant == "") return "For rent.";
    return "Rented by " + sTenant + ", paid for " + IntToString(iDaysLeft) + " more day(s).";
}
