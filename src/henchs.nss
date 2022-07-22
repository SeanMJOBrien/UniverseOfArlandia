#include "aps_include"
#include "zep_inc_phenos"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = OBJECT_SELF;
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sPCName = GetName(oPC);
object oArea = GetArea(oPC);
string sAreaTag = GetTag(oArea);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
//
object oHench = GetLocalObject(oPC,"Hench");
float fX = GetPosition(oHench).x;
float fY = GetPosition(oHench).y;
int iHench = GetLocalInt(oHench,"HenchNum");
int iHenchAction = GetLocalInt(oPC,"HenchAction");
int iNum = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&"+"&SoldierN");
int iSoldierNum = GetLocalInt(oHench,"SoldierNum");
string sMaster = GetLocalString(oHench,"Master");
//
int iHenchs;string sHench;string sBP;string sTag;string sName;string sStayHench;object oItem;object oNew;object oHenchs;int iNewPheno;int iHencheHorde;location lLoc;int iAppearance;int iClass;int iLevel;int iHead;int iSlot;int iLevels;
string sItemBP;string sItemTag;string sItemName;string sItemStack;string sItemMaster;string sItemWear;string sItemWear2;string sItemFix;string sItemVar;string sItemBonus;string sItemCharges;string sAll;string sVar;string sCount;string sCount1;string sCount2;int iVar;string sHenchPlanet;string sHenchArea;int iMission;string sMission;int iType;int iMissionSuccess;int i;
////////////////////////////////////////////////////////////////////////////////
if(sAreaTag==""){DelayCommand(3.0,ExecuteScript("henchs",oPC));}else if(GetStringLeft(sAreaTag,5)!="space"){
////////////////////////////////////////////////////////////////////////////////
// Henchs recall when entering the server
if(iHenchAction==0)
 {
// Familiars
string sFamiliar1 = GetLocalString(oGoldbag,"Familiar1");
string sFamiliar2 = GetLocalString(oGoldbag,"Familiar2");
string sFamiliar3 = GetLocalString(oGoldbag,"Familiar3");
string sFamiliar4 = GetLocalString(oGoldbag,"Familiar4");

if(sFamiliar1!=""){SummonAnimalCompanion(oPC);}
if(sFamiliar2!=""){SummonFamiliar(oPC);}
if(sFamiliar3!=""){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectSummonCreature(sFamiliar3),GetLocation(oPC));}
if(sFamiliar4!=""){object oFamiliar = CreateObject(OBJECT_TYPE_CREATURE,sFamiliar4,GetLocation(oPC));ChangeToStandardFaction(oFamiliar,STANDARD_FACTION_COMMONER);SetLocalInt(oFamiliar,"Hench",1);SetLocalInt(oFamiliar,"DontSave",1);SetLocalString(oFamiliar,"Master",sPCName);SetLocalObject(oPC,"Familiar4",oFamiliar);AddHenchman(oPC,oFamiliar);}

// Normal henchs
while(iHenchs<iMaxHenchs)
  {
iHenchs++;
sStayHench = GetLocalString(oGoldbag,IntToString(iHenchs)+"StayHench");
sHench = GetLocalString(oGoldbag,IntToString(iHenchs)+"Hench");
sBP = GetStringLeft(sHench,FindSubString(sHench,"&A&"));
sName = GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"&B&")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"&B&")))-FindSubString(sHench,"&A&")-3);
iAppearance = StringToInt(GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"&C&")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"&C&")))-FindSubString(sHench,"&B&")-3));
iLevel = StringToInt(GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"&D&")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"&D&")))-FindSubString(sHench,"&C&")-3));
iClass = StringToInt(GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"&E&")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"&E&")))-FindSubString(sHench,"&D&")-3));
iHead = StringToInt(GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"&F&")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"&F&")))-FindSubString(sHench,"&E&")-3));

if((sHench!="")&&(sStayHench=="")&&(GetLocalInt(oGoldbag,"HorseNum")!=iHenchs)&&(GetLocalInt(oPC,"FalconAway"+IntToString(iHenchs))!=1))
   {
oHench = CreateObject(OBJECT_TYPE_CREATURE,sBP,GetLocation(oPC));
if(GetName(oHench)!=sName){SetName(oHench,sName);}
DeleteLocalObject(oPC,"HenchObject"+IntToString(iHenchs));
SetLocalInt(oHench,"Hench",1);
SetLocalInt(oHench,"HenchNum",iHenchs);
SetLocalString(oHench,"Master",sPCName);
SetLocalInt(oHench,"Race",iAppearance);
SetLocalInt(oHench,"Level",iLevel);
SetLocalInt(oHench,"Class",iClass);
SetLocalInt(oHench,"Head",iHead);
ChangeToStandardFaction(oHench,STANDARD_FACTION_COMMONER);
AddHenchman(oPC,oHench);

if(sBP=="henchani009"){SetLocalObject(oPC,"Hench",oHench);SetLocalInt(oPC,"HenchAction",7);ExecuteScript("henchs",oPC);}
if(sBP=="hench000"){SetLocalObject(oPC,"Hench",oHench);SetLocalInt(oPC,"HenchAction",14);ExecuteScript("henchs",oPC);}
   }
  }
// Mission henchs
int iMission = GetLocalInt(oGoldbag,"Missions");

while(iMission>0)
  {
sMission = GetLocalString(oGoldbag,"Mission"+IntToString(iMission));
iType = StringToInt(GetStringLeft(sMission,FindSubString(sMission,"&001&")));
sBP = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&005&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&005&")))-FindSubString(sMission,"&004&")-5);
sTag = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&006&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&006&")))-FindSubString(sMission,"&005&")-5);

if((iType>=31)&&(iType<=40))
   {
iMissionSuccess = GetLocalInt(oGoldbag,"MissionSuccess"+IntToString(iMission));

if(iMissionSuccess==1)
    {
oHench = CreateObject(OBJECT_TYPE_CREATURE,sBP,GetLocation(oPC),FALSE,sTag);
DelayCommand(0.5,SetName(oHench,GetName(oHench)+"*"));
SetLocalInt(oHench,"Mission",iMission);
SetLocalString(oHench,"Var",sMission);
SetLocalString(oHench,"Master",GetName(oPC));
SetLocalString(oHench,"Tag","mission");
SetLocalInt(oHench,"Hench",1);
SetLocalInt(oHench,"DontSave",1);
SetLocalObject(oHench,"PC",oPC);
ChangeToStandardFaction(oHench,STANDARD_FACTION_COMMONER);
AddHenchman(oPC,oHench);
    }
   }
iMission--;
  }
//
 }
