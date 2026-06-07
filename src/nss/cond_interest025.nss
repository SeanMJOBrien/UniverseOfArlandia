int StartingConditional()
{
object oMouse;int i;int j;

if((GetLocalInt(OBJECT_SELF,"Player")==20)&&(GetLocalInt(OBJECT_SELF,"Round")==1))
 {
while(i<10)
  {
i++;
oMouse = GetNearestObjectByTag("mn_mouse001",OBJECT_SELF,i);
if((oMouse==OBJECT_INVALID)||(GetCurrentHitPoints(oMouse)<=0)){j++;}
  }
 }
if(j>=10){return TRUE;}else{return FALSE;}
}
