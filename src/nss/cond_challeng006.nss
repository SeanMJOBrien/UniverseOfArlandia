int StartingConditional()
{
object oPC = GetPCSpeaker();
int iLevel = GetLevelByPosition(1,oPC)+GetLevelByPosition(2,oPC)+GetLevelByPosition(3,oPC);

if(iLevel>=10){return TRUE;}else{return FALSE;}
}
