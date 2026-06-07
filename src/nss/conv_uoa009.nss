#include "_module"
#include "dmfi_dmw_inc"
void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iGrade = GetLocalInt(oGoldbag,"Grade")+1;
int iXP = GetXP(oPC);

SetXP(oPC,iXP-(iGradeUpgradeXP*(iGrade)));
TakeGoldFromCreature(iGradeUpgradeGP*(iGrade),oPC,TRUE);

ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_HOLY_AID),oPC);
SetLocalInt(oGoldbag,"Grade",iGrade);
}
