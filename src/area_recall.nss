#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
string sPlanet = GetLocalString(OBJECT_SELF,"Planet");
string sArea = GetLocalString(OBJECT_SELF,"Area");
string sTarget = GetPersistentString(oModule,sPlanet+"_"+sArea);
int iSpecialArea = GetLocalInt(OBJECT_SELF,"SpecialArea");
//
int iAreaIni = GetLocalInt(OBJECT_SELF,"AreaIni");
int iReady = GetLocalInt(oModule,sPlanet+"_"+sArea+"&Ready");
object oObjects = GetFirstObjectInArea(OBJECT_SELF);
//
int i = GetLocalInt(oModule,sPlanet+"&"+sArea+"&ObjectsTot");
int j2 = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&ObjectsTot");
//
string sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
string sAreaName = GetStringRight(GetStringLeft(sInterests,FindSubString(sInterests,"&2&")),GetStringLength(GetStringLeft(sInterests,FindSubString(sInterests,"&2&")))-FindSubString(sInterests,"&1&")-3);
float fTZ = 0.0;if(GetStringLeft(GetTag(OBJECT_SELF),8)=="tropical"){fTZ = 1.0;}else if((GetStringLeft(GetTag(OBJECT_SELF),6)=="ground")||(GetStringLeft(GetTag(OBJECT_SELF),11)=="ruralcastle")){fTZ = 5.0;}
//
int iAreaX = GetAreaSize(AREA_WIDTH,OBJECT_SELF)*10;
int iAreaY = GetAreaSize(AREA_HEIGHT,OBJECT_SELF)*10;
int iNight = GetLocalInt(OBJECT_SELF,"Night");
string sObject;string sItem;object oNew;string sBP;string sTag;string sName;int iType;float fX;float fY;float fZ;float fF;int iStop;string sMaster;int iHP;int iStack;int iFaction;string sBonus;int iLeader;int iWear;int iWear2;int iFix;int iD;string sVar;int iRandom;string s;string si1;string si2;string sj1;string sj2;int iUseable;int iLocked;int iTrapped;int iCamp;int iPlot;int iCharges;object oDoor;object oItem;int l;int j;int m;string sPer;
string sItemBP;string sItemTag;string sItemName;string sItemStack;string sItemMaster;string sItemWear;string sItemWear2;string sItemFix;string sItemVar;string sItemBonus;string sItemCharges;string sAll;string sCount;string sCount1;string sCount2;int iVar;int iSlot;
////////////////////////////////////////////////////////////////////////////////
// Permanent toolset objects & ambiance
if(iAreaIni!=1){while(GetIsObjectValid(oObjects)){if((!GetIsPC(oObjects))&&(!GetIsDM(oObjects))&&(!GetIsDMPossessed(oObjects))&&(GetLocalInt(oObjects,"DontSave")!=1)&&(GetLocalInt(oObjects,"DontSave2")!=1)&&(GetLocalInt(oObjects,"DontSave3")!=1)&&(GetLocalInt(oObjects,"Camp")!=1)&&(GetMaster(oObjects)==OBJECT_INVALID)){SetLocalInt(oObjects,"Permanent",1);SetPlotFlag(oObjects,TRUE);}if(GetStringLeft(GetTag(oObjects),7)=="placard"){SetLocalObject(OBJECT_SELF,GetTag(oObjects),oObjects);}oObjects = GetNextObjectInArea(OBJECT_SELF);}}
////////////////////////////////////////////////////////////////////////////////
// If this is a real area recall, execute it all
if(iNight==0){
////////////////////////////////////////////////////////////////////////////////
// Recall non-persistent objects
while(i>0)
 {
sObject = GetLocalString(oModule,sPlanet+"_"+sArea+"_Objects"+IntToString(i));

sBP = GetStringLeft(sObject,FindSubString(sObject,"_A_"));
sTag = GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_B_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_B_")))-FindSubString(sObject,"_A_")-3);
sName = GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_C_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_C_")))-FindSubString(sObject,"_B_")-3);
iType = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_D_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_D_")))-FindSubString(sObject,"_C_")-3));
fX = StringToFloat(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_E_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_E_")))-FindSubString(sObject,"_D_")-3));
fY = StringToFloat(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_F_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_F_")))-FindSubString(sObject,"_E_")-3));
fZ = fTZ+StringToFloat(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_G_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_G_")))-FindSubString(sObject,"_F_")-3));
fF = StringToFloat(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_H_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_H_")))-FindSubString(sObject,"_G_")-3));
iStop = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_I_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_I_")))-FindSubString(sObject,"_H_")-3));
sMaster = GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_J_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_J_")))-FindSubString(sObject,"_I_")-3);
iHP = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_K_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_K_")))-FindSubString(sObject,"_J_")-3));
iStack = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_L_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_L_")))-FindSubString(sObject,"_K_")-3));
iFaction = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_M_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_M_")))-FindSubString(sObject,"_L_")-3));
sBonus = GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_N_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_N_")))-FindSubString(sObject,"_M_")-3);
iUseable = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_O_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_O_")))-FindSubString(sObject,"_N_")-3));
iLocked = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_P_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_P_")))-FindSubString(sObject,"_O_")-3));
iTrapped = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_Q_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_Q_")))-FindSubString(sObject,"_P_")-3));
iCamp = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_R_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_R_")))-FindSubString(sObject,"_Q_")-3));
iLeader = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_S_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_S_")))-FindSubString(sObject,"_R_")-3));
iWear = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_T_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_T_")))-FindSubString(sObject,"_S_")-3));
iWear2 = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_U_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_U_")))-FindSubString(sObject,"_T_")-3));
iFix = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_V_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_V_")))-FindSubString(sObject,"_U_")-3));
iPlot = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_W_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_W_")))-FindSubString(sObject,"_V_")-3));
iCharges = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_X_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_X_")))-FindSubString(sObject,"_W_")-3));
iD = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_Y_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_Y_")))-FindSubString(sObject,"_X_")-3));
sVar = GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_Z_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_Z_")))-FindSubString(sObject,"_Y_")-3);

oNew = CreateObject(iType,sBP,Location(OBJECT_SELF,Vector(fX,fY,fZ),fF),FALSE,sTag);
SetName(oNew,sName);if(FindSubString(sName,"(Quality")!=-1){AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyQuality(IP_CONST_QUALITY_EXCELLENT),oNew);}
SetLocalInt(oNew,"Stop",iStop);
SetLocalString(oNew,"Master",sMaster);
if(iStack>1){SetItemStackSize(oNew,iStack);}
if(iFaction==1){ChangeToStandardFaction(oNew,STANDARD_FACTION_COMMONER);}else if(iFaction==2){ChangeToStandardFaction(oNew,STANDARD_FACTION_DEFENDER);}else if(iFaction==3){ChangeToStandardFaction(oNew,STANDARD_FACTION_HOSTILE);}else if(iFaction==4){ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);}
SetLocalString(oNew,"Bonus",sBonus);if(sBonus!=""){ExecuteScript("bonus",oNew);}
if(iType==OBJECT_TYPE_PLACEABLE){SetUseableFlag(oNew,iUseable);}
if(iLocked){SetLocked(oNew,TRUE);}
if(iTrapped){CreateTrapOnObject(TRAP_BASE_TYPE_AVERAGE_SONIC,oNew,STANDARD_FACTION_HOSTILE,"unlock_disarm");}
SetLocalInt(oNew,"Camp",iCamp);
SetLocalInt(oNew,"Leader",iLeader);
SetLocalInt(oNew,"Wear",iWear);
SetLocalInt(oNew,"Wear%",iWear2);
SetLocalInt(oNew,"Fix",iFix);
SetPlotFlag(oNew,iPlot);
if(iCharges>0){SetItemCharges(oNew,iCharges);}
if((iType==OBJECT_TYPE_ITEM)&&(iD==TRUE)){SetIdentified(oNew,TRUE);}
SetLocalString(oNew,"Var",sVar);
if((iType==OBJECT_TYPE_CREATURE)&&(iHP<1)){SetLocalInt(oNew,"Dead",1);AssignCommand(oNew,SetIsDestroyable(FALSE,FALSE,FALSE));AssignCommand(oNew,TakeGoldFromCreature(GetGold(oNew),oNew,TRUE));oItem = GetFirstItemInInventory(oNew);while(GetIsObjectValid(oItem)){DestroyObject(oItem);oItem = GetNextItemInInventory(oNew);}ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetMaxHitPoints(oNew)),oNew);}

// Tags
if(GetTag(oNew)=="enigmmaker"){oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);if(GetUseableFlag(oNew)==TRUE){SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));}else{AssignCommand(oNew,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));SetLocked(oDoor,FALSE);AssignCommand(oDoor,ActionOpenDoor(oDoor));}}

