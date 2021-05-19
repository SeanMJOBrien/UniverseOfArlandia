#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
string sPlanet = GetLocalString(oModule,"MissIniPlanet");
string sTot = GetPersistentString(oModule,sPlanet);
int iPlanetSize = StringToInt(GetStringRight(GetStringLeft(sTot,FindSubString(sTot,"&002&")),GetStringLength(GetStringLeft(sTot,FindSubString(sTot,"&002&")))-FindSubString(sTot,"&001&")-5));
//
int iX;int iY;string sX;string sY;string sArea;string sInterests;string sInterest;int iT=0;
////////////////////////////////////////////////////////////////////////////////
iX = -(iPlanetSize/2);
while(iX<=(iPlanetSize/2))
 {
iY = -(iPlanetSize/2);
while(iY<=(iPlanetSize/2))
  {
sX = IntToString(iX);if(iX<0){sX = "m"+GetStringRight(IntToString(iX),GetStringLength(IntToString(iX))-1);}
sY = IntToString(iY);if(iY<0){sY = "m"+GetStringRight(IntToString(iY),GetStringLength(IntToString(iY))-1);}
sArea = sX+"_"+sY;
sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
sInterest = GetStringLeft(sInterests,FindSubString(sInterests,"&1&"));

if((GetStringLeft(sInterest,1)=="1")||(GetStringLeft(sInterest,1)=="3"))
   {
iT++;SetLocalString(oModule,sPlanet+"Towns"+IntToString(iT),sArea);
   }

iY++;
  }
iX++;
 }
////////////////////////////////////////////////////////////////////////////////
SetLocalInt(oModule,sPlanet+"Towns",iT);
DeleteLocalString(oModule,"MissIniPlanet");
////////////////////////////////////////////////////////////////////////////////
}