////////////////////////////////////////////////////////////////////////////////
// Henchs hiring
else if(iHenchAction==1)
 {
while(i<iMaxHenchs){i++;sHench = GetLocalString(oGoldbag,IntToString(i)+"Hench");if(sHench==""){break;}}

SetLocalString(oGoldbag,IntToString(i)+"Hench",GetResRef(oHench)+"&A&"+GetName(oHench)+"&B&"+IntToString(GetLocalInt(oHench,"Race"))+"&C&"+IntToString(GetLocalInt(oHench,"Level"))+"&D&"+IntToString(GetLocalInt(oHench,"Class"))+"&E&"+IntToString(GetLocalInt(oHench,"Head"))+"&F&");
DeleteLocalObject(oPC,"HenchObject"+IntToString(i));
SetLocalInt(oHench,"Hench",1);
SetLocalInt(oHench,"HenchNum",i);
SetLocalString(oHench,"Master",sPCName);
ChangeToStandardFaction(oHench,STANDARD_FACTION_COMMONER);
AddHenchman(oPC,oHench);
SendMessageToPC(oPC,"Note : To dismiss a hench, don't use the 'Remove from party' option of the radial menu. Use the 'Dismiss' option from the hench dialog.");
if((GetResRef(oHench)=="hench000")&&(sMaster!=""))
  {
while(iSoldierNum<iNum)
   {
SetPersistentString(oModule,sPlanet+"&"+sArea+"&Soldier"+IntToString(iSoldierNum),GetPersistentString(oModule,sPlanet+"&"+sArea+"&Soldier"+IntToString(iSoldierNum+1)));
SetLocalInt(GetLocalObject(oArea,"Guard"+IntToString(iSoldierNum+1)),"SoldierNum",iSoldierNum);
iSoldierNum++;
   }
DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&Soldier"+IntToString(iSoldierNum));
if((iSoldierNum-1)==0){DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&"+"&SoldierN");}else{SetPersistentInt(oModule,sPlanet+"&"+sArea+"&"+"&SoldierN",iSoldierNum-1);}
SetLocalObject(oPC,"Hench",oHench);SetLocalInt(oPC,"HenchAction",13);ExecuteScript("henchs",oPC);
  }
// First
int a = 10;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
//
 }
////////////////////////////////////////////////////////////////////////////////
// Henchs Death/Dismiss
else if((iHenchAction==2)&&(!GetIsDead(oPC)))
 {
// Remove hench
DeleteLocalString(oGoldbag,IntToString(iHench)+"Hench");
DeleteLocalString(oGoldbag,"Ox"+IntToString(iHench));
DeleteLocalString(oGoldbag,"HenchCasernSlots"+IntToString(iHench));
DeleteLocalString(oGoldbag,"HenchCasernInv"+IntToString(iHench));
ChangeToStandardFaction(oHench,STANDARD_FACTION_MERCHANT);
DeleteLocalObject(oPC,"HenchObject"+IntToString(iHench));
DeleteLocalInt(oPC,"FalconAway"+IntToString(iHench));
SetLocalInt(oHench,"Hench",1);
DeleteLocalInt(oHench,"DontSave");
DeleteLocalInt(oHench,"HenchNum");
DeleteLocalString(oHench,"Master");
RemoveHenchman(oPC,oHench);
AssignCommand(oHench,ClearAllActions());

if(GetLocalString(oGoldbag,"Familiar4")==GetResRef(oHench)){DeleteLocalString(oGoldbag,"Familiar4");}
if((GetTag(oHench)=="henchani009")&&(GetCurrentHitPoints(oHench)<1)){SetLocalInt(oHench,"HenchRecall",1);oItem = GetFirstItemInInventory(oHench);while(GetIsObjectValid(oItem)){oNew = CopyObject(oItem,GetLocation(oHench));SetLocalInt(oNew,"Persistent",1);SetLocalString(oNew,"Master",GetLocalString(oItem,"Master"));SetLocalInt(oNew,"Wear",GetLocalInt(oItem,"Wear"));SetLocalString(oNew,"Var",GetLocalString(oItem,"Var"));SetLocalString(oNew,"Bonus",GetLocalString(oItem,"Bonus"));SetLocalInt(oNew,"Wear",GetLocalInt(oItem,"Wear"));DestroyObject(oItem);oItem = GetNextItemInInventory(oHench);}}
if((GetTag(oHench)=="hench000")&&(GetCurrentHitPoints(oHench)<1))
 {
SetLocalInt(oHench,"HenchRecall",1);
while(i<18)
  {
i++;
if(i==1) {iSlot = INVENTORY_SLOT_ARMS;}
if(i==2) {iSlot = INVENTORY_SLOT_ARROWS;}
if(i==3) {iSlot = INVENTORY_SLOT_BELT;}
if(i==4) {iSlot = INVENTORY_SLOT_BOLTS;}
if(i==5) {iSlot = INVENTORY_SLOT_BOOTS;}
if(i==6) {iSlot = INVENTORY_SLOT_BULLETS;}
if(i==7) {iSlot = INVENTORY_SLOT_CARMOUR;}
if(i==8) {iSlot = INVENTORY_SLOT_CHEST;}
if(i==9) {iSlot = INVENTORY_SLOT_CLOAK;}
if(i==10){iSlot = INVENTORY_SLOT_CWEAPON_B;}
if(i==11){iSlot = INVENTORY_SLOT_CWEAPON_L;}
if(i==12){iSlot = INVENTORY_SLOT_CWEAPON_R;}
if(i==13){iSlot = INVENTORY_SLOT_HEAD;}
if(i==14){iSlot = INVENTORY_SLOT_LEFTHAND;}
if(i==15){iSlot = INVENTORY_SLOT_LEFTRING;}
if(i==16){iSlot = INVENTORY_SLOT_NECK;}
if(i==17){iSlot = INVENTORY_SLOT_RIGHTHAND;}
if(i==18){iSlot = INVENTORY_SLOT_RIGHTRING;}

oItem = GetItemInSlot(iSlot,oHench);oNew = CopyObject(oItem,GetLocation(oHench));SetLocalInt(oNew,"Persistent",1);SetLocalString(oNew,"Master",GetLocalString(oItem,"Master"));SetLocalInt(oNew,"Wear",GetLocalInt(oItem,"Wear"));SetLocalString(oNew,"Var",GetLocalString(oItem,"Var"));SetLocalString(oNew,"Bonus",GetLocalString(oItem,"Bonus"));SetLocalInt(oNew,"Wear",GetLocalInt(oItem,"Wear"));DestroyObject(oItem);
  }
oItem = GetFirstItemInInventory(oHench);while(GetIsObjectValid(oItem)){oNew = CopyObject(oItem,GetLocation(oHench));SetLocalInt(oNew,"Persistent",1);SetLocalString(oNew,"Master",GetLocalString(oItem,"Master"));SetLocalInt(oNew,"Wear",GetLocalInt(oItem,"Wear"));SetLocalString(oNew,"Var",GetLocalString(oItem,"Var"));SetLocalString(oNew,"Bonus",GetLocalString(oItem,"Bonus"));SetLocalInt(oNew,"Wear",GetLocalInt(oItem,"Wear"));DestroyObject(oItem);oItem = GetNextItemInInventory(oHench);}}
if(GetLocalInt(oHench,"Clone")==1){lLoc = GetLocation(oHench);ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_UNSUMMON),lLoc);SetImmortal(oHench,FALSE);SetPlotFlag(oHench,FALSE);AssignCommand(oHench,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oHench);}
//
 }