// Inventory
l = GetLocalInt(oModule,sPlanet+"&"+sArea+"&ObjectsTot"+IntToString(i)+"Inventory");

while(l>0)
   {
sItem = GetLocalString(oModule,sPlanet+"_"+sArea+"_Objects"+IntToString(i)+"Inventory"+IntToString(l));

sBP = GetStringLeft(sItem,FindSubString(sItem,"_A_"));
sTag = GetStringRight(GetStringLeft(sItem,FindSubString(sItem,"_B_")),GetStringLength(GetStringLeft(sItem,FindSubString(sItem,"_B_")))-FindSubString(sItem,"_A_")-3);
sName = GetStringRight(GetStringLeft(sItem,FindSubString(sItem,"_C_")),GetStringLength(GetStringLeft(sItem,FindSubString(sItem,"_C_")))-FindSubString(sItem,"_B_")-3);
sMaster = GetStringRight(GetStringLeft(sItem,FindSubString(sItem,"_J_")),GetStringLength(GetStringLeft(sItem,FindSubString(sItem,"_J_")))-FindSubString(sItem,"_I_")-3);
iStack = StringToInt(GetStringRight(GetStringLeft(sItem,FindSubString(sItem,"_L_")),GetStringLength(GetStringLeft(sItem,FindSubString(sItem,"_L_")))-FindSubString(sItem,"_K_")-3));
sBonus = GetStringRight(GetStringLeft(sItem,FindSubString(sItem,"_N_")),GetStringLength(GetStringLeft(sItem,FindSubString(sItem,"_N_")))-FindSubString(sItem,"_M_")-3);
iWear = StringToInt(GetStringRight(GetStringLeft(sItem,FindSubString(sItem,"_T_")),GetStringLength(GetStringLeft(sItem,FindSubString(sItem,"_T_")))-FindSubString(sItem,"_S_")-3));
iWear2 = StringToInt(GetStringRight(GetStringLeft(sItem,FindSubString(sItem,"_U_")),GetStringLength(GetStringLeft(sItem,FindSubString(sItem,"_U_")))-FindSubString(sItem,"_T_")-3));
iFix = StringToInt(GetStringRight(GetStringLeft(sItem,FindSubString(sItem,"_V_")),GetStringLength(GetStringLeft(sItem,FindSubString(sItem,"_V_")))-FindSubString(sItem,"_U_")-3));
iCharges = StringToInt(GetStringRight(GetStringLeft(sItem,FindSubString(sItem,"_X_")),GetStringLength(GetStringLeft(sItem,FindSubString(sItem,"_X_")))-FindSubString(sItem,"_W_")-3));
iD = StringToInt(GetStringRight(GetStringLeft(sItem,FindSubString(sItem,"_Y_")),GetStringLength(GetStringLeft(sItem,FindSubString(sItem,"_Y_")))-FindSubString(sItem,"_X_")-3));
sVar = GetStringRight(GetStringLeft(sItem,FindSubString(sItem,"_Z_")),GetStringLength(GetStringLeft(sItem,FindSubString(sItem,"_Z_")))-FindSubString(sItem,"_Y_")-3);

oItem = CreateItemOnObject(sBP,oNew,iStack,sTag);
SetName(oItem,sName);
SetLocalString(oItem,"Master",sMaster);
SetLocalString(oItem,"Bonus",sBonus);if(sBonus!=""){ExecuteScript("bonus",oItem);}
SetLocalInt(oItem,"Wear",iWear);
SetLocalInt(oItem,"Wear%",iWear2);
SetLocalInt(oItem,"Fix",iFix);
if(iCharges>0){SetItemCharges(oItem,iCharges);}
if(iD==TRUE){SetIdentified(oItem,TRUE);}
SetLocalString(oItem,"Var",sVar);

l--;
  }

