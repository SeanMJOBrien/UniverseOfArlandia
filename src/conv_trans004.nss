#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
//
string sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
string sInterest = GetStringLeft(sInterests,FindSubString(sInterests,"&1&"));
string sAreaName = GetStringRight(GetStringLeft(sInterests,FindSubString(sInterests,"&2&")),GetStringLength(GetStringLeft(sInterests,FindSubString(sInterests,"&2&")))-FindSubString(sInterests,"&1&")-3);
//
string sVar = GetStringRight(GetStringLeft(sInterests,FindSubString(sInterests,"&3&")),GetStringLength(GetStringLeft(sInterests,FindSubString(sInterests,"&3&")))-FindSubString(sInterests,"&2&")-3);
string sVar11 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_11_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_11_")))-FindSubString(sVar,"_10_")-4);
if(GetStringLeft(sInterest,1)=="D"){sAreaName = sVar11;}
//
int iPage = (GetLocalInt(OBJECT_SELF,"Page")-1)*10;
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice2")+iPage;
//
object oItem;string sName;int iDist;int iPrice;
string sPlanetProv;string sPlanetDest;string sAreaProv;string sAreaDest;
////////////////////////////////////////////////////////////////////////////////
// Airships
if(iChoice1==1)
 {
sPlanetProv = sPlanet;
sPlanetDest = sPlanet;
sAreaProv = sArea;
sAreaDest = GetLocalString(OBJECT_SELF,"AirShipDest"+IntToString(iChoice2));
sName = GetLocalString(OBJECT_SELF,"AirShipName"+IntToString(iChoice2));
iDist = GetLocalInt(OBJECT_SELF,"AirShipLength"+IntToString(iChoice2));
iPrice = GetLocalInt(OBJECT_SELF,"AirShipPrice"+IntToString(iChoice2));

oItem = CreateItemOnObject("ticket",oPC);
SetLocalString(oItem,"Var","1&1&"+sPlanetProv+"&2&"+sPlanetDest+"&3&"+sAreaProv+"&4&"+sAreaDest+"&5&"+sName+"&6&"+IntToString(iDist)+"&7&");
SetName(oItem,sPlanet+" airship ticket from "+sAreaName+" to "+sName);
TakeGoldFromCreature(iPrice,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// Starships
else if(iChoice1==2)
 {
sPlanetProv = sPlanet;
sPlanetDest = GetLocalString(OBJECT_SELF,"StarShipName"+IntToString(iChoice2));
sAreaProv = sArea;
sAreaDest = GetLocalString(OBJECT_SELF,"StarShipArea"+IntToString(iChoice2));
sName = GetLocalString(OBJECT_SELF,"StarShipName"+IntToString(iChoice2));
iDist = GetLocalInt(OBJECT_SELF,"StarShipLength"+IntToString(iChoice2));
iPrice = GetLocalInt(OBJECT_SELF,"StarShipPrice"+IntToString(iChoice2));

oItem = CreateItemOnObject("ticket",oPC);
SetLocalString(oItem,"Var","2&1&"+sPlanetProv+"&2&"+sPlanetDest+"&3&"+sAreaProv+"&4&"+sAreaDest+"&5&"+sName+"&6&"+IntToString(iDist)+"&7&");
SetName(oItem,"Starship ticket from "+sPlanet+" to "+sName);
TakeGoldFromCreature(iPrice,oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// Domains
if(GetStringLeft(sInterests,1)=="D")
 {
object oFlag = GetLocalObject(OBJECT_SELF,"StructureFlag");
int iLevel = StringToInt(GetStringRight(GetName(oFlag),1));
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
int iGain = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain");

     if(iLevel>=5){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iPrice/1));}
else if(iLevel>=3){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iPrice/2));}
 }
////////////////////////////////////////////////////////////////////////////////
}