////////////////////////////////////////////////////////////////////////////////
// Henchs Stay here
else if(iHenchAction==3)
 {
if(GetLocalString(oGoldbag,"Familiar4")==GetResRef(oHench)){DeleteLocalString(oGoldbag,"Familiar4");}
else
 {
SetLocalString(oGoldbag,IntToString(iHench)+"StayHench",sPlanet+"&A&"+sArea+"&B&"+IntToString(FloatToInt(fX))+"&C&"+IntToString(FloatToInt(fY))+"&D&");
SetLocalObject(oPC,"HenchObject"+IntToString(iHench),oHench);
SetLocalInt(oHench,"Hench",1);
SetLocalInt(oHench,"DontSave",1);
 }
ChangeToStandardFaction(oHench,STANDARD_FACTION_MERCHANT);
RemoveHenchman(oPC,oHench);
AssignCommand(oHench,ClearAllActions());
//
 }
////////////////////////////////////////////////////////////////////////////////
// Henchs Follow
else if(iHenchAction==4)
 {
DeleteLocalString(oGoldbag,IntToString(iHench)+"StayHench");
DeleteLocalObject(oPC,"HenchObject"+IntToString(iHench));
SetLocalInt(oHench,"Hench",1);
DeleteLocalInt(oHench,"DontSave");
ChangeToStandardFaction(oHench,STANDARD_FACTION_COMMONER);
AddHenchman(oPC,oHench);
//
 }
////////////////////////////////////////////////////////////////////////////////
// Henchs area recall
else if(iHenchAction==5)
 {
while(iHenchs<iMaxHenchs)
  {
iHenchs++;
sStayHench = GetLocalString(oGoldbag,IntToString(iHenchs)+"StayHench");
sHenchPlanet = GetStringLeft(sStayHench,FindSubString(sStayHench,"&A&"));
sHenchArea = GetStringRight(GetStringLeft(sStayHench,FindSubString(sStayHench,"&B&")),GetStringLength(GetStringLeft(sStayHench,FindSubString(sStayHench,"&B&")))-FindSubString(sStayHench,"&A&")-3);

if((sStayHench!="")&&(sHenchPlanet==sPlanet)&&(sHenchArea==sArea))
   {
sHench = GetLocalString(oGoldbag,IntToString(iHenchs)+"Hench");
sBP = GetStringLeft(sHench,FindSubString(sHench,"&A&"));
sName = GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"&B&")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"&B&")))-FindSubString(sHench,"&A&")-3);
iAppearance = StringToInt(GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"&C&")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"&C&")))-FindSubString(sHench,"&B&")-3));
iLevel = StringToInt(GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"&D&")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"&D&")))-FindSubString(sHench,"&C&")-3));
iClass = StringToInt(GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"&E&")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"&E&")))-FindSubString(sHench,"&D&")-3));
iHead = StringToInt(GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"&F&")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"&F&")))-FindSubString(sHench,"&E&")-3));
fX = StringToFloat(GetStringRight(GetStringLeft(sStayHench,FindSubString(sStayHench,"&C&")),GetStringLength(GetStringLeft(sStayHench,FindSubString(sStayHench,"&C&")))-FindSubString(sStayHench,"&B&")-3));
fY = StringToFloat(GetStringRight(GetStringLeft(sStayHench,FindSubString(sStayHench,"&D&")),GetStringLength(GetStringLeft(sStayHench,FindSubString(sStayHench,"&D&")))-FindSubString(sStayHench,"&C&")-3));

oHench = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(oArea,Vector(fX,fY,0.0),DIRECTION_NORTH));
if(GetName(oHench)!=sName){SetName(oHench,sName);}
ChangeToStandardFaction(oHench,STANDARD_FACTION_MERCHANT);
SetLocalObject(oPC,"HenchObject"+IntToString(iHenchs),oHench);
SetLocalInt(oHench,"Hench",1);
SetLocalInt(oHench,"DontSave",1);
SetLocalInt(oHench,"HenchNum",iHenchs);
SetLocalString(oHench,"Master",sPCName);
SetLocalInt(oHench,"Race",iAppearance);
SetLocalInt(oHench,"Level",iLevel);
SetLocalInt(oHench,"Class",iClass);
SetLocalInt(oHench,"Head",iHead);

if(sBP=="henchani009"){SetLocalObject(oPC,"Hench",oHench);SetLocalInt(oPC,"HenchAction",7);ExecuteScript("henchs",oPC);}
if(sBP=="hench000"){SetLocalObject(oPC,"Hench",oHench);SetLocalInt(oPC,"HenchAction",14);ExecuteScript("henchs",oPC);}
   }
  }
//
 }
////////////////////////////////////////////////////////////////////////////////
// Ox save
else if(iHenchAction==6)
 {
oItem = GetFirstItemInInventory(oHench);
while(GetIsObjectValid(oItem))
  {
sItemBP = GetResRef(oItem);
sItemTag = GetTag(oItem);
sItemName = GetName(oItem);
sItemStack = IntToString(GetItemStackSize(oItem));
sItemMaster = GetLocalString(oItem,"Master");
sItemWear = IntToString(GetLocalInt(oItem,"Wear"));
sItemWear2 = IntToString(GetLocalInt(oItem,"Wear%"));
sItemFix = IntToString(GetLocalInt(oItem,"Fix"));
sItemCharges = IntToString(GetItemCharges(oItem));
sItemVar = GetLocalString(oItem,"Var");
sItemBonus = GetLocalString(oItem,"Bonus");
sAll = sItemBP+"_A_"+sItemTag+"_B_"+sItemName+"_C_"+sItemStack+"_D_"+sItemMaster+"_E_"+sItemWear+"_F_"+sItemWear2+"_G_"+sItemFix+"_H_"+sItemCharges+"_I_"+sItemVar+"_J_"+sItemBonus+"_K_";

i++;
sCount = IntToString(i);if(i<10){sCount = "00"+IntToString(i);}else if(i<100){sCount = "0"+IntToString(i);}sCount = "&"+sCount+"&";
sVar = sVar+sAll+sCount;

SetDroppableFlag(oItem,TRUE);
oItem = GetNextItemInInventory(oHench);
  }
SetLocalString(oGoldbag,"Ox"+IntToString(iHench),sVar);
 }
////////////////////////////////////////////////////////////////////////////////
// Ox recall
else if(iHenchAction==7)
 {
SetLocalInt(oHench,"HenchRecall",1);
sVar = GetLocalString(oGoldbag,"Ox"+IntToString(iHench));
iVar = StringToInt(GetStringLeft(GetStringRight(sVar,4),3));

while(i<iVar)
  {
i++;
sCount1 = IntToString(i);if(i<10){sCount1 = "00"+IntToString(i);}else if(i<100){sCount1 = "0"+IntToString(i);}
sCount2 = IntToString(i-1);if((i-1)<10){sCount2 = "00"+IntToString(i-1);}else if((i-1)<100){sCount2 = "0"+IntToString(i-1);}

if(i==1){sAll = GetStringLeft(sVar,FindSubString(sVar,"&"+sCount1+"&"));}else{sAll = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"&"+sCount1+"&")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"&"+sCount1+"&")))-FindSubString(sVar,"&"+sCount2+"&")-5);}
sItemBP = GetStringLeft(sAll,FindSubString(sAll,"_A_"));
sItemTag = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_B_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_B_")))-FindSubString(sAll,"_A_")-3);
sItemName = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_C_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_C_")))-FindSubString(sAll,"_B_")-3);
sItemStack = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_D_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_D_")))-FindSubString(sAll,"_C_")-3);
sItemMaster = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_E_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_E_")))-FindSubString(sAll,"_D_")-3);
sItemWear = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_F_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_F_")))-FindSubString(sAll,"_E_")-3);
sItemWear2 = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_G_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_G_")))-FindSubString(sAll,"_F_")-3);
sItemFix = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_H_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_H_")))-FindSubString(sAll,"_G_")-3);
sItemCharges = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_I_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_I_")))-FindSubString(sAll,"_H_")-3);
sItemVar = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_J_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_J_")))-FindSubString(sAll,"_I_")-3);
sItemBonus = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_K_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_K_")))-FindSubString(sAll,"_J_")-3);