// Slots
sVar = GetLocalString(oModule,sPlanet+"_"+sArea+"_Objects"+IntToString(i)+"Slots");
iVar = StringToInt(GetStringLeft(GetStringRight(sVar,4),3));
m=0;

while(m<iVar)
  {
m++;
sCount1 = IntToString(m);if(m<10){sCount1 = "00"+IntToString(m);}else if(m<100){sCount1 = "0"+IntToString(m);}
sCount2 = IntToString(m-1);if((m-1)<10){sCount2 = "00"+IntToString(m-1);}else if((m-1)<100){sCount2 = "0"+IntToString(m-1);}

if(m==1){sAll = GetStringLeft(sVar,FindSubString(sVar,"&"+sCount1+"&"));}else{sAll = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"&"+sCount1+"&")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"&"+sCount1+"&")))-FindSubString(sVar,"&"+sCount2+"&")-5);}
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

oItem = CreateItemOnObject(sItemBP,oNew,StringToInt(sItemStack),sItemTag);
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

if(m==1) {iSlot = INVENTORY_SLOT_ARMS;}
if(m==2) {iSlot = INVENTORY_SLOT_ARROWS;}
if(m==3) {iSlot = INVENTORY_SLOT_BELT;}
if(m==4) {iSlot = INVENTORY_SLOT_BOLTS;}
if(m==5) {iSlot = INVENTORY_SLOT_BOOTS;}
if(m==6) {iSlot = INVENTORY_SLOT_BULLETS;}
if(m==7) {iSlot = INVENTORY_SLOT_CARMOUR;}
if(m==8) {iSlot = INVENTORY_SLOT_CHEST;}
if(m==9) {iSlot = INVENTORY_SLOT_CLOAK;}
if(m==10){iSlot = INVENTORY_SLOT_CWEAPON_B;}
if(m==11){iSlot = INVENTORY_SLOT_CWEAPON_L;}
if(m==12){iSlot = INVENTORY_SLOT_CWEAPON_R;}
if(m==13){iSlot = INVENTORY_SLOT_HEAD;}
if(m==14){iSlot = INVENTORY_SLOT_LEFTHAND;}
if(m==15){iSlot = INVENTORY_SLOT_LEFTRING;}
if(m==16){iSlot = INVENTORY_SLOT_NECK;}
if(m==17){iSlot = INVENTORY_SLOT_RIGHTHAND;}
if(m==18){iSlot = INVENTORY_SLOT_RIGHTRING;}

