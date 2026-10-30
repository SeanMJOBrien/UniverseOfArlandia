// _bank - bank account interest, settled when the account is opened.
//
// This used to run in mod_heartbeat for every account item in every online
// player's inventory, every 6 seconds. Now an account remembers the holder's
// online ticks (goldbag "Counter") at its last settlement and catches up on
// demand, so nothing runs per heartbeat. The clock is still the holder's own
// online time, so an account only earns while its holder plays, exactly as before.
//
// Locals on the account item:
//   GP, IV        balance and investment principal (unchanged)
//   IVdelay       ticks of investment term left; -1 = matured (unchanged)
//   GPmark        holder ticks at the last whole day of interest paid
//   IVmark        holder ticks when IVdelay was last brought up to date
// The old per-tick "GPdelay" is migrated into GPmark on first settlement.
//
// Normal interest is a monthly rate (BankNormalRate10, 2% by default) over a month of BankMonthDays bank days,
// added daily on the holder's online time. The fraction of a gold piece it
// rounds off is carried (GPfrac) so small balances still grow.
//
// An investment locks its principal for a term. At purchase the rate
// (IVrate, tenths of a percent per month), the term (IVdays) and the month length (IVmonth) are stored on
// the item, so a later change to the settings never alters a deal in progress.
// When the term ends the principal is grown once at that rate, compounded daily
// over the term, and then waits to be collected. Investments bought before this
// change have no IVrate and are paid back at face value, as they were bought.

#include "aps_include"
#include "_module"

const int BANK_SECONDS_PER_TICK = 6;
const int BANK_MAX_DAYS_PER_SETTLE = 400; // keeps one settlement inside the instruction limit

// --- Settings -------------------------------------------------------------
// The DM page (www/dm_bank.php) stores these as BankSetting_<name> in pwdata and
// the module reads them every time, so a change applies to the next account
// opened with no restart. When a setting has never been saved, the compiled
// default in _module.nss is used. Rates are in tenths of a percent per month.

const string BANK_SETTING = "BankSetting_";

int BankSetting(string sName, int iDefault)
{
    string sValue = GetPersistentString(GetModule(), BANK_SETTING + sName);
    if (sValue == "") { return iDefault; }
    return StringToInt(sValue);
}

int BankNormalRate10()  { return BankSetting("normal10", iNormalInterest * 10); }
int BankInvestRate10()  { return BankSetting("rate10", iInvestmentInterest * 10); }
int BankMonthDays()     { return BankSetting("month", iBankMonthDays); }
int BankTermDays()      { return BankSetting("term", iInvestmentDelay); }
// One bank day of online time, in 6-second heartbeats. Never below 10, so a bad setting cannot divide by zero.
int BankDayTicks()
{
    int iTicks = BankSetting("dayticks", iBankDayTicks);
    if (iTicks < 10) { iTicks = 10; }
    return iTicks;
}

// The three amounts offered for a deposit or withdrawal (iIndex 1-3), and for an investment.
int BankMoveAmount(int iIndex)
{
    if (iIndex == 1) { return BankSetting("mov1", iBankMove1); }
    if (iIndex == 2) { return BankSetting("mov2", iBankMove2); }
    if (iIndex == 3) { return BankSetting("mov3", iBankMove3); }
    return 0;
}

int BankInvestAmount(int iIndex)
{
    if (iIndex == 1) { return BankSetting("inv1", iBankInvest1); }
    if (iIndex == 2) { return BankSetting("inv2", iBankInvest2); }
    if (iIndex == 3) { return BankSetting("inv3", iBankInvest3); }
    return 0;
}

int BankAccountPrice()  { return BankSetting("price", iAccount); }
int BankInvestmentsOpen() { return BankSetting("open", 1); }

// 20 -> "2", 15 -> "1.5"
string BankPercentText(int iTenths)
{
    if ((iTenths % 10) == 0) { return IntToString(iTenths / 10); }
    return IntToString(iTenths / 10) + "." + IntToString(iTenths % 10);
}

int BankHolderTicks(object oPC)
{
    return GetLocalInt(GetItemPossessedBy(oPC, "goldbag"), "Counter");
}

// Value of a principal at the end of a term: principal * (1 + monthly rate) ^ (term / month).
int BankInvestmentValue(int iPrincipal, int iRate10, int iDays, int iMonth)
{
    if ((iRate10 <= 0) || (iDays <= 0)) { return iPrincipal; }
    if (iMonth <= 0) { iMonth = BankMonthDays(); }
    float fGrowth = pow(1.0 + IntToFloat(iRate10) / 1000.0, IntToFloat(iDays) / IntToFloat(iMonth));
    return FloatToInt(IntToFloat(iPrincipal) * fGrowth);
}

