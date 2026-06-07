#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLastUsedBy();
object oPCs = GetFirstPC();
string sTag = GetTag(OBJECT_SELF);
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sName = GetName(OBJECT_SELF);
//
int iType = GetLocalInt(OBJECT_SELF,"TransType");
string sPlanetProv = GetLocalString(OBJECT_SELF,"PlanetProv");
string sPlanetDest = GetLocalString(OBJECT_SELF,"PlanetDest");
string sAreaProv = GetLocalString(OBJECT_SELF,"AreaProv");
string sAreaDest = GetLocalString(OBJECT_SELF,"AreaDest");
int iDist = GetLocalInt(OBJECT_SELF,"TransDist");
//
int iHour = GetTimeHour();
float fPX;float fPY;float fPZ = 0.0;if(GetStringLeft(GetTag(oArea),8)=="tropical"){fPZ = 1.0;}else if((GetStringLeft(GetTag(oArea),6)=="ground")||(GetStringLeft(GetTag(oArea),11)=="ruralcastle")){fPZ = 5.0;}else if(GetStringLeft(GetTag(oArea),4)=="city"){fPZ = -1.0;}
int iTransports = GetLocalInt(oArea,"Transports");
object oObjects = GetFirstObjectInArea(oArea);
int iArrival = GetLocalInt(OBJECT_SELF,"TransArrival");
location lArrival = GetLocalLocation(OBJECT_SELF,"TransArrivalLoc");
//
object oFlag = GetLocalObject(OBJECT_SELF,"StructureFlag");
int iLevel = StringToInt(GetStringRight(GetName(oFlag),1));
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
//
string sBP;float fX;float fY;float fZ;float fF;location lLoc; object oPla;int iTimeLeft;int iTime;int iStarshipD = -1;
object oSound1;object oSound2;object oSound3;object oSound4;object oExit;
////////////////////////////////////////////////////////////////////////////////
// Transport Airship
if(GetStringLeft(sTag,7)=="airship")
 {
oSound1 = GetObjectByTag("SD_"+sTag+"_1");
oSound2 = GetObjectByTag("SD_"+sTag+"_2");
oSound3 = GetObjectByTag("SD_"+sTag+"_3");
oSound4 = GetObjectByTag("SD_"+sTag+"_4");
oExit = GetObjectByTag("EX_"+sTag);
iTime = (iAirshipSec*iDist)/5;
iTimeLeft = GetLocalInt(OBJECT_SELF,"TimeLeft");if(iTimeLeft==0){iTimeLeft = iTime;}
//SendMessageToAllDMs("Airship Time Left = "+IntToString(iTimeLeft));

while(GetIsObjectValid(oPCs))
  {
if(GetArea(oPCs)==OBJECT_SELF)
   {
if((iHour==iAirship1)||(iHour==iAirship2)||(iHour==iAirship3)){if(GetLocalInt(oPCs,"TransMess1")==0){SetLocalInt(oPCs,"TransMess1",1);FloatingTextStringOnCreature("The trip will begin in a few moments. Please take place.",oPCs);SoundObjectStop(oSound1);SoundObjectStop(oSound2);SoundObjectStop(oSound3);SoundObjectStop(oSound4);}}
else if(GetLocalInt(oPCs,"TransMess2")==0){SetLocalInt(oPCs,"TransMess2",1);FloatingTextStringOnCreature("The journey begins.",oPCs);SoundObjectPlay(oSound1);SoundObjectPlay(oSound2);SoundObjectPlay(oSound3);SoundObjectPlay(oSound4);}
else if((GetLocalInt(oPCs,"TransMess3")==0)&&(iTimeLeft<=iTime/2)){SetLocalInt(oPCs,"TransMess3",1);FloatingTextStringOnCreature("We are half of the way.",oPCs);}
else if((GetLocalInt(oPCs,"TransMess4")==0)&&(iTimeLeft<=0)){SetLocalInt(oPCs,"TransMess4",1);FloatingTextStringOnCreature("We have reached our destination. Take the ramp to exit and have a nice day.",oPCs);SoundObjectStop(oSound1);SoundObjectStop(oSound2);SoundObjectStop(oSound3);SoundObjectStop(oSound4);}
   }
oPCs = GetNextPC();
  }
if((iTimeLeft!=-1)&&(iHour!=iAirship1)&&(iHour!=iAirship2)&&(iHour!=iAirship3)){iTimeLeft--;SetLocalInt(OBJECT_SELF,"TimeLeft",iTimeLeft);if(iTimeLeft==0){SetLocalInt(OBJECT_SELF,"TimeLeft",-1);}}
 }
