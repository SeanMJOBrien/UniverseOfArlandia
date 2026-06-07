int StartingConditional()
{
object oPC = GetPCSpeaker();
int iPlaceDomain = GetLocalInt(oPC,"PlaceDomain");

if(iPlaceDomain==1){return TRUE;}else{return FALSE;}
}
