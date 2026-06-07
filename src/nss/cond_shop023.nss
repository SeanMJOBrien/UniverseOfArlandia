int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iLevels = GetLevelByPosition(1,oPC)+GetLevelByPosition(2,oPC)+GetLevelByPosition(3,oPC);

if((iLevels<30)||(GetLocalInt(oGoldbag,"Clone")==0)){return TRUE;}else{return FALSE;}
}
