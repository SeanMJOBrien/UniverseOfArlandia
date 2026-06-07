#include "aps_include"
void main()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
object oObject = GetFirstObjectInArea(oArea);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");

DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&Interests");

while(GetIsObjectValid(oObject))
 {
if(((GetObjectType(oObject)==OBJECT_TYPE_CREATURE)||(GetObjectType(oObject)==OBJECT_TYPE_PLACEABLE))&&(GetLocalInt(oObject,"Permanent")!=1)&&(GetLocalInt(oObject,"Persistent")!=1)){SetImmortal(oObject,FALSE);SetPlotFlag(oObject,FALSE);AssignCommand(oObject,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oObject);}
oObject = GetNextObjectInArea(oArea);
 }
SendMessageToPC(oPC,"Interest, creatures and placeables removed");
}
