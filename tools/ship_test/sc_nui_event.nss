// sc_nui_event - NUI event handler for the Ship Orders window.

#include "sc_nui"

void main()
{
    object oPC = NuiGetEventPlayer();
    int nToken = NuiGetEventWindow();
    if (NuiGetWindowId(oPC, nToken) != SCNUI_WINDOW) return;

    string sEvent = NuiGetEventType();
    string sElement = NuiGetEventElement();
    if (sEvent == "watch")
    {
        ScUiReadOrders(oPC, nToken);
        return;
    }
    if (sEvent != "click") return;

    if (sElement == SCNUI_READY)
    {
        if (GetLocalInt(GetModule(), SC_PHASE) != 1) return;
        ScUiReadOrders(oPC, nToken);
        ScResolve();
    }
    else if (sElement == SCNUI_END)
    {
        if (GetLocalInt(GetModule(), SC_ACTIVE)) ScEndBattle(0);
    }
}
