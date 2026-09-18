// unitrent_event - NUI handler for the multi-unit rental door list.
// Registered per-window by NuiCreate, so it only fires for our own window.
#include "_unitrent"

void main()
{
    object oPC = NuiGetEventPlayer();
    int nTok = NuiGetEventWindow();
    if (NuiGetWindowId(oPC, nTok) != UNITRENT_WINDOW) { return; }

    string sEvent = NuiGetEventType();
    if (sEvent == "close") { DeleteLocalObject(oPC, UNITRENT_DOOR); return; }
    if (sEvent != "click") { return; }

    string sElem = NuiGetEventElement();
    string sKind = GetStringLeft(sElem, 2);
    if ((sKind != "u_") && (sKind != "e_") && (sKind != "p_") && (sKind != "l_")) { return; }

    object oDoor = GetLocalObject(oPC, UNITRENT_DOOR);
    if (!GetIsObjectValid(oDoor)) { return; }

    int iUnit = StringToInt(GetStringRight(sElem, GetStringLength(sElem) - 2));
    if ((iUnit < 1) || (iUnit > UnitCount(oDoor))) { return; }

    int bRefresh;
         if (sKind == "u_") { bRefresh = UnitRentTake(oPC, oDoor, iUnit); }
    else if (sKind == "p_") { bRefresh = UnitRentPay(oPC, oDoor, iUnit); }
    else if (sKind == "l_") { bRefresh = UnitRentLeave(oPC, oDoor, iUnit); }
    else if (sKind == "e_")
    {
        // Entering closes the window - the player is leaving the doorstep.
        if (UnitTenant(oDoor, iUnit) == GetName(oPC))
        {
            NuiDestroy(oPC, nTok);
            UnitEnter(oPC, oDoor, iUnit);
        }
        return;
    }

    if (bRefresh) { NuiSetGroupLayout(oPC, nTok, "_window_", UnitRentPage(oPC)); }
}
