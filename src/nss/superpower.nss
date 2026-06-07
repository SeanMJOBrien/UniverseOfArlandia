void main()
{
object oPC = OBJECT_SELF;
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oSuperpower = GetItemPossessedBy(oPC,"superpower");
int iRace = GetLocalInt(oGoldbag,"Race");
int iTalent = GetLocalInt(oGoldbag,"Super Power");
int iColor = GetLocalInt(oSuperpower,"Color");
int iRacial = GetRacialType(oPC);
int iGender = GetGender(oPC);
float fDuration = 120.0;
int iLight;int iAura;int iEyes;

     if(iColor==1){iLight = VFX_DUR_LIGHT_BLUE_20;iAura = VFX_DUR_AURA_CYAN;
     if(iRacial==RACIAL_TYPE_DWARF){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_CYN_DWARF_FEMALE;}else{iEyes = VFX_EYES_CYN_DWARF_MALE;}}
else if(iRacial==RACIAL_TYPE_ELF){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_CYN_ELF_FEMALE;}else{iEyes = VFX_EYES_CYN_ELF_MALE;}}
else if(iRacial==RACIAL_TYPE_GNOME){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_CYN_GNOME_FEMALE;}else{iEyes = VFX_EYES_CYN_GNOME_MALE;}}
else if(iRacial==RACIAL_TYPE_HALFLING){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_CYN_HALFLING_FEMALE;}else{iEyes = VFX_EYES_CYN_HALFLING_MALE;}}
else if(iRacial==RACIAL_TYPE_HALFORC){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_CYN_HALFORC_FEMALE;}else{iEyes = VFX_EYES_CYN_HALFORC_MALE;}}
else if((iRacial==RACIAL_TYPE_HUMAN)||(iRacial==RACIAL_TYPE_HALFELF)){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_CYN_HUMAN_FEMALE;}else{iEyes = VFX_EYES_CYN_HUMAN_MALE;}}}

else if(iColor==2){iLight = VFX_DUR_LIGHT_GREY_20;iAura = VFX_DUR_AURA_GREEN;
     if(iRacial==RACIAL_TYPE_DWARF){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_GREEN_DWARF_FEMALE;}else{iEyes = VFX_EYES_GREEN_DWARF_MALE;}}
else if(iRacial==RACIAL_TYPE_ELF){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_GREEN_ELF_FEMALE;}else{iEyes = VFX_EYES_GREEN_ELF_MALE;}}
else if(iRacial==RACIAL_TYPE_GNOME){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_GREEN_GNOME_FEMALE;}else{iEyes = VFX_EYES_GREEN_GNOME_MALE;}}
else if(iRacial==RACIAL_TYPE_HALFLING){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_GREEN_HALFLING_FEMALE;}else{iEyes = VFX_EYES_GREEN_HALFLING_MALE;}}
else if(iRacial==RACIAL_TYPE_HALFORC){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_GREEN_HALFORC_FEMALE;}else{iEyes = VFX_EYES_GREEN_HALFORC_MALE;}}
else if((iRacial==RACIAL_TYPE_HUMAN)||(iRacial==RACIAL_TYPE_HALFELF)){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_GREEN_HUMAN_FEMALE;}else{iEyes = VFX_EYES_GREEN_HUMAN_MALE;}}}

else if(iColor==3){iLight = VFX_DUR_LIGHT_ORANGE_20;iAura = VFX_DUR_AURA_ORANGE;
     if(iRacial==RACIAL_TYPE_DWARF){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_ORG_DWARF_FEMALE;}else{iEyes = VFX_EYES_ORG_DWARF_MALE;}}
else if(iRacial==RACIAL_TYPE_ELF){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_ORG_ELF_FEMALE;}else{iEyes = VFX_EYES_ORG_ELF_MALE;}}
else if(iRacial==RACIAL_TYPE_GNOME){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_ORG_GNOME_FEMALE;}else{iEyes = VFX_EYES_ORG_GNOME_MALE;}}
else if(iRacial==RACIAL_TYPE_HALFLING){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_ORG_HALFLING_FEMALE;}else{iEyes = VFX_EYES_ORG_HALFLING_MALE;}}
else if(iRacial==RACIAL_TYPE_HALFORC){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_ORG_HALFORC_FEMALE;}else{iEyes = VFX_EYES_ORG_HALFORC_MALE;}}
else if((iRacial==RACIAL_TYPE_HUMAN)||(iRacial==RACIAL_TYPE_HALFELF)){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_ORG_HUMAN_FEMALE;}else{iEyes = VFX_EYES_ORG_HUMAN_MALE;}}}

