#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sZ = "_";int iM = FindSubString(sArea,sZ)+1;
string sX = GetStringLeft(sArea,iM-1);
string sY = GetStringRight(sArea,GetStringLength(sArea)-iM);
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
object oFlag = GetLocalObject(OBJECT_SELF,"StructureFlag");
int iLevel = StringToInt(GetStringRight(GetName(oFlag),1));
//
string sTot;string sAreaDest;string sInterest;string sName;string sVisible;string sSystem;string sPlanetDest;string sPlanetPlace;string sPlanetDestPlace;string sPlanetDestType;string sDestX;string sDestY;int iPlanetSize;int iX;int iY;int iDist;int i;int iTot;int jTot;float fDist;float fX;float fY;int iDS;string sPlanetDestArea;string sPlanetDestDomain;
string sVar;string sVar1;string sVar2;string sVar3;string sVar4;string sVar5;string sVar6;string sVar7;string sVar8;string sVar9;string sVar10;string sVar11;string sVar1L;string sVar2L;string sVar3L;string sVar4L;string sVar5L;string sVar6L;string sVar7L;string sVar8L;string sVar9L;string sVar10L;string sVar1R;string sVar2R;string sVar3R;string sVar4R;string sVar5R;string sVar6R;string sVar7R;string sVar8R;string sVar9R;string sVar10R;int iDomainAirShip;
////////////////////////////////////////////////////////////////////////////////
ExecuteScript("conv_dm_varempty",OBJECT_SELF);
////////////////////////////////////////////////////////////////////////////////
// Domains
if(iLevel>=4){iStarshipDist = iStarshipDist*2;}
if((iLevel>=5)&&(GetName(oPC)==GetLocalString(OBJECT_SELF,"Master"))){iAirshipCost = 0;iStarshipCost = 0;}
////////////////////////////////////////////////////////////////////////////////
// Airships
sTot = GetPersistentString(oModule,sPlanet);
sPlanetPlace = GetStringLeft(sTot,FindSubString(sTot,"&001&"));
iPlanetSize = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&002&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&002&")))-FindSubString(sTot,"&001&")-5));

