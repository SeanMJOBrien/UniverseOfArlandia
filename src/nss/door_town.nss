void main()
{
// Town door
if(GetTag(OBJECT_SELF)=="doortown001")
 {
if((GetIsOpen(OBJECT_SELF))&&(GetIsNight()))
  {
DelayCommand(5.0,PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
DelayCommand(5.0,SetLocalObject(OBJECT_SELF,"GateBlock",CreateObject(OBJECT_TYPE_PLACEABLE,GetLocalString(OBJECT_SELF,"CEP_L_GATEBLOCK"),GetLocation(OBJECT_SELF))));
  }
else if((!GetIsOpen(OBJECT_SELF))&&(GetIsDay()))
  {
DelayCommand(5.0,PlayAnimation(ANIMATION_PLACEABLE_OPEN));
if(GetLocalObject(OBJECT_SELF,"GateBlock")!=OBJECT_INVALID)
   {
DelayCommand(5.0,DestroyObject(GetLocalObject(OBJECT_SELF,"GateBlock")));
DelayCommand(5.0,SetLocalObject(OBJECT_SELF,"GateBlock",OBJECT_INVALID));
   }
  }
 }
else
 {
// City door
if((GetIsOpen(OBJECT_SELF))&&(GetIsNight()))
  {
DelayCommand(5.0,ActionCloseDoor(OBJECT_SELF));
  }
else if((!GetIsOpen(OBJECT_SELF))&&(GetIsDay()))
  {
DelayCommand(5.0,ActionOpenDoor(OBJECT_SELF));
  }
 }
}
