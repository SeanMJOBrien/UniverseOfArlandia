// pilot_nui_inc - Builder + ticket-purchase logic for the Pilot's NUI
// "Departures Board" window.
// ---
// Read-only browsing of the live airship/starship destination lists (built by
// conv_trans002.nss, same as the transport dialog uses) plus a "Buy" button
// per row. Routes its own events via sEventScript (see pilot_nui_event.nss) --
// no module-level OnNuiEvent wiring needed.
//
// Ticket purchase here mirrors conv_trans002.nss's afford-check and
// conv_trans004.nss's ticket-item creation exactly, so tickets bought from the
// NUI board redeem the same way at any pilot as ones bought via dialog.

#include "nw_inc_nui"
#include "aps_include"
#include "_module"

const string PILOT_NUI_EVENT_SCRIPT = "pilot_nui_event";
const string PILOT_NUI_WINDOW       = "pilot_departures";
const string PILOT_NUI_CTX          = "PilotNuiCtx"; // PC local: the Pilot object
const string PILOT_NUI_ROOT         = "_window_";    // NuiSetGroupLayout's magic window-root id
const string PILOT_NUI_GOTO_AIR     = "gotoAir";
const string PILOT_NUI_GOTO_STAR    = "gotoStar";
const string PILOT_NUI_BACK         = "back";
const float  PILOT_NUI_CONTENT_WIDTH = 380.0; // NuiCol does not stretch children -- each top-level element must claim the window's width explicitly or it collapses to its own text size
// NuiCol also does not size children by content -- with no explicit height it
// hands out the window's leftover space evenly across every child (that's why
// the arrival lines were stretched apart and the list was squeezed to a
// sliver). Every element below gets an explicit NuiHeight so only the list
// claims the leftover room.
const float  PILOT_NUI_ARRIVALS_HEIGHT = 70.0;  // 3 lines (airship / blank / starship)
const float  PILOT_NUI_TITLE_HEIGHT    = 30.0;
const float  PILOT_NUI_LIST_HEIGHT     = 350.0;

// Hours until the next airship departure, same schedule math (and
// domain-upgrade adjustments) as conv_trans001.nss.
string PilotNuiAirshipNextText(object oPilot)
{
    object oFlag = GetLocalObject(oPilot,"StructureFlag");
    int iLevel = StringToInt(GetStringRight(GetName(oFlag),1));
    int iHour = GetTimeHour();
    int iAir2 = iAirship2;int iAir3 = iAirship3;
    int iAirShip;

    if(GetIsObjectValid(oFlag))
       {
    if(GetStringLeft(GetName(oFlag),7)=="Airship"){if(iLevel==1){iAir2 = -1;iAir3 = -1;}else if(iLevel<=3){iAir2 = -1;}}
       }

         if(iHour<iAirship1){iAirShip = iAirship1-iHour;}
    else if(iHour<iAir2){iAirShip = iAir2-iHour;}
    else if(iHour<iAir3){iAirShip = iAir3-iHour;}
    else                {iAirShip = 24-iHour+iAirship1;}

    return "Next Airship departs in "+IntToString(iAirShip)+" hour(s).";
}

// Hours until the next starship departure, same schedule math (and
// domain-upgrade adjustments) as conv_trans001.nss.
string PilotNuiStarshipNextText(object oPilot)
{
    object oFlag = GetLocalObject(oPilot,"StructureFlag");
    int iLevel = StringToInt(GetStringRight(GetName(oFlag),1));
    int iHour = GetTimeHour();
    int iStarD = -1;
    int iStarShip;

    if(GetIsObjectValid(oFlag))
       {
    if(GetStringLeft(GetName(oFlag),8)=="Starship"){if(iLevel>=2){iStarD = 20;}}
       }

         if(iHour<iStarship){iStarShip = iStarship-iHour;}
    else if(iHour<iStarD){iStarShip = iStarD-iHour;}
    else                 {iStarShip = 24-iHour+iStarship;}

    return "Next Starship departs in "+IntToString(iStarShip)+" hour(s).";
}

