#include "zep_inc_phenos"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = OBJECT_SELF;
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iAppOrig = GetLocalInt(oGoldbag,"AppOrig");
int iRace = GetLocalInt(oGoldbag,"Race");
int iLevel = GetLevelByPosition(1,oPC)+GetLevelByPosition(2,oPC)+GetLevelByPosition(3,oPC);
location lPC = GetLocation(oPC);
object oObjects = GetFirstObjectInShape(SHAPE_SPHERE,8.0,lPC,FALSE,OBJECT_TYPE_ALL);float fRacePowerDuration = ((iLevel-1)*5)+30.0;
object oNew;int i;
////////////////////////////////////////////////////////////////////////////////
// Brownie
     if(iRace==1) {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectHaste(),oPC,fRacePowerDuration);FloatingTextStringOnCreature("leak",oPC);}
// Bugbear
else if(iRace==2) {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAttackIncrease(1),oPC,fRacePowerDuration);ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SMOKE_PUFF),oPC);FloatingTextStringOnCreature("bugbear fart",oPC);}
// Drow
else if(iRace==3) {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSpellImmunity(SPELL_BALL_LIGHTNING),oPC,fRacePowerDuration);ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSpellImmunity(SPELL_CHAIN_LIGHTNING),oPC,fRacePowerDuration);ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSpellImmunity(SPELL_LIGHTNING_BOLT),oPC,fRacePowerDuration);ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSpellImmunity(SPELL_SEARING_LIGHT),oPC,fRacePowerDuration);FloatingTextStringOnCreature("anti-light power",oPC);}
// Fey
else if(iRace==4) {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectConcealment(50),oPC,fRacePowerDuration);ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_MAGICAL_VISION),oPC);FloatingTextStringOnCreature("dream",oPC);}
// Goblin
else if(iRace==5) {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSanctuary(10),oPC,fRacePowerDuration);FloatingTextStringOnCreature("ruse",oPC);}
// Gnoll
else if(iRace==6) {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMovementSpeedIncrease(50),oPC,fRacePowerDuration);FloatingTextStringOnCreature("speed increase",oPC);}
// Kenku
else if(iRace==7) {ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectHaste(),oPC,fRacePowerDuration);FloatingTextStringOnCreature("haste",oPC);}
// Kobold
else if(iRace==8){while(i<5){i++;oNew = CreateObject(OBJECT_TYPE_CREATURE,"mn_kobold002",GetLocation(oPC));ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);SetLocalInt(oNew,"Hench",1);SetLocalString(oNew,"Master",GetName(oPC));SetLocalInt(oNew,"DontSave",1);ChangeToStandardFaction(oNew,STANDARD_FACTION_COMMONER);SetLocalInt(oNew,"Summon",1);AddHenchman(oPC,oNew);DelayCommand(fRacePowerDuration,RemoveHenchman(oPC,oNew));DelayCommand(fRacePowerDuration,ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT));DelayCommand(fRacePowerDuration,SetImmortal(oNew,FALSE));DelayCommand(fRacePowerDuration,SetPlotFlag(oNew,FALSE));DelayCommand(fRacePowerDuration,AssignCommand(oNew,SetIsDestroyable(TRUE,FALSE,FALSE)));DestroyObject(oNew,fRacePowerDuration+0.1);}FloatingTextStringOnCreature("grouping",oPC);DelayCommand(fRacePowerDuration,FloatingTextStringOnCreature("ungrouping",oPC));}
// Lizardfolk
else if(iRace==9){while(i<2){i++;oNew = CreateObject(OBJECT_TYPE_CREATURE,"mn_lizard002",GetLocation(oPC));ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);SetLocalInt(oNew,"Hench",1);SetLocalString(oNew,"Master",GetName(oPC));SetLocalInt(oNew,"DontSave",1);ChangeToStandardFaction(oNew,STANDARD_FACTION_COMMONER);SetLocalInt(oNew,"Summon",1);AddHenchman(oPC,oNew);DelayCommand(fRacePowerDuration,RemoveHenchman(oPC,oNew));DelayCommand(fRacePowerDuration,ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT));DelayCommand(fRacePowerDuration,SetImmortal(oNew,FALSE));DelayCommand(fRacePowerDuration,SetPlotFlag(oNew,FALSE));DelayCommand(fRacePowerDuration,AssignCommand(oNew,SetIsDestroyable(TRUE,FALSE,FALSE)));DestroyObject(oNew,fRacePowerDuration+0.1);}FloatingTextStringOnCreature("grouping",oPC);DelayCommand(fRacePowerDuration,FloatingTextStringOnCreature("ungrouping",oPC));}
// Minotaur
else if(iRace==10){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_STRENGTH,1),oPC,fRacePowerDuration);FloatingTextStringOnCreature("minotaur anger",oPC);}
// Ogre
else if(iRace==11){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(GetMaxHitPoints(oPC)*30/100),oPC);FloatingTextStringOnCreature("canibalism",oPC);}
// Orc
else if(iRace==12){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDamageIncrease(5),oPC,fRacePowerDuration);FloatingTextStringOnCreature("orc cry",oPC);}
// Troll
else if(iRace==13){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectRegenerate(5,8.0),oPC,fRacePowerDuration);ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_HOLY_AID),oPC);FloatingTextStringOnCreature("regenerating",oPC);}
// Werecat
else if(iRace==14)
 {
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_UNSUMMON),oPC);
DelayCommand(fRacePowerDuration*2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_UNSUMMON),oPC));
SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_WERECAT);
DelayCommand(fRacePowerDuration*2.0,SetCreatureAppearanceType(oPC,iAppOrig-1));
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)/2),oPC);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_STRENGTH,4),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_DEXTERITY,4),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowIncrease(SAVING_THROW_FORT,2),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowIncrease(SAVING_THROW_REFLEX,2),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowIncrease(SAVING_THROW_WILL,2),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_ANIMAL_EMPATHY,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_APPRAISE,10),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_DISABLE_TRAP,10),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_HIDE,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_LISTEN,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_MOVE_SILENTLY,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_OPEN_LOCK,10),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_PARRY,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_PERFORM,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_SEARCH,10),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_SET_TRAP,10),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_SPELLCRAFT,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_TUMBLE,10),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_USE_MAGIC_DEVICE,10),oPC,fRacePowerDuration*2.0);
 }
