void main()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
object oObject = GetFirstObjectInArea(oArea);

while(GetIsObjectValid(oObject))
 {
if((GetObjectType(oObject)==OBJECT_TYPE_PLACEABLE)&&(GetLocalInt(oObject,"Permanent")!=1)){DestroyObject(oObject);}
oObject = GetNextObjectInArea(oArea);
 }
SendMessageToPC(oPC,"Area placeables destroyed");
}
