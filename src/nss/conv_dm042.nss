#include "aps_include"
#include "_string_utils"
void main()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");

string sZ = "_";int iM = FindSubString(sArea,sZ)+1;
string sX = GetStringLeft(sArea,iM-1);
string sY = GetStringRight(sArea,GetStringLength(sArea)-iM);
int iX = StringToInt(sX);if(GetStringLeft(sX,1)=="m"){iX = -StringToInt(GetStringRight(sX,GetStringLength(sX)-1));}
int iY = StringToInt(sY);if(GetStringLeft(sY,1)=="m"){iY = -StringToInt(GetStringRight(sY,GetStringLength(sY)-1));}

int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");string sChoice;if(iChoice1<10){sChoice = "0"+IntToString(iChoice1);}else{sChoice = IntToString(iChoice1);}

string sColKey = sPlanet+"AreasX"+IntToString(iX);
SetPersistentString(oModule,sColKey,SetColTile(GetPersistentString(oModule,sColKey),iY,sChoice));

ExecuteScript("area_save",oArea);

SetLocalString(oPC,"PlanetDest",sPlanet);
SetLocalString(oPC,"AreaDest",sArea);
SetLocalFloat(oPC,"fX",120.0);
SetLocalFloat(oPC,"fY",90.0);
SetLocalFloat(oPC,"fFacing",90.0);

ExecuteScript("transitions",oPC);
}