iX = -(iPlanetSize/2);
while(iX<=(iPlanetSize/2))
 {
iY = -(iPlanetSize/2);
while(iY<=(iPlanetSize/2))
  {
sDestX = IntToString(iX);if(iX<0){sDestX = "m"+GetStringRight(IntToString(iX),GetStringLength(IntToString(iX))-1);}
sDestY = IntToString(iY);if(iY<0){sDestY = "m"+GetStringRight(IntToString(iY),GetStringLength(IntToString(iY))-1);}
sAreaDest = sDestX+"_"+sDestY;
sInterest = GetPersistentString(oModule,sPlanet+"&"+sAreaDest+"&Interests");
sName = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&2&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&2&")))-FindSubString(sInterest,"&1&")-3);
sVar = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")))-FindSubString(sInterest,"&2&")-3);
sVisible = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&4&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&4&")))-FindSubString(sInterest,"&3&")-3);

if(GetStringLeft(sInterest,1)=="D")
   {
sVar1L = "";sVar2L = "";sVar3L = "";sVar4L = "";sVar6L = "";sVar7L = "";sVar9L = "";
sVar11 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_11_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_11_")))-FindSubString(sVar,"_10_")-4);
sName = sVar11;
iDomainAirShip = 0;
sVar1 = GetStringLeft(sVar,FindSubString(sVar,"_01_"));
sVar2 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_02_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_02_")))-FindSubString(sVar,"_01_")-4);
sVar3 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_03_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_03_")))-FindSubString(sVar,"_02_")-4);
sVar4 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_04_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_04_")))-FindSubString(sVar,"_03_")-4);
sVar5 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_05_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_05_")))-FindSubString(sVar,"_04_")-4);
sVar6 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_06_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_06_")))-FindSubString(sVar,"_05_")-4);
sVar7 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_07_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_07_")))-FindSubString(sVar,"_06_")-4);
sVar8 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_08_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_08_")))-FindSubString(sVar,"_07_")-4);
sVar9 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_09_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_09_")))-FindSubString(sVar,"_08_")-4);
sVar10 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_10_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_10_")))-FindSubString(sVar,"_09_")-4);
sVar1L = GetStringLeft(sVar1,FindSubString(sVar1,"%"));sVar1R = GetStringRight(sVar1,GetStringLength(sVar1)-FindSubString(sVar1,"%")-1);
sVar2L = GetStringLeft(sVar2,FindSubString(sVar2,"%"));sVar2R = GetStringRight(sVar2,GetStringLength(sVar2)-FindSubString(sVar2,"%")-1);
sVar3L = GetStringLeft(sVar3,FindSubString(sVar3,"%"));sVar3R = GetStringRight(sVar3,GetStringLength(sVar3)-FindSubString(sVar3,"%")-1);
sVar4L = GetStringLeft(sVar4,FindSubString(sVar4,"%"));sVar4R = GetStringRight(sVar4,GetStringLength(sVar4)-FindSubString(sVar4,"%")-1);
sVar5L = GetStringLeft(sVar5,FindSubString(sVar5,"%"));sVar5R = GetStringRight(sVar5,GetStringLength(sVar5)-FindSubString(sVar5,"%")-1);
sVar6L = GetStringLeft(sVar6,FindSubString(sVar6,"%"));sVar6R = GetStringRight(sVar6,GetStringLength(sVar6)-FindSubString(sVar6,"%")-1);
sVar7L = GetStringLeft(sVar7,FindSubString(sVar7,"%"));sVar7R = GetStringRight(sVar7,GetStringLength(sVar7)-FindSubString(sVar7,"%")-1);
sVar8L = GetStringLeft(sVar8,FindSubString(sVar8,"%"));sVar8R = GetStringRight(sVar8,GetStringLength(sVar8)-FindSubString(sVar8,"%")-1);
sVar9L = GetStringLeft(sVar9,FindSubString(sVar9,"%"));sVar9R = GetStringRight(sVar9,GetStringLength(sVar9)-FindSubString(sVar9,"%")-1);
sVar10L = GetStringLeft(sVar10,FindSubString(sVar10,"%"));sVar10R = GetStringRight(sVar10,GetStringLength(sVar10)-FindSubString(sVar10,"%")-1);
if((sVar1L=="1")||(sVar2L=="1")||(sVar3L=="1")||(sVar4L=="1")||(sVar6L=="1")||(sVar7L=="1")||(sVar9L=="1")){iDomainAirShip = 1;}
   }

if((sAreaDest!=sArea)&&((GetStringLeft(sInterest,1)=="1")||((GetStringLeft(sInterest,1)=="D"))&&(sVisible=="1")&&(iDomainAirShip==1)))
   {
if(GetStringLeft(sX,1)=="m"){sX = "-"+GetStringRight(sX,GetStringLength(sX)-1);}
if(GetStringLeft(sY,1)=="m"){sY = "-"+GetStringRight(sY,GetStringLength(sY)-1);}
if(GetStringLeft(sDestX,1)=="m"){sDestX = "-"+GetStringRight(sDestX,GetStringLength(sDestX)-1);}
if(GetStringLeft(sDestY,1)=="m"){sDestY = "-"+GetStringRight(sDestY,GetStringLength(sDestY)-1);}

fX = StringToFloat(sDestX)-StringToFloat(sX);if(fX<0.0){fX = -fX;}if(fX>IntToFloat(iPlanetSize/2)){fX = IntToFloat((iPlanetSize/2)-(FloatToInt(fX)-(iPlanetSize/2)));}
fY = StringToFloat(sDestY)-StringToFloat(sY);if(fY<0.0){fY = -fY;}if(fY>IntToFloat(iPlanetSize/2)){fY = IntToFloat((iPlanetSize/2)-(FloatToInt(fY)-(iPlanetSize/2)));}
fDist = sqrt((fX*fX)+(fY*fY));iDist = FloatToInt(fDist);

i++;
SetLocalString(OBJECT_SELF,"AirShipDest"+IntToString(i),sAreaDest);
SetLocalString(OBJECT_SELF,"AirShipName"+IntToString(i),sName);
SetLocalInt(OBJECT_SELF,"AirShipLength"+IntToString(i),iDist);
SetLocalInt(OBJECT_SELF,"AirShipPrice"+IntToString(i),iDist*iAirshipCost);
   }
iY++;
  }
iX++;
 }
////////////////////////////////////////////////////////////////////////////////
// Starships
sTot = GetLocalString(oModule,"Galaxy");
iPlanetSize = StringToInt(GetStringLeft(sTot,FindSubString(sTot,"&001&")));

i=0;
sZ = "_";iM = FindSubString(sPlanetPlace,sZ)+1;
sX = GetStringLeft(sPlanetPlace,iM-1);
sY = GetStringRight(sPlanetPlace,GetStringLength(sPlanetPlace)-iM);

