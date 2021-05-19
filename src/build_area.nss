#include "aps_include"
void main()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
int iAreaX = GetAreaSize(AREA_WIDTH,oArea)*10;float fX = IntToFloat(iAreaX/2);
int iAreaY = GetAreaSize(AREA_HEIGHT,oArea)*10;float fY = IntToFloat(iAreaY/2);
object oObjects = GetFirstObjectInArea(oArea);
string sObjects;string sBP;string sX;string sY;string sZ;string sF;int iLength;int i;

while(GetIsObjectValid(oObjects))
 {
sBP = GetResRef(oObjects);
sX = FloatToString((GetPosition(oObjects).x)-fX);
sY = FloatToString((GetPosition(oObjects).y)-fY);
sZ = FloatToString(GetPosition(oObjects).z);
sF = FloatToString(GetFacing(oObjects));

sObjects = sObjects+"&1&"+sBP+"&2&"+sX+"&3&"+sY+"&4&"+sZ+"&5&"+sF+"&6&"+"//";
iLength = GetStringLength(sObjects);
oObjects = GetNextObjectInArea(oArea);

if((iLength>900)||(oObjects==OBJECT_INVALID)){i++;SetPersistentString(oModule,GetName(oArea)+"_Objects"+IntToString(i),sObjects);sObjects = "";}
 }
SendMessageToPC(oPC,"Area written in database");
}
