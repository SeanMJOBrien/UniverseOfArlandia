int StartingConditional()
{
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"oTarget");

if(GetIsPC(oTarget)){return TRUE;}else{return FALSE;}
}