// "5 h 12 min" / "40 min": the play time that a number of ticks stands for.
string BankPlayTime(int iTicks)
{
    int iMinutes = (iTicks * BANK_SECONDS_PER_TICK) / 60;
    if (iMinutes < 60) { return IntToString(iMinutes) + " min"; }
    string sMin = IntToString(iMinutes % 60);
    if ((iMinutes % 60) < 10) { sMin = "0" + sMin; }
    return IntToString(iMinutes / 60) + " h " + sMin + " min";
}

// "20 bank days (about 19 h 12 min of play)"; a part of a day counts as a whole one.
string BankTermText(int iTicks)
{
    int iDays = (iTicks + BankDayTicks() - 1) / BankDayTicks();
    return IntToString(iDays) + " bank day(s), about " + BankPlayTime(iTicks) + " of play";
}

// "about 58 minutes spent logged in"
string BankDayText()
{
    return "about " + IntToString((BankDayTicks() * BANK_SECONDS_PER_TICK + 30) / 60) + " minutes spent logged in";
}

// Grow the principal once, when its term ends.
void BankPayInvestmentGain(object oAccount)
{
    SetLocalInt(oAccount, "IV", BankInvestmentValue(GetLocalInt(oAccount, "IV"), GetLocalInt(oAccount, "IVrate"), GetLocalInt(oAccount, "IVdays"), GetLocalInt(oAccount, "IVmonth")));
}

// Record the deal on the item when an investment is bought.
void BankStartInvestment(object oPC, object oAccount, int iPrincipal)
{
    SetLocalInt(oAccount, "IV", iPrincipal);
    SetLocalInt(oAccount, "IVdelay", BankTermDays() * BankDayTicks());
    SetLocalInt(oAccount, "IVmark", BankHolderTicks(oPC));
    SetLocalInt(oAccount, "IVrate", BankInvestRate10());
    SetLocalInt(oAccount, "IVdays", BankTermDays());
    SetLocalInt(oAccount, "IVmonth", BankMonthDays());
}

// After buying: fill the tokens of the confirmation line and tell the buyer the deal.
void BankInvestmentNotice(object oPC, object oAccount)
{
    int iPrincipal = GetLocalInt(oAccount, "IV");
    int iTicks = GetLocalInt(oAccount, "IVdelay");
    int iValue = BankInvestmentValue(iPrincipal, GetLocalInt(oAccount, "IVrate"), GetLocalInt(oAccount, "IVdays"), GetLocalInt(oAccount, "IVmonth"));
    SetCustomToken(10140, IntToString(iPrincipal));
    SetCustomToken(10141, BankTermText(iTicks));
    SetCustomToken(10146, IntToString(iValue));
    FloatingTextStringOnCreature("Invested " + IntToString(iPrincipal) + " GP. In " + BankTermText(iTicks) + " you receive " + IntToString(iValue) + " GP.", oPC);
}

// Bring an account up to date for the time its holder has been online.
void BankSettle(object oPC, object oAccount)
{
    if (!GetIsObjectValid(oAccount)) { return; }
    int iNow = BankHolderTicks(oPC);

    // Interest
    int iMark = GetLocalInt(oAccount, "GPmark");
    if (iMark < 1)
    {
        iMark = iNow - GetLocalInt(oAccount, "GPdelay");
        DeleteLocalInt(oAccount, "GPdelay");
        if (iMark < 1) { iMark = 1; }
    }
    if (iMark > iNow) { iMark = iNow; }   // moved from a holder with a longer history
    int iDays = (iNow - iMark) / BankDayTicks();
    if (iDays > BANK_MAX_DAYS_PER_SETTLE) { iDays = BANK_MAX_DAYS_PER_SETTLE; }
    int iGP = GetLocalInt(oAccount, "GP");
    int i;
    if (iGP > 0)
    {
        float fGP = IntToFloat(iGP) + GetLocalFloat(oAccount, "GPfrac");
        float fDaily = pow(1.0 + IntToFloat(BankNormalRate10()) / 1000.0, 1.0 / IntToFloat(BankMonthDays()));
        fGP = fGP * pow(fDaily, IntToFloat(iDays));
        iGP = FloatToInt(fGP);
        SetLocalInt(oAccount, "GP", iGP);
        SetLocalFloat(oAccount, "GPfrac", fGP - IntToFloat(iGP));
    }
    SetLocalInt(oAccount, "GPmark", iMark + (iDays * BankDayTicks()));

    // Investment term
    int iIVdelay = GetLocalInt(oAccount, "IVdelay");
    int iIVmark = GetLocalInt(oAccount, "IVmark");
    if ((GetLocalInt(oAccount, "IV") != 0) && (iIVdelay >= 0))
    {
        if (iIVmark >= 1)
        {
            int iElapsed = iNow - iIVmark;
            if (iElapsed < 0) { iElapsed = 0; }
            iIVdelay = iIVdelay - iElapsed;
            if (iIVdelay < 0)
            {
                iIVdelay = -1;
                BankPayInvestmentGain(oAccount);
            }
            SetLocalInt(oAccount, "IVdelay", iIVdelay);
        }
    }
    SetLocalInt(oAccount, "IVmark", iNow);
}
