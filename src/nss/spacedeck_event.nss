// spacedeck_event - NUI handler for the ship's navigation control.
#include "_spacenav"

void main()
{
    object oPC = NuiGetEventPlayer();
    int nTok = NuiGetEventWindow();
    if (NuiGetWindowId(oPC, nTok) != SPACENAV_WINDOW) { return; }

    string sEvent = NuiGetEventType();
    if (sEvent == "close") { DeleteLocalObject(oPC, SPACENAV_CTRL); return; }
    if (sEvent != "click") { return; }

    string sElem = NuiGetEventElement();
    if (GetStringLeft(sElem, 2) != "d_") { return; }

    object oCtrl = GetLocalObject(oPC, SPACENAV_CTRL);
    object oCabin = GetArea(oCtrl);
    if (!SpaceDeckMayUse(oPC, oCabin)) { return; }

    int n = StringToInt(GetStringRight(sElem, GetStringLength(sElem) - 2));
    string sBody = SpaceNavBodyName(SpaceNavBodyRecord(GetModule(), n));
    if (sBody == "") { return; }

    if (SpaceDeckTravel(oPC, oCabin, sBody)) { NuiDestroy(oPC, nTok); }
}
