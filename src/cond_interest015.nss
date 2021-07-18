int StartingConditional()
{
object oPC = GetNearestObjectByTag("npc_tord");

if((GetLocalInt(OBJECT_SELF,"Player")==1)&&(GetLocalInt(oPC,"Success")==1)&&(GetDistanceToObject(oPC)<=2.0)){return TRUE;}else{return FALSE;}
}
