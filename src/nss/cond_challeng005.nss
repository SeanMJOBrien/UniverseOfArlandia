int StartingConditional()
{
object oPC = GetPCSpeaker();
int iGold = GetGold(oPC);

if(iGold>=50){return TRUE;}else{return FALSE;}
}