oItem = CreateItemOnObject(sItemBP,oHench,StringToInt(sItemStack),sItemTag);
if(GetName(oItem)!=sItemName){SetName(oItem,sItemName);}if(FindSubString(sItemName,"(Quality")!=-1){AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyQuality(IP_CONST_QUALITY_EXCELLENT),oItem);}
SetLocalString(oItem,"Master",sItemMaster);
SetLocalInt(oItem,"Wear",StringToInt(sItemWear));
SetLocalInt(oItem,"Wear%",StringToInt(sItemWear2));
SetLocalInt(oItem,"Fix",StringToInt(sItemFix));
SetLocalString(oItem,"Bonus",sItemBonus);if(sItemBonus!=""){ExecuteScript("bonus",oItem);}
SetLocalString(oItem,"Var",sItemVar);
if(StringToInt(sItemCharges)>0){SetItemCharges(oItem,StringToInt(sItemCharges));}
SetIdentified(oItem,TRUE);
SetDroppableFlag(oItem,TRUE);
  }
DelayCommand(0.5,DeleteLocalInt(oHench,"HenchRecall"));
 }
////////////////////////////////////////////////////////////////////////////////
// Mount horse
else if(iHenchAction==8)
 {
int iRaceSpe = GetLocalInt(oGoldbag,"Race");
int iRace = GetRacialType(oPC);
int iPheno = GetPhenoType(oPC);
int iFoot = GetFootstepType(oHench);

     if(GetItemPossessedBy(oPC,"mountitem")==OBJECT_INVALID){FloatingTextStringOnCreature("You need a mount item to mount your horse !",oPC);}
else if(GetIsAreaInterior(GetArea(oPC))){FloatingTextStringOnCreature("You may not mount this animal in an interior !",oPC);}
else if(GetName(GetArea(oPC))=="Swamp"){FloatingTextStringOnCreature("Your animal can not carry you on this kind of land !",oPC);}
else if((GetItemPossessedBy(oPC,"cr_plantcommon")==OBJECT_INVALID)&&(GetLocalInt(oPC,"NoHorsePaladin")==1)){FloatingTextStringOnCreature("You need more common plant to mount this animal !",oPC);}
else
  {
// Paladin horse power
if((GetLevelByClass(CLASS_TYPE_PALADIN,oPC)>=5)&&(GetLocalInt(oPC,"NoHorsePaladin")!=1))
   {
if((iRace==RACIAL_TYPE_HUMAN)||(iRace==RACIAL_TYPE_HALFORC)||(iRace==RACIAL_TYPE_HALFELF)||(iRace==RACIAL_TYPE_ELF))
    {
if(iPheno==PHENOTYPE_BIG){iNewPheno = nCEP_PH_HORSE_WHITE_L;}else{iNewPheno = nCEP_PH_HORSE_WHITE;}if(iRaceSpe==0){SetPhenoType(iNewPheno,oPC);}SetLocalInt(oGoldbag,"NewPheno",iNewPheno);SetFootstepType(5,oPC);
    }
else
    {
if(iPheno==PHENOTYPE_BIG){iNewPheno = nCEP_PH_PONY_LTBROWN_L;}else{iNewPheno = nCEP_PH_PONY_LTBROWN;}if(iRaceSpe==0){SetPhenoType(iNewPheno,oPC);}SetLocalInt(oGoldbag,"NewPheno",iNewPheno);SetFootstepType(5,oPC);
    }
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3),oPC);
SetLocalInt(oGoldbag,"Phenotype",iPheno);
SetLocalString(oGoldbag,"HorseBP","henchani003");
SetLocalInt(oGoldbag,"HorsePaladin",1);
SetLocalInt(oPC,"HenchAction",10);ExecuteScript("henchs",oPC);
   }

