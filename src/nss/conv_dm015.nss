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

if(sPlanet=="")
 {
FloatingTextStringOnCreature("you must be on a planet to use that function",oPC);
 }
else
 {
string sColKey = sPlanet+"AreasX"+IntToString(iX);
string sVar = GetPersistentString(oModule,sColKey);
if(IsAreaTileDiscovered(oModule,sPlanet,iX,iY))
  {
SetPersistentString(oModule,sColKey,SetColTileDiscovered(sVar,iY,FALSE));
SendMessageToPC(oPC,"Area hidden");
  }
else
  {
SetPersistentString(oModule,sColKey,SetColTileDiscovered(sVar,iY,TRUE));
SendMessageToPC(oPC,"Area discovered");
  }
 }
}
