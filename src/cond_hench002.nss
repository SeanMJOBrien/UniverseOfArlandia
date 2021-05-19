int StartingConditional()
{
object oPC = GetPCSpeaker();
int iGold = GetGold(oPC);
int iHenchsPrice = GetLocalInt(oPC,"Price");

if(iGold>=iHenchsPrice){return TRUE;}else{return FALSE;}
}
