int StartingConditional()
{
object oPC = GetPCSpeaker();
object oTarget = GetLocalObject(oPC,"oTarget");

if(GetIsObjectValid(oTarget)){return TRUE;}else{return FALSE;}
}
