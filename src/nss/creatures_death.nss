#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLastKiller();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sAreaTag = GetTag(oArea);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
object oFaction = GetFirstFactionMember(oPC);
string sTag = GetTag(OBJECT_SELF);
float fMonster = GetChallengeRating(OBJECT_SELF);
object oMaster = GetMaster(OBJECT_SELF);
object oItem = GetFirstItemInInventory(OBJECT_SELF);
//
float fBarbarian;float fBard;float fCleric;float fDruid;float fFighter;float fMonk;float fPaladin;float fRanger;float fRogue;float fSorcerer;float fWizard;
float fXP;float fPoints;float fDiff;float fLevels;float fTable;int iXP;int f;int i;object oNew;object oEnigm;int iPen;
////////////////////////////////////////////////////////////////////////////////
// XPs
int n;string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");while(GetIsObjectValid(oFaction)){if((iGuild>0)&&(GetLocalString(GetItemPossessedBy(oFaction,"goldbag"),"Guild")==sGuild)&&(GetArea(oFaction)==GetArea(oPC))&&(GetDistanceBetween(oFaction,oPC)<=50.0)){n++;}if((GetArea(oFaction)==GetArea(oPC))&&(GetDistanceToObject(oFaction)<=50.0)&&(GetStringLeft(GetTag(oFaction),8)!="henchani")&&(GetLocalInt(oFaction,"Clone")==0)){i++;}oFaction = GetNextFactionMember(oPC);}
//
f++;SetLocalObject(oArea,IntToString(f)+"PartyMember",oPC);
oFaction = GetFirstFactionMember(oPC);

while(GetIsObjectValid(oFaction))
 {
f++;SetLocalObject(oArea,IntToString(f)+"PartyMember",oFaction);

if((GetArea(oFaction)==GetArea(oPC))&&(GetDistanceToObject(oFaction)<=40.0))
  {
fLevels = IntToFloat(GetLevelByPosition(1,oFaction)+GetLevelByPosition(2,oFaction)+GetLevelByPosition(3,oFaction));
////////////////////////////////////////////////////////////////////////////////
// XP rates
// Very weak classes
fPoints = 0.6;
fBard = GetLevelByClass(CLASS_TYPE_BARD,oFaction)*fPoints;
// Weak classes
fPoints = 0.8;
fDruid = GetLevelByClass(CLASS_TYPE_DRUID,oFaction)*fPoints;
fMonk = GetLevelByClass(CLASS_TYPE_MONK,oFaction)*fPoints;
fRanger = GetLevelByClass(CLASS_TYPE_RANGER,oFaction)*fPoints;
fRogue = GetLevelByClass(CLASS_TYPE_ROGUE,oFaction)*fPoints;
// Average classes
fPoints = 1.0;
fBarbarian = GetLevelByClass(CLASS_TYPE_BARBARIAN,oFaction)*fPoints;
fPaladin = GetLevelByClass(CLASS_TYPE_PALADIN,oFaction)*fPoints;
// Strong classes
fPoints = 1.2;
fFighter = GetLevelByClass(CLASS_TYPE_FIGHTER,oFaction)*fPoints;
fSorcerer = GetLevelByClass(CLASS_TYPE_SORCERER,oFaction)*fPoints;
fWizard = GetLevelByClass(CLASS_TYPE_WIZARD,oFaction)*fPoints;
// Very strong classes
fPoints = 1.4;
fCleric = GetLevelByClass(CLASS_TYPE_CLERIC,oFaction)*fPoints;
////////////////////////////////////////////////////////////////////////////////
// Total points
fPoints = (fBarbarian+fBard+fCleric+fDruid+fFighter+fMonk+fPaladin+fRanger+fRogue+fSorcerer+fWizard)/10.0;
////////////////////////////////////////////////////////////////////////////////
// XPs
fDiff = fLevels-fMonster;
fXP = ((fMonster*IntToFloat(iXPKilled))/fPoints)/(IntToFloat(i))-fDiff;iXP = FloatToInt(fXP);if(iXP<0){iXP = 0;}
if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}
SetXP(oFaction,GetXP(oFaction)+iXP);
if(iXP>0){FloatingTextStringOnCreature(IntToString(iXP)+" xps",oFaction);}
  }
oFaction = GetNextFactionMember(oPC);
 }