////////////////////////////////////////////////////////////////////////////////
// Transport Starship
else if(GetStringLeft(sTag,8)=="starship")
 {
oSound1 = GetObjectByTag("SD_"+sTag+"_1");
oExit = GetObjectByTag("EX_"+sTag);
iTime = (iStarshipSec*iDist)/5;
iTimeLeft = GetLocalInt(OBJECT_SELF,"TimeLeft");if(iTimeLeft==0){iTimeLeft = iTime;}
//SendMessageToAllDMs("Starship Time Left = "+IntToString(iTimeLeft));

while(GetIsObjectValid(oPCs))
  {
if(GetArea(oPCs)==OBJECT_SELF)
   {
if(iHour==iStarship){if(GetLocalInt(oPCs,"TransMess1")==0){SetLocalInt(oPCs,"TransMess1",1);FloatingTextStringOnCreature("The trip will begin in a few moments. Please take place.",oPCs);SoundObjectStop(oSound1);}}
else if(GetLocalInt(oPCs,"TransMess2")==0){SetLocalInt(oPCs,"TransMess2",1);FloatingTextStringOnCreature("The journey begins.",oPCs);SoundObjectPlay(oSound1);}
else if((GetLocalInt(oPCs,"TransMess3")==0)&&(iTimeLeft<=iTime/2)){SetLocalInt(oPCs,"TransMess3",1);FloatingTextStringOnCreature("We are half of the way.",oPCs);}
else if((GetLocalInt(oPCs,"TransMess4")==0)&&(iTimeLeft<=0)){SetLocalInt(oPCs,"TransMess4",1);FloatingTextStringOnCreature("We have reached our destination. Take the exit to leave the starship and have a nice day.",oPCs);SoundObjectStop(oSound1);}
   }
oPCs = GetNextPC();
  }
if((iTimeLeft!=-1)&&(iHour!=iStarship)){iTimeLeft--;SetLocalInt(OBJECT_SELF,"TimeLeft",iTimeLeft);if(iTimeLeft==0){SetLocalInt(OBJECT_SELF,"TimeLeft",-1);}}
 }
