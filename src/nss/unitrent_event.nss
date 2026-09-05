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
    if (GetStringLeft(sElem, 2) != "u_") { return; }

    object oDoor = GetLocalObject(oPC, UNITRENT_DOOR);
    if (!GetIsObjectValid(oDoor)) { return; }

    int iUnit = StringToInt(GetStringRight(sElem, GetStringLength(sElem) - 2));
    if ((iUnit < 1) || (iUnit > UnitCount(oDoor))) { return; }

    string sTenant = UnitTenant(oDoor, iUnit);

    // Occupied by this player: the button is "Enter". Occupied by anyone else:
    // no button was drawn, so a click can only be a stale window - ignore it.
    if (sTenant != "")
    {
        if (sTenant == GetName(oPC)) { UnitEnter(oPC, oDoor, iUnit); }
        return;
    }

    if (UnitRentTake(oPC, oDoor, iUnit))
    {
        NuiSetGroupLayout(oPC, nTok, "_window_", UnitRentPage(oPC));
    }
}
