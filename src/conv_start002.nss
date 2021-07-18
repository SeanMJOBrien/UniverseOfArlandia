#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iStep = 10*(GetLocalInt(OBJECT_SELF,"Step")-1);if(iStep<0){iStep = 0;}
int iChoice = GetLocalInt(OBJECT_SELF,"Choice"+IntToString(GetLocalInt(OBJECT_SELF,"Step")))+iStep;
int iRace = GetLocalInt(oGoldbag,"Race");
//
string sSystem = GetLocalString(oModule,"System"+IntToString(iChoice));
string sPlanet = GetLocalString(oModule,sSystem+"Start");
object oItem;
////////////////////////////////////////////////////////////////////////////////
// Start items
if(iRace>0)
 {
oItem = CreateItemOnObject("racialproperties",oPC);

// Brownie
if(iRace==1)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_STR,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CON,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyReducedSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,5),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_DISCIPLINE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_HIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_PARRY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_RIDE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SEARCH,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SPELLCRAFT,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_TUMBLE,10),oItem);
  }
// Bugbear
else if(iRace==2)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyReducedSavingThrow(IP_CONST_SAVEBASETYPE_WILL,5),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_ANIMAL_EMPATHY,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_DISCIPLINE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_MOVE_SILENTLY,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SPOT,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_TAUNT,10),oItem);
  }
// Drow
else if(iRace==3)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_STR,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyReducedSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,5),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HEAL,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_PERFORM,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_RIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_SPELLCRAFT,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_USE_MAGIC_DEVICE,10),oItem);
  }
// Fey
else if(iRace==4)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_STR,3),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,2),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_ANIMAL_EMPATHY,20),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_ARMOR,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_TRAP,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_WEAPON,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_DISCIPLINE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_HIDE,20),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_PARRY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PERFORM,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_RIDE,20),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SPOT,10),oItem);
  }
// Goblin
else if(iRace==5)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_STR,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CON,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,10),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_BLUFF,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_DISCIPLINE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HEAL,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_HIDE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_RIDE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_SEARCH,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_SPELLCRAFT,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_TUMBLE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_USE_MAGIC_DEVICE,5),oItem);
  }
// Gnoll
else if(iRace==6)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyReducedSavingThrow(IP_CONST_SAVEBASETYPE_WILL,2),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_ANIMAL_EMPATHY,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_APPRAISE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CONCENTRATION,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HEAL,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HIDE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_INTIMIDATE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_LISTEN,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_LORE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_MOVE_SILENTLY,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_TAUNT,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_TUMBLE,5),oItem);
  }
// Kenku
else if(iRace==7)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_WIS,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CHA,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyReducedSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,5),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_ANIMAL_EMPATHY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_APPRAISE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_DISABLE_TRAP,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HEAL,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_INTIMIDATE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_LORE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_PERFORM,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_RIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_SET_TRAP,10),oItem);
  }
// Kobold
else if(iRace==8)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_STR,4),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,4),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CON,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,5),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_APPRAISE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CRAFT_ARMOR,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CRAFT_TRAP,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CRAFT_WEAPON,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_DISCIPLINE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HEAL,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_HIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_LORE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_PARRY,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PERFORM,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_RIDE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SPELLCRAFT,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_TUMBLE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_USE_MAGIC_DEVICE,5),oItem);
  }
// Lizardfolk
else if(iRace==9)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,5),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_APPRAISE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CONCENTRATION,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HEAL,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_LORE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_TAUNT,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_USE_MAGIC_DEVICE,5),oItem);
  }
// Minotaur
else if(iRace==10)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,3),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,3),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,3),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,3),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyReducedSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,5),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_MOVE_SILENTLY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,10),oItem);
  }
// Ogre
else if(iRace==11)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,3),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,2),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyReducedSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,5),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_ANIMAL_EMPATHY,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_APPRAISE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_DISCIPLINE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_INTIMIDATE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_MOVE_SILENTLY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_RIDE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SEARCH,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SPOT,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_TUMBLE,5),oItem);
  }
// Orc
else if(iRace==12)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyReducedSavingThrow(IP_CONST_SAVEBASETYPE_WILL,5),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_APPRAISE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CONCENTRATION,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_DISCIPLINE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HEAL,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_INTIMIDATE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_OPEN_LOCK,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_RIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SEARCH,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_SPELLCRAFT,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_USE_MAGIC_DEVICE,10),oItem);
  }
