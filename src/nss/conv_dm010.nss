////////////////////////////////////////////////////////////////////////////////
#include "zep_inc_phenos"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();if(oPC==OBJECT_INVALID){oPC = GetLocalObject(OBJECT_SELF,"oPC");}
object oArea = GetArea(oPC);
string sAreaName = GetName(oArea);
//
object oTarget = GetLocalObject(oPC,"oTarget");
object oGoldbag = GetItemPossessedBy(oTarget,"goldbag");
string sBP = GetResRef(oTarget);
string sTag = GetTag(oTarget);
string sNPCName = GetName(oTarget);
location lLoc = GetLocation(oTarget);
int iType = GetObjectType(oTarget);
int iPhenotype = GetPhenoType(oTarget);
effect eEffects = GetFirstEffect(oTarget);
int iNPCNum = GetLocalInt(oTarget,"Num");
int iStop = GetLocalInt(oTarget,"Stop");
int iDontSave = GetLocalInt(oTarget,"DontSave");
//
location lTarget = GetLocalLocation(oPC,"lTarget");
//
int iMode = GetLocalInt(oPC,"AreaMode");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice2");
int iChoice3 = GetLocalInt(OBJECT_SELF,"Choice3");
int iChoice4 = GetLocalInt(OBJECT_SELF,"Choice4");
int iChoice5 = GetLocalInt(OBJECT_SELF,"Choice5");
//
int iAppOrig = GetLocalInt(oTarget,"AppOrig");if((!GetIsPC(oTarget))&&(iAppOrig==0)){SetLocalInt(oTarget,"AppOrig",GetAppearanceType(oTarget));}
int iReputation = GetLocalInt(oGoldbag,"Reputation");
//
int iPC;if(GetIsPC(oTarget)){iPC = 1;}
object oNew;object oItem;int iFly;int iApp;int iFaction;string sNewBP;int j;int i; // i (Vfx) : 1 = Yes, 0 = No.
////////////////////////////////////////////////////////////////////////////////
if(iMode==0){
////////////////////////////////////////////////////////////////////////////////
// Solo Begin //
////////////////////////////////////////////////////////////////////////////////
// Animation/effects
if(iChoice1==1)
 {
////////////////////////////////////////////////////////////////////////////////
// Fly away
if(iChoice2==0)
  {
iFly = GetLocalInt(oTarget,"NumTarget");

SetLocalString(oPC,IntToString(iFly)+"BP",GetResRef(oTarget));
SetLocalString(oPC,IntToString(iFly)+"Tag",GetTag(oTarget));
SetLocalString(oPC,IntToString(iFly)+"Name",GetName(oTarget));
SetLocalInt(oPC,IntToString(iFly)+"Persistent",GetLocalInt(oTarget,"Persistent"));
SetLocalInt(oPC,IntToString(iFly)+"Stop",GetLocalInt(oTarget,"Stop"));
SetLocalString(oPC,IntToString(iFly)+"Master",GetLocalString(oTarget,"Master"));
SetLocalInt(oPC,IntToString(iFly)+"HitPoints",GetCurrentHitPoints(oTarget));
SetLocalString(oPC,IntToString(iFly)+"Var",GetLocalString(oTarget,"Var"));
SetLocalInt(oPC,IntToString(iFly)+"Hench",GetLocalInt(oTarget,"Hench"));
SetLocalInt(oPC,IntToString(iFly)+"HenchNum",GetLocalInt(oTarget,"HenchNum"));
SetLocalInt(oPC,IntToString(iFly)+"Camp",GetLocalInt(oTarget,"Camp"));
SetLocalInt(oPC,IntToString(iFly)+"Flee",GetLocalInt(oTarget,"Flee"));
SetLocalInt(oPC,IntToString(iFly)+"NotFlee",GetLocalInt(oTarget,"NotFlee"));
SetLocalInt(oPC,"Flying_Cre",iFly);

     if(GetStandardFactionReputation(STANDARD_FACTION_COMMONER,oTarget)>=90){iFaction = 1;}
else if(GetStandardFactionReputation(STANDARD_FACTION_DEFENDER,oTarget)>=90){iFaction = 2;}
else if(GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,oTarget)>=90){iFaction = 3;}
else if(GetStandardFactionReputation(STANDARD_FACTION_MERCHANT,oTarget)>=90){iFaction = 4;}
SetLocalInt(oPC,IntToString(iFly)+"Faction",iFaction);

AssignCommand(oTarget,SetIsDestroyable(TRUE,TRUE,TRUE));
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDisappear(),oTarget);
  }
