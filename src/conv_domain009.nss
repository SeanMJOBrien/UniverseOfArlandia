#include "dmfi_dmw_inc"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
int iBonus = GetLocalInt(oArea,"Bonus");
int iStructure = GetLocalInt(OBJECT_SELF,"Structure");
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
int iLevel = StringToInt(GetStringRight(GetName(OBJECT_SELF),1));
//
int iStep = GetLocalInt(OBJECT_SELF,"Step");
int iStep2 = GetLocalInt(OBJECT_SELF,"Step2");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iDontStep = GetLocalInt(OBJECT_SELF,"DontStep");
int iResultPerPage = 20;
//
string sVar;string sBP;string sName;string sResult;string sCR2;string sName1;string sName2;string sTag1;string sTag2;int i1;int i;int j;
////////////////////////////////////////////////////////////////////////////////
if(iDontStep==0)
 {
i = 2;
iStep++;

SetLocalInt(OBJECT_SELF,"Choice"+IntToString(iStep),i);
SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);
SetLocalInt(OBJECT_SELF,"Step",iStep);
 }
////////////////////////////////////////////////////////////////////////////////
// Extractor
if(iStructure==5)
 {
//
i=0;
while(i<20)
  {
i++;
sVar = GetLocalString(oModule,sPlanet+"Rock"+IntToString(i));
sName = GetStringRight(sVar,GetStringLength(sVar)-FindSubString(sVar,"%")-1);

if(sName!=""){DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));SetCustomToken(10500+i,sName);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);}
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Factory
else if(iStructure==6)
 {
i=0;while(i<iResultPerPage){i++;SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);SetCustomToken(10310+i,"");SetCustomToken(10330+i,"");}
i=0;
while(i<iResultPerPage)
  {
i++;
sName = GetLocalString(oModule,"CRI"+IntToString(i+(iStep2*iResultPerPage)));
sResult = "";

if(sName!="")
   {
SetCustomToken(10310+i,sName);

sCR2 = GetLocalString(oModule,sName+"CRI1");
sName1 = GetStringLeft(sCR2,FindSubString(sCR2,"&A&"));
sName2 = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&B&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&B&")))-FindSubString(sCR2,"&A&")-3);
sBP = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&J&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&J&")))-FindSubString(sCR2,"&I&")-3);
sTag1 = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&K&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&K&")))-FindSubString(sCR2,"&J&")-3);
sTag2 = GetStringRight(GetStringLeft(sCR2,FindSubString(sCR2,"&L&")),GetStringLength(GetStringLeft(sCR2,FindSubString(sCR2,"&L&")))-FindSubString(sCR2,"&K&")-3);
if(GetStringLeft(sTag1,1)=="2"){sName1 = "Improved "+sName1;}else if(GetStringLeft(sTag1,1)=="3"){sName1 = "Quality "+sName1;}else if(GetStringLeft(sTag1,1)=="4"){sName1 = "Precious "+sName1;}
if(GetStringLeft(sTag2,1)=="2"){sName2 = "Improved "+sName2;}else if(GetStringLeft(sTag2,1)=="3"){sName2 = "Quality "+sName2;}else if(GetStringLeft(sTag2,1)=="4"){sName2 = "Precious "+sName2;}

sResult = "For each "+ColorText(sName,"g")+", the unit needs one "+ColorText(sName1,"y")+" and one "+ColorText(sName2,"y")+".";

DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
SetLocalString(OBJECT_SELF,"ItemBP"+IntToString(i),sBP);
SetLocalString(OBJECT_SELF,"ItemName"+IntToString(i),sName);
SetLocalString(OBJECT_SELF,"ItemTag1"+IntToString(i),sTag1);
SetLocalString(OBJECT_SELF,"ItemTag2"+IntToString(i),sTag2);
   }
if(sResult==""){sResult = "no combination";}SetCustomToken(10330+i,sResult);
  }
SetLocalInt(OBJECT_SELF,"DontStep",1);
 }