jTot = StringToInt(GetLocalString(oModule,"Systems"));
//
iY=0;
while(iY<jTot)
 {
iY++;
sSystem = GetLocalString(oModule,"System"+IntToString(iY));
//
if(sSystem!="")
  {
iTot = StringToInt(GetLocalString(oModule,sSystem+"Planets"));
iX=0;
//
while(iX<iTot)
   {
iX++;
sTot = GetLocalString(oModule,sSystem+"Planet"+IntToString(iX));
sPlanetDest = GetStringLeft(sTot,FindSubString(sTot,"&001&"));
sPlanetDestPlace = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&002&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&002&")))-FindSubString(sTot,"&001&")-5);
sPlanetDestType = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&004&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&004&")))-FindSubString(sTot,"&003&")-5);

if((sPlanetDest!="")&&(sPlanetDest!=sPlanet)&&(GetStringLeft(sPlanetDestType,1)!="b")&&(GetStringLeft(sPlanetDestType,1)!="s"))
    {
sZ = "_";iM = FindSubString(sPlanetDestPlace,sZ)+1;
sDestX = GetStringLeft(sPlanetDestPlace,iM-1);
sDestY = GetStringRight(sPlanetDestPlace,GetStringLength(sPlanetDestPlace)-iM);

if(GetStringLeft(sX,1)=="m"){sX = "-"+GetStringRight(sX,GetStringLength(sX)-1);}
if(GetStringLeft(sY,1)=="m"){sY = "-"+GetStringRight(sY,GetStringLength(sY)-1);}
if(GetStringLeft(sDestX,1)=="m"){sDestX = "-"+GetStringRight(sDestX,GetStringLength(sDestX)-1);}
if(GetStringLeft(sDestY,1)=="m"){sDestY = "-"+GetStringRight(sDestY,GetStringLength(sDestY)-1);}
fX = StringToFloat(sDestX)-StringToFloat(sX);if(fX<0.0){fX = -fX;}if(fX>IntToFloat(iPlanetSize/2)){fX = IntToFloat((iPlanetSize/2)-(FloatToInt(fX)-(iPlanetSize/2)));}
fY = StringToFloat(sDestY)-StringToFloat(sY);if(fY<0.0){fY = -fY;}if(fY>IntToFloat(iPlanetSize/2)){fY = IntToFloat((iPlanetSize/2)-(FloatToInt(fY)-(iPlanetSize/2)));}
fDist = sqrt((fX*fX)+(fY*fY));iDist = FloatToInt(fDist);

if(iDist<=iStarshipDist)
     {
i++;
SetLocalString(OBJECT_SELF,"StarShipDest"+IntToString(i),sPlanetDestPlace);
SetLocalString(OBJECT_SELF,"StarShipArea"+IntToString(i),"0_0");
SetLocalString(OBJECT_SELF,"StarShipName"+IntToString(i),sPlanetDest);
SetLocalInt(OBJECT_SELF,"StarShipLength"+IntToString(i),iDist);
SetLocalInt(OBJECT_SELF,"StarShipPrice"+IntToString(i),iDist*iStarshipCost);

iDS = GetPersistentInt(oModule,sPlanetDest+"_DS");

while(iDS>0)
      {
sTot = GetPersistentString(oModule,sPlanetDest+"_DS_"+IntToString(iDS));

if(sTot!="")
       {
i++;
sPlanetDestArea = GetStringLeft(sTot,FindSubString(sTot,"&001&"));
sPlanetDestDomain = GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&002&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&002&")))-FindSubString(sTot,"&001&")-5);

SetLocalString(OBJECT_SELF,"StarShipDest"+IntToString(i),sPlanetDestPlace);
SetLocalString(OBJECT_SELF,"StarShipArea"+IntToString(i),sPlanetDestArea);
SetLocalString(OBJECT_SELF,"StarShipName"+IntToString(i),sPlanetDest+" ("+sPlanetDestDomain+")");
SetLocalInt(OBJECT_SELF,"StarShipLength"+IntToString(i),iDist);
SetLocalInt(OBJECT_SELF,"StarShipPrice"+IntToString(i),iDist*iStarshipCost);
       }
iDS--;
      }
     }
    }
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
// First
int a = 20;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));SetLocalInt(oPC,"DontChangeChoices",1);DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
////////////////////////////////////////////////////////////////////////////////
}
