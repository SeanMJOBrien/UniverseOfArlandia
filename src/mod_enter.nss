#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetEnteringObject();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iAppOrig = GetLocalInt(oGoldbag,"AppOrig");
int iRace = GetLocalInt(oGoldbag,"Race");
string sName = GetName(oPC);
string sPCName = GetPCPlayerName(oPC);
int iPlayers = GetPersistentInt(oModule,"Players");
int iLevel = GetLevelByPosition(1,oPC)+GetLevelByPosition(2,oPC)+GetLevelByPosition(3,oPC);
object oItems = GetFirstItemInInventory(oPC);
object oItem;int n;
////////////////////////////////////////////////////////////////////////////////
// Dms
if(GetIsDM(oPC))
 {
// Common items
if(GetItemPossessedBy(oPC,"goldbag")==OBJECT_INVALID){CreateItemOnObject("goldbag",oPC);TakeGoldFromCreature(GetGold(oPC),oPC);GiveGoldToCreature(oPC,1000000);}
if(GetItemPossessedBy(oPC,"dmtool")==OBJECT_INVALID){CreateItemOnObject("dmtool",oPC);}
if(GetItemPossessedBy(oPC,"dmfi_onering")==OBJECT_INVALID){CreateItemOnObject("dmfi_onering",oPC);}
// Maximum grades & talents
SetLocalInt(oGoldbag,"Cartographer",5);
SetLocalInt(oGoldbag,"Clone",5);
SetLocalInt(oGoldbag,"Horse Horde",5);
SetLocalInt(oGoldbag,"Leader",5);
SetLocalInt(oGoldbag,"Item Sensor",5);
SetLocalInt(oGoldbag,"Grade",5);
SetLocalInt(oGoldbag,"Super Power",5);
// UOA Rules
AddJournalQuestEntry("UOA Rules",1,oPC,FALSE,FALSE,FALSE);
AddJournalQuestEntry("Missions",1,oPC,FALSE,FALSE,FALSE);
// No Firest
int b;while(b<iUOAreferences){b++;SetLocalInt(oGoldbag,"Uoabook"+IntToString(b),1);}
 }
////////////////////////////////////////////////////////////////////////////////
// PCs
else if(!GetIsDM(oPC))
 {
if(GetItemPossessedBy(oPC,"goldbag")==OBJECT_INVALID)
  {
// Destroy game items
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_ARMS,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BELT,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CHEST,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_HEAD,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_NECK,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC)));
AssignCommand(oPC,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC)));
while(GetIsObjectValid(oItems)){DestroyObject(oItems);oItems = GetNextItemInInventory(oPC);}
// Common items
CreateItemOnObject("goldbag",oPC);TakeGoldFromCreature(GetGold(oPC),oPC);GiveGoldToCreature(oPC,200);
CreateItemOnObject("dmfi_pc_follow",oPC);
CreateItemOnObject("dmfi_pc_dicebag",oPC);
CreateItemOnObject("dmfi_pc_emote",oPC);
CreateItemOnObject("help",oPC);
CreateItemOnObject("cr_apple",oPC);
CreateItemOnObject("cr_bag",oPC);
CreateItemOnObject("bedroll",oPC);
CreateItemOnObject("cr_firelit",oPC);CreateItemOnObject("cr_firelit",oPC);
CreateItemOnObject("cr_food",oPC);CreateItemOnObject("cr_food",oPC);CreateItemOnObject("cr_food",oPC);CreateItemOnObject("cr_food",oPC);
CreateItemOnObject("tool_gauntlet",oPC);
CreateItemOnObject("nw_it_medkit001",oPC,3);
CreateItemOnObject("nw_it_torch001",oPC);
CreateItemOnObject("nw_it_mpotion001",oPC,4);
CreateItemOnObject("nw_wambu001",oPC,99);
CreateItemOnObject("nw_wbwsl001",oPC);
CreateItemOnObject("nw_wswdg001",oPC);
CreateItemOnObject("nw_wblcl001",oPC);
// Races items
if((GetRacialType(oPC)==RACIAL_TYPE_ELF)||(GetRacialType(oPC)==RACIAL_TYPE_HALFELF)){CreateItemOnObject("hlslang_1",oPC);}
if(GetRacialType(oPC)==RACIAL_TYPE_GNOME){CreateItemOnObject("hlslang_2",oPC);}
if(GetRacialType(oPC)==RACIAL_TYPE_HALFLING){CreateItemOnObject("hlslang_3",oPC);}
if(GetRacialType(oPC)==RACIAL_TYPE_DWARF){CreateItemOnObject("hlslang_4",oPC);}
if(GetRacialType(oPC)==RACIAL_TYPE_HALFORC){CreateItemOnObject("hlslang_5",oPC);}
// Class items
     if(GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)>=1){CreateItemOnObject("nw_waxbt001",oPC);oItem = CreateItemOnObject("nw_cloth024",oPC);AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));CreateItemOnObject("nw_aarcl002",oPC);}
