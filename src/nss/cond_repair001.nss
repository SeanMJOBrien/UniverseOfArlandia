int StartingConditional()
{
object oPC = GetPCSpeaker();
int iGold = GetGold(oPC);
object oTarget = GetLocalObject(oPC,"oTarget");
int iPrice = GetLocalInt(oTarget,"Fix");

if(iGold>=iPrice){return TRUE;}else{return FALSE;}
}
