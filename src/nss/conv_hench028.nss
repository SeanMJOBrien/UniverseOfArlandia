// "Level up" reply on a posted Soldier (see cond_hench028.nss for the gate).
// Adds one real class level via LevelUpHenchman() - same function henchs.nss
// uses to build a Soldier up to its garrison tier - for iSoldierLevelUpCost
// gold, and records it in PaidLevels so soldiers_save.nss/soldiers_recall.nss
// can replay it across a server restart, on top of (not instead of) the
// tier-based rebuild in henchs.nss's HenchAction==15.
#include "aps_include"
#include "_module"

void main()
{
object oPC = GetPCSpeaker();
int iCost = iSoldierLevelUpCost;

if(GetGold(oPC)<iCost)
 {
FloatingTextStringOnCreature("You don't have "+IntToString(iCost)+" gold.",oPC,FALSE);
return;
 }

int iClass = GetLocalInt(OBJECT_SELF,"Class");
TakeGoldFromCreature(iCost,oPC,TRUE);
LevelUpHenchman(OBJECT_SELF,iClass,TRUE);
SetLocalInt(OBJECT_SELF,"PaidLevels",GetLocalInt(OBJECT_SELF,"PaidLevels")+1);
FloatingTextStringOnCreature(GetName(OBJECT_SELF)+" is now level "+IntToString(GetHitDice(OBJECT_SELF))+".",oPC,FALSE);
}