else if(GetLevelByClass(CLASS_TYPE_BARD,oPC)>=1){CreateItemOnObject("nw_wblml001",oPC);oItem = CreateItemOnObject("nw_cloth024",oPC);AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));CreateItemOnObject("nw_aarcl001",oPC);}
else if(GetLevelByClass(CLASS_TYPE_CLERIC,oPC)>=1){CreateItemOnObject("nw_wblml001",oPC);oItem = CreateItemOnObject("x2_cloth008",oPC);AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));CreateItemOnObject("nw_aarcl001",oPC);}
else if(GetLevelByClass(CLASS_TYPE_DRUID,oPC)>=1){CreateItemOnObject("nw_wspsc001",oPC);oItem = CreateItemOnObject("nw_cloth012",oPC);AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));CreateItemOnObject("nw_wamar001",oPC,99);}
else if(GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)>=1){CreateItemOnObject("nw_wswss001",oPC);oItem = CreateItemOnObject("nw_cloth024",oPC);AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));CreateItemOnObject("nw_aarcl002",oPC);}
else if(GetLevelByClass(CLASS_TYPE_MONK,oPC)>=1){CreateItemOnObject("nw_wbwsh001",oPC);oItem = CreateItemOnObject("nw_cloth016",oPC);AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));CreateItemOnObject("nw_cloth007",oPC);}
else if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC)>=1){CreateItemOnObject("nw_wswss001",oPC);oItem = CreateItemOnObject("nw_cloth024",oPC);AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));CreateItemOnObject("nw_aarcl012",oPC);}
else if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>=1){CreateItemOnObject("nw_wbwln001",oPC);oItem = CreateItemOnObject("nw_cloth024",oPC);AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));CreateItemOnObject("nw_aarcl001",oPC);CreateItemOnObject("nw_wamar001",oPC,99);}
else if(GetLevelByClass(CLASS_TYPE_ROGUE,oPC)>=1){CreateItemOnObject("nw_wswss001",oPC);oItem = CreateItemOnObject("nw_cloth004",oPC);AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));CreateItemOnObject("nw_aarcl001",oPC);}
else if(GetLevelByClass(CLASS_TYPE_SORCERER,oPC)>=1){CreateItemOnObject("nw_wmgwn004",oPC);oItem = CreateItemOnObject("nw_cloth008",oPC);AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));}
else if(GetLevelByClass(CLASS_TYPE_WIZARD,oPC)>=1){CreateItemOnObject("nw_wmgwn004",oPC);oItem = CreateItemOnObject("nw_cloth005",oPC);AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));}
  }
// Racial special
     if((iRace==2) &&(iLevel>=20)&&(GetAppearanceType(oPC)!=APPEARANCE_TYPE_BUGBEAR_CHIEFTAIN_A)){SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_BUGBEAR_CHIEFTAIN_A);}
