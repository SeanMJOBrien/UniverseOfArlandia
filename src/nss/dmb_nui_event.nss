// dmb_nui_event - NUI event handler for the DM cluster editor window.
// ---
// Registered per-window via NuiCreate's sEventScript (see dmb_nui_inc), so
// it only ever fires for our own window. "set_<Dir>"/"blk_<Dir>" edit the
// DM's pending per-direction mapping (PC locals), "save"/"remove" commit
// through DmbClusterNuiSave/DmbClusterNuiRemove; every change re-renders the
// page through the "_window_" root.

#include "dmb_nui_inc"

void main()
{
    object oPC = NuiGetEventPlayer();
    int nTok = NuiGetEventWindow();
    if (NuiGetWindowId(oPC, nTok) != DMB_NUI_WINDOW) { return; }

    string sEvent = NuiGetEventType();

    if (sEvent == "close")
    {
        DmbClusterNuiCleanup(oPC);
        return;
    }
    if (sEvent != "click") { return; }

    string sElem = NuiGetEventElement();

    if (GetStringLeft(sElem, 4) == "set_")
    {
        if (DmbClusterNuiSetHere(oPC, GetStringRight(sElem, GetStringLength(sElem) - 4)))
            DmbClusterNuiRefresh(oPC, nTok);
        return;
    }
    if (GetStringLeft(sElem, 4) == "blk_")
    {
        DeleteLocalString(oPC, "DmbClu_" + GetStringRight(sElem, GetStringLength(sElem) - 4));
        DmbClusterNuiRefresh(oPC, nTok);
        return;
    }
    if (sElem == DMB_NUI_SAVE)
    {
        DmbClusterNuiSave(oPC);
        DmbClusterNuiRefresh(oPC, nTok);
        return;
    }
    if (sElem == DMB_NUI_REMOVE)
    {
        DmbClusterNuiRemove(oPC);
        DmbClusterNuiRefresh(oPC, nTok);
        return;
    }
}
