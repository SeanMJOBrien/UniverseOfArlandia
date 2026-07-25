#include "_module"
int StartingConditional()
{
object oPC = GetMaster();
object oHench = OBJECT_SELF;
int iNewLevel = GetHitDice(oHench)+1;
int iPrice = iHenchLevelUpCostPerLevel*iNewLevel;

if((GetIsObjectValid(oPC))&&(GetTag(oHench)=="adventurer")&&(iNewLevel<=iHenchLevelUpMaxLevel)&&(GetGold(oPC)>=iPrice)){return TRUE;}else{return FALSE;}
}
