void main()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
object oObject = GetFirstObjectInArea(oArea);
int iAreaObjects = GetLocalInt(OBJECT_SELF,"AreaObjects");
int iType;int i;
//
while(i<iAreaObjects)
 {
i++;
DeleteLocalInt(OBJECT_SELF,"Choice"+IntToString(i));
DeleteLocalObject(OBJECT_SELF,"AreaObject"+IntToString(i));
 }
DeleteLocalInt(OBJECT_SELF,"Step");
//
i = 0;
while(GetIsObjectValid(oObject))
 {
iType = GetObjectType(oObject);
if(((iType==OBJECT_TYPE_ITEM)||(iType==OBJECT_TYPE_PLACEABLE)||(iType==OBJECT_TYPE_STORE)||(iType==OBJECT_TYPE_TRIGGER)||(iType==OBJECT_TYPE_WAYPOINT))&&(GetLocalInt(oObject,"Permanent")!=1)&&(GetTag(oObject)!="North")&&(GetTag(oObject)!="South")&&(GetTag(oObject)!="East")&&(GetTag(oObject)!="West"))
  {
i++;
SetLocalObject(OBJECT_SELF,"AreaObject"+IntToString(i),oObject);
  }
oObject = GetNextObjectInArea(oArea);
 }
SetLocalInt(OBJECT_SELF,"AreaObjects",i);
}