else if(iColor==4){iLight = VFX_DUR_LIGHT_PURPLE_20;iAura = VFX_DUR_AURA_PURPLE;
     if(iRacial==RACIAL_TYPE_DWARF){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_RED_FLAME_DWARF_FEMALE;}else{iEyes = VFX_EYES_RED_FLAME_DWARF_MALE;}}
else if(iRacial==RACIAL_TYPE_ELF){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_RED_FLAME_ELF_FEMALE;}else{iEyes = VFX_EYES_RED_FLAME_ELF_MALE;}}
else if(iRacial==RACIAL_TYPE_GNOME){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_RED_FLAME_GNOME_FEMALE;}else{iEyes = VFX_EYES_RED_FLAME_GNOME_MALE;}}
else if(iRacial==RACIAL_TYPE_HALFLING){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_RED_FLAME_HALFLING_FEMALE;}else{iEyes = VFX_EYES_RED_FLAME_HALFLING_MALE;}}
else if(iRacial==RACIAL_TYPE_HALFORC){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_RED_FLAME_HALFORC_FEMALE;}else{iEyes = VFX_EYES_RED_FLAME_HALFORC_MALE;}}
else if((iRacial==RACIAL_TYPE_HUMAN)||(iRacial==RACIAL_TYPE_HALFELF)){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_RED_FLAME_HUMAN_FEMALE;}else{iEyes = VFX_EYES_RED_FLAME_HUMAN_MALE;}}}

else if(iColor==5){iLight = VFX_DUR_LIGHT_RED_20;iAura = VFX_DUR_AURA_RED;
     if(iRacial==RACIAL_TYPE_DWARF){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_RED_FLAME_DWARF_FEMALE;}else{iEyes = VFX_EYES_RED_FLAME_DWARF_MALE;}}
else if(iRacial==RACIAL_TYPE_ELF){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_RED_FLAME_ELF_FEMALE;}else{iEyes = VFX_EYES_RED_FLAME_ELF_MALE;}}
else if(iRacial==RACIAL_TYPE_GNOME){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_RED_FLAME_GNOME_FEMALE;}else{iEyes = VFX_EYES_RED_FLAME_GNOME_MALE;}}
else if(iRacial==RACIAL_TYPE_HALFLING){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_RED_FLAME_HALFLING_FEMALE;}else{iEyes = VFX_EYES_RED_FLAME_HALFLING_MALE;}}
else if(iRacial==RACIAL_TYPE_HALFORC){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_RED_FLAME_HALFORC_FEMALE;}else{iEyes = VFX_EYES_RED_FLAME_HALFORC_MALE;}}
else if((iRacial==RACIAL_TYPE_HUMAN)||(iRacial==RACIAL_TYPE_HALFELF)){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_RED_FLAME_HUMAN_FEMALE;}else{iEyes = VFX_EYES_RED_FLAME_HUMAN_MALE;}}}

else if(iColor==6){iLight = VFX_DUR_LIGHT_WHITE_20;iAura = VFX_DUR_AURA_WHITE;
     if(iRacial==RACIAL_TYPE_DWARF){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_YEL_DWARF_FEMALE;}else{iEyes = VFX_EYES_YEL_DWARF_MALE;}}
else if(iRacial==RACIAL_TYPE_ELF){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_YEL_ELF_FEMALE;}else{iEyes = VFX_EYES_YEL_ELF_MALE;}}
else if(iRacial==RACIAL_TYPE_GNOME){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_YEL_GNOME_FEMALE;}else{iEyes = VFX_EYES_YEL_GNOME_MALE;}}
else if(iRacial==RACIAL_TYPE_HALFLING){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_YEL_HALFLING_FEMALE;}else{iEyes = VFX_EYES_YEL_HALFLING_MALE;}}
else if(iRacial==RACIAL_TYPE_HALFORC){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_YEL_HALFORC_FEMALE;}else{iEyes = VFX_EYES_YEL_HALFORC_MALE;}}
else if((iRacial==RACIAL_TYPE_HUMAN)||(iRacial==RACIAL_TYPE_HALFELF)){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_YEL_HUMAN_FEMALE;}else{iEyes = VFX_EYES_YEL_HUMAN_MALE;}}}

