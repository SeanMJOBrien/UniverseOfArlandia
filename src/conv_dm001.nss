void main()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
object oObject = GetFirstObjectInArea(oArea);

while(GetIsObjectValid(oObject))
 {
if((GetObjectType(oObject)==OBJECT_TYPE_CREATURE)&&(GetLocalInt(oObject,"Permanent")!=1)){SetImmortal(oObject,FALSE);SetPlotFlag(oObject,FALSE);AssignCommand(oObject,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oObject);}
oObject = GetNextObjectInArea(oArea);
 }
SendMessageToPC(oPC,"Area creatures destroyed");
}