////////////////////////////////////////////////////////////////////////////////
// Farm
else if(iStructure==7)
 {
DeleteLocalInt(OBJECT_SELF,"ChoiceDone1");SetCustomToken(10501,"Badger");SetLocalString(oModule,sPlanet+"Ani1","mn_small_ani001%Badger");
DeleteLocalInt(OBJECT_SELF,"ChoiceDone2");SetCustomToken(10502,"Dog");SetLocalString(oModule,sPlanet+"Ani2","henchani011%Dog");
DeleteLocalInt(OBJECT_SELF,"ChoiceDone3");SetCustomToken(10503,"Falcon");SetLocalString(oModule,sPlanet+"Ani3","henchani012%Falcon");
DeleteLocalInt(OBJECT_SELF,"ChoiceDone4");SetCustomToken(10504,"Goat");SetLocalString(oModule,sPlanet+"Ani4","mn_goat001%Goat");

if(iLevel>=2){DeleteLocalInt(OBJECT_SELF,"ChoiceDone5");SetCustomToken(10505,"Boar");SetLocalString(oModule,sPlanet+"Ani5","mn_boar003%Boar");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone5",1);}
if(iLevel>=2){DeleteLocalInt(OBJECT_SELF,"ChoiceDone6");SetCustomToken(10506,"Cow");SetLocalString(oModule,sPlanet+"Ani6","henchani010%Cow");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone6",1);}
if(iLevel>=2){DeleteLocalInt(OBJECT_SELF,"ChoiceDone7");SetCustomToken(10507,"Deer");SetLocalString(oModule,sPlanet+"Ani7","mn_deer002%Deer");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone7",1);}

if(iLevel>=3){DeleteLocalInt(OBJECT_SELF,"ChoiceDone8");SetCustomToken(10508,"Brown Horse");SetLocalString(oModule,sPlanet+"Ani8","henchani001%Brown Horse");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone8",1);}
if(iLevel>=3){DeleteLocalInt(OBJECT_SELF,"ChoiceDone9");SetCustomToken(10509,"Brown Pony");SetLocalString(oModule,sPlanet+"Ani9","henchani006%Brown Pony");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone9",1);}
if(iLevel>=3){DeleteLocalInt(OBJECT_SELF,"ChoiceDone10");SetCustomToken(10510,"Snake");SetLocalString(oModule,sPlanet+"Ani10","mn_snake008%Snake");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone10",1);}

if(iLevel>=4){DeleteLocalInt(OBJECT_SELF,"ChoiceDone11");SetCustomToken(10511,"Angus Wild");SetLocalString(oModule,sPlanet+"Ani11","mn_wildbeef002%Angus Wild");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone11",1);}
if(iLevel>=4){DeleteLocalInt(OBJECT_SELF,"ChoiceDone12");SetCustomToken(10512,"Black horse");SetLocalString(oModule,sPlanet+"Ani12","henchani002%Black horse");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone12",1);}
if(iLevel>=4){DeleteLocalInt(OBJECT_SELF,"ChoiceDone13");SetCustomToken(10513,"Ox");SetLocalString(oModule,sPlanet+"Ani13","henchani009%Ox");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone13",1);}
if(iLevel>=4){DeleteLocalInt(OBJECT_SELF,"ChoiceDone14");SetCustomToken(10514,"Stain Pony");SetLocalString(oModule,sPlanet+"Ani14","henchani007%Stain Pony");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone14",1);}

if(iLevel>=5){DeleteLocalInt(OBJECT_SELF,"ChoiceDone15");SetCustomToken(10515,"White Horse");SetLocalString(oModule,sPlanet+"Ani15","henchani003%White Horse");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone15",1);}
if(iLevel>=5){DeleteLocalInt(OBJECT_SELF,"ChoiceDone16");SetCustomToken(10516,"White Pony");SetLocalString(oModule,sPlanet+"Ani16","henchani008%White Pony");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone16",1);}

SetLocalInt(OBJECT_SELF,"ChoiceDone17",1);SetLocalInt(OBJECT_SELF,"ChoiceDone18",1);SetLocalInt(OBJECT_SELF,"ChoiceDone19",1);SetLocalInt(OBJECT_SELF,"ChoiceDone20",1);
 }
////////////////////////////////////////////////////////////////////////////////
// Field
else if(iStructure==8)
 {
//
i=0;
while(i<25)
  {
i++;
sVar = GetLocalString(oModule,sPlanet+"Plant"+IntToString(i));
sBP = GetStringLeft(sVar,FindSubString(sVar,"%"));
sName = GetStringRight(sVar,GetStringLength(sVar)-FindSubString(sVar,"%")-1);

if((iLevel<5)&&((sBP=="cr_belvedere")||(sBP=="cr_elhuin")||(sBP=="cr_hashbushin"))){sName = "";}

if(sName!=""){DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));SetCustomToken(10500+i,sName);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);}
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Sawmill
else if(iStructure==21)
 {
//
i=0;
while(i<4)
  {
i++;
sVar = GetLocalString(oModule,sPlanet+"Tree"+IntToString(i));
sBP = GetStringLeft(sVar,FindSubString(sVar,"%"));
sName = GetStringRight(sVar,GetStringLength(sVar)-FindSubString(sVar,"%")-1);

if(sName!=""){DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));SetCustomToken(10500+i,sName);}else{SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);}
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
