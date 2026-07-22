// pilot_nui_event - NUI event handler for the Pilot's "Departures Board".
// ---
// Registered per-window via NuiCreate's sEventScript (see pilot_nui_inc), so
// it only ever fires for our own window. "gotoAir"/"gotoStar"/"back" swap the
// window's single "root" group between the front page and a ship type's
// destinations list (see PilotNuiShowList/PilotNuiShowMain). "airbuy"/
// "starbuy" clicks map their row (NuiGetEventArrayIndex, 0-based) back to the
// matching 1-based AirShipDest<n>/StarShipArea<n> index on the Pilot object
// stashed in PilotNuiOpen, and hand off to PilotNuiBuyTicket for the actual
// purchase.

#include "pilot_nui_inc"

void main()
{
    object oPC = NuiGetEventPlayer();
    int nTok = NuiGetEventWindow();
    if(NuiGetWindowId(oPC,nTok)!=PILOT_NUI_WINDOW){return;}

    string sEvent = NuiGetEventType();

    if(sEvent=="close")
       {
    DeleteLocalObject(oPC,PILOT_NUI_CTX);
    return;
       }
    if(sEvent!="click"){return;}

    object oPilot = GetLocalObject(oPC,PILOT_NUI_CTX);
    if(!GetIsObjectValid(oPilot))
       {
    NuiDestroy(oPC,nTok);
    return;
       }

    string sElem = NuiGetEventElement();

    if(sElem==PILOT_NUI_GOTO_AIR)
       {
    PilotNuiShowList(oPC,nTok,oPilot,1);
    return;
       }
    if(sElem==PILOT_NUI_GOTO_STAR)
       {
    PilotNuiShowList(oPC,nTok,oPilot,2);
    return;
       }
    if(sElem==PILOT_NUI_BACK)
       {
    PilotNuiShowMain(oPC,nTok,oPilot);
    return;
       }

    int i = NuiGetEventArrayIndex()+1;

    if(sElem=="airbuy")
       {
    PilotNuiBuyTicket(oPC,oPilot,1,i);
       }
    else if(sElem=="starbuy")
       {
    if(GetItemPossessedBy(oPC,"starpass")==OBJECT_INVALID)
        {
    SendMessageToPC(oPC,"I'm sorry, but you need an intergalactic star pass to buy a starship ticket.");
    return;
        }
    PilotNuiBuyTicket(oPC,oPilot,2,i);
       }
}
