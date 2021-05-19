#include "_module"
#include "dmfi_dmw_inc"
void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iGrade = GetLocalInt(oGoldbag,"Grade");
string sGrade = "G"+IntToString(iGrade);

SetCustomToken(10181,ColorText(sGrade,"g"));
SetCustomToken(10182,ColorText("G"+IntToString(iGrade+1),"g"));
SetCustomToken(10183,IntToString(iGradeUpgradeXP*(iGrade+1)));
SetCustomToken(10184,IntToString(iGradeUpgradeGP*(iGrade+1)));
}
