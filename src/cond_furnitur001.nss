int StartingConditional()
{
object oPC = GetPCSpeaker();
int iPC = GetLocalInt(oPC,"PlaceFurniture");

if(iPC==1){return TRUE;}else{return FALSE;}
}
