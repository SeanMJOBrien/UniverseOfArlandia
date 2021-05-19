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
string sZ = "_";int iM = FindSubString(sArea,sZ)+1;
string sX = GetStringLeft(sArea,iM-1);
string sY = GetStringRight(sArea,GetStringLength(sArea)-iM);
int iX = StringToInt(sX);if(GetStringLeft(sX,1)=="m"){iX = -StringToInt(GetStringRight(sX,GetStringLength(sX)-1));}
int iY = StringToInt(sY);if(GetStringLeft(sY,1)=="m"){iY = -StringToInt(GetStringRight(sY,GetStringLength(sY)-1));}
string sVar = GetPersistentString(oModule,sPlanet+"AreasX"+IntToString(iX));

string sNewArea;string sCount1;string sCount2;string sLeft;string sRight;

if(sPlanet=="")
 {
FloatingTextStringOnCreature("you must be on a planet to use that function",oPC);
 }
else
 {
if(iY<=-10){sCount1 = "-"+IntToString(-iY);}else if(iY<0){sCount1 = "-0"+IntToString(-iY);}else if(iY<10){sCount1 = "+0"+IntToString(iY);}else{sCount1 = "+"+IntToString(iY);}sCount1 = "&"+sCount1+"&";
if(iY-1<=-10){sCount2 = "-"+IntToString(-iY+1);}else if(iY-1<0){sCount2 = "-0"+IntToString(-iY+1);}else if(iY-1<10){sCount2 = "+0"+IntToString(iY-1);}else{sCount2 = "+"+IntToString(iY-1);}sCount2 = "&"+sCount2+"&";
if(iY==-iPlanetSize/2){sNewArea = GetStringLeft(sVar,FindSubString(sVar,sCount1));}else{sNewArea = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,sCount1)),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,sCount1)))-FindSubString(sVar,sCount2)-5);}

if(GetStringRight(sNewArea,1)=="*")
  {
sLeft = GetStringLeft(sVar,FindSubString(sVar,sCount1)-GetStringLength(sNewArea));
sRight = GetStringRight(sVar,GetStringLength(sVar)-FindSubString(sVar,sCount1));
sNewArea = GetStringLeft(sNewArea,GetStringLength(sNewArea)-1);
sVar = sLeft+sNewArea+sRight;

SetPersistentString(oModule,sPlanet+"AreasX"+IntToString(iX),sVar);
SendMessageToPC(oPC,"Area hidden");
  }
else
  {
sVar = InsertString(sVar,"*",FindSubString(sVar,sCount1));

SetPersistentString(oModule,sPlanet+"AreasX"+IntToString(iX),sVar);
SendMessageToPC(oPC,"Area discovered");
  }
 }
}
