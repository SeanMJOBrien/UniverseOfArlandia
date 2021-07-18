#include "aps_include"
void main()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sPlanetVar = GetPersistentString(oModule,sPlanet);
int iPlanetSize = StringToInt(GetStringRight(GetStringLeft(sPlanetVar,FindSubString(sPlanetVar,"&002&")),GetStringLength(GetStringLeft(sPlanetVar,FindSubString(sPlanetVar,"&002&")))-FindSubString(sPlanetVar,"&001&")-5));
int iPlanetDiscoverDMOption = GetLocalInt(oModule,sPlanet+"Discovered");;
string sNewArea;string sVarAreas;string sCount;string sCount1;string sCount2;string sLeft;string sRight;string sVar;int iX;int iY;string sX;string sY;

if(sPlanet=="")
 {
FloatingTextStringOnCreature("you must be on a planet to use that function",oPC);
 }
else
 {
iX = -(iPlanetSize/2);

while(iX<=(iPlanetSize/2))
  {
iY = -(iPlanetSize/2);

while(iY<=(iPlanetSize/2))
   {
sX = IntToString(iX);if(iX<0){sX = "m"+GetStringRight(IntToString(iX),GetStringLength(IntToString(iX))-1);}
sY = IntToString(iY);if(iY<0){sY = "m"+GetStringRight(IntToString(iY),GetStringLength(IntToString(iY))-1);}
sArea = sX+"_"+sY;

sVar = GetPersistentString(oModule,sPlanet+"AreasX"+IntToString(iX));

if(iY<=-10){sCount1 = "-"+IntToString(-iY);}else if(iY<0){sCount1 = "-0"+IntToString(-iY);}else if(iY<10){sCount1 = "+0"+IntToString(iY);}else{sCount1 = "+"+IntToString(iY);}sCount1 = "&"+sCount1+"&";
if(iY-1<=-10){sCount2 = "-"+IntToString(-iY+1);}else if(iY-1<0){sCount2 = "-0"+IntToString(-iY+1);}else if(iY-1<10){sCount2 = "+0"+IntToString(iY-1);}else{sCount2 = "+"+IntToString(iY-1);}sCount2 = "&"+sCount2+"&";
if(iY==-iPlanetSize/2){sNewArea = GetStringLeft(sVar,FindSubString(sVar,sCount1));}else{sNewArea = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,sCount1)),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,sCount1)))-FindSubString(sVar,sCount2)-5);}

if(GetLocalString(oModule,sPlanet+sArea+"Orig")==""){SetLocalString(oModule,sPlanet+sArea+"Orig",sNewArea);}

// Discover all areas
if(iPlanetDiscoverDMOption==0)
    {
if(GetStringRight(sNewArea,1)!="*"){sNewArea = sNewArea+"*";}
    }
// Hide all areas
else if(iPlanetDiscoverDMOption==1)
    {
sLeft = GetStringLeft(sVar,FindSubString(sVar,sCount1)-GetStringLength(sNewArea));
sRight = GetStringRight(sVar,GetStringLength(sVar)-FindSubString(sVar,sCount1));

sNewArea = GetStringLeft(sNewArea,GetStringLength(sNewArea)-1);
    }
// Return origin
else if(iPlanetDiscoverDMOption==2)
    {
sNewArea = GetLocalString(oModule,sPlanet+sArea+"Orig");
    }

sCount = IntToString(iY);if(iY<=-10){sCount = "-"+IntToString(-iY);}else if(iY<0){sCount = "-0"+IntToString(-iY);}else if(iY<10){sCount = "+0"+IntToString(iY);}else{sCount = "+"+IntToString(iY);}sCount = "&"+sCount+"&";
sVarAreas = sVarAreas+sNewArea+sCount;
iY++;
   }
// Store planet areas variable
SetPersistentString(oModule,sPlanet+"AreasX"+IntToString(iX),sVarAreas);sVarAreas = "";
//
iX++;
  }

     if(iPlanetDiscoverDMOption==0){iPlanetDiscoverDMOption = 1;SendMessageToPC(oPC,"Planet areas discovered");}
else if(iPlanetDiscoverDMOption==1){iPlanetDiscoverDMOption = 2;SendMessageToPC(oPC,"Planet areas hidden");}
else if(iPlanetDiscoverDMOption==2){iPlanetDiscoverDMOption = 0;SendMessageToPC(oPC,"Planet areas return to origin");}
SetLocalInt(oModule,sPlanet+"Discovered",iPlanetDiscoverDMOption);
 }
}