AssignCommand(oNew,ActionEquipItem(oItem,iSlot));
  }
i--;
 }
////////////////////////////////////////////////////////////////////////////////
// Recall persistent objects
while(j2>0)
 {
sPer = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Objects"+IntToString(j2));
j = StringToInt(GetStringLeft(GetStringRight(sPer,4),3));

while(j>0)
  {
sj1 = IntToString(j);if(j<10){sj1 = "00"+IntToString(j);}else if(j<100){sj1 = "0"+IntToString(j);}
sj2 = IntToString(j-1);if((j-1)<10){sj2 = "00"+IntToString(j-1);}else if((j-1)<100){sj2 = "0"+IntToString(j-1);}

if(j==1){sObject = GetStringLeft(sPer,FindSubString(sPer,"&"+sj1+"&"));}else{sObject = GetStringRight(GetStringLeft(sPer,FindSubString(sPer,"&"+sj1+"&")),GetStringLength(GetStringLeft(sPer,FindSubString(sPer,"&"+sj1+"&")))-FindSubString(sPer,"&"+sj2+"&")-5);}
sBP = GetStringLeft(sObject,FindSubString(sObject,"_A_"));
sTag = GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_B_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_B_")))-FindSubString(sObject,"_A_")-3);
sName = GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_C_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_C_")))-FindSubString(sObject,"_B_")-3);
iType = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_D_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_D_")))-FindSubString(sObject,"_C_")-3));
fX = StringToFloat(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_E_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_E_")))-FindSubString(sObject,"_D_")-3));
fY = StringToFloat(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_F_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_F_")))-FindSubString(sObject,"_E_")-3));
fZ = fTZ+StringToFloat(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_G_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_G_")))-FindSubString(sObject,"_F_")-3));
fF = StringToFloat(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_H_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_H_")))-FindSubString(sObject,"_G_")-3));
iStop = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_I_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_I_")))-FindSubString(sObject,"_H_")-3));
sMaster = GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_J_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_J_")))-FindSubString(sObject,"_I_")-3);
iHP = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_K_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_K_")))-FindSubString(sObject,"_J_")-3));
iStack = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_L_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_L_")))-FindSubString(sObject,"_K_")-3));
iFaction = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_M_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_M_")))-FindSubString(sObject,"_L_")-3));
sBonus = GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_N_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_N_")))-FindSubString(sObject,"_M_")-3);
iUseable = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_O_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_O_")))-FindSubString(sObject,"_N_")-3));
iLocked = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_P_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_P_")))-FindSubString(sObject,"_O_")-3));
iTrapped = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_Q_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_Q_")))-FindSubString(sObject,"_P_")-3));
iCamp = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_R_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_R_")))-FindSubString(sObject,"_Q_")-3));
iLeader = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_S_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_S_")))-FindSubString(sObject,"_R_")-3));
iWear = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_T_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_T_")))-FindSubString(sObject,"_S_")-3));
iWear2 = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_U_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_U_")))-FindSubString(sObject,"_T_")-3));
iFix = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_V_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_V_")))-FindSubString(sObject,"_U_")-3));
iPlot = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_W_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_W_")))-FindSubString(sObject,"_V_")-3));
iCharges = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_X_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_X_")))-FindSubString(sObject,"_W_")-3));
iD = StringToInt(GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_Y_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_Y_")))-FindSubString(sObject,"_X_")-3));
sVar = GetStringRight(GetStringLeft(sObject,FindSubString(sObject,"_Z_")),GetStringLength(GetStringLeft(sObject,FindSubString(sObject,"_Z_")))-FindSubString(sObject,"_Y_")-3);

oNew = CreateObject(iType,sBP,Location(OBJECT_SELF,Vector(fX,fY,fZ),fF),FALSE,sTag);
SetName(oNew,sName);
SetLocalInt(oNew,"Persistent",1);
SetLocalInt(oNew,"Stop",iStop);
SetLocalString(oNew,"Master",sMaster);
if(iStack>1){SetItemStackSize(oNew,iStack);}
if(iFaction==1){ChangeToStandardFaction(oNew,STANDARD_FACTION_COMMONER);}else if(iFaction==2){ChangeToStandardFaction(oNew,STANDARD_FACTION_DEFENDER);}else if(iFaction==3){ChangeToStandardFaction(oNew,STANDARD_FACTION_HOSTILE);}else{ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);}
SetLocalString(oNew,"Bonus",sBonus);if(sBonus!=""){ExecuteScript("bonus",oNew);}
if(iType==OBJECT_TYPE_PLACEABLE){SetUseableFlag(oNew,iUseable);}
if(iLocked){SetLocked(oNew,TRUE);}
if(iTrapped){CreateTrapOnObject(TRAP_BASE_TYPE_AVERAGE_SONIC,oNew,STANDARD_FACTION_HOSTILE,"unlock_disarm");}
SetLocalInt(oNew,"Camp",iCamp);
SetLocalInt(oNew,"Leader",iLeader);
SetLocalInt(oNew,"Wear",iWear);
SetLocalInt(oNew,"Wear%",iWear2);
SetLocalInt(oNew,"Fix",iFix);
SetPlotFlag(oNew,iPlot);
if(iCharges>0){SetItemCharges(oNew,iCharges);}
if((iType==OBJECT_TYPE_ITEM)&&(iD==TRUE)){SetIdentified(oNew,TRUE);}
SetLocalString(oNew,"Var",sVar);
if((iType==OBJECT_TYPE_CREATURE)&&(iHP<1)){SetLocalInt(oNew,"Dead",1);AssignCommand(oNew,SetIsDestroyable(FALSE,FALSE,FALSE));oItem = GetFirstItemInInventory(oNew);while(GetIsObjectValid(oItem)){DestroyObject(oItem);oItem = GetNextItemInInventory(oNew);}ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetMaxHitPoints(oNew)),oNew);}

// Tags
if(GetTag(oNew)=="enigmmaker"){oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oNew);if(GetUseableFlag(oNew)==TRUE){SetLocked(oDoor,TRUE);AssignCommand(oDoor,ActionCloseDoor(oDoor));}else{AssignCommand(oNew,ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));SetLocked(oDoor,FALSE);AssignCommand(oDoor,ActionOpenDoor(oDoor));}}

j--;
  }
j2--;
 }