else if((iRace==3) &&(iLevel>=20)&&(GetAppearanceType(oPC)!=APPEARANCE_TYPE_DROW_WARRIOR_1)){SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_DROW_WARRIOR_1);}
else if((iRace==5) &&(iLevel>=20)&&(GetAppearanceType(oPC)!=APPEARANCE_TYPE_GOBLIN_CHIEF_A)){SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_GOBLIN_CHIEF_A);}
else if((iRace==8) &&(iLevel>=20)&&(GetAppearanceType(oPC)!=APPEARANCE_TYPE_KOBOLD_CHIEF_A)){SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_KOBOLD_CHIEF_A);}
else if((iRace==9) &&(iLevel>=20)&&(GetAppearanceType(oPC)!=APPEARANCE_TYPE_LIZARDFOLK_WARRIOR_A)){SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_LIZARDFOLK_WARRIOR_A);}
else if((iRace==10)&&(iLevel>=20)&&(GetAppearanceType(oPC)!=APPEARANCE_TYPE_MINOTAUR_SHAMAN)){SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_MINOTAUR_SHAMAN);}
else if((iRace==11)&&(iLevel>=20)&&(GetAppearanceType(oPC)!=APPEARANCE_TYPE_OGRE_CHIEFTAIN)){SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_OGRE_CHIEFTAIN);}
else if((iRace==12)&&(iLevel>=20)&&(GetAppearanceType(oPC)!=APPEARANCE_TYPE_ORC_CHIEFTAIN_A)){SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_ORC_CHIEFTAIN_A);}
else if((iRace==13)&&(iLevel>=20)&&(GetAppearanceType(oPC)!=APPEARANCE_TYPE_TROLL_CHIEFTAIN)){SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_TROLL_CHIEFTAIN);}
else if((iRace==14)||(iRace==15)){SetCreatureAppearanceType(oPC,iAppOrig-1);}
// Forbid spell continual flame & darkfire
n=20;while(n>0){DecrementRemainingSpellUses(oPC,SPELL_CONTINUAL_FLAME);n--;}
n=20;while(n>0){DecrementRemainingSpellUses(oPC,SPELL_DARKFIRE);n--;}
n=20;while(n>0){DecrementRemainingSpellUses(oPC,SPELL_FLAME_WEAPON);n--;}
n=2; while(n>0){DecrementRemainingFeatUses(oPC,FEAT_PALADIN_SUMMON_MOUNT);n--;}
// Automatic talents for classes
if((GetLevelByClass(CLASS_TYPE_RANGER,oPC)>0)&&(GetLocalInt(oGoldbag,"Cartographer")==0)){SetLocalInt(oGoldbag,"Cartographer",1);}
if((GetLevelByClass(CLASS_TYPE_RANGER,oPC)>0)&&(GetLocalInt(oGoldbag,"Leader")==0)){SetLocalInt(oGoldbag,"Leader",1);}
// Paladin horse power
if((GetLevelByClass(CLASS_TYPE_PALADIN,oPC)>=5)&&(GetItemPossessedBy(oPC,"mountitem")==OBJECT_INVALID)){CreateItemOnObject("mountitem",oPC);}
// Henchs
if(GetLocalInt(oGoldbag,"Grade")<1){SetLocalInt(oGoldbag,"Grade",1);}
ExecuteScript("henchs",oPC);
// Misc
if((GetAppearanceType(oPC)!=GetLocalInt(oGoldbag,"OrigApp")-1)&&(GetLocalInt(oGoldbag,"OrigApp")!=0)){SetCreatureAppearanceType(oPC,GetLocalInt(oGoldbag,"OrigApp")-1);}if(GetPhenoType(oPC)>4){SetPhenoType(GetLocalInt(oGoldbag,"Phenotype"),oPC);SetFootstepType(FOOTSTEP_TYPE_DEFAULT,oPC);}
if(GetLocalInt(oPC,"PhenoBig")==1){SetPhenoType(PHENOTYPE_NORMAL,oPC);DeleteLocalInt(oPC,"PhenoBig");}
// Levels
if(GetXP(oPC)<3000){SetXP(oPC,3000);}
// UOA Rules
AddJournalQuestEntry("UOA Rules",2,oPC,FALSE,FALSE,FALSE);
AddJournalQuestEntry("Missions",1,oPC,FALSE,FALSE,FALSE);
 }
////////////////////////////////////////////////////////////////////////////////
// All
if(GetItemPossessedBy(oPC,"analyser")==OBJECT_INVALID){CreateItemOnObject("analyser",oPC);}
if(GetItemPossessedBy(oPC,"uoabook")==OBJECT_INVALID){CreateItemOnObject("uoabook",oPC);}
if(GetIsObjectValid(GetItemPossessedBy(oPC,"clones"))){DeleteLocalInt(GetItemPossessedBy(oPC,"clones"),"Uses");}
// Set PC enter
SetLocalInt(oPC,"Entered",1);
SetLocalInt(oPC,"Entering",1);
// Delete variables from former connects
DeleteLocalInt(oPC,"Flying");
DeleteLocalInt(oPC,"TransArrival");
DeleteLocalInt(oPC,"TransMess1");DeleteLocalInt(oPC,"TransMess2");DeleteLocalInt(oPC,"TransMess3");DeleteLocalInt(oPC,"TransMess4");
DeleteLocalObject(oPC,"DestroyIt");
////////////////////////////////////////////////////////////////////////////////
// Website
if(GetLocalInt(oModule,sName)==0){iPlayers++;SetLocalInt(oModule,sName,iPlayers);SetPersistentInt(oModule,"Players",iPlayers);}
////////////////////////////////////////////////////////////////////////////////
}
