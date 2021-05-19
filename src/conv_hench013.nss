void main()
{
object oCre = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,1);
int i = 1;

while(GetIsObjectValid(oCre))
 {
if((GetCurrentHitPoints(oCre)>0)&&(!GetIsPC(oCre))&&(!GetIsDM(oCre))&&(!GetIsObjectValid(GetMaster(oCre)))){break;}
i++;oCre = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,i);
 }
SetLocalInt(OBJECT_SELF,"Tracking",1);
ActionMoveToObject(oCre);
}