// Clear all action / effects
else if(iChoice2==1)
  {
DeleteLocalInt(oTarget,"Kneeling");
DeleteLocalInt(oTarget,"NoReaction");
DeleteLocalInt(oTarget,"Sleep");
while(GetIsEffectValid(eEffects))
   {
RemoveEffect(oTarget,eEffects);
eEffects = GetNextEffect(oTarget);
   }
AssignCommand(oTarget,ClearAllActions(TRUE));
  }
// Fly / Land
else if(iChoice2==2)
  {
if(GetStringLeft(sTag,9)=="mn_dragon")
   {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"entry",GetLocation(oTarget));
SetLocalInt(oNew,"Action",1);
SetLocalObject(oNew,"PC",oPC);
SetLocalString(oNew,"DragonTag",GetResRef(oTarget));
SetLocalString(oNew,"DragonName",GetName(oTarget));
SetLocalInt(oNew,"DragonHP",GetCurrentHitPoints(oTarget));
SetLocalString(oNew,"Var",GetLocalString(oTarget,"Var"));
SetLocalInt(oNew,"Stop",GetLocalInt(oTarget,"Stop"));
SetLocalInt(oNew,"Persistent",GetLocalInt(oTarget,"Persistent"));
if(GetStandardFactionReputation(STANDARD_FACTION_COMMONER,oTarget)>=90){iFaction = 1;}else if(GetStandardFactionReputation(STANDARD_FACTION_DEFENDER,oTarget)>=90){iFaction = 2;}else if(GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,oTarget)>=90){iFaction = 3;}else{iFaction = 4;}SetLocalInt(oNew,"Faction",iFaction);
DelayCommand(0.5,ExecuteScript("dragons",oNew));
AssignCommand(oTarget,SetIsDestroyable(TRUE,TRUE,TRUE));
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDisappear(),oTarget);
DestroyObject(oTarget,0.2);
   }
else if(GetLocalInt(oTarget,"Flying")==0)
   {
SetLocalInt(oTarget,"Flying",2);
zep_Fly(oTarget,nCEP_WG_NONE,2.5);
SetFootstepType(FOOTSTEP_TYPE_NONE,oTarget);
   }
else
   {
DeleteLocalInt(oTarget,"Flying");
zep_Fly_Land(oTarget,TRUE);
SetFootstepType(FOOTSTEP_TYPE_DEFAULT,oTarget);
   }
  }
// Freeze
else if(iChoice2==3)
  {
AssignCommand(oTarget,ClearAllActions());
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION),oTarget);
  }
// Ghostly visage
else if(iChoice2==4)
  {
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE_NO_SOUND),oTarget);
  }
// Injure
else if(iChoice2==5)
  {
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetMaxHitPoints(oTarget)/2),oTarget);
  }
// INvisibility
else if(iChoice2==6)
  {
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectInvisibility(INVISIBILITY_TYPE_IMPROVED),oTarget);
  }
// Kneel
else if(iChoice2==7)
  {
SetLocalInt(oTarget,"Stop",1);
SetLocalInt(oTarget,"Kneeling",1);
AssignCommand(oTarget,ClearAllActions());
AssignCommand(oTarget,PlayAnimation(ANIMATION_LOOPING_MEDITATE));
DelayCommand(0.8,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION),oTarget));
  }
