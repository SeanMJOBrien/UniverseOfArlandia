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
// Normal interest is iNormalInterest % per month (iBankMonthDays bank days),
// added daily on the holder's online time. The fraction of a gold piece it
// rounds off is carried (GPfrac) so small balances still grow.
//
// An investment locks its principal for a term. At purchase the rate
// (IVrate, tenths of a percent per month) and the term (IVdays) are stored on
// the item, so a later change to the settings never alters a deal in progress.
// When the term ends the principal is grown once at that rate, compounded daily
// over the term, and then waits to be collected. Investments bought before this
// change have no IVrate and are paid back at face value, as they were bought.

#include "_module"

const int BANK_TICKS_PER_DAY = 576;       // one day of online time (6 s heartbeat)
const int BANK_MAX_DAYS_PER_SETTLE = 400; // keeps one settlement inside the instruction limit

int BankHolderTicks(object oPC)
{
    return GetLocalInt(GetItemPossessedBy(oPC, "goldbag"), "Counter");
}

// Grow the principal once, when its term ends: (1 + monthly rate) ^ (term / month).
void BankPayInvestmentGain(object oAccount)
{
    int iRate = GetLocalInt(oAccount, "IVrate");
    int iDays = GetLocalInt(oAccount, "IVdays");
    if ((iRate <= 0) || (iDays <= 0)) { return; }
    float fGrowth = pow(1.0 + IntToFloat(iRate) / 1000.0, IntToFloat(iDays) / IntToFloat(iBankMonthDays));
    SetLocalInt(oAccount, "IV", FloatToInt(IntToFloat(GetLocalInt(oAccount, "IV")) * fGrowth));
}

// Record the deal on the item when an investment is bought.
void BankStartInvestment(object oPC, object oAccount, int iPrincipal)
{
    SetLocalInt(oAccount, "IV", iPrincipal);
    SetLocalInt(oAccount, "IVdelay", iInvestmentDelay * BANK_TICKS_PER_DAY);
    SetLocalInt(oAccount, "IVmark", BankHolderTicks(oPC));
    SetLocalInt(oAccount, "IVrate", iInvestmentInterest * 10);
    SetLocalInt(oAccount, "IVdays", iInvestmentDelay);
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
    int iDays = (iNow - iMark) / BANK_TICKS_PER_DAY;
    if (iDays > BANK_MAX_DAYS_PER_SETTLE) { iDays = BANK_MAX_DAYS_PER_SETTLE; }
    int iGP = GetLocalInt(oAccount, "GP");
    int i;
    if (iGP > 0)
    {
        float fGP = IntToFloat(iGP) + GetLocalFloat(oAccount, "GPfrac");
        float fDaily = pow(1.0 + IntToFloat(iNormalInterest) / 100.0, 1.0 / IntToFloat(iBankMonthDays));
        fGP = fGP * pow(fDaily, IntToFloat(iDays));
        iGP = FloatToInt(fGP);
        SetLocalInt(oAccount, "GP", iGP);
        SetLocalFloat(oAccount, "GPfrac", fGP - IntToFloat(iGP));
    }
    SetLocalInt(oAccount, "GPmark", iMark + (iDays * BANK_TICKS_PER_DAY));

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