// Normal horses
else
   {
if((iRace==RACIAL_TYPE_HUMAN)||(iRace==RACIAL_TYPE_HALFORC)||(iRace==RACIAL_TYPE_HALFELF)||(iRace==RACIAL_TYPE_ELF))
    {
     if(GetResRef(oHench)=="henchani001"){SetLocalString(oGoldbag,"HorseBP",GetResRef(oHench));SetLocalInt(oGoldbag,"HorseNum",iHench);SetLocalInt(oGoldbag,"Phenotype",iPheno);if(iPheno==PHENOTYPE_BIG){iNewPheno = nCEP_PH_HORSE_BROWN_L;}else{iNewPheno = nCEP_PH_HORSE_BROWN;}if(iRaceSpe==0){SetPhenoType(iNewPheno,oPC);}SetLocalInt(oGoldbag,"NewPheno",iNewPheno);SetFootstepType(iFoot,oPC);SetLocalInt(oPC,"HenchAction",10);ExecuteScript("henchs",oPC);DestroyObject(GetItemPossessedBy(oPC,"cr_plantcommon"));FloatingTextStringOnCreature("*Using one common plant to mount*",oPC);AssignCommand(oHench,SetIsDestroyable(TRUE,TRUE,TRUE));DestroyObject(oHench);i++;}
else if(GetResRef(oHench)=="henchani002"){SetLocalString(oGoldbag,"HorseBP",GetResRef(oHench));SetLocalInt(oGoldbag,"HorseNum",iHench);SetLocalInt(oGoldbag,"Phenotype",iPheno);if(iPheno==PHENOTYPE_BIG){iNewPheno = nCEP_PH_HORSE_BLACK_L;}else{iNewPheno = nCEP_PH_HORSE_BLACK;}if(iRaceSpe==0){SetPhenoType(iNewPheno,oPC);}SetLocalInt(oGoldbag,"NewPheno",iNewPheno);SetFootstepType(iFoot,oPC);SetLocalInt(oPC,"HenchAction",10);ExecuteScript("henchs",oPC);DestroyObject(GetItemPossessedBy(oPC,"cr_plantcommon"));FloatingTextStringOnCreature("*Using one common plant to mount*",oPC);AssignCommand(oHench,SetIsDestroyable(TRUE,TRUE,TRUE));DestroyObject(oHench);i++;}
else if(GetResRef(oHench)=="henchani003"){SetLocalString(oGoldbag,"HorseBP",GetResRef(oHench));SetLocalInt(oGoldbag,"HorseNum",iHench);SetLocalInt(oGoldbag,"Phenotype",iPheno);if(iPheno==PHENOTYPE_BIG){iNewPheno = nCEP_PH_HORSE_WHITE_L;}else{iNewPheno = nCEP_PH_HORSE_WHITE;}if(iRaceSpe==0){SetPhenoType(iNewPheno,oPC);}SetLocalInt(oGoldbag,"NewPheno",iNewPheno);SetFootstepType(iFoot,oPC);SetLocalInt(oPC,"HenchAction",10);ExecuteScript("henchs",oPC);DestroyObject(GetItemPossessedBy(oPC,"cr_plantcommon"));FloatingTextStringOnCreature("*Using one common plant to mount*",oPC);AssignCommand(oHench,SetIsDestroyable(TRUE,TRUE,TRUE));DestroyObject(oHench);i++;}
else if(GetResRef(oHench)=="henchani004"){SetLocalString(oGoldbag,"HorseBP",GetResRef(oHench));SetLocalInt(oGoldbag,"HorseNum",iHench);SetLocalInt(oGoldbag,"Phenotype",iPheno);if(iPheno==PHENOTYPE_BIG){iNewPheno = nCEP_PH_HORSE_NIGHTMARE_L;}else{iNewPheno = nCEP_PH_HORSE_NIGHTMARE;}if(iRaceSpe==0){SetPhenoType(iNewPheno,oPC);}SetLocalInt(oGoldbag,"NewPheno",iNewPheno);SetFootstepType(iFoot,oPC);SetLocalInt(oPC,"HenchAction",10);ExecuteScript("henchs",oPC);DestroyObject(GetItemPossessedBy(oPC,"cr_plantcommon"));FloatingTextStringOnCreature("*Using one common plant to mount*",oPC);AssignCommand(oHench,SetIsDestroyable(TRUE,TRUE,TRUE));DestroyObject(oHench);i++;}
else if(GetResRef(oHench)=="henchani005"){SetLocalString(oGoldbag,"HorseBP",GetResRef(oHench));SetLocalInt(oGoldbag,"HorseNum",iHench);SetLocalInt(oGoldbag,"Phenotype",iPheno);if(iPheno==PHENOTYPE_BIG){iNewPheno = nCEP_PH_HORSE_AURENTHIL_L;}else{iNewPheno = nCEP_PH_HORSE_AURENTHIL;}if(iRaceSpe==0){SetPhenoType(iNewPheno,oPC);}SetLocalInt(oGoldbag,"NewPheno",iNewPheno);SetFootstepType(iFoot,oPC);SetLocalInt(oPC,"HenchAction",10);ExecuteScript("henchs",oPC);DestroyObject(GetItemPossessedBy(oPC,"cr_plantcommon"));FloatingTextStringOnCreature("*Using one common plant to mount*",oPC);AssignCommand(oHench,SetIsDestroyable(TRUE,TRUE,TRUE));DestroyObject(oHench);i++;}
else{FloatingTextStringOnCreature("You are too tall to mount this animal !",oPC);}
    }
else
    {
     if(GetResRef(oHench)=="henchani006"){SetLocalString(oGoldbag,"HorseBP",GetResRef(oHench));SetLocalInt(oGoldbag,"HorseNum",iHench);SetLocalInt(oGoldbag,"Phenotype",iPheno);if(iPheno==PHENOTYPE_BIG){iNewPheno = nCEP_PH_PONY_BROWN_L;}else{iNewPheno = nCEP_PH_PONY_BROWN;}if(iRaceSpe==0){SetPhenoType(iNewPheno,oPC);}SetLocalInt(oGoldbag,"NewPheno",iNewPheno);SetFootstepType(iFoot,oPC);SetLocalInt(oPC,"HenchAction",10);ExecuteScript("henchs",oPC);DestroyObject(GetItemPossessedBy(oPC,"cr_plantcommon"));FloatingTextStringOnCreature("*Using one common plant to mount*",oPC);AssignCommand(oHench,SetIsDestroyable(TRUE,TRUE,TRUE));DestroyObject(oHench);i++;}
else if(GetResRef(oHench)=="henchani007"){SetLocalString(oGoldbag,"HorseBP",GetResRef(oHench));SetLocalInt(oGoldbag,"HorseNum",iHench);SetLocalInt(oGoldbag,"Phenotype",iPheno);if(iPheno==PHENOTYPE_BIG){iNewPheno = nCEP_PH_PONY_SPOT;}else{iNewPheno = nCEP_PH_PONY_SPOT;}if(iRaceSpe==0){SetPhenoType(iNewPheno,oPC);}SetLocalInt(oGoldbag,"NewPheno",iNewPheno);SetFootstepType(iFoot,oPC);SetLocalInt(oPC,"HenchAction",10);ExecuteScript("henchs",oPC);DestroyObject(GetItemPossessedBy(oPC,"cr_plantcommon"));FloatingTextStringOnCreature("*Using one common plant to mount*",oPC);AssignCommand(oHench,SetIsDestroyable(TRUE,TRUE,TRUE));DestroyObject(oHench);i++;}
else if(GetResRef(oHench)=="henchani008"){SetLocalString(oGoldbag,"HorseBP",GetResRef(oHench));SetLocalInt(oGoldbag,"HorseNum",iHench);SetLocalInt(oGoldbag,"Phenotype",iPheno);if(iPheno==PHENOTYPE_BIG){iNewPheno = nCEP_PH_PONY_LTBROWN_L;}else{iNewPheno = nCEP_PH_PONY_LTBROWN_L;}if(iRaceSpe==0){SetPhenoType(iNewPheno,oPC);}SetLocalInt(oGoldbag,"NewPheno",iNewPheno);SetFootstepType(iFoot,oPC);SetLocalInt(oPC,"HenchAction",10);ExecuteScript("henchs",oPC);DestroyObject(GetItemPossessedBy(oPC,"cr_plantcommon"));FloatingTextStringOnCreature("*Using one common plant to mount*",oPC);AssignCommand(oHench,SetIsDestroyable(TRUE,TRUE,TRUE));DestroyObject(oHench);i++;}
else{FloatingTextStringOnCreature("You are too small to mount this animal !",oPC);}
    }
   }
