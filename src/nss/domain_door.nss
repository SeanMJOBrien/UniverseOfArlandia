void main()
{
object oArea = GetArea(OBJECT_SELF);
int iLevel = GetLocalInt(oArea,"Level");
string sTag = GetStringRight(GetTag(OBJECT_SELF),1);

if(((sTag=="2")&&(iLevel>=2))||((sTag=="3")&&(iLevel>=3))||((sTag=="5")&&(iLevel>=5)))
 {
SetLocked(OBJECT_SELF,FALSE);
ActionOpenDoor(OBJECT_SELF);
SetLocalInt(OBJECT_SELF,"Locked",1);
 }
}
