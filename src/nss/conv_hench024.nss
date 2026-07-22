// Other Options -> toggle follow distance. Applied via a per-hench
// "FollowDistance" local float that nw_ch_ac1.nss's GetHenchFollowDistance()
// reads instead of the stock GetFollowDistance() whenever it re-issues the
// follow command.
void main()
{
object oPC = GetPCSpeaker();
float fCurrent = GetLocalFloat(OBJECT_SELF,"FollowDistance");
float fNew;
if(fCurrent==3.0){fNew = 7.0;}else{fNew = 3.0;}
SetLocalFloat(OBJECT_SELF,"FollowDistance",fNew);
AssignCommand(OBJECT_SELF,ClearAllActions());
AssignCommand(OBJECT_SELF,ActionForceFollowObject(oPC,fNew));
FloatingTextStringOnCreature("Follow distance set to "+FloatToString(fNew,3,0)+"m",oPC);
}