// Horse horde talent
if((i>0)&&(GetLocalInt(oGoldbag,"Horse Horde")>0)&&(GetLocalInt(oPC,"Horse Horde Unactivated")==0))
   {
while(i<iMaxHenchs+1)
    {
oHenchs = GetHenchman(oPC,i);
iRace = GetRacialType(oHenchs);
iPheno = GetPhenoType(oHenchs);
iHencheHorde = GetLocalInt(oGoldbag,"Horse Horde");

     if((iRace==RACIAL_TYPE_HUMAN)||(iRace==RACIAL_TYPE_HALFORC)||(iRace==RACIAL_TYPE_HALFELF)||(iRace==RACIAL_TYPE_ELF)){if(iPheno==PHENOTYPE_BIG){if(iHencheHorde==1){iNewPheno = nCEP_PH_HORSE_BROWN_L;}else if(iHencheHorde==2){iNewPheno = nCEP_PH_HORSE_BLACK_L;}else{iNewPheno = nCEP_PH_HORSE_WHITE_L;}}else{if(iHencheHorde==1){iNewPheno = nCEP_PH_HORSE_BROWN;}else if(iHencheHorde==2){iNewPheno = nCEP_PH_HORSE_BLACK;}else{iNewPheno = nCEP_PH_HORSE_WHITE;}}SetPhenoType(iNewPheno,oHenchs);SetFootstepType(iFoot,oHenchs);SetLocalInt(oHenchs,"Phenotype",iPheno);if(iHencheHorde==1){SetLocalString(oHenchs,"HorseBP","henchani001");}else if(iHencheHorde==2){SetLocalString(oHenchs,"HorseBP","henchani002");}else{SetLocalString(oHenchs,"HorseBP","henchani003");}SetLocalInt(oHenchs,"HenchAction",10);ExecuteScript("henchs",oHenchs);}
else if((iRace==RACIAL_TYPE_DWARF)||(iRace==RACIAL_TYPE_GNOME)||(iRace==RACIAL_TYPE_HALFLING)){if(iPheno==PHENOTYPE_BIG){if(iHencheHorde==1){iNewPheno = nCEP_PH_PONY_BROWN_L;}else if(iHencheHorde==2){iNewPheno = nCEP_PH_PONY_SPOT;}else{iNewPheno = nCEP_PH_PONY_LTBROWN_L;}}else{if(iHencheHorde==1){iNewPheno = nCEP_PH_PONY_BROWN;}else if(iHencheHorde==2){iNewPheno = nCEP_PH_PONY_SPOT;}else{iNewPheno = nCEP_PH_PONY_LTBROWN_L;}}SetPhenoType(iNewPheno,oHenchs);SetFootstepType(iFoot,oHenchs);SetLocalInt(oHenchs,"Phenotype",iPheno);if(iHencheHorde==1){SetLocalString(oHenchs,"HorseBP","henchani006");}else if(iHencheHorde==2){SetLocalString(oHenchs,"HorseBP","henchani007");}else{SetLocalString(oHenchs,"HorseBP","henchani008");}SetLocalInt(oHenchs,"HenchAction",10);ExecuteScript("henchs",oHenchs);}
i++;
    }
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Dismount horse
else if(iHenchAction==9)
 {
int iRaceSpe = GetLocalInt(oGoldbag,"Race");
location lLoc = GetLocation(oPC);
effect eEffect = GetFirstEffect(oPC);
string sBP = GetLocalString(oGoldbag,"HorseBP");
int iNum = GetLocalInt(oGoldbag,"HorseNum");
int iPheno = GetLocalInt(oGoldbag,"Phenotype");
sHench = GetLocalString(oGoldbag,IntToString(iNum)+"Hench");
sName = GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"&B&")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"&B&")))-FindSubString(sHench,"&A&")-3);

if(iRaceSpe==0){SetPhenoType(iPheno,oPC);}
SetFootstepType(FOOTSTEP_TYPE_DEFAULT,oPC);

// Paladin horse power
if(GetLocalInt(oGoldbag,"HorsePaladin")==1)
  {
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_UNSUMMON),oPC);
DeleteLocalInt(oGoldbag,"HorsePaladin");
  }
// Normal horses
else
  {
oHench = CreateObject(OBJECT_TYPE_CREATURE,sBP,lLoc);
if(GetName(oHench)!=sName){SetName(oHench,sName);}
SetLocalInt(oHench,"Hench",1);
SetLocalInt(oHench,"DontSave",1);
SetLocalInt(oHench,"HenchNum",iNum);
SetLocalString(oHench,"Master",sPCName);
ChangeToStandardFaction(oHench,STANDARD_FACTION_COMMONER);
AddHenchman(oPC,oHench);
  }
DeleteLocalString(oGoldbag,"HorseBP");
DeleteLocalInt(oGoldbag,"HorseNum");
DeleteLocalInt(oGoldbag,"Phenotype");
DeleteLocalInt(oGoldbag,"NewPheno");
DeleteLocalInt(oPC,"Mounted");

while(GetIsEffectValid(eEffect)){if((GetEffectType(eEffect)==EFFECT_TYPE_HASTE)||(GetEffectType(eEffect)==EFFECT_TYPE_ATTACK_DECREASE)||(GetEffectType(eEffect)==EFFECT_TYPE_AC_DECREASE)||(GetEffectType(eEffect)==EFFECT_TYPE_SKILL_DECREASE)){RemoveEffect(oPC,eEffect);}eEffect = GetNextEffect(oPC);}

// Horse horde talent
if(GetLocalInt(oGoldbag,"Horse Horde")>0)
  {
while(i<iMaxHenchs+1)
   {
oHenchs = GetHenchman(oPC,i);
iPheno = GetLocalInt(oHenchs,"Phenotype");
eEffect = GetFirstEffect(oHenchs);

if(GetLocalInt(oHenchs,"Mounted")==1)
    {
SetPhenoType(iPheno,oHenchs);
SetFootstepType(FOOTSTEP_TYPE_DEFAULT,oHenchs);
DeleteLocalInt(oHenchs,"Mounted");

while(GetIsEffectValid(eEffect)){if((GetEffectType(eEffect)==EFFECT_TYPE_HASTE)||(GetEffectType(eEffect)==EFFECT_TYPE_ATTACK_DECREASE)||(GetEffectType(eEffect)==EFFECT_TYPE_AC_DECREASE)||(GetEffectType(eEffect)==EFFECT_TYPE_SKILL_DECREASE)){RemoveEffect(oHenchs,eEffect);}eEffect = GetNextEffect(oHenchs);}
    }
i++;
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Horses bonuses/maluses
else if(iHenchAction==10)
 {
string sHorseBP = GetLocalString(oGoldbag,"HorseBP");if(oGoldbag==OBJECT_INVALID){sHorseBP = GetLocalString(oPC,"HorseBP");}
int iBonus;

if(GetHasFeat(FEAT_MOUNTED_ARCHERY,oPC)){iBonus = iBonus+4;}
if(GetHasFeat(FEAT_MOUNTED_COMBAT,oPC)){iBonus = iBonus+4;}

ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectHaste(),oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectACDecrease(6-GetSkillRank(SKILL_RIDE,oPC)/4),oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSkillDecrease(SKILL_HIDE,50),oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSkillDecrease(SKILL_MOVE_SILENTLY,50),oPC);

     if((sHorseBP=="henchani001")||(sHorseBP=="henchani006")){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAttackDecrease(10-iBonus),oPC);}
else if((sHorseBP=="henchani002")||(sHorseBP=="henchani007")){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAttackDecrease(8-iBonus),oPC);}
else if((sHorseBP=="henchani003")||(sHorseBP=="henchani008")){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAttackDecrease(6-iBonus),oPC);}

SetLocalInt(oPC,"Mounted",1);
 }
////////////////////////////////////////////////////////////////////////////////
// Hench takes melee weapon
else if(iHenchAction==11)
 {
AssignCommand(oHench,ActionEquipMostEffectiveArmor());
AssignCommand(oHench,ActionEquipItem(GetItemPossessedBy(oHench,"NW_ASHLW001"),INVENTORY_SLOT_LEFTHAND));
AssignCommand(oHench,ActionEquipMostDamagingMelee());
 }
////////////////////////////////////////////////////////////////////////////////
// Hench takes range weapon
else if(iHenchAction==12)
 {
AssignCommand(oHench,ActionEquipMostEffectiveArmor());
AssignCommand(oHench,ActionEquipItem(GetItemPossessedBy(oHench,"NW_ASHLW001"),INVENTORY_SLOT_LEFTHAND));
AssignCommand(oHench, ActionEquipMostDamagingRanged());
 }
