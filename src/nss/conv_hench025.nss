#include "_module"
void main()
{
int iNewLevel = GetHitDice(OBJECT_SELF)+1;
SetCustomToken(10471,IntToString(iHenchLevelUpCostPerLevel*iNewLevel));
}
