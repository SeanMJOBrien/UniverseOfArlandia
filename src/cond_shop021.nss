#include "_module"
int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iXPs = GetXP(oPC);

if(iXPs<iXPLifePoints){return TRUE;}else{return FALSE;}
}