// The board's front page: both next-arrival times plus the two ship-type nav
// buttons. Built fresh each time it's (re)shown, so the arrival times never
// go stale while the window stays open.
json PilotNuiMainPage(object oPilot)
{
    string sArrivals = PilotNuiAirshipNextText(oPilot)+"\n\n"+PilotNuiStarshipNextText(oPilot);

    json jList = JsonArray();
    jList = JsonArrayInsert(jList,NuiHeight(NuiWidth(NuiText(JsonString(sArrivals),FALSE,NUI_SCROLLBARS_NONE),PILOT_NUI_CONTENT_WIDTH),PILOT_NUI_ARRIVALS_HEIGHT));
    jList = JsonArrayInsert(jList,NuiHeight(NuiWidth(NuiId(NuiButton(JsonString("Airship Tickets")),PILOT_NUI_GOTO_AIR),PILOT_NUI_CONTENT_WIDTH),NUI_STYLE_PRIMARY_HEIGHT));
    jList = JsonArrayInsert(jList,NuiHeight(NuiWidth(NuiId(NuiButton(JsonString("Starship Tickets")),PILOT_NUI_GOTO_STAR),PILOT_NUI_CONTENT_WIDTH),NUI_STYLE_PRIMARY_HEIGHT));
    return NuiCol(jList);
}

// The destination page for one ship type (iType 1 = airship, 2 = starship).
// Each destination is its own full-width "<name> - <price> gp" button; a
// click on it *is* the purchase (see pilot_nui_event.nss). Reads the
// AirShip*/StarShip* locals conv_trans002.nss stashed on oPilot, sets the bind
// the list template references, and returns the page layout -- the caller
// still has to NuiSetGroupLayout() it into the window.
json PilotNuiListPage(object oPC, int nTok, object oPilot, int iType)
{
    json jLabels = JsonArray();
    string sDest;string sName;int iPrice;int i;

    i = 0;
    while(TRUE)
       {
    i++;
    if(iType==1){sDest = GetLocalString(oPilot,"AirShipDest"+IntToString(i));}
    else        {sDest = GetLocalString(oPilot,"StarShipArea"+IntToString(i));}
    if(sDest==""){break;}
    if(iType==1)
       {
    sName = GetLocalString(oPilot,"AirShipName"+IntToString(i));
    iPrice = GetLocalInt(oPilot,"AirShipPrice"+IntToString(i));
       }
    else
       {
    sName = GetLocalString(oPilot,"StarShipName"+IntToString(i));
    iPrice = GetLocalInt(oPilot,"StarShipPrice"+IntToString(i));
       }
    jLabels = JsonArrayInsert(jLabels,JsonString(sName+" - "+IntToString(iPrice)+" gp"));
       }

    string sLabelBind = (iType==1) ? "airLabel" : "starLabel";
    string sBuyId = (iType==1) ? "airbuy" : "starbuy";
    string sTitle = (iType==1) ? "Airship Destinations" : "Starship Destinations";

    NuiSetBind(oPC,nTok,sLabelBind,jLabels);

    json jTemplate = JsonArray();
    jTemplate = JsonArrayInsert(jTemplate,NuiListTemplateCell(NuiId(NuiButton(NuiBind(sLabelBind)),sBuyId),0.0,TRUE));

    json jList = JsonArray();
    jList = JsonArrayInsert(jList,NuiHeight(NuiWidth(NuiLabel(JsonString(sTitle),JsonInt(NUI_HALIGN_CENTER),JsonInt(NUI_VALIGN_MIDDLE)),PILOT_NUI_CONTENT_WIDTH),PILOT_NUI_TITLE_HEIGHT));
    jList = JsonArrayInsert(jList,NuiHeight(NuiWidth(NuiList(jTemplate,JsonInt(JsonGetLength(jLabels)),30.0,TRUE,NUI_SCROLLBARS_Y),PILOT_NUI_CONTENT_WIDTH),PILOT_NUI_LIST_HEIGHT));
    jList = JsonArrayInsert(jList,NuiHeight(NuiWidth(NuiId(NuiButton(JsonString("Back")),PILOT_NUI_BACK),PILOT_NUI_CONTENT_WIDTH),NUI_STYLE_PRIMARY_HEIGHT));
    return NuiCol(jList);
}

// Swaps the window's page to the main front page.
void PilotNuiShowMain(object oPC, int nTok, object oPilot)
{
    NuiSetGroupLayout(oPC,nTok,PILOT_NUI_ROOT,PilotNuiMainPage(oPilot));
}

// Swaps the window's page to the airship (iType 1) or starship (iType 2)
// destinations list.
void PilotNuiShowList(object oPC, int nTok, object oPilot, int iType)
{
    NuiSetGroupLayout(oPC,nTok,PILOT_NUI_ROOT,PilotNuiListPage(oPC,nTok,oPilot,iType));
}