SetLocalInt(oArea,"PartyMembers",f);
////////////////////////////////////////////////////////////////////////////////
// If killing a commoncer or a guard, make more guards appear and attack
if((GetIsPC(oPC))&&((sTag=="commoner")||(GetStringLeft(sTag,11)=="mn_galactic")))
 {
float fX = GetPosition(oPC).x;float fXrand;int iXRand;
float fY = GetPosition(oPC).y;float fYrand;int iYRand;
i=0;

while(i<4)
  {
i++;
iXRand = Random(2)+1;if(iXRand==1){fXrand = -IntToFloat(Random(20)+20);}else{fXrand = IntToFloat(Random(20)+20);}
iYRand = Random(2)+1;if(iYRand==1){fYrand = -IntToFloat(Random(20)+20);}else{fYrand = IntToFloat(Random(20)+20);}
oNew = CreateObject(OBJECT_TYPE_CREATURE,"mn_galactic001",Location(oArea,Vector(fX+fXrand,fY+fYrand,0.0),0.0),TRUE,"specialguard");ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);SetLocalInt(oNew,"DontSave",1);AssignCommand(oNew,ActionAttack(oPC));
  }
FloatingTextStringOnCreature("the guards are called",oPC);
 }
////////////////////////////////////////////////////////////////////////////////
// Gorochem Death
else if(GetStringLeft(sTag,11)=="mn_gorochem")
 {
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_DESTRUCTION,FALSE),GetLocation(OBJECT_SELF));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_FIREBALL,FALSE),GetLocation(OBJECT_SELF));
object o01 = CreateObject(OBJECT_TYPE_CREATURE,"mn_golpart001",GetLocation(OBJECT_SELF),FALSE);ChangeFaction(o01,OBJECT_SELF);SetLocalInt(o01,"Stop",GetLocalInt(OBJECT_SELF,"Stop"));ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN),o01);
object o02 = CreateObject(OBJECT_TYPE_CREATURE,"mn_golpart002",GetLocation(OBJECT_SELF),FALSE);ChangeFaction(o02,OBJECT_SELF);SetLocalInt(o02,"Stop",GetLocalInt(OBJECT_SELF,"Stop"));ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN),o02);
object o03 = CreateObject(OBJECT_TYPE_CREATURE,"mn_golpart003",GetLocation(OBJECT_SELF),FALSE);ChangeFaction(o03,OBJECT_SELF);SetLocalInt(o03,"Stop",GetLocalInt(OBJECT_SELF,"Stop"));ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN),o03);
object o04 = CreateObject(OBJECT_TYPE_CREATURE,"mn_golpart004",GetLocation(OBJECT_SELF),FALSE);ChangeFaction(o04,OBJECT_SELF);SetLocalInt(o04,"Stop",GetLocalInt(OBJECT_SELF,"Stop"));ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN),o04);
object o05 = CreateObject(OBJECT_TYPE_CREATURE,"mn_golpart005",GetLocation(OBJECT_SELF),FALSE);ChangeFaction(o05,OBJECT_SELF);SetLocalInt(o05,"Stop",GetLocalInt(OBJECT_SELF,"Stop"));ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN),o05);
object o06 = CreateObject(OBJECT_TYPE_CREATURE,"mn_golpart006",GetLocation(OBJECT_SELF),FALSE);ChangeFaction(o06,OBJECT_SELF);SetLocalInt(o06,"Stop",GetLocalInt(OBJECT_SELF,"Stop"));ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN),o06);
object o07 = CreateObject(OBJECT_TYPE_CREATURE,"mn_golpart007",GetLocation(OBJECT_SELF),FALSE);ChangeFaction(o07,OBJECT_SELF);SetLocalInt(o07,"Stop",GetLocalInt(OBJECT_SELF,"Stop"));ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN),o07);
object o08 = CreateObject(OBJECT_TYPE_CREATURE,"mn_golpart008",GetLocation(OBJECT_SELF),FALSE);ChangeFaction(o08,OBJECT_SELF);SetLocalInt(o08,"Stop",GetLocalInt(OBJECT_SELF,"Stop"));ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN),o08);
object o09 = CreateObject(OBJECT_TYPE_CREATURE,"mn_golpart009",GetLocation(OBJECT_SELF),FALSE);ChangeFaction(o09,OBJECT_SELF);SetLocalInt(o09,"Stop",GetLocalInt(OBJECT_SELF,"Stop"));ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN),o09);
object o10 = CreateObject(OBJECT_TYPE_CREATURE,"mn_golpart010",GetLocation(OBJECT_SELF),FALSE);ChangeFaction(o10,OBJECT_SELF);SetLocalInt(o10,"Stop",GetLocalInt(OBJECT_SELF,"Stop"));ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN),o10);
object o11 = CreateObject(OBJECT_TYPE_CREATURE,"mn_golpart011",GetLocation(OBJECT_SELF),FALSE);ChangeFaction(o11,OBJECT_SELF);SetLocalInt(o11,"Stop",GetLocalInt(OBJECT_SELF,"Stop"));ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_PROT_GREATER_STONESKIN),o11);
CreateObject(OBJECT_TYPE_ITEM,"cr_stone",GetLocation(OBJECT_SELF),FALSE);
SetIsDestroyable(TRUE,FALSE,FALSE);DestroyObject(OBJECT_SELF);
 }
