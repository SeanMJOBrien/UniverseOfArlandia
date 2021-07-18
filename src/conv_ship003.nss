#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"PlanetOrb");
//
string sTot;string sAreaDest;string sInterest;string sName;string sVisible;string sGalaxy;string sPlanetDest;string sPlanetPlace;string sPlanetDestPlace;int iPlanetDestType;string sDestX;string sDestY;int iPlanetSize;int iX;int iY;int iDist;int i;int iTot;int jTot;float fDist;float fX;float fY;
string sVar;string sVar1;string sVar2;string sVar3;string sVar4;string sVar5;string sVar6;string sVar7;string sVar8;string sVar9;string sVar10;string sVar11;string sVar1L;string sVar2L;string sVar3L;string sVar4L;string sVar5L;string sVar6L;string sVar7L;string sVar8L;string sVar9L;string sVar10L;string sVar1R;string sVar2R;string sVar3R;string sVar4R;string sVar5R;string sVar6R;string sVar7R;string sVar8R;string sVar9R;string sVar10R;int iDomainStarShip;
////////////////////////////////////////////////////////////////////////////////
// Check all places to land (cities and domains with starships)
sTot = GetPersistentString(oModule,sPlanet);
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
sVar11 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_11_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_11_")))-FindSubString(sVar,"_10_")-4);
sName = sVar11;
iDomainStarShip = 0;
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
if((sVar1L=="17")||(sVar2L=="17")||(sVar3L=="17")||(sVar4L=="17")||(sVar5L=="17")||(sVar6L=="17")||(sVar7L=="17")||(sVar8L=="17")||(sVar9L=="17")||(sVar10L=="17")){iDomainStarShip = 1;}
   }

if(((sAreaDest=="0_0")||((GetStringLeft(sInterest,1)=="D"))&&(sVisible=="1")&&(iDomainStarShip==1)))
   {
i++;
SetLocalString(OBJECT_SELF,"LandPlaceDest"+IntToString(i),sAreaDest);
SetLocalString(OBJECT_SELF,"LandPlaceName"+IntToString(i),sName);
   }
iY++;
  }
iX++;
 }
SetLocalInt(OBJECT_SELF,"LandPlaces",i);
////////////////////////////////////////////////////////////////////////////////
}
