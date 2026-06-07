#include "_module"
int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iGrade = GetLocalInt(oGoldbag,"Grade");
int iGP = GetGold(oPC);
int iXP = GetXP(oPC);

if(((iXP>=iGradeUpgradeXP*(iGrade+1))&&(iGP>=iGradeUpgradeGP*(iGrade+1)))||(GetIsDM(oPC))){return TRUE;}else{return FALSE;}
}