////////////////////////////////////////////////////////////////////////////////
// Enigm creatures
if(GetLocalString(OBJECT_SELF,"Enigm")!="")
 {
oEnigm = GetLocalObject(OBJECT_SELF,"oEnigm");
SetLocalString(oEnigm,"Var",GetLocalString(oEnigm,"Var")+"&Success");
 }
////////////////////////////////////////////////////////////////////////////////
// Missions creatures
if(GetLocalString(OBJECT_SELF,"Tag")=="mission"){SetLocalObject(OBJECT_SELF,"MissionObject",OBJECT_SELF);SetLocalInt(OBJECT_SELF,"MissionToPlace",2);ExecuteScript("missions",OBJECT_SELF);}
////////////////////////////////////////////////////////////////////////////////
// Animal reserves
if(GetLocalInt(oPC,"AniReserve")>0)
 {
iPen = GetLocalInt(OBJECT_SELF,"Pen");
SetLocalInt(oModule,sPlanet+sArea+"Pen"+IntToString(iPen),GetLocalInt(oModule,sPlanet+sArea+"Pen"+IntToString(iPen))-1);
 }
////////////////////////////////////////////////////////////////////////////////
// First
int a = 4;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
////////////////////////////////////////////////////////////////////////////////
// Destroy body of undead spectre and fogs
if((GetResRef(OBJECT_SELF)=="nw_allip")||(GetResRef(OBJECT_SELF)=="nw_spectre")||(GetResRef(OBJECT_SELF)=="nw_wraith")||(GetResRef(OBJECT_SELF)=="nw_vampire_shad")||(GetResRef(OBJECT_SELF)=="nw_shadow")||(GetResRef(OBJECT_SELF)=="nw_shfiend")||(GetResRef(OBJECT_SELF)=="mn_spectrebelker")||(GetResRef(OBJECT_SELF)=="mn_visage001")||(GetResRef(OBJECT_SELF)=="mn_shadow")||(GetResRef(OBJECT_SELF)=="mn_shadfiend")||(GetResRef(OBJECT_SELF)=="mn_energy001")||(GetResRef(OBJECT_SELF)=="mn_energy002")||(GetResRef(OBJECT_SELF)=="mn_fog")||(GetResRef(OBJECT_SELF)=="mn_fog03")||(GetResRef(OBJECT_SELF)=="mn_fog02")||(GetStringLeft(GetResRef(OBJECT_SELF),10)=="mn_golpart")){SetImmortal(OBJECT_SELF,FALSE);SetPlotFlag(OBJECT_SELF,FALSE);SetIsDestroyable(TRUE,FALSE,FALSE);DestroyObject(OBJECT_SELF);}
////////////////////////////////////////////////////////////////////////////////
// Destroy creature items
while(GetIsObjectValid(oItem)){if((GetBaseItemType(oItem)==BASE_ITEM_CBLUDGWEAPON)||(GetBaseItemType(oItem)==BASE_ITEM_CPIERCWEAPON)||(GetBaseItemType(oItem)==BASE_ITEM_CREATUREITEM)||(GetBaseItemType(oItem)==BASE_ITEM_CSLASHWEAPON)||(GetBaseItemType(oItem)==BASE_ITEM_CSLSHPRCWEAP)){DestroyObject(oItem);}oItem = GetNextItemInInventory(OBJECT_SELF);}
////////////////////////////////////////////////////////////////////////////////
// Remove summoneds
object oFamiliar1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,OBJECT_SELF);
object oFamiliar2 = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,OBJECT_SELF);
object oFamiliar3 = GetAssociate(ASSOCIATE_TYPE_SUMMONED,OBJECT_SELF);
object oFamiliar4 = GetAssociate(ASSOCIATE_TYPE_DOMINATED,OBJECT_SELF);

if(GetIsObjectValid(oFamiliar1)){RemoveSummonedAssociate(oPC,oFamiliar1);AssignCommand(oFamiliar1,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar1,FALSE);DestroyObject(oFamiliar1);}
if(GetIsObjectValid(oFamiliar2)){RemoveSummonedAssociate(oPC,oFamiliar2);AssignCommand(oFamiliar2,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar2,FALSE);DestroyObject(oFamiliar2);}
if(GetIsObjectValid(oFamiliar3)){RemoveSummonedAssociate(oPC,oFamiliar3);AssignCommand(oFamiliar3,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar3,FALSE);DestroyObject(oFamiliar3);}
if(GetIsObjectValid(oFamiliar4)){RemoveSummonedAssociate(oPC,oFamiliar4);AssignCommand(oFamiliar4,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar4,FALSE);DestroyObject(oFamiliar4);}
////////////////////////////////////////////////////////////////////////////////
}
