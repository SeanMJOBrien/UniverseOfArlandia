// shipname_event - NUI event handler for the ship rename window.
// Registered per-window via NuiCreate's sEventScript (see _shipname.nss), so
// it only ever fires for our own window.

#include "_shipname"

void main()
{
    object oPC = NuiGetEventPlayer();
    int nTok = NuiGetEventWindow();
    if (NuiGetWindowId(oPC, nTok) != SHIPNAME_WINDOW) { return; }

    string sEvent = NuiGetEventType();

    if (sEvent == "close")
    {
        DeleteLocalObject(oPC, SHIPNAME_PCTOOL);
        return;
    }
    if (sEvent != "click") { return; }

    string sElem = NuiGetEventElement();

    if (sElem == SHIPNAME_SAVE)
    {
        string sName = JsonGetString(NuiGetBind(oPC, nTok, SHIPNAME_BIND));
        if (ShipNameCommit(oPC, sName))
        {
            NuiSetGroupLayout(oPC, nTok, "_window_", ShipNamePage(oPC));
        }
    }
    else if (sElem == SHIPNAME_CLEAR)
    {
        if (ShipNameCommit(oPC, ""))
        {
            NuiSetBind(oPC, nTok, SHIPNAME_BIND, JsonString(""));
            NuiSetGroupLayout(oPC, nTok, "_window_", ShipNamePage(oPC));
        }
    }
}