////////////////////////////////////////////////////////////////////////////////
// Recall guards
ExecuteScript("soldiers_recall",OBJECT_SELF);
////////////////////////////////////////////////////////////////////////////////
// Cities placard names
if(GetStringLeft(GetTag(OBJECT_SELF),4)=="city")
 {
object oPlacard1 = GetLocalObject(OBJECT_SELF,"placard1");SetName(oPlacard1,sAreaName);
object oPlacard2 = GetLocalObject(OBJECT_SELF,"placard2");SetName(oPlacard2,sAreaName);
object oPlacard3 = GetLocalObject(OBJECT_SELF,"placard3");SetName(oPlacard3,sAreaName);
object oPlacard4 = GetLocalObject(OBJECT_SELF,"placard4");SetName(oPlacard4,sAreaName);
 }
////////////////////////////////////////////////////////////////////////////////
// Tavern and town hall henchs
if((iReady!=1)&&((GetStringLeft(GetTag(OBJECT_SELF),6)=="tavern")||(GetStringLeft(GetTag(OBJECT_SELF),8)=="townhall")))
 {
oNew = CreateObject(OBJECT_TYPE_CREATURE,"hench001",GetLocation(GetWaypointByTag("WPH_"+GetTag(OBJECT_SELF))));
oNew = CreateObject(OBJECT_TYPE_CREATURE,"hench010",GetLocation(GetWaypointByTag("WPH_"+GetTag(OBJECT_SELF))));
oNew = CreateObject(OBJECT_TYPE_CREATURE,"hench020",GetLocation(GetWaypointByTag("WPH_"+GetTag(OBJECT_SELF))));
 }
