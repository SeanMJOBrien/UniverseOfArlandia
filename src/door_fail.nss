void main()
{
object oPC = GetClickingObject();
string sTag = GetTag(OBJECT_SELF);
object oKey;

if((sTag=="door_entry")||(GetStringLeft(sTag,6)=="door_0"))
 {
oKey = GetItemPossessedBy(oPC,"key001");
if(GetIsObjectValid(oKey))
  {
SetLocked(OBJECT_SELF,FALSE);
ActionOpenDoor(OBJECT_SELF);
DestroyObject(oKey);
  }
 }
else if(sTag=="door_treasure")
 {
oKey = GetItemPossessedBy(oPC,"key003");
if(GetIsObjectValid(oKey))
  {
SetLocked(OBJECT_SELF,FALSE);
ActionOpenDoor(OBJECT_SELF);
DestroyObject(oKey);
SetUseableFlag(GetNearestObjectByTag("enigmmaker"),FALSE);
  }
 }
}