// Werewolf
else if(iRace==15)
 {
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_UNSUMMON),oPC);
DelayCommand(fRacePowerDuration*2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_UNSUMMON),oPC));
SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_WEREWOLF);
DelayCommand(fRacePowerDuration*2.0,SetCreatureAppearanceType(oPC,iAppOrig-1));
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)/2),oPC);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_STRENGTH,6),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_DEXTERITY,6),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_ANIMAL_EMPATHY,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_BLUFF,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_CRAFT_ARMOR,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_CRAFT_TRAP,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_CRAFT_WEAPON,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_DISABLE_TRAP,10),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_DISCIPLINE,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_HEAL,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_MOVE_SILENTLY,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_PICK_POCKET,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_RIDE,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_SEARCH,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_SPOT,5),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_TUMBLE,10),oPC,fRacePowerDuration*2.0);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_USE_MAGIC_DEVICE,10),oPC,fRacePowerDuration*2.0);
 }
// Narok
else if(iRace==16){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_CRAFT_ARMOR,10),oPC,fRacePowerDuration);ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_CRAFT_TRAP,10),oPC,fRacePowerDuration);ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillIncrease(SKILL_CRAFT_WEAPON,10),oPC,fRacePowerDuration);FloatingTextStringOnCreature("crafting knowledge",oPC);}
// Abishai
else if(iRace==17){SetLocalInt(oPC,"ChoiceDone1",1);AssignCommand(oPC,ActionStartConversation(oPC,"power",TRUE,FALSE));}
// Cornugon
else if(iRace==18){while(i<2){i++;ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD),oPC);oNew = CreateObject(OBJECT_TYPE_CREATURE,"mn_hellhound001",GetLocation(oPC));ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);SetLocalInt(oNew,"Hench",1);SetLocalString(oNew,"Master",GetName(oPC));SetLocalInt(oNew,"DontSave",1);ChangeToStandardFaction(oNew,STANDARD_FACTION_COMMONER);SetLocalInt(oNew,"Summon",1);AddHenchman(oPC,oNew);DelayCommand(fRacePowerDuration,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD),oNew));DelayCommand(fRacePowerDuration,RemoveHenchman(oPC,oNew));DelayCommand(fRacePowerDuration,ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT));DelayCommand(fRacePowerDuration,SetImmortal(oNew,FALSE));DelayCommand(fRacePowerDuration,SetPlotFlag(oNew,FALSE));DelayCommand(fRacePowerDuration,AssignCommand(oNew,SetIsDestroyable(TRUE,FALSE,FALSE)));DestroyObject(oNew,fRacePowerDuration+0.5);}FloatingTextStringOnCreature("summoning hell hounds",oPC);}
// Devil
else if(iRace==19){SetLocalInt(oPC,"ChoiceDone1",1);AssignCommand(oPC,ActionStartConversation(oPC,"power",TRUE,FALSE));}
// Glabrezu
else if(iRace==20){while(i<2){i++;ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD),oPC);oNew = CreateObject(OBJECT_TYPE_CREATURE,"mn_hellhound001",GetLocation(oPC));ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);SetLocalInt(oNew,"Hench",1);SetLocalString(oNew,"Master",GetName(oPC));SetLocalInt(oNew,"DontSave",1);ChangeToStandardFaction(oNew,STANDARD_FACTION_COMMONER);SetLocalInt(oNew,"Summon",1);AddHenchman(oPC,oNew);DelayCommand(fRacePowerDuration,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD),oNew));DelayCommand(fRacePowerDuration,RemoveHenchman(oPC,oNew));DelayCommand(fRacePowerDuration,ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT));DelayCommand(fRacePowerDuration,SetImmortal(oNew,FALSE));DelayCommand(fRacePowerDuration,SetPlotFlag(oNew,FALSE));DelayCommand(fRacePowerDuration,AssignCommand(oNew,SetIsDestroyable(TRUE,FALSE,FALSE)));DestroyObject(oNew,fRacePowerDuration+0.5);}FloatingTextStringOnCreature("summoning hell hounds",oPC);}
// Nalfeshnee
else if(iRace==21){while(i<5){i++;ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD),oPC);oNew = CreateObject(OBJECT_TYPE_CREATURE,"mn_fiend001",GetLocation(oPC));ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);SetLocalInt(oNew,"Hench",1);SetLocalString(oNew,"Master",GetName(oPC));SetLocalInt(oNew,"DontSave",1);ChangeToStandardFaction(oNew,STANDARD_FACTION_COMMONER);SetLocalInt(oNew,"Summon",1);AddHenchman(oPC,oNew);DelayCommand(fRacePowerDuration,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD),oNew));DelayCommand(fRacePowerDuration,RemoveHenchman(oPC,oNew));DelayCommand(fRacePowerDuration,ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT));DelayCommand(fRacePowerDuration,SetImmortal(oNew,FALSE));DelayCommand(fRacePowerDuration,SetPlotFlag(oNew,FALSE));DelayCommand(fRacePowerDuration,AssignCommand(oNew,SetIsDestroyable(TRUE,FALSE,FALSE)));DestroyObject(oNew,fRacePowerDuration+0.5);}FloatingTextStringOnCreature("summoning imps",oPC);}
// Oschore
else if(iRace==22){while(GetIsObjectValid(oObjects)){if(oObjects!=oPC){DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE),oObjects));DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(iLevel),DAMAGE_TYPE_FIRE),oObjects));}oObjects = GetNextObjectInShape(SHAPE_SPHERE,8.0,lPC,FALSE,OBJECT_TYPE_ALL);}ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_FIRESTORM),oPC);FloatingTextStringOnCreature("fire explosion",oPC);}
// Succubus
else if(iRace==23){while(i<1){i++;ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD),oPC);oNew = CreateObject(OBJECT_TYPE_CREATURE,"mn_sucubus001",GetLocation(oPC));ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);SetLocalInt(oNew,"Hench",1);SetLocalString(oNew,"Master",GetName(oPC));SetLocalInt(oNew,"DontSave",1);ChangeToStandardFaction(oNew,STANDARD_FACTION_COMMONER);SetLocalInt(oNew,"Summon",1);AddHenchman(oPC,oNew);DelayCommand(fRacePowerDuration,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD),oNew));DelayCommand(fRacePowerDuration,RemoveHenchman(oPC,oNew));DelayCommand(fRacePowerDuration,ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT));DelayCommand(fRacePowerDuration,SetImmortal(oNew,FALSE));DelayCommand(fRacePowerDuration,SetPlotFlag(oNew,FALSE));DelayCommand(fRacePowerDuration,AssignCommand(oNew,SetIsDestroyable(TRUE,FALSE,FALSE)));DestroyObject(oNew,fRacePowerDuration+0.5);}FloatingTextStringOnCreature("summoning succubus",oPC);}
// Yagnoloth
else if(iRace==24){while(i<5){i++;ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD),oPC);oNew = CreateObject(OBJECT_TYPE_CREATURE,"mn_fiend001",GetLocation(oPC));ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);SetLocalInt(oNew,"Hench",1);SetLocalString(oNew,"Master",GetName(oPC));SetLocalInt(oNew,"DontSave",1);ChangeToStandardFaction(oNew,STANDARD_FACTION_COMMONER);SetLocalInt(oNew,"Summon",1);AddHenchman(oPC,oNew);DelayCommand(fRacePowerDuration,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD),oNew));DelayCommand(fRacePowerDuration,RemoveHenchman(oPC,oNew));DelayCommand(fRacePowerDuration,ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT));DelayCommand(fRacePowerDuration,SetImmortal(oNew,FALSE));DelayCommand(fRacePowerDuration,SetPlotFlag(oNew,FALSE));DelayCommand(fRacePowerDuration,AssignCommand(oNew,SetIsDestroyable(TRUE,FALSE,FALSE)));DestroyObject(oNew,fRacePowerDuration+0.5);}FloatingTextStringOnCreature("summoning imps",oPC);}
////////////////////////////////////////////////////////////////////////////////
}