// Lay-on-the-ground
else if(iChoice2==8)
  {
AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK,1.0,20000.0));
  }
// No reaction
else if(iChoice2==9)
  {
SetLocalInt(oTarget,"NoReaction",1);
  }
// Paralyse
else if(iChoice2==10)
  {
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectParalyze(),oTarget);
  }
// Petrify
else if(iChoice2==11)
  {
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectPetrify(),oTarget);
  }
// Sit
else if(iChoice2==12)
  {
oItem = GetNearestObject(OBJECT_TYPE_PLACEABLE,oTarget);if((GetIsObjectValid(oItem))&&(GetDistanceBetween(oTarget,oItem)<10.0)&&(GetSittingCreature(oItem)==OBJECT_INVALID)){AssignCommand(oTarget,ActionSit(oItem));}else{AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS,1.0,20000.0));SetLocalInt(oTarget,"Sit",1);}
  }
// Sleep
else if(iChoice2==13)
  {
SetLocalInt(oTarget,"Sleep",1);AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,20000.0));ExecuteScript("sleep",oTarget);
  }
// Stoneskin
else if(iChoice2==14)
  {
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN),oTarget);
  }
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
// Appearances
else if(iChoice1==2)
 {
////////////////////////////////////////////////////////////////////////////////
     if(iChoice2==1) {SetCreatureAppearanceType(oTarget,GetLocalInt(oPC,"Appareance1"));}
else if(iChoice2==2) {SetCreatureAppearanceType(oTarget,GetLocalInt(oPC,"Appareance2"));}
else if(iChoice2==3) {SetCreatureAppearanceType(oTarget,GetLocalInt(oPC,"Appareance3"));}
else if(iChoice2==4) {SetCreatureAppearanceType(oTarget,GetLocalInt(oPC,"Appareance4"));}
else if(iChoice2==5) {SetCreatureAppearanceType(oTarget,GetLocalInt(oPC,"Appareance5"));}
else if(iChoice2==6) {SetCreatureAppearanceType(oTarget,GetLocalInt(oPC,"Appareance6"));}
else if(iChoice2==7) {SetLocalInt(oPC,"Appareance1",GetAppearanceType(oTarget));SetLocalString(oPC,"Appareance20231",GetName(oTarget));SetCustomToken(20231,GetName(oTarget));SendMessageToPC(oPC,"Custom 1 appearance : "+GetName(oTarget)+".");}
else if(iChoice2==8) {SetLocalInt(oPC,"Appareance2",GetAppearanceType(oTarget));SetLocalString(oPC,"Appareance20232",GetName(oTarget));SetCustomToken(20232,GetName(oTarget));SendMessageToPC(oPC,"Custom 2 appearance : "+GetName(oTarget)+".");}
else if(iChoice2==9) {SetLocalInt(oPC,"Appareance3",GetAppearanceType(oTarget));SetLocalString(oPC,"Appareance20233",GetName(oTarget));SetCustomToken(20233,GetName(oTarget));SendMessageToPC(oPC,"Custom 3 appearance : "+GetName(oTarget)+".");}
else if(iChoice2==10){SetLocalInt(oPC,"Appareance4",GetAppearanceType(oTarget));SetLocalString(oPC,"Appareance20234",GetName(oTarget));SetCustomToken(20234,GetName(oTarget));SendMessageToPC(oPC,"Custom 4 appearance : "+GetName(oTarget)+".");}
else if(iChoice2==11){SetLocalInt(oPC,"Appareance5",GetAppearanceType(oTarget));SetLocalString(oPC,"Appareance20235",GetName(oTarget));SetCustomToken(20235,GetName(oTarget));SendMessageToPC(oPC,"Custom 5 appearance : "+GetName(oTarget)+".");}
else if(iChoice2==12){SetLocalInt(oPC,"Appareance6",GetAppearanceType(oTarget));SetLocalString(oPC,"Appareance20236",GetName(oTarget));SetCustomToken(20236,GetName(oTarget));SendMessageToPC(oPC,"Custom 6 appearance : "+GetName(oTarget)+".");}
else if(iChoice2==13){while(GetIsEffectValid(eEffects)){if(GetEffectType(eEffects)==EFFECT_TYPE_VISUALEFFECT){RemoveEffect(oTarget,eEffects);}eEffects = GetNextEffect(oTarget);}if(GetLocalInt(oTarget,"Color_Hair")!=0){SetColor(oTarget,COLOR_CHANNEL_HAIR,GetLocalInt(oTarget,"Color_Hair"));}if((GetIsPC(oTarget))||(GetRacialType(oTarget)==RACIAL_TYPE_DWARF)){ExecuteScript("appearances",oTarget);}else{SetCreatureAppearanceType(oTarget,iAppOrig);}}
else if(iChoice2==14){if(iChoice3==1){iApp = GetLocalInt(oTarget,"OriginRace")-1;}else if(iChoice3==2){iApp = APPEARANCE_TYPE_DWARF;}else if(iChoice3==3){iApp = APPEARANCE_TYPE_ELF;}else if(iChoice3==4){iApp = APPEARANCE_TYPE_GNOME;}else if(iChoice3==5){iApp = APPEARANCE_TYPE_HALF_ELF;}else if(iChoice3==6){iApp = APPEARANCE_TYPE_HALFLING;}else if(iChoice3==7){iApp = APPEARANCE_TYPE_HALF_ORC;}else if(iChoice3==8){iApp = APPEARANCE_TYPE_HUMAN;}if(GetLocalInt(oTarget,"OriginRace")==0){SetLocalInt(oTarget,"OriginRace",GetRacialType(oTarget)+1);}ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD),oTarget);DelayCommand(0.5,SetCreatureAppearanceType(oTarget,iApp));if((iChoice3==1)&&(GetLocalInt(oTarget,"OriginHead")!=0)){DelayCommand(0.6,SetCreatureBodyPart(CREATURE_PART_HEAD,GetLocalInt(oTarget,"OriginHead"),oTarget));}else if(GetCreatureBodyPart(CREATURE_PART_HEAD,oTarget)>15){if(GetLocalInt(oTarget,"OriginHead")==0){SetLocalInt(oTarget,"OriginHead",GetCreatureBodyPart(CREATURE_PART_HEAD,oTarget));}DelayCommand(0.5,SetCreatureBodyPart(CREATURE_PART_HEAD,10,oTarget));}}
else if(iChoice2==15){if(iChoice3==1){while(GetIsEffectValid(eEffects)){if(GetEffectType(eEffects)==EFFECT_TYPE_VISUALEFFECT){RemoveEffect(oTarget,eEffects);}eEffects = GetNextEffect(oTarget);}}else if(iChoice3==2){if(GetRacialType(oTarget)==RACIAL_TYPE_DWARF){if(GetGender(oTarget)==GENDER_FEMALE){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_EYES_PUR_DWARF_FEMALE),oTarget);}else{ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_EYES_PUR_DWARF_MALE),oTarget);}}else if(GetRacialType(oTarget)==RACIAL_TYPE_ELF){if(GetGender(oTarget)==GENDER_FEMALE){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_EYES_PUR_ELF_FEMALE),oTarget);}else{ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_EYES_PUR_ELF_MALE),oTarget);}}else if(GetRacialType(oTarget)==RACIAL_TYPE_GNOME){if(GetGender(oTarget)==GENDER_FEMALE){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_EYES_PUR_GNOME_FEMALE),oTarget);}else{ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_EYES_PUR_GNOME_MALE),oTarget);}}else if((GetRacialType(oTarget)==RACIAL_TYPE_HALFELF)||(GetRacialType(oTarget)==RACIAL_TYPE_HUMAN)){if(GetGender(oTarget)==GENDER_FEMALE){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_EYES_PUR_HUMAN_FEMALE),oTarget);}else{ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_EYES_PUR_HUMAN_MALE),oTarget);}}else if(GetRacialType(oTarget)==RACIAL_TYPE_HALFLING){if(GetGender(oTarget)==GENDER_FEMALE){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_EYES_PUR_HALFLING_FEMALE),oTarget);}else{ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_EYES_PUR_HALFLING_MALE),oTarget);}}else if(GetRacialType(oTarget)==RACIAL_TYPE_HALFORC){if(GetGender(oTarget)==GENDER_FEMALE){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_EYES_PUR_HALFORC_FEMALE),oTarget);}else{ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_EYES_PUR_HALFORC_MALE),oTarget);}}}}
else if(iChoice2==16){if(iChoice3==1){SetColor(oTarget,COLOR_CHANNEL_HAIR,GetLocalInt(oTarget,"Color_Hair"));}else if(iChoice3==2){if(GetLocalInt(oTarget,"Color_Hair")==0){SetLocalInt(oTarget,"Color_Hair",GetColor(oTarget,COLOR_CHANNEL_HAIR));}SetColor(oTarget,COLOR_CHANNEL_HAIR,90);}else if(iChoice3==3){if(GetLocalInt(oTarget,"Color_Hair")==0){SetLocalInt(oTarget,"Color_Hair",GetColor(oTarget,COLOR_CHANNEL_HAIR));}SetColor(oTarget,COLOR_CHANNEL_HAIR,147);}else if(iChoice3==4){if(GetLocalInt(oTarget,"Color_Hair")==0){SetLocalInt(oTarget,"Color_Hair",GetColor(oTarget,COLOR_CHANNEL_HAIR));}SetColor(oTarget,COLOR_CHANNEL_HAIR,12);}}
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
// Duplicate
else if(iChoice1==3)
 {
////////////////////////////////////////////////////////////////////////////////
     if(iChoice2==1){iChoice2 = 1;}
else if(iChoice2==2){iChoice2 = 2;}
else if(iChoice2==3){iChoice2 = 5;}
else if(iChoice2==4){iChoice2 = 10;}
else if(iChoice2==5){iChoice2 = 20;}
else if(iChoice2==6){iChoice2 = 50;}

if(GetStandardFactionReputation(STANDARD_FACTION_COMMONER,oTarget)>=90){iFaction = 1;}else if(GetStandardFactionReputation(STANDARD_FACTION_DEFENDER,oTarget)>=90){iFaction = 2;}else if(GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,oTarget)>=90){iFaction = 3;}else{iFaction = 4;}
while(iChoice2>0)
  {
iChoice2--;
oNew = CopyObject(oTarget,GetLocation(oTarget),OBJECT_INVALID,GetTag(oTarget));

SetLocalString(oNew,"Persistent",GetLocalString(oTarget,"Persistent"));
SetLocalInt(oNew,"Stop",GetLocalInt(oTarget,"Stop"));
SetLocalString(oNew,"Master",GetLocalString(oTarget,"Master"));
SetLocalInt(oNew,"HitPoints",GetLocalInt(oTarget,"HitPoints"));
SetLocalString(oNew,"Var",GetLocalString(oTarget,"Var"));
SetLocalInt(oNew,"Hench",GetLocalInt(oTarget,"Hench"));
SetLocalInt(oNew,"HenchNum",GetLocalInt(oTarget,"HenchNum"));
SetLocalInt(oNew,"Camp",GetLocalInt(oTarget,"Camp"));
SetLocalInt(oNew,"Flee",GetLocalInt(oTarget,"Flee"));
SetLocalInt(oNew,"NotFlee",GetLocalInt(oTarget,"NotFlee"));

     if(iFaction==1){ChangeToStandardFaction(oNew,STANDARD_FACTION_COMMONER);}
else if(iFaction==2){ChangeToStandardFaction(oNew,STANDARD_FACTION_DEFENDER);}
else if(iFaction==3){ChangeToStandardFaction(oNew,STANDARD_FACTION_HOSTILE);}
else if(iFaction==4){ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);}

