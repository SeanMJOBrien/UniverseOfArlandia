#include "_module"
void main()
{
object oPC = GetPCSpeaker();
object oHench = OBJECT_SELF;
int iNewLevel = GetHitDice(oHench)+1;
int iPrice = iHenchLevelUpCostPerLevel*iNewLevel;

TakeGoldFromCreature(iPrice,oPC,TRUE);
LevelUpHenchman(oHench,CLASS_TYPE_INVALID,TRUE,PACKAGE_INVALID);
SetLocalInt(oHench,"Level",iNewLevel);
FloatingTextStringOnCreature(GetName(oHench)+" is now level "+IntToString(iNewLevel)+"!",oPC);

// Snapshot immediately, same reasoning as the "snapshot immediately on
// hire, don't rely on reactive save" comment at henchs.nss:154 - reuses
// the existing dismiss-time snapshot action (henchs.nss action 13, which
// already special-cases "adventurer" via StoreCampaignObject) instead of
// duplicating its sCampaignName/StoreCampaignObject logic.
SetLocalObject(oPC,"Hench",oHench);
SetLocalInt(oPC,"HenchAction",13);
ExecuteScript("henchs",oPC);
}
