////////////////////////////////////////////////////////////////////////////////
void main()
{
////////////////////////////////////////////////////////////////////////////////
string sBP = GetLocalString(OBJECT_SELF,"Bonus");
string sQuality = GetLocalString(OBJECT_SELF,"Quality");string sQuality2;
int iBonus = StringToInt(GetStringRight(sBP,1));
string sName = GetName(OBJECT_SELF);if(FindSubString(sName,"Quality")!=-1){sQuality2 = "Quality";}if(FindSubString(sName,"(")!=-1){sName = GetStringLeft(sName,FindSubString(sName,"(")-1);}
int iTargetBase = GetBaseItemType(OBJECT_SELF);
int IP_CONST_DAMAGETYPE;if(iTargetBase==BASE_ITEM_CBLUDGWEAPON){IP_CONST_DAMAGETYPE = IP_CONST_DAMAGETYPE_BLUDGEONING;}else if(iTargetBase==BASE_ITEM_CPIERCWEAPON){IP_CONST_DAMAGETYPE = IP_CONST_DAMAGETYPE_PIERCING;}else if(iTargetBase==BASE_ITEM_CSLASHWEAPON){IP_CONST_DAMAGETYPE = IP_CONST_DAMAGETYPE_SLASHING;}else if(iTargetBase==BASE_ITEM_CSLSHPRCWEAP){IP_CONST_DAMAGETYPE = IP_CONST_DAMAGETYPE_SUBDUAL;}
itemproperty iTargetProp = GetFirstItemProperty(OBJECT_SELF);
itemproperty ipItem = GetFirstItemProperty(OBJECT_SELF);
itemproperty iMagic;string sBonus;
////////////////////////////////////////////////////////////////////////////////
if((GetTag(OBJECT_SELF)=="cr_scroll")||(GetTag(OBJECT_SELF)=="cr_wand"))
 {
while(GetIsItemPropertyValid(ipItem)){if(GetItemPropertyType(ipItem)!=155){RemoveItemProperty(OBJECT_SELF,ipItem);}ipItem = GetNextItemProperty(OBJECT_SELF);}
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(StringToInt(sBP),IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE),OBJECT_SELF);
SetLocalInt(OBJECT_SELF,"Ready",1);
 }
////////////////////////////////////////////////////////////////////////////////
else
 {
     if(sQuality=="Quality"){iMagic = ItemPropertyQuality(IP_CONST_QUALITY_EXCELLENT);}
     if(GetStringLeft(sBP,11)=="Armor Class"){sBonus = "Armor Class +"+IntToString(iBonus);iMagic = ItemPropertyACBonus(iBonus);}
else if(GetStringLeft(sBP,6)=="Attack"){sBonus = "Attack +"+IntToString(iBonus);iMagic = ItemPropertyAttackBonus(iBonus);}
else if(GetStringLeft(sBP,10)=="Bonus Feat")
  {
sBonus = "Bonus Feat";iMagic = ItemPropertyBonusFeat(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11)));
     if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_ALERTNESS){sBonus = sBonus+" Alertness";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_AMBIDEXTROUS){sBonus = sBonus+" Ambidextrous";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_ARMOR_PROF_HEAVY){sBonus = sBonus+" Armor proficiency heavy";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_ARMOR_PROF_LIGHT){sBonus = sBonus+" Armor proficiency light";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_ARMOR_PROF_MEDIUM){sBonus = sBonus+" Armor proficiency medium";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_CLEAVE){sBonus = sBonus+" Cleave";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_COMBAT_CASTING){sBonus = sBonus+" Combat casting";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_DISARM){sBonus = sBonus+" Disarm";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_DODGE){sBonus = sBonus+" Dodge";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_EXTRA_TURNING){sBonus = sBonus+" Extra turning";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_KNOCKDOWN){sBonus = sBonus+" Knockdown";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_MOBILITY){sBonus = sBonus+" Mobility";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_POINTBLANK){sBonus = sBonus+" Point blank shot";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_POWERATTACK){sBonus = sBonus+" Power attack";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_RAPID_SHOT){sBonus = sBonus+" Rapid shot";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_SHIELD_PROFICIENCY){sBonus = sBonus+" Shield proficiency";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_SPELLPENETRATION){sBonus = sBonus+" Spell penetration";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_TWO_WEAPON_FIGHTING){sBonus = sBonus+" Two weapons fighting";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_WEAPFINESSE){sBonus = sBonus+" Weapon finesse";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_WEAPON_PROF_EXOTIC){sBonus = sBonus+" Weapon proficiency exotic";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_WEAPON_PROF_MARTIAL){sBonus = sBonus+" Weapon proficiency martial";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_WEAPON_PROF_SIMPLE){sBonus = sBonus+" Weapon proficiency simple";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-11))==IP_CONST_FEAT_WHIRLWIND){sBonus = sBonus+" Whirlwind attack";}
  }