else if(iColor==7){iLight = VFX_DUR_LIGHT_YELLOW_20;iAura = VFX_DUR_AURA_YELLOW;
     if(iRacial==RACIAL_TYPE_DWARF){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_YEL_DWARF_FEMALE;}else{iEyes = VFX_EYES_YEL_DWARF_MALE;}}
else if(iRacial==RACIAL_TYPE_ELF){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_YEL_ELF_FEMALE;}else{iEyes = VFX_EYES_YEL_ELF_MALE;}}
else if(iRacial==RACIAL_TYPE_GNOME){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_YEL_GNOME_FEMALE;}else{iEyes = VFX_EYES_YEL_GNOME_MALE;}}
else if(iRacial==RACIAL_TYPE_HALFLING){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_YEL_HALFLING_FEMALE;}else{iEyes = VFX_EYES_YEL_HALFLING_MALE;}}
else if(iRacial==RACIAL_TYPE_HALFORC){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_YEL_HALFORC_FEMALE;}else{iEyes = VFX_EYES_YEL_HALFORC_MALE;}}
else if((iRacial==RACIAL_TYPE_HUMAN)||(iRacial==RACIAL_TYPE_HALFELF)){if(iGender==GENDER_FEMALE){iEyes = VFX_EYES_YEL_HUMAN_FEMALE;}else{iEyes = VFX_EYES_YEL_HUMAN_MALE;}}}

ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_LIGHTNING_M),oPC,fDuration);
if(GetPhenoType(oPC)!=PHENOTYPE_BIG){DelayCommand(1.0,SetPhenoType(PHENOTYPE_BIG,oPC));DelayCommand(1.0,SetLocalInt(oPC,"PhenoBig",1));DelayCommand(1.0+fDuration,SetPhenoType(PHENOTYPE_NORMAL,oPC));DelayCommand(1.0+fDuration,DeleteLocalInt(oPC,"PhenoBig"));}
DelayCommand(1.0,SetXP(oPC,GetXP(oPC)-100));
DelayCommand(1.0,FloatingTextStringOnCreature("-100 xps",oPC));

if(iTalent==1)
 {
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_STRENGTH,0),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_DEXTERITY,0),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_CONSTITUTION,2),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_INTELLIGENCE,0),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_WISDOM,2),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_CHARISMA,2),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(iLight),oPC,fDuration));
 }
else if(iTalent==2)
 {
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_STRENGTH,0),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_DEXTERITY,2),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_CONSTITUTION,4),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_INTELLIGENCE,2),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_WISDOM,4),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_CHARISMA,4),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(iLight),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(iAura),oPC,fDuration));
 }
else if(iTalent==3)
 {
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(GetMaxHitPoints(oPC)),oPC));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_STRENGTH,2),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_DEXTERITY,4),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_CONSTITUTION,6),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_INTELLIGENCE,4),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_WISDOM,6),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_CHARISMA,6),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(iLight),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(iAura),oPC,fDuration));
if(iRace==0){DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(iEyes),oPC,fDuration));}
 }
else if(iTalent==4)
 {
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(GetMaxHitPoints(oPC)),oPC));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_STRENGTH,4),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_DEXTERITY,6),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_CONSTITUTION,8),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_INTELLIGENCE,6),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_WISDOM,8),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_CHARISMA,8),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(iLight),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(iAura),oPC,fDuration));
if(iRace==0){DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(iEyes),oPC,fDuration));}
DelayCommand(1.0,SetCreatureWingType(CREATURE_WING_TYPE_ANGEL,oPC));DelayCommand(fDuration,SetCreatureWingType(CREATURE_WING_TYPE_NONE,oPC));
 }
else if(iTalent==5)
 {
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(GetMaxHitPoints(oPC)),oPC));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_STRENGTH,6),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_DEXTERITY,8),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_CONSTITUTION,10),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_INTELLIGENCE,8),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_WISDOM,10),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_CHARISMA,10),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(iLight),oPC,fDuration));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(iAura),oPC,fDuration));
if(iRace==0){DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(iEyes),oPC,fDuration));}
DelayCommand(1.0,SetCreatureWingType(CREATURE_WING_TYPE_ANGEL,oPC));DelayCommand(fDuration,SetCreatureWingType(CREATURE_WING_TYPE_NONE,oPC));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_PROT_EPIC_ARMOR),oPC,fDuration));
 }
}
