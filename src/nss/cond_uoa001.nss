int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iLifePoints = GetLocalInt(oGoldbag,"LifePoints");

if(iLifePoints<1){return TRUE;}else{return FALSE;}
}