////////////////////////////////////////////////////////////////////////////////
// Transport Exit
else if(GetStringLeft(sTag,3)=="EX_")
 {
if(GetLocalInt(oPC,"TransMess4")==0)
  {
SpeakString("Please wait for the end of the trip");
  }
else
  {
iType = GetLocalInt(oArea,"TransType");
sPlanetDest = GetLocalString(oArea,"PlanetDest");if(GetStringRight(sPlanetDest,1)==")"){sPlanetDest = GetStringLeft(sPlanetDest,FindSubString(sPlanetDest," ("));}
sAreaDest = GetLocalString(oArea,"AreaDest");
//
SetLocalString(oPC,"PlanetDest",sPlanetDest);
SetLocalString(oPC,"AreaDest",sAreaDest);
//
string sInterest = GetPersistentString(oModule,sPlanetDest+"&"+sAreaDest+"&Interests");
string sVar = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")))-FindSubString(sInterest,"&2&")-3);
string sVar1 = GetStringLeft(sVar,FindSubString(sVar,"_01_"));
string sVar2 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_02_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_02_")))-FindSubString(sVar,"_01_")-4);
string sVar3 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_03_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_03_")))-FindSubString(sVar,"_02_")-4);
string sVar4 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_04_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_04_")))-FindSubString(sVar,"_03_")-4);
string sVar6 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_06_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_06_")))-FindSubString(sVar,"_05_")-4);
string sVar7 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_07_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_07_")))-FindSubString(sVar,"_06_")-4);
string sVar9 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_09_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_09_")))-FindSubString(sVar,"_08_")-4);
// Types & Levels
string sVar1L = GetStringLeft(sVar1,FindSubString(sVar1,"%"));
string sVar2L = GetStringLeft(sVar2,FindSubString(sVar2,"%"));
string sVar3L = GetStringLeft(sVar3,FindSubString(sVar3,"%"));
string sVar4L = GetStringLeft(sVar4,FindSubString(sVar4,"%"));
string sVar6L = GetStringLeft(sVar6,FindSubString(sVar6,"%"));
string sVar7L = GetStringLeft(sVar7,FindSubString(sVar7,"%"));
string sVar9L = GetStringLeft(sVar9,FindSubString(sVar9,"%"));
//
     if(((iType==1)&&(sVar1L=="1"))||((iType==2)&&(sVar1L=="17"))){fX = 100.0;fY = 137.0;}
else if(((iType==1)&&(sVar2L=="1"))||((iType==2)&&(sVar1L=="17"))){fX = 120.0;fY = 137.0;}
else if(((iType==1)&&(sVar3L=="1"))||((iType==2)&&(sVar1L=="17"))){fX = 140.0;fY = 137.0;}
else if(((iType==1)&&(sVar4L=="1"))||((iType==2)&&(sVar1L=="17"))){fX = 100.0;fY = 117.0;}
else if(((iType==1)&&(sVar6L=="1"))||((iType==2)&&(sVar1L=="17"))){fX = 140.0;fY = 117.0;}
else if(((iType==1)&&(sVar7L=="1"))||((iType==2)&&(sVar1L=="17"))){fX = 100.0;fY = 97.0;}
else if(((iType==1)&&(sVar9L=="1"))||((iType==2)&&(sVar1L=="17"))){fX = 140.0;fY = 97.0;}

else if(sAreaDest=="0_0"){fX = 120.0;fY = 117.0;}
else{fX = 125.0;fY = 135.0;}
//
SetLocalFloat(oPC,"fX",fX);
SetLocalFloat(oPC,"fY",fY);
SetLocalInt(oPC,"TransArrival",iType);
//
ExecuteScript("transitions",oPC);
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Take off HB
else if(sTag=="planettakeoff")
 {
if((sPlanet!="")&&(sArea!=""))
  {
////////////////////////////////////////////////////////////////////////////////
// Domains
if(GetIsObjectValid(oFlag))
   {
if(GetStringLeft(GetName(oFlag),7)=="Airship"){iType = 1;if(iLevel==1){iAirship2 = -1;iAirship3 = -1;}else if(iLevel<=3){iAirship2 = -1;}}
else if(GetStringLeft(GetName(oFlag),8)=="Starship"){iType = 2;if(iLevel>=2){iStarshipD = 20;}}
   }
////////////////////////////////////////////////////////////////////////////////
// Airships
if((iTransports!=1)&&((iHour==iAirship1)||(iHour==iAirship2)||(iHour==iAirship3)))
   {
SetLocalInt(oArea,"Transports",1);
fPX = GetPosition(OBJECT_SELF).x;
fPY = GetPosition(OBJECT_SELF).y;

sBP = "zep_ship001";fX = 0.0;fY = 0.0;fZ = 9.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport1");SetLocalInt(oPla,"DontSave",1);SetPlotFlag(oPla,TRUE);SetLocalObject(oArea,"Transport",oPla);
sBP = "pla_rope";fX = 6.0;fY = -1.8;fZ = -5.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport1");SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
sBP = "pla_rope";fX = 6.0;fY = 1.8;fZ = -5.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport1");SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
sBP = "pla_rope";fX = -3.0;fY = -2.2;fZ = -5.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport1");SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
sBP = "pla_rope";fX = -3.0;fY = 2.2;fZ = -5.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport1");SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
sBP = "pla_ramp";fX = 0.0;fY = -2.0;fZ = 0.0;fF = 270.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport1");SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,TRUE);SetName(oPla,"Airship");
sBP = "pla_ramp";fX = 0.0;fY = -0.25;fZ = 4.5;fF = 270.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport1");SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
   }
////////////////////////////////////////////////////////////////////////////////
// Starships
else if((sArea=="0_0")&&(iTransports!=2)&&((iHour==iStarship)||(iHour==iStarshipD)))
   {
SetLocalInt(oArea,"Transports",2);
fPX = GetPosition(OBJECT_SELF).x;
fPY = GetPosition(OBJECT_SELF).y;

sBP = "zep_ship002";fX = 0.0;fY = 0.0;fZ = 9.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport2");SetLocalInt(oPla,"DontSave",1);SetPlotFlag(oPla,TRUE);SetLocalObject(oArea,"Transport",oPla);
sBP = "pla_rope";fX = 6.0;fY = -1.8;fZ = -5.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport2");SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
sBP = "pla_rope";fX = 6.0;fY = 1.8;fZ = -5.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport2");SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
sBP = "pla_rope";fX = -3.0;fY = -2.2;fZ = -5.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport2");SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
sBP = "pla_rope";fX = -3.0;fY = 2.2;fZ = -5.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport2");SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
sBP = "pla_ramp";fX = 0.0;fY = -2.0;fZ = 0.0;fF = 270.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport2");SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,TRUE);SetName(oPla,"Starship");
sBP = "pla_ramp";fX = 0.0;fY = -0.25;fZ = 4.5;fF = 270.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport2");SetLocalInt(oPla,"DontSave",1);SetUseableFlag(oPla,FALSE);
   }
////////////////////////////////////////////////////////////////////////////////
// Destroy transports
else if(((iTransports==1)&&(iHour!=iAirship1)&&(iHour!=iAirship2)&&(iHour!=iAirship3))||((iTransports==2)&&(iHour!=iStarship)))
   {
DeleteLocalInt(oArea,"Transports");
while(GetIsObjectValid(oObjects))
    {
if(GetStringLeft(GetTag(oObjects),9)=="transport"){DestroyObject(oObjects);}
oObjects = GetNextObjectInArea(oArea);
    }
   }
////////////////////////////////////////////////////////////////////////////////
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Transport arrival
else if(iArrival!=0)
 {
fPX = GetPositionFromLocation(lArrival).x;
fPY = GetPositionFromLocation(lArrival).y;

sBP = "zep_ship00"+IntToString(iArrival);fX = 0.0;fY = 0.0;fZ = 9.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport1");SetUseableFlag(oPla,FALSE);SetLocalInt(oPla,"DontSave",1);DestroyObject(oPla,10.0);
sBP = "pla_rope";fX = 6.0;fY = -1.8;fZ = -5.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport1");SetUseableFlag(oPla,FALSE);SetLocalInt(oPla,"DontSave",1);DestroyObject(oPla,10.0);
sBP = "pla_rope";fX = 6.0;fY = 1.8;fZ = -5.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport1");SetUseableFlag(oPla,FALSE);SetLocalInt(oPla,"DontSave",1);DestroyObject(oPla,10.0);
sBP = "pla_rope";fX = -3.0;fY = -2.2;fZ = -5.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport1");SetUseableFlag(oPla,FALSE);SetLocalInt(oPla,"DontSave",1);DestroyObject(oPla,10.0);
sBP = "pla_rope";fX = -3.0;fY = 2.2;fZ = -5.0;fF = 180.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport1");SetUseableFlag(oPla,FALSE);SetLocalInt(oPla,"DontSave",1);DestroyObject(oPla,10.0);
sBP = "pla_ramp";fX = 0.0;fY = -2.0;fZ = 0.0;fF = 270.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport1");SetUseableFlag(oPla,FALSE);SetLocalInt(oPla,"DontSave",1);DestroyObject(oPla,10.0);
sBP = "pla_ramp";fX = 0.0;fY = -0.25;fZ = 4.5;fF = 270.0;lLoc = Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);oPla = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,FALSE,"transport1");SetUseableFlag(oPla,FALSE);SetLocalInt(oPla,"DontSave",1);DestroyObject(oPla,10.0);

DelayCommand(10.0,DeleteLocalInt(OBJECT_SELF,"TransArrival"));
DelayCommand(10.0,DeleteLocalLocation(OBJECT_SELF,"TransArrivalLoc"));
 }
////////////////////////////////////////////////////////////////////////////////
}
