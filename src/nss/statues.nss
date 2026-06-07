void main()
{
object oPC = GetNearestObject(OBJECT_TYPE_CREATURE);
string sTag = GetTag(OBJECT_SELF);
object oNew;string sStatue;int iRandom;

if(sTag=="pla_animated001")
 {
iRandom = Random(4);
if((GetIsPC(oPC))&&(GetDistanceToObject(oPC)<=10.0)&&(iRandom==0))
  {
iRandom = Random(6);
if(iRandom==0){sStatue = "mn_statueanim002";}else{sStatue = "mn_statueanim001";}
oNew = CreateObject(OBJECT_TYPE_CREATURE,sStatue,GetLocation(OBJECT_SELF));
AssignCommand(oNew,SetFacing(GetFacing(oNew)+180.0));
AssignCommand(oNew,ActionAttack(oPC));
DestroyObject(OBJECT_SELF);
  }
 }

}
