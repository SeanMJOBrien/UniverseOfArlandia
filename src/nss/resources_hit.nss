#include "_module"
void main()
{
object oPC = GetLastAttacker();if(oPC==OBJECT_INVALID){oPC = GetLastDamager();}if(oPC==OBJECT_INVALID){oPC = GetLastSpellCaster();}
object oArea = GetArea(OBJECT_SELF);
int iMountain = GetLocalInt(oArea,"Mountain");
int iPCRes = GetLocalInt(oPC,"ResMountain");
object oTool = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
object oGauntlets = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
string sTool = GetTag(oTool);
string sTag = GetTag(OBJECT_SELF);
int iDamage;int iWear;

if((GetIsObjectValid(oPC))&&(oPC!=GetLastSpellCaster())&&(oPC!=OBJECT_SELF)&&(((sTag=="pla_plant")&&(sTool=="tool_sickle"))||((sTag=="pla_rock")&&(sTool=="tool_pick"))||((sTag=="pla_tree")&&(sTool=="tool_axe"))))
 {
// Gauntlets brake
if(GetTag(oGauntlets)=="tool_gauntlet")
  {
iWear = GetLocalInt(oGauntlets,"Wear")+1;SetLocalInt(oGauntlets,"Wear",iWear);
SetLocalInt(oGauntlets,"Wear%",100-(iWear*100/iGauntletsWear));
if((iWear>=iGauntletsWear)&&(Random(10)==0)){DestroyObject(oGauntlets);FloatingTextStringOnCreature("Your tool gauntlets have broken",oPC,TRUE);AssignCommand(oPC,ClearAllActions());AssignCommand(oPC,ActionUnequipItem(oTool));}
  }
// Tool brakes
iWear = GetLocalInt(oTool,"Wear")+1;SetLocalInt(oTool,"Wear",iWear);
SetLocalInt(oTool,"Wear%",100-(iWear*100/iToolWear));
if((iWear>=iToolWear)&&(Random(5)==0)){DestroyObject(oTool);FloatingTextStringOnCreature("Your tool has broken",oPC,TRUE);AssignCommand(oPC,ClearAllActions());}

if((iMountain==1)&&(iPCRes>0)&&(GetLocalInt(OBJECT_SELF,GetName(oPC))!=1))
  {
SetLocalInt(OBJECT_SELF,GetName(oPC),1);
SetLocalInt(oPC,"ResMountain",GetLocalInt(oPC,"ResMountain")-1);
SetPlotFlag(OBJECT_SELF,FALSE);
FloatingTextStringOnCreature(IntToString(GetLocalInt(oPC,"ResMountain"))+" stones left",oPC);
  }
if(!GetPlotFlag(OBJECT_SELF))
  {
iDamage = Random(GetAbilityScore(oPC,ABILITY_STRENGTH)/2)+1;
SetLocalObject(OBJECT_SELF,"Killer",oPC);
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(iDamage),OBJECT_SELF);
FloatingTextStringOnCreature(IntToString(iDamage)+" damage",oPC);
  }
 }
else if((oPC!=OBJECT_SELF)&&(!GetPlotFlag(OBJECT_SELF)))
 {
SetLocalInt(OBJECT_SELF,"Destroyed",1);
FloatingTextStringOnCreature("resource destroyed",oPC);
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetMaxHitPoints(OBJECT_SELF),DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),OBJECT_SELF);
 }
}
