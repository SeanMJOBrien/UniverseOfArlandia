int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iLifePoints = GetLocalInt(oGoldbag,"LifePoints");

if(iLifePoints<=0){return TRUE;}else{return FALSE;}
}
