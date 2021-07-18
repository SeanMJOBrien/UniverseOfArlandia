int StartingConditional()
{
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"oTarget");

if((GetIsObjectValid(oTarget))&&(GetLocalInt(oPC,"AreaMode")==1)){return TRUE;}else{return FALSE;}
}
