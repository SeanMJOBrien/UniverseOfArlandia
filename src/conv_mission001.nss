#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}
int iPCMissions = GetLocalInt(oGoldbag,"Missions");
int iMissionsDay = GetLocalInt(oModule,sPlanet+sArea+"MissionsDay");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
//
int iMissions = GetLocalInt(oModule,sPlanet+sArea+"Missions");
int iStep = (GetLocalInt(OBJECT_SELF,"Step")-1)*10;
int MissionType1 = GetLocalInt(oModule,"MissionType1");
int MissionType2 = GetLocalInt(oModule,"MissionType2");
int MissionType3 = GetLocalInt(oModule,"MissionType3");
int MissionType4 = GetLocalInt(oModule,"MissionType4");
int MissionType5 = GetLocalInt(oModule,"MissionType5");
//
string sMission;int i;int iNum;int iTaken;int iType;string sMissPlanet;string sProvArea;string sMissArea;string sBP;string sTag;int iNumber;int iXP;int iGP;int iDist;string sTitle;string sDes;
////////////////////////////////////////////////////////////////////////////////
while(i<10){i++;SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);SetCustomToken(10140+i,"");SetCustomToken(10150+i,"");SetCustomToken(10160+i,"");}SetLocalInt(OBJECT_SELF,"ChoiceDone11",1);i=0;
////////////////////////////////////////////////////////////////////////////////
// Choose mission
if(iChoice1==1)
 {
while((i<10)&&(iNum<iMissions))
  {
i++;iNum = iStep+i;
sMission = GetLocalString(oModule,sPlanet+sArea+"Mission"+IntToString(iNum));
iType = StringToInt(GetStringLeft(sMission,FindSubString(sMission,"&001&")));
sMissPlanet = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&002&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&002&")))-FindSubString(sMission,"&001&")-5);
sProvArea = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&003&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&003&")))-FindSubString(sMission,"&002&")-5);
sMissArea = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&004&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&004&")))-FindSubString(sMission,"&003&")-5);
sBP = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&005&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&005&")))-FindSubString(sMission,"&004&")-5);
sTag = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&006&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&006&")))-FindSubString(sMission,"&005&")-5);
iNumber = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&007&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&007&")))-FindSubString(sMission,"&006&")-5));
iXP = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&008&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&008&")))-FindSubString(sMission,"&007&")-5));
iGP = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&009&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&009&")))-FindSubString(sMission,"&008&")-5));
iDist = StringToInt(GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&010&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&010&")))-FindSubString(sMission,"&009&")-5));
sTitle = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&011&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&011&")))-FindSubString(sMission,"&010&")-5);
sDes = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&012&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&012&")))-FindSubString(sMission,"&011&")-5);
iTaken = GetLocalInt(OBJECT_SELF,"MT"+IntToString(iNum));

if((sMission!="")&&(iTaken!=1))
   {
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
if((iType>=MissionType1+1)&&(iType<=MissionType2)){SetCustomToken(10140+i,sTitle);}else{SetCustomToken(10140+i,sTitle+" ("+sMissArea+")");}
SetCustomToken(10150+i,sDes+" (area : "+sMissArea+", number : "+IntToString(iNumber)+", "+IntToString(iXP)+" xps, "+IntToString(iGP)+" gps)");
   }
  }
if(iMissions>iNum){DeleteLocalInt(OBJECT_SELF,"ChoiceDone11");}
 }
////////////////////////////////////////////////////////////////////////////////
// Delete mission
else if(iChoice1==2)
 {
while((i<10)&&(iNum<iPCMissions))
  {
i++;iNum = iStep+i;
sMission = GetLocalString(oGoldbag,"Mission"+IntToString(iNum));
sMissPlanet = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&002&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&002&")))-FindSubString(sMission,"&001&")-5);
sMissArea = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&004&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&004&")))-FindSubString(sMission,"&003&")-5);
sTitle = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&011&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&011&")))-FindSubString(sMission,"&010&")-5);

if(sMission!="")
   {
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
if((iType>=MissionType1+1)&&(iType<=MissionType2)){SetCustomToken(10150+i,sTitle);}else{SetCustomToken(10150+i,sTitle+" ("+sMissPlanet+" "+sMissArea+")");}
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Finish mission
else if(iChoice1==3)
 {
while((i<10)&&(iNum<iPCMissions))
  {
i++;iNum = iStep+i;
sMission = GetLocalString(oGoldbag,"Mission"+IntToString(iNum));
sMissPlanet = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&002&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&002&")))-FindSubString(sMission,"&001&")-5);
sMissArea = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&004&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&004&")))-FindSubString(sMission,"&003&")-5);
sTitle = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&011&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&011&")))-FindSubString(sMission,"&010&")-5);

if((sMission!="")&&(GetLocalInt(OBJECT_SELF,"MS"+IntToString(iNum))==1))
   {
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
if((iType>=MissionType1+1)&&(iType<=MissionType2)){SetCustomToken(10160+i,sTitle);}else{SetCustomToken(10160+i,sTitle+" ("+sMissPlanet+" "+sMissArea+")");}
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