////////////////////////////////////////////////////////////////////////////////
// Henchs casern save
else if(iHenchAction==13)
 {
while(i<18)
  {
i++;
if(i==1) {iSlot = INVENTORY_SLOT_ARMS;}
if(i==2) {iSlot = INVENTORY_SLOT_ARROWS;}
if(i==3) {iSlot = INVENTORY_SLOT_BELT;}
if(i==4) {iSlot = INVENTORY_SLOT_BOLTS;}
if(i==5) {iSlot = INVENTORY_SLOT_BOOTS;}
if(i==6) {iSlot = INVENTORY_SLOT_BULLETS;}
if(i==7) {iSlot = INVENTORY_SLOT_CARMOUR;}
if(i==8) {iSlot = INVENTORY_SLOT_CHEST;}
if(i==9) {iSlot = INVENTORY_SLOT_CLOAK;}
if(i==10){iSlot = INVENTORY_SLOT_CWEAPON_B;}
if(i==11){iSlot = INVENTORY_SLOT_CWEAPON_L;}
if(i==12){iSlot = INVENTORY_SLOT_CWEAPON_R;}
if(i==13){iSlot = INVENTORY_SLOT_HEAD;}
if(i==14){iSlot = INVENTORY_SLOT_LEFTHAND;}
if(i==15){iSlot = INVENTORY_SLOT_LEFTRING;}
if(i==16){iSlot = INVENTORY_SLOT_NECK;}
if(i==17){iSlot = INVENTORY_SLOT_RIGHTHAND;}
if(i==18){iSlot = INVENTORY_SLOT_RIGHTRING;}

oItem = GetItemInSlot(iSlot,oHench);

sItemBP = GetResRef(oItem);
sItemTag = GetTag(oItem);
sItemName = GetName(oItem);
sItemStack = IntToString(GetItemStackSize(oItem));
sItemMaster = GetLocalString(oItem,"Master");
sItemWear = IntToString(GetLocalInt(oItem,"Wear"));
sItemWear2 = IntToString(GetLocalInt(oItem,"Wear%"));
sItemFix = IntToString(GetLocalInt(oItem,"Fix"));
sItemCharges = IntToString(GetItemCharges(oItem));
sItemVar = GetLocalString(oItem,"Var");
sItemBonus = GetLocalString(oItem,"Bonus");
sAll = sItemBP+"_A_"+sItemTag+"_B_"+sItemName+"_C_"+sItemStack+"_D_"+sItemMaster+"_E_"+sItemWear+"_F_"+sItemWear2+"_G_"+sItemFix+"_H_"+sItemCharges+"_I_"+sItemVar+"_J_"+sItemBonus+"_K_";

sCount = IntToString(i);if(i<10){sCount = "00"+IntToString(i);}else if(i<100){sCount = "0"+IntToString(i);}sCount = "&"+sCount+"&";
sVar = sVar+sAll+sCount;

SetDroppableFlag(oItem,TRUE);
  }
SetLocalString(oGoldbag,"HenchCasernSlots"+IntToString(iHench),sVar);

//

oItem = GetFirstItemInInventory(oHench);sAll = "";i=0;sCount = "";sVar = "";
while(GetIsObjectValid(oItem))
  {
// Casern henchs can only carry 10 items
if(i>9)
   {
CopyItem(oItem,oPC,TRUE);SetLocalInt(oHench,"HenchRecall",1);DestroyObject(oItem);FloatingTextStringOnCreature("casern troops can only carry 10 items",oPC);
   }
else
   {
sItemBP = GetResRef(oItem);
sItemTag = GetTag(oItem);
sItemName = GetName(oItem);
sItemStack = IntToString(GetItemStackSize(oItem));
sItemMaster = GetLocalString(oItem,"Master");
sItemWear = IntToString(GetLocalInt(oItem,"Wear"));
sItemWear2 = IntToString(GetLocalInt(oItem,"Wear%"));
sItemFix = IntToString(GetLocalInt(oItem,"Fix"));
sItemCharges = IntToString(GetItemCharges(oItem));
sItemVar = GetLocalString(oItem,"Var");
sItemBonus = GetLocalString(oItem,"Bonus");
sAll = sItemBP+"_A_"+sItemTag+"_B_"+sItemName+"_C_"+sItemStack+"_D_"+sItemMaster+"_E_"+sItemWear+"_F_"+sItemWear2+"_G_"+sItemFix+"_H_"+sItemCharges+"_I_"+sItemVar+"_J_"+sItemBonus+"_K_";

i++;
sCount = IntToString(i);if(i<10){sCount = "00"+IntToString(i);}else if(i<100){sCount = "0"+IntToString(i);}sCount = "&"+sCount+"&";
if(sItemTag!="goldbag"){sVar = sVar+sAll+sCount;}else{i--;}

SetDroppableFlag(oItem,TRUE);
   }
oItem = GetNextItemInInventory(oHench);
  }
SetLocalString(oGoldbag,"HenchCasernInv"+IntToString(iHench),sVar);
 }
////////////////////////////////////////////////////////////////////////////////
// Henchs casern recall
else if(iHenchAction==14)
 {
SetLocalInt(oHench,"HenchAction",15);ExecuteScript("henchs",oHench);
SetLocalInt(oHench,"HenchRecall",1);

//

sVar = GetLocalString(oGoldbag,"HenchCasernSlots"+IntToString(iHench));
iVar = StringToInt(GetStringLeft(GetStringRight(sVar,4),3));
i=0;

while(i<iVar)
  {
i++;
sCount1 = IntToString(i);if(i<10){sCount1 = "00"+IntToString(i);}else if(i<100){sCount1 = "0"+IntToString(i);}
sCount2 = IntToString(i-1);if((i-1)<10){sCount2 = "00"+IntToString(i-1);}else if((i-1)<100){sCount2 = "0"+IntToString(i-1);}

if(i==1){sAll = GetStringLeft(sVar,FindSubString(sVar,"&"+sCount1+"&"));}else{sAll = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"&"+sCount1+"&")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"&"+sCount1+"&")))-FindSubString(sVar,"&"+sCount2+"&")-5);}
sItemBP = GetStringLeft(sAll,FindSubString(sAll,"_A_"));
sItemTag = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_B_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_B_")))-FindSubString(sAll,"_A_")-3);
sItemName = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_C_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_C_")))-FindSubString(sAll,"_B_")-3);
sItemStack = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_D_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_D_")))-FindSubString(sAll,"_C_")-3);
sItemMaster = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_E_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_E_")))-FindSubString(sAll,"_D_")-3);
sItemWear = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_F_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_F_")))-FindSubString(sAll,"_E_")-3);
sItemWear2 = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_G_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_G_")))-FindSubString(sAll,"_F_")-3);
sItemFix = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_H_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_H_")))-FindSubString(sAll,"_G_")-3);
sItemCharges = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_I_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_I_")))-FindSubString(sAll,"_H_")-3);
sItemVar = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_J_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_J_")))-FindSubString(sAll,"_I_")-3);
sItemBonus = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_K_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_K_")))-FindSubString(sAll,"_J_")-3);

