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
// Behaviour kept as it was: normal interest compounds iNormalInterest % per day
// of online time; an investment's term counts down and then waits to be
// collected. The investment gain (iInvestmentInterest) was never applied by the
// old heartbeat code (it tested a stale copy of IVdelay) and still is not.

#include "_module"

const int BANK_TICKS_PER_DAY = 576;       // one day of online time (6 s heartbeat)
const int BANK_MAX_DAYS_PER_SETTLE = 400; // keeps one settlement inside the instruction limit

int BankHolderTicks(object oPC)
{
    return GetLocalInt(GetItemPossessedBy(oPC, "goldbag"), "Counter");
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
        for (i = 0; i < iDays; i++) { iGP = iGP + (iGP * iNormalInterest / 100); }
        SetLocalInt(oAccount, "GP", iGP);
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
            if (iIVdelay < 0) { iIVdelay = -1; }
            SetLocalInt(oAccount, "IVdelay", iIVdelay);
        }
    }
    SetLocalInt(oAccount, "IVmark", iNow);
}