////////////////////////////////////////////////////////////////////////////////
// Place objects
}if((sPlanet!="")&&(sArea!="")&&((!GetIsAreaInterior(OBJECT_SELF))||(GetStringLeft(GetTag(OBJECT_SELF),10)=="underwater"))&&(GetStringLeft(GetTag(OBJECT_SELF),7)!="airship"))
 {
// Interests
if(GetStringLeft(GetTag(OBJECT_SELF),4)!="city"){ExecuteScript("area_interests",OBJECT_SELF);}
// Cities & town commoners
if((GetStringLeft(GetTag(OBJECT_SELF),4)=="city")&&(GetIsDay())&&((GetStringRight(GetStringLeft(GetTag(OBJECT_SELF),5),1)=="a")||(GetStringRight(GetStringLeft(GetTag(OBJECT_SELF),5),1)=="b")||(GetStringRight(GetStringLeft(GetTag(OBJECT_SELF),5),1)=="c")||(GetStringRight(GetStringLeft(GetTag(OBJECT_SELF),5),1)=="d"))){i = 0;while(i<100){i++;if(Random(2)==1){s = "commoner_female";}else{s = "commoner_male";}oNew = CreateObject(OBJECT_TYPE_CREATURE,s,Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0));SetLocalInt(oNew,"DontSave",1);}}

if((GetStringLeft(GetTag(OBJECT_SELF),4)!="city")&&(GetStringLeft(sInterests,1)!="1")&&(GetStringLeft(sInterests,1)!="3")&&(GetStringLeft(sInterests,1)!="5")&&(GetStringLeft(sInterests,1)!="6")&&(GetStringLeft(sInterests,1)!="7")&&(GetStringLeft(GetTag(OBJECT_SELF),5)!="ocean")&&(iReady!=1)&&(iSpecialArea!=1)&&(iNight==0))
  {
// Exteriors creatures
if(GetStringLeft(sInterests,1)!="D"){ExecuteScript("area_creatures",OBJECT_SELF);}
// Exteriors resources
ExecuteScript("area_resources",OBJECT_SELF);
  }
 }
// Dungeons ext & int
if(((GetStringLeft(GetTag(OBJECT_SELF),2)=="d_")||(GetStringLeft(GetTag(OBJECT_SELF),8)=="h_castle")||(GetStringLeft(GetTag(OBJECT_SELF),7)=="h_tower")||(GetStringLeft(sInterests,1)=="2"))&&(iReady!=1)&&(iNight==0)){ExecuteScript("dungeons",OBJECT_SELF);}
// Ruins int
if((GetStringLeft(GetTag(OBJECT_SELF),8)=="h_ruins_")&&(iReady!=1)&&(iNight==0)){i = Random(5);while(i>0){i--;oNew = CreateObject(OBJECT_TYPE_CREATURE,"nw_spectre",Location(OBJECT_SELF,Vector(IntToFloat(Random(iAreaX)),IntToFloat(Random(iAreaY)),0.0),0.0));}}
// Resource mountain int
if((GetStringLeft(GetTag(OBJECT_SELF),11)=="h_mountain_")&&(GetLocalInt(OBJECT_SELF,"Mountain")!=1)){SetLocalInt(OBJECT_SELF,"Mountain",1);ExecuteScript("area_resources",OBJECT_SELF);}
////////////////////////////////////////////////////////////////////////////////
if(iNight==0)
 {
if((sPlanet!="")&&(sArea!="")){SetLocalInt(oModule,sPlanet+"_"+sArea+"&Ready",1);}
SetLocalInt(OBJECT_SELF,"Used",2);
 }
////////////////////////////////////////////////////////////////////////////////
SetLocalInt(OBJECT_SELF,"AreaIni",1);
////////////////////////////////////////////////////////////////////////////////
}