else if(GetStringLeft(sBP,11)=="Bonus Skill")
  {
sBonus = "Bonus Skill";iMagic = ItemPropertySkillBonus(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12)),10);
     if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_ANIMAL_EMPATHY){sBonus = sBonus+" Animal empathy";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_APPRAISE){sBonus = sBonus+" Appraise";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_BLUFF){sBonus = sBonus+" Bluff";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_CONCENTRATION){sBonus = sBonus+" Concentration";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_CRAFT_ARMOR){sBonus = sBonus+" Craft armor";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_CRAFT_TRAP){sBonus = sBonus+" Craft trap";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_CRAFT_WEAPON){sBonus = sBonus+" Craft weapon";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_DISABLE_TRAP){sBonus = sBonus+" Disable trap";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_DISCIPLINE){sBonus = sBonus+" Discipline";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_HEAL){sBonus = sBonus+" Heal";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_HIDE){sBonus = sBonus+" Hide";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_INTIMIDATE){sBonus = sBonus+" Intimidate";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_LISTEN){sBonus = sBonus+" Listen";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_LORE){sBonus = sBonus+" Lore";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_MOVE_SILENTLY){sBonus = sBonus+" Move silently";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_OPEN_LOCK){sBonus = sBonus+" Open lock";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_PARRY){sBonus = sBonus+" Parry";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_PERFORM){sBonus = sBonus+" Perform";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_PERSUADE){sBonus = sBonus+" Persuade";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_PICK_POCKET){sBonus = sBonus+" Pick pocket";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_RIDE){sBonus = sBonus+" Ride";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_SEARCH){sBonus = sBonus+" Search";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_SET_TRAP){sBonus = sBonus+" Set trap";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_SPELLCRAFT){sBonus = sBonus+" Spellcraft";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_SPOT){sBonus = sBonus+" Spot";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_TAUNT){sBonus = sBonus+" Taunt";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_TUMBLE){sBonus = sBonus+" Tumble";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-12))==SKILL_USE_MAGIC_DEVICE){sBonus = sBonus+" Use magic device";}
sBonus = sBonus+" +10";
  }