// Troll
else if(iRace==13)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_WIS,1),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CHA,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,2),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_ANIMAL_EMPATHY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_APPRAISE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CONCENTRATION,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_ARMOR,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_TRAP,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_WEAPON,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_HEAL,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_LISTEN,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_LORE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_PARRY,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_RIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SEARCH,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SPELLCRAFT,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_SPOT,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_TAUNT,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_TUMBLE,5),oItem);
  }
// Werecat

// Werewolf

// Narok
else if(iRace==16)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_STR,3),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CON,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,3),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CRAFT_ARMOR,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CRAFT_TRAP,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CRAFT_WEAPON,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HEAL,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_INTIMIDATE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_PARRY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_RIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_TUMBLE,5),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_USE_MAGIC_DEVICE,5),oItem);
  }
// Abishai
else if(iRace==17)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_WIS,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_APPRAISE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_ARMOR,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_TRAP,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_WEAPON,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_INTIMIDATE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_MOVE_SILENTLY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SPELLCRAFT,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_TUMBLE,10),oItem);
  }
// Cornugon
else if(iRace==18)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CHA,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_APPRAISE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_ARMOR,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_TRAP,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_WEAPON,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_INTIMIDATE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_MOVE_SILENTLY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SPELLCRAFT,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_TUMBLE,10),oItem);
  }
// Devil
else if(iRace==19)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_WIS,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CHA,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_APPRAISE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_ARMOR,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_TRAP,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_WEAPON,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_INTIMIDATE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_MOVE_SILENTLY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SPELLCRAFT,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_TUMBLE,10),oItem);
  }
// Glabrezu
else if(iRace==20)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_WIS,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_APPRAISE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_ARMOR,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_TRAP,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_WEAPON,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_INTIMIDATE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_MOVE_SILENTLY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SPELLCRAFT,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_TUMBLE,10),oItem);
  }
// Nalfeshnee
else if(iRace==21)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CON,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_WIS,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_APPRAISE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_ARMOR,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_TRAP,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_WEAPON,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_INTIMIDATE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_MOVE_SILENTLY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SPELLCRAFT,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_TUMBLE,10),oItem);
  }
// Oschore
else if(iRace==22)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CON,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CON,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_APPRAISE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_ARMOR,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_TRAP,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_WEAPON,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_INTIMIDATE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_MOVE_SILENTLY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SPELLCRAFT,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_TUMBLE,10),oItem);
  }
// Succubus
else if(iRace==23)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_STR,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_APPRAISE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_ARMOR,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_TRAP,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_WEAPON,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_INTIMIDATE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_MOVE_SILENTLY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SPELLCRAFT,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_TUMBLE,10),oItem);
  }
// Yagnoloth
else if(iRace==24)
  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,2),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_INT,1),oItem);

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_APPRAISE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_CONCENTRATION,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_ARMOR,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_TRAP,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_CRAFT_WEAPON,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HIDE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_INTIMIDATE,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_MOVE_SILENTLY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_SPELLCRAFT,10),oItem);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_TUMBLE,10),oItem);
  }
//
AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_RIGHTRING));
 }
////////////////////////////////////////////////////////////////////////////////
CreateItemOnObject("cr_apple",oPC);
CreateItemOnObject("cr_food",oPC);CreateItemOnObject("cr_food",oPC);CreateItemOnObject("cr_food",oPC);
CreateItemOnObject("cr_plantcommon",oPC);CreateItemOnObject("cr_plantcommon",oPC);
CreateItemOnObject("tool_gauntlet",oPC);CreateItemOnObject("tool_gauntlet",oPC);
SetLocalInt(oGoldbag,"LifePoints",5);
////////////////////////////////////////////////////////////////////////////////
SetLocalString(oPC,"PlanetDest",sPlanet);
SetLocalString(oPC,"AreaDest","0_0");
SetLocalFloat(oPC,"fX",120.0);
SetLocalFloat(oPC,"fY",110.0);
SetLocalFloat(oPC,"fFacing",DIRECTION_NORTH);
//
SetLocalInt(oGoldbag,"Start",1);
ExecuteScript("transitions",oPC);
////////////////////////////////////////////////////////////////////////////////
}