SetLocalInt(oNew,"DontCopy",1);DelayCommand(3.0,DeleteLocalInt(oNew,"DontCopy"));
  }
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
// Faction
else if(iChoice1==4)
 {
////////////////////////////////////////////////////////////////////////////////
     if(iChoice2==1){ChangeToStandardFaction(oTarget,STANDARD_FACTION_COMMONER);SendMessageToPC(oPC,GetName(oTarget)+" is now commoner");}
else if(iChoice2==2){ChangeToStandardFaction(oTarget,STANDARD_FACTION_DEFENDER);SendMessageToPC(oPC,GetName(oTarget)+" is now defender");}
else if(iChoice2==3){ChangeToStandardFaction(oTarget,STANDARD_FACTION_HOSTILE);SendMessageToPC(oPC,GetName(oTarget)+" is now hostile");}
else if(iChoice2==4){ChangeToStandardFaction(oTarget,STANDARD_FACTION_MERCHANT);SendMessageToPC(oPC,GetName(oTarget)+" is now merchant");}
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
// Reputation
else if(iChoice1==5)
 {
////////////////////////////////////////////////////////////////////////////////
if(iChoice2==1)
  {
SetLocalInt(oGoldbag,"Reputation",iReputation+1);
SendMessageToPC(oPC,GetName(oTarget)+" has now "+IntToString(iReputation+1)+" reputation points.");
  }
else if(iChoice2==2)
  {
SetLocalInt(oGoldbag,"Reputation",iReputation-1);
SendMessageToPC(oPC,GetName(oTarget)+" has now "+IntToString(iReputation-1)+" reputation points.");
  }
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
// Transform
else if(iChoice1==6)
 {
////////////////////////////////////////////////////////////////////////////////
SetLocalInt(oTarget,"DontCopy",1);

string s = GetLocalString(oTarget,"Var");
string s001 = GetStringLeft(s,FindSubString(s,"_001_"));
string s002 = GetStringRight(GetStringLeft(s,FindSubString(s,"_002_")),GetStringLength(GetStringLeft(s,FindSubString(s,"_002_")))-FindSubString(s,"_001_")-5);
string s003 = GetStringRight(GetStringLeft(s,FindSubString(s,"_003_")),GetStringLength(GetStringLeft(s,FindSubString(s,"_003_")))-FindSubString(s,"_002_")-5);
string s004 = GetStringRight(GetStringLeft(s,FindSubString(s,"_004_")),GetStringLength(GetStringLeft(s,FindSubString(s,"_004_")))-FindSubString(s,"_003_")-5);
int iTypeCre = OBJECT_TYPE_CREATURE;i=0;
//
     if(iChoice2==1) {i = 1;sNewBP = s002;iTypeCre = StringToInt(s001);sTag = s003;sNPCName = s004;j = 1;}
else if(iChoice2==2) {i = 0;sNewBP = "zep_animchest";}
else if(iChoice2==3) {i = 0;if((GetCreatureSize(oTarget)==CREATURE_SIZE_LARGE)||(GetCreatureSize(oTarget)==CREATURE_SIZE_HUGE)){sNewBP = "mn_statueanim002";}else{sNewBP = "mn_statueanim001";}}
else if(iChoice2==4) {i = 1;sNewBP = "nw_spidgiant";}
else if(iChoice2==5) {i = 1;sNewBP = "zep_doppelganger";}
else if(iChoice2==6) {i = 1;sNewBP = "mn_doppenganger";}
else if(iChoice2==7) {i = 0;sNewBP = "zep_treant";}
else if(iChoice2==8) {i = 1;sNewBP = "mn_gargoyle001";}
else if(iChoice2==9) {i = 1;sNewBP = "mn_squel006";}
else if(iChoice2==10){i = 1;sNewBP = "mn_squel007";}
else if(iChoice2==11){i = 1;sNewBP = "nw_spectre";}
else if(iChoice2==12){i = 1;sNewBP = "nw_dmsucubus";}
else if(iChoice2==13){i = 1;if(GetGender(oTarget)==GENDER_MALE){sNewBP = "mn_vampire002";}else{sNewBP = "mn_vampire005";}}
else if(iChoice2==14){i = 1;if(GetGender(oTarget)==GENDER_MALE){sNewBP = "mn_vampire003";}else{sNewBP = "mn_vampire006";}}
else if(iChoice2==15){i = 1;sNewBP = "nw_werecat";}
else if(iChoice2==16){i = 1;sNewBP = "nw_wererat";}
else if(iChoice2==17){i = 1;sNewBP = "nw_werewolf";}
else if(iChoice2==18){i = 1;sNewBP = "nw_zombie01";}
else if(iChoice2==19){i = 1;sNewBP = "nw_zombwarr01";}
//
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_null",lLoc);

if(sNewBP==""){SetLocalInt(oNew,"ShapeNPC",iNPCNum);}
if(j==1){SetLocalInt(oNew,"ChangeTagName",1);}
SetLocalString(oNew,"ShapeBP",sNewBP);
SetLocalString(oNew,"ShapeOrigBP",sBP);
SetLocalString(oNew,"ShapeOrigTag",sTag);
SetLocalString(oNew,"ShapeOrigName",sNPCName);
SetLocalInt(oNew,"ShapeType",iTypeCre);
SetLocalInt(oNew,"ShapeOrigType",iType);
SetLocalLocation(oNew,"ShapeLoc",lLoc);
SetLocalInt(oNew,"ShapeStop",iStop);
SetLocalObject(oNew,"PC",oPC);

if(i==1){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD),lLoc);}
oItem = GetFirstItemInInventory(oTarget);while(GetIsObjectValid(oItem)){DestroyObject(oItem);oItem = GetNextItemInInventory(oTarget);}
AssignCommand(oTarget,ClearAllActions());AssignCommand(oTarget,SetIsDestroyable(TRUE,TRUE,TRUE));DestroyObject(oTarget);
DelayCommand(0.5,ExecuteScript("shapes",oNew));
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Solo End //
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
}else{DeleteLocalInt(oPC,"AreaMode");oTarget = GetFirstObjectInArea(GetArea(oPC));while(GetIsObjectValid(oTarget)){if((GetMaster(oTarget)==OBJECT_INVALID)&&(GetCurrentHitPoints(oTarget)>0)&&(GetObjectType(oTarget)==iType)&&(GetDistanceBetween(oPC,oTarget)<IntToFloat(15))&&(GetLocalInt(oTarget,"DontCopy")!=1)&&(((iPC==0)&&(!GetIsPC(oTarget)))||((iPC==1)&&(GetIsPC(oTarget))))){
////////////////////////////////////////////////////////////////////////////////
// Area Begin //
////////////////////////////////////////////////////////////////////////////////
i++;SetLocalInt(oTarget,"NumTarget",i);SetLocalObject(oPC,"oTarget",oTarget);SetLocalObject(OBJECT_SELF,"oPC",oPC);ExecuteScript("conv_dm010",OBJECT_SELF);DeleteLocalInt(oTarget,"NumTarget");
////////////////////////////////////////////////////////////////////////////////
// Area End //
////////////////////////////////////////////////////////////////////////////////
}oTarget = GetNextObjectInArea(GetArea(oPC));}SetLocalInt(oPC,"AreaMode",1);}
////////////////////////////////////////////////////////////////////////////////
}