else if(GetStringLeft(sBP,8)=="Charisma"){sBonus = "Charisma +"+IntToString(iBonus);iMagic = ItemPropertyAbilityBonus(ABILITY_CHARISMA,iBonus);}
else if(GetStringLeft(sBP,12)=="Constitution"){sBonus = "Constitution +"+IntToString(iBonus);iMagic = ItemPropertyAbilityBonus(ABILITY_CONSTITUTION,iBonus);}
else if(GetStringLeft(sBP,16)=="Damage Reduction"){sBonus = "Damage Reduction +"+IntToString(iBonus);if(iBonus==1){iMagic = ItemPropertyDamageReduction(iBonus,IP_CONST_DAMAGESOAK_5_HP);}else if(iBonus==2){iMagic = ItemPropertyDamageReduction(iBonus,IP_CONST_DAMAGESOAK_10_HP);}else if(iBonus==3){iMagic = ItemPropertyDamageReduction(iBonus,IP_CONST_DAMAGESOAK_15_HP);}}
else if(GetStringLeft(sBP,6)=="Damage"){sBonus = "Damage +"+IntToString(iBonus);iMagic = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE,iBonus);}
else if(GetStringLeft(sBP,9)=="Dexterity"){sBonus = "Dexterity +"+IntToString(iBonus);iMagic = ItemPropertyAbilityBonus(ABILITY_DEXTERITY,iBonus);}
else if(GetStringLeft(sBP,11)=="Enhancement"){sBonus = "Enhancement +"+IntToString(iBonus);iMagic = ItemPropertyEnhancementBonus(iBonus);}
else if(GetStringLeft(sBP,9)=="Fortitude"){sBonus = "Fortitude +"+IntToString(iBonus);iMagic = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,iBonus);}
else if(GetStringLeft(sBP,8)=="Immunity")
  {
sBonus = "Immunity";iMagic = ItemPropertyImmunityMisc(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-9)));
     if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-9))==IP_CONST_IMMUNITYMISC_BACKSTAB){sBonus = sBonus+" Backstab";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-9))==IP_CONST_IMMUNITYMISC_CRITICAL_HITS){sBonus = sBonus+" Critical hits";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-9))==IP_CONST_IMMUNITYMISC_DEATH_MAGIC){sBonus = sBonus+" Death magic";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-9))==IP_CONST_IMMUNITYMISC_DISEASE){sBonus = sBonus+" Disease";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-9))==IP_CONST_IMMUNITYMISC_FEAR){sBonus = sBonus+" Fear";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-9))==IP_CONST_IMMUNITYMISC_KNOCKDOWN){sBonus = sBonus+" Knockdown";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-9))==IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN){sBonus = sBonus+" Level ability drain";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-9))==IP_CONST_IMMUNITYMISC_MINDSPELLS){sBonus = sBonus+" Mindspells";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-9))==IP_CONST_IMMUNITYMISC_PARALYSIS){sBonus = sBonus+" Paralysis";}
else if(StringToInt(GetStringRight(sBP,GetStringLength(sBP)-9))==IP_CONST_IMMUNITYMISC_POISON){sBonus = sBonus+" Poison";}
  }
else if(GetStringLeft(sBP,12)=="Intelligence"){sBonus = "Intelligence +"+IntToString(iBonus);iMagic = ItemPropertyAbilityBonus(ABILITY_INTELLIGENCE,iBonus);}
else if(GetStringLeft(sBP,6)=="Reflex"){sBonus = "Reflex +"+IntToString(iBonus);iMagic = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,iBonus);}
else if(GetStringLeft(sBP,8)=="Strength"){sBonus = "Strength +"+IntToString(iBonus);iMagic = ItemPropertyAbilityBonus(ABILITY_STRENGTH,iBonus);}
else if(GetStringLeft(sBP,16)=="Weight Reduction"){sBonus = "Weight Reduction +"+IntToString(iBonus);if(iBonus==1){iMagic = ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_80_PERCENT);}else if(iBonus==2){iMagic = ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_60_PERCENT);}else if(iBonus==3){iMagic = ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT);}}
else if(GetStringLeft(sBP,4)=="Will"){sBonus = "Will +"+IntToString(iBonus);iMagic = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,iBonus);}
else if(GetStringLeft(sBP,6)=="Wisdom"){sBonus = "Wisdom +"+IntToString(iBonus);iMagic = ItemPropertyAbilityBonus(ABILITY_WISDOM,iBonus);}
////////////////////////////////////////////////////////////////////////////////
if(GetItemPropertyType(iMagic)!=ITEM_PROPERTY_QUALITY){while(GetIsItemPropertyValid(iTargetProp)){if(GetItemPropertyType(iTargetProp)!=ITEM_PROPERTY_QUALITY){RemoveItemProperty(OBJECT_SELF,iTargetProp);}iTargetProp = GetNextItemProperty(OBJECT_SELF);}}

AddItemProperty(DURATION_TYPE_PERMANENT,iMagic,OBJECT_SELF);
//
sName = sName+" (";
if((sQuality=="Quality")||(sQuality2=="Quality")){sName = sName+"Quality";if(sBP!=""){sName = sName+"/";}}
if(sBP!=""){sName = sName+sBonus;}
sName = sName+")";
//
if(GetName(OBJECT_SELF)!=sName){SetName(OBJECT_SELF,sName);}
 }
////////////////////////////////////////////////////////////////////////////////
DeleteLocalString(OBJECT_SELF,"Quality");
////////////////////////////////////////////////////////////////////////////////
}
