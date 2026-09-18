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
    object oCtrl = GetLocalObject(oPC, SPACENAV_CTRL);
    object oHere = GetArea(oCtrl);

    // Through to the ship's other room. Open to everyone aboard: a passenger has
    // no other way between the deck and the cabin.
    if (sElem == "x_move")
    {
        object oThere = FlightOtherHalf(oHere);
        if (!GetIsObjectValid(oThere)) { return; }
        NuiDestroy(oPC, nTok);
        FlightMoveTo(oPC, oThere);
        return;
    }

    if (GetStringLeft(sElem, 2) != "d_") { return; }

    object oCabin = FlightCabinOf(oHere);
    if (!SpaceDeckMayUse(oPC, oCabin)) { return; }

    int n = StringToInt(GetStringRight(sElem, GetStringLength(sElem) - 2));
    string sBody = SpaceNavBodyName(SpaceNavBodyRecord(GetModule(), n));
    if (sBody == "") { return; }

    if (SpaceDeckTravel(oPC, oCabin, sBody)) { NuiDestroy(oPC, nTok); }
}