oItem = CreateItemOnObject(sItemBP,oHench,StringToInt(sItemStack),sItemTag);
if(GetName(oItem)!=sItemName){SetName(oItem,sItemName);}if(FindSubString(sItemName,"(Quality")!=-1){AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyQuality(IP_CONST_QUALITY_EXCELLENT),oItem);}
SetLocalString(oItem,"Master",sItemMaster);
SetLocalInt(oItem,"Wear",StringToInt(sItemWear));
SetLocalInt(oItem,"Wear%",StringToInt(sItemWear2));
SetLocalInt(oItem,"Fix",StringToInt(sItemFix));
SetLocalString(oItem,"Bonus",sItemBonus);if(sItemBonus!=""){ExecuteScript("bonus",oItem);}
SetLocalString(oItem,"Var",sItemVar);
if(StringToInt(sItemCharges)>0){SetItemCharges(oItem,StringToInt(sItemCharges));}
SetIdentified(oItem,TRUE);
SetDroppableFlag(oItem,TRUE);

if(i==1) {iSlot = INVENTORY_SLOT_ARMS;}
if(i==2) {iSlot = INVENTORY_SLOT_ARROWS;}
if(i==3) {iSlot = INVENTORY_SLOT_BELT;}
if(i==4) {iSlot = INVENTORY_SLOT_BOLTS;}
if(i==5) {iSlot = INVENTORY_SLOT_BOOTS;}
if(i==6) {iSlot = INVENTORY_SLOT_BULLETS;}
if(i==7) {iSlot = INVENTORY_SLOT_CARMOUR;}
if(i==8) {iSlot = INVENTORY_SLOT_CHEST;}
if(i==9) {iSlot = INVENTORY_SLOT_CLOAK;}
if(i==10){iSlot = INVENTORY_SLOT_CWEAPON_B;}
if(i==11){iSlot = INVENTORY_SLOT_CWEAPON_L;}
if(i==12){iSlot = INVENTORY_SLOT_CWEAPON_R;}
if(i==13){iSlot = INVENTORY_SLOT_HEAD;}
if(i==14){iSlot = INVENTORY_SLOT_LEFTHAND;}
if(i==15){iSlot = INVENTORY_SLOT_LEFTRING;}
if(i==16){iSlot = INVENTORY_SLOT_NECK;}
if(i==17){iSlot = INVENTORY_SLOT_RIGHTHAND;}
if(i==18){iSlot = INVENTORY_SLOT_RIGHTRING;}

AssignCommand(oHench,ActionEquipItem(oItem,iSlot));
  }

//

sVar = GetLocalString(oGoldbag,"HenchCasernInv"+IntToString(iHench));
iVar = StringToInt(GetStringLeft(GetStringRight(sVar,4),3));
i=0;

while(i<iVar)
  {
i++;
sCount1 = IntToString(i);if(i<10){sCount1 = "00"+IntToString(i);}else if(i<100){sCount1 = "0"+IntToString(i);}
sCount2 = IntToString(i-1);if((i-1)<10){sCount2 = "00"+IntToString(i-1);}else if((i-1)<100){sCount2 = "0"+IntToString(i-1);}

if(i==1){sAll = GetStringLeft(sVar,FindSubString(sVar,"&"+sCount1+"&"));}else{sAll = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"&"+sCount1+"&")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"&"+sCount1+"&")))-FindSubString(sVar,"&"+sCount2+"&")-5);}

sItemBP = GetStringLeft(sAll,FindSubString(sAll,"_A_"));
sItemTag = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_B_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_B_")))-FindSubString(sAll,"_A_")-3);
sItemName = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_C_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_C_")))-FindSubString(sAll,"_B_")-3);
sItemStack = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_D_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_D_")))-FindSubString(sAll,"_C_")-3);
sItemMaster = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_E_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_E_")))-FindSubString(sAll,"_D_")-3);
sItemWear = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_F_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_F_")))-FindSubString(sAll,"_E_")-3);
sItemWear2 = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_G_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_G_")))-FindSubString(sAll,"_F_")-3);
sItemFix = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_H_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_H_")))-FindSubString(sAll,"_G_")-3);
sItemCharges = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_I_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_I_")))-FindSubString(sAll,"_H_")-3);
sItemVar = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_J_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_J_")))-FindSubString(sAll,"_I_")-3);
sItemBonus = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_K_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_K_")))-FindSubString(sAll,"_J_")-3);

oItem = CreateItemOnObject(sItemBP,oHench,StringToInt(sItemStack),sItemTag);
if(GetName(oItem)!=sItemName){SetName(oItem,sItemName);}if(FindSubString(sItemName,"(Quality")!=-1){AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyQuality(IP_CONST_QUALITY_EXCELLENT),oItem);}
SetLocalString(oItem,"Master",sItemMaster);
SetLocalInt(oItem,"Wear",StringToInt(sItemWear));
SetLocalInt(oItem,"Wear%",StringToInt(sItemWear2));
SetLocalInt(oItem,"Fix",StringToInt(sItemFix));
SetLocalString(oItem,"Bonus",sItemBonus);
SetLocalString(oItem,"Var",sItemVar);
if(StringToInt(sItemCharges)>0){SetItemCharges(oItem,StringToInt(sItemCharges));}
SetIdentified(oItem,TRUE);
SetDroppableFlag(oItem,TRUE);
  }
DelayCommand(0.5,DeleteLocalInt(oHench,"HenchRecall"));
 }
////////////////////////////////////////////////////////////////////////////////
// Henchs casern level up
else if(iHenchAction==15)
 {
iAppearance = GetLocalInt(OBJECT_SELF,"Race");
iLevel = GetLocalInt(OBJECT_SELF,"Level");
iClass = GetLocalInt(OBJECT_SELF,"Class");
iHead = GetLocalInt(OBJECT_SELF,"Head");

SetCreatureAppearanceType(OBJECT_SELF,iAppearance);
if(iHead>0){SetCreatureBodyPart(CREATURE_PART_HEAD,iHead,OBJECT_SELF);}

if((iClass==5)||(iClass==6)){AdjustAlignment(OBJECT_SELF,ALIGNMENT_LAWFUL,25,FALSE);}
if(iClass==6){AdjustAlignment(OBJECT_SELF,ALIGNMENT_GOOD,25,FALSE);}

     if(iLevel==1){iLevels = 4;}
else if(iLevel==2){iLevels = 7;}
else if(iLevel==3){iLevels = 10;}
else if(iLevel==4){iLevels = 13;}
else if(iLevel==5){iLevels = 16;}

if(iClass==2){iLevels = (iLevels*140)/100;}
else if((iClass==4)||(iClass==6)||(iClass==8)||(iClass==9)){iLevels = (iLevels*120)/100;}
else if((iClass==5)||(iClass==10)||(iClass==11)){iLevels = (iLevels*80)/100;}
else if(iClass==3){iLevels = (iLevels*60)/100;}

while(i<iLevels){i++;LevelUpHenchman(OBJECT_SELF,iClass,TRUE);}
 }
////////////////////////////////////////////////////////////////////////////////
DeleteLocalInt(oPC,"HenchAction");
DeleteLocalInt(oPC,"Item");
DeleteLocalInt(oPC,"NoHorsePaladin");
////////////////////////////////////////////////////////////////////////////////
}}