// Opens (or refreshes) the departures board for oPC, talking to oPilot.
void PilotNuiOpen(object oPC, object oPilot)
{
    // Destination lists have historically gone stale/empty around area-save
    // races (see area_save.nss/conv_trans002.nss history) -- always re-derive
    // live rather than trust old locals on the Pilot object.
    ExecuteScript("conv_trans002",oPilot);

    SetLocalObject(oPC,PILOT_NUI_CTX,oPilot);

    // NuiSetGroupLayout only targets a real "group" element or the special
    // "_window_" root (see its native doc comment in nwscript.nss) -- an
    // explicit NuiGroup wrapper here does not report its size upward and
    // squashes the whole window's content into a sliver, so the window's
    // own root layout is swapped directly via "_window_" instead.
    json jWin = NuiWindow(PilotNuiMainPage(oPilot),JsonString("Departures Board"),NuiRect(-1.0,-1.0,420.0,500.0),JsonBool(TRUE),JsonBool(FALSE),JsonBool(TRUE),JsonBool(FALSE),JsonBool(TRUE));

    NuiCreate(oPC,jWin,PILOT_NUI_WINDOW,PILOT_NUI_EVENT_SCRIPT);
}

// Buys a ticket for AirShip (iType 1) or StarShip (iType 2) destination index
// i, exactly mirroring conv_trans002.nss's afford-check and
// conv_trans004.nss's ticket-item creation.
void PilotNuiBuyTicket(object oPC, object oPilot, int iType, int i)
{
    object oArea = GetArea(oPilot);
    string sPlanet = GetLocalString(oArea,"Planet");
    string sArea = GetLocalString(oArea,"Area");
    string sPlanetProv;string sPlanetDest;string sAreaProv;string sAreaDest;
    string sName;int iDist;int iPrice;object oItem;string sAreaName = sArea;

    if(iType==1)
       {
    sName = GetLocalString(oPilot,"AirShipName"+IntToString(i));
    iDist = GetLocalInt(oPilot,"AirShipLength"+IntToString(i));
    iPrice = GetLocalInt(oPilot,"AirShipPrice"+IntToString(i));
    sAreaDest = GetLocalString(oPilot,"AirShipDest"+IntToString(i));
    sPlanetProv = sPlanet;sPlanetDest = sPlanet;sAreaProv = sArea;

    string sInterests = GetPersistentString(GetModule(),sPlanet+"&"+sArea+"&Interests");
    string sInterest = GetStringLeft(sInterests,FindSubString(sInterests,"&1&"));
    string sVar = GetStringRight(GetStringLeft(sInterests,FindSubString(sInterests,"&3&")),GetStringLength(GetStringLeft(sInterests,FindSubString(sInterests,"&3&")))-FindSubString(sInterests,"&2&")-3);
    string sVar11 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_11_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_11_")))-FindSubString(sVar,"_10_")-4);
    if(GetStringLeft(sInterest,1)=="D"){sAreaName = sVar11;}
    else{sAreaName = GetStringRight(GetStringLeft(sInterests,FindSubString(sInterests,"&2&")),GetStringLength(GetStringLeft(sInterests,FindSubString(sInterests,"&2&")))-FindSubString(sInterests,"&1&")-3);}
       }
    else
       {
    sName = GetLocalString(oPilot,"StarShipName"+IntToString(i));
    iDist = GetLocalInt(oPilot,"StarShipLength"+IntToString(i));
    iPrice = GetLocalInt(oPilot,"StarShipPrice"+IntToString(i));
    sAreaDest = GetLocalString(oPilot,"StarShipArea"+IntToString(i));
    sPlanetProv = sPlanet;sPlanetDest = sName;sAreaProv = sArea;
       }

    if(sAreaDest=="")
       {
    SendMessageToPC(oPC,"That destination is no longer available.");
    return;
       }
    if(GetGold(oPC)<iPrice)
       {
    SendMessageToPC(oPC,"I'm sorry, you don't have enough gold.");
    return;
       }

    oItem = CreateItemOnObject("ticket",oPC);
    SetLocalString(oItem,"Var",IntToString(iType)+"&1&"+sPlanetProv+"&2&"+sPlanetDest+"&3&"+sAreaProv+"&4&"+sAreaDest+"&5&"+sName+"&6&"+IntToString(iDist)+"&7&");
    if(iType==1){SetName(oItem,sPlanet+" airship ticket from "+sAreaName+" to "+sName);}
    else{SetName(oItem,"Starship ticket from "+sPlanet+" to "+sName);}
    TakeGoldFromCreature(iPrice,oPC,TRUE);

    SendMessageToPC(oPC,"Ticket purchased: "+GetName(oItem)+".");
}
