#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iGold = GetGold(oPC);
int iGender = GetGender(oPC);
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
object oObjects = GetFirstObjectInArea(oArea);
//
int iStructure = GetLocalInt(OBJECT_SELF,"Structure");
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
int iLevel = StringToInt(GetStringRight(GetName(OBJECT_SELF),1));
//
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice2");
int iChoice3 = GetLocalInt(OBJECT_SELF,"Choice3");
int iChoice4 = GetLocalInt(OBJECT_SELF,"Choice4");
int iChoice5 = GetLocalInt(OBJECT_SELF,"Choice5");

//
string sBP = GetLocalString(OBJECT_SELF,"BP"+IntToString(iChoice1));
int iPrice = GetLocalInt(OBJECT_SELF,"Price"+IntToString(iChoice1));
//
int iCounter = GetLocalInt(oGoldbag,"Counter");
int iOrigCounter = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter");
//
float fX = GetPosition(OBJECT_SELF).x;
float fY = GetPosition(OBJECT_SELF).y;
//
object oNew;object oItems;string sChoice;int iItems;string sName;int iClass;int iAppearance;int iHead;int i1;int i2;int i;int j;
string sTag1;string sTag2;string sVar;string sVar1;string sVar2;string sVar3;string sVar4;string sVar5;string sBP1L;string sBP2L;string sBP3L;string sBP4L;string sBP5L;string sNum1R;string sNum2R;string sNum3R;string sNum4R;string sNum5R;int iNum1;int iNum2;int iNum3;int iNum4;int iNum5;
string sBP1;string sTag11;string sTag12;string sNum1;string sBP2;string sTag21;string sTag22;string sNum2;string sBP3;string sTag31;string sTag32;string sNum3;string sBP4;string sTag41;string sTag42;string sNum4;string sBP5;string sTag51;string sTag52;string sNum5;int iNum11;int iNum21;int iNum31;int iNum41;int iNum51;int iNum12;int iNum22;int iNum32;int iNum42;int iNum52;string sNum11;string sNum21;string sNum31;string sNum41;string sNum51;string sNum12;string sNum22;string sNum32;string sNum42;string sNum52;int iItemCost;string sUpgrade1;string sUpgrade2;int iNum;
////////////////////////////////////////////////////////////////////////////////
// Casern
if(iStructure==3)
 {
oNew = CreateObject(OBJECT_TYPE_CREATURE,"hench000",GetLocation(oPC));

     if(iChoice2==1) {iAppearance = 1002;} // Brownie
else if(iChoice2==2) {iAppearance = APPEARANCE_TYPE_BUGBEAR_A;}
else if(iChoice2==3) {iAppearance = APPEARANCE_TYPE_DROW_FIGHTER;}
else if(iChoice2==4) {iAppearance = APPEARANCE_TYPE_DWARF;}
else if(iChoice2==5) {iAppearance = APPEARANCE_TYPE_ELF;}
else if(iChoice2==6) {iAppearance = APPEARANCE_TYPE_FAIRY;}
else if(iChoice2==7) {iAppearance = APPEARANCE_TYPE_GNOME;}
else if(iChoice2==8) {iAppearance = APPEARANCE_TYPE_GOBLIN_A;}
else if(iChoice2==9) {iAppearance = APPEARANCE_TYPE_GNOLL_WARRIOR;}
else if(iChoice2==10){iAppearance = APPEARANCE_TYPE_HUMAN;}
else if(iChoice2==11){iAppearance = APPEARANCE_TYPE_HALF_ELF;}
else if(iChoice2==12){iAppearance = APPEARANCE_TYPE_HALFLING;}
else if(iChoice2==13){iAppearance = APPEARANCE_TYPE_HALF_ORC;}
else if(iChoice2==14){if(iGender==GENDER_FEMALE){iAppearance = 1516;}else{iAppearance = 1518;}} // Kenku
else if(iChoice2==15){iAppearance = APPEARANCE_TYPE_KOBOLD_A;}
else if(iChoice2==16){iAppearance = APPEARANCE_TYPE_LIZARDFOLK_A;}
else if(iChoice2==17){iAppearance = APPEARANCE_TYPE_MINOTAUR;}
else if(iChoice2==18){iAppearance = APPEARANCE_TYPE_OGRE;}
else if(iChoice2==19){iAppearance = APPEARANCE_TYPE_ORC_A;}
else if(iChoice2==20){iAppearance = APPEARANCE_TYPE_TROLL;}
else if(iChoice2==21){iAppearance = APPEARANCE_TYPE_WERECAT;}
else if(iChoice2==22){iAppearance = APPEARANCE_TYPE_WEREWOLF;}
else if(iChoice2==23){iAppearance = APPEARANCE_TYPE_GNOME;iHead = 30;} // Narok

if((iChoice2==4)||(iChoice2==5)||(iChoice2==7)||(iChoice2==10)||(iChoice2==11)||(iChoice2==12)||(iChoice2==13)){iHead = Random(10)+1;}

     if(iChoice3==1) {iClass = CLASS_TYPE_BARBARIAN;}
else if(iChoice3==2) {iClass = CLASS_TYPE_BARD;}
else if(iChoice3==3) {iClass = CLASS_TYPE_CLERIC;}
else if(iChoice3==4) {iClass = CLASS_TYPE_DRUID;}
else if(iChoice3==5) {iClass = CLASS_TYPE_FIGHTER;}
else if(iChoice3==6) {iClass = CLASS_TYPE_MONK;}
else if(iChoice3==7) {iClass = CLASS_TYPE_PALADIN;}
else if(iChoice3==8) {iClass = CLASS_TYPE_RANGER;}
else if(iChoice3==9) {iClass = CLASS_TYPE_ROGUE;}
else if(iChoice3==10){iClass = CLASS_TYPE_SORCERER;}
else if(iChoice3==11){iClass = CLASS_TYPE_WIZARD;}

SetLocalInt(oNew,"Race",iAppearance);SetLocalInt(oNew,"Class",iClass);SetLocalInt(oNew,"Level",iChoice1);SetLocalInt(oNew,"Head",iHead);SetLocalInt(oNew,"HenchAction",15);ExecuteScript("henchs",oNew);
SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter",iOrigCounter+GetLocalInt(OBJECT_SELF,"Days"+IntToString(iChoice1)));
TakeGoldFromCreature(GetLocalInt(OBJECT_SELF,"Price"+IntToString(iChoice1)),oPC,TRUE);
 }
////////////////////////////////////////////////////////////////////////////////
// Dungeon
else if(iStructure==4)
 {
SetPersistentString(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot),IntToString(iChoice1));
 }
////////////////////////////////////////////////////////////////////////////////
// Extractor
else if(iStructure==5)
 {
sVar = GetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot));

sVar1 = GetStringLeft(sVar,FindSubString(sVar,"_A_"));
sVar2 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_B_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_B_")))-FindSubString(sVar,"_A_")-3);
sVar3 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_C_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_C_")))-FindSubString(sVar,"_B_")-3);
sVar4 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_D_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_D_")))-FindSubString(sVar,"_C_")-3);
sVar5 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_E_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_E_")))-FindSubString(sVar,"_D_")-3);

sBP1L = GetStringLeft(sVar1,FindSubString(sVar1,"%"));sNum1R = GetStringRight(sVar1,GetStringLength(sVar1)-FindSubString(sVar1,"%")-1);iNum1 = StringToInt(sNum1R);
sBP2L = GetStringLeft(sVar2,FindSubString(sVar2,"%"));sNum2R = GetStringRight(sVar2,GetStringLength(sVar2)-FindSubString(sVar2,"%")-1);iNum2 = StringToInt(sNum2R);
sBP3L = GetStringLeft(sVar3,FindSubString(sVar3,"%"));sNum3R = GetStringRight(sVar3,GetStringLength(sVar3)-FindSubString(sVar3,"%")-1);iNum3 = StringToInt(sNum3R);
sBP4L = GetStringLeft(sVar4,FindSubString(sVar4,"%"));sNum4R = GetStringRight(sVar4,GetStringLength(sVar4)-FindSubString(sVar4,"%")-1);iNum4 = StringToInt(sNum4R);
sBP5L = GetStringLeft(sVar5,FindSubString(sVar5,"%"));sNum5R = GetStringRight(sVar5,GetStringLength(sVar5)-FindSubString(sVar5,"%")-1);iNum5 = StringToInt(sNum5R);

if(iChoice2==1)
  {
if(iChoice3<3)
   {
     if(iChoice1==1){i = StringToInt(sNum1R);oNew = CreateItemOnObject(sBP1L);iItemCost = GetGoldPieceValue(oNew)*iDomainItemCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP1L,oPC);iGold = iGold-iItemCost;iItems++;iNum1--;}else{j++;}i--;}}
else if(iChoice1==2){i = StringToInt(sNum2R);oNew = CreateItemOnObject(sBP2L);iItemCost = GetGoldPieceValue(oNew)*iDomainItemCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP2L,oPC);iGold = iGold-iItemCost;iItems++;iNum2--;}else{j++;}i--;}}
else if(iChoice1==3){i = StringToInt(sNum3R);oNew = CreateItemOnObject(sBP3L);iItemCost = GetGoldPieceValue(oNew)*iDomainItemCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP3L,oPC);iGold = iGold-iItemCost;iItems++;iNum3--;}else{j++;}i--;}}
else if(iChoice1==4){i = StringToInt(sNum4R);oNew = CreateItemOnObject(sBP4L);iItemCost = GetGoldPieceValue(oNew)*iDomainItemCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP4L,oPC);iGold = iGold-iItemCost;iItems++;iNum4--;}else{j++;}i--;}}
else if(iChoice1==5){i = StringToInt(sNum5R);oNew = CreateItemOnObject(sBP5L);iItemCost = GetGoldPieceValue(oNew)*iDomainItemCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP5L,oPC);iGold = iGold-iItemCost;iItems++;iNum5--;}else{j++;}i--;}}

TakeGoldFromCreature(iItems*iItemCost,oPC,TRUE);
if(j>0){FloatingTextStringOnCreature("you miss some money to grab all the items",oPC);}else if(((iChoice1==1)&&(iNum1==0))||((iChoice2==1)&&(iNum2==0))||((iChoice3==1)&&(iNum3==0))||((iChoice4==1)&&(iNum4==0))||((iChoice5==1)&&(iNum5==0))){FloatingTextStringOnCreature("container empty",oPC);}

     if(iChoice1==1){sNum1R = IntToString(iNum1);sVar1 = sBP1L+"%"+sNum1R;}
else if(iChoice1==2){sNum2R = IntToString(iNum2);sVar2 = sBP2L+"%"+sNum2R;}
else if(iChoice1==3){sNum3R = IntToString(iNum3);sVar3 = sBP3L+"%"+sNum3R;}
else if(iChoice1==4){sNum4R = IntToString(iNum4);sVar4 = sBP4L+"%"+sNum4R;}
else if(iChoice1==5){sNum5R = IntToString(iNum5);sVar5 = sBP5L+"%"+sNum5R;}
   }
else
   {
     if(iChoice1==1){sVar1 = sBP1L+"%0";}
else if(iChoice1==2){sVar2 = sBP2L+"%0";}
else if(iChoice1==3){sVar3 = sBP3L+"%0";}
else if(iChoice1==4){sVar4 = sBP4L+"%0";}
else if(iChoice1==5){sVar5 = sBP5L+"%0";}
FloatingTextStringOnCreature("container empty",oPC);
   }
  }
else if(iChoice2==2)
  {
sChoice = GetLocalString(oModule,sPlanet+"Rock"+IntToString(iChoice3));
sBP = GetStringLeft(sChoice,FindSubString(sChoice,"%"));

     if(iChoice1==1){sVar1 = sBP+"%0";}
else if(iChoice1==2){sVar2 = sBP+"%0";}
else if(iChoice1==3){sVar3 = sBP+"%0";}
else if(iChoice1==4){sVar4 = sBP+"%0";}
else if(iChoice1==5){sVar5 = sBP+"%0";}
SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(iChoice1),iCounter);
  }
SetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot),sVar1+"_A_"+sVar2+"_B_"+sVar3+"_C_"+sVar4+"_D_"+sVar5+"_E_");
 }
////////////////////////////////////////////////////////////////////////////////
// Factory
else if(iStructure==6)
 {
sVar = GetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot));

sVar1 = GetStringLeft(sVar,FindSubString(sVar,"_A_"));
sVar2 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_B_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_B_")))-FindSubString(sVar,"_A_")-3);
sVar3 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_C_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_C_")))-FindSubString(sVar,"_B_")-3);
sVar4 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_D_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_D_")))-FindSubString(sVar,"_C_")-3);
sVar5 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_E_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_E_")))-FindSubString(sVar,"_D_")-3);

sBP1 = GetStringLeft(sVar1,FindSubString(sVar1,"%001%"));sTag11 = GetStringRight(GetStringLeft(sVar1,FindSubString(sVar1,"%002%")),GetStringLength(GetStringLeft(sVar1,FindSubString(sVar1,"%002%")))-FindSubString(sVar1,"%001%")-5);sTag12 = GetStringRight(GetStringLeft(sVar1,FindSubString(sVar1,"%003%")),GetStringLength(GetStringLeft(sVar1,FindSubString(sVar1,"%003%")))-FindSubString(sVar1,"%002%")-5);sNum11 = GetStringRight(GetStringLeft(sVar1,FindSubString(sVar1,"%004%")),GetStringLength(GetStringLeft(sVar1,FindSubString(sVar1,"%004%")))-FindSubString(sVar1,"%003%")-5);iNum11 = StringToInt(sNum11);sNum12 = GetStringRight(GetStringLeft(sVar1,FindSubString(sVar1,"%005%")),GetStringLength(GetStringLeft(sVar1,FindSubString(sVar1,"%005%")))-FindSubString(sVar1,"%004%")-5);iNum12 = StringToInt(sNum12);sNum1 = GetStringRight(GetStringLeft(sVar1,FindSubString(sVar1,"%006%")),GetStringLength(GetStringLeft(sVar1,FindSubString(sVar1,"%006%")))-FindSubString(sVar1,"%005%")-5);iNum1 = StringToInt(sNum1);
sBP2 = GetStringLeft(sVar2,FindSubString(sVar2,"%001%"));sTag21 = GetStringRight(GetStringLeft(sVar2,FindSubString(sVar2,"%002%")),GetStringLength(GetStringLeft(sVar2,FindSubString(sVar2,"%002%")))-FindSubString(sVar2,"%001%")-5);sTag22 = GetStringRight(GetStringLeft(sVar2,FindSubString(sVar2,"%003%")),GetStringLength(GetStringLeft(sVar2,FindSubString(sVar2,"%003%")))-FindSubString(sVar2,"%002%")-5);sNum21 = GetStringRight(GetStringLeft(sVar2,FindSubString(sVar2,"%004%")),GetStringLength(GetStringLeft(sVar2,FindSubString(sVar2,"%004%")))-FindSubString(sVar2,"%003%")-5);iNum21 = StringToInt(sNum21);sNum22 = GetStringRight(GetStringLeft(sVar2,FindSubString(sVar2,"%005%")),GetStringLength(GetStringLeft(sVar2,FindSubString(sVar2,"%005%")))-FindSubString(sVar2,"%004%")-5);iNum22 = StringToInt(sNum22);sNum2 = GetStringRight(GetStringLeft(sVar2,FindSubString(sVar2,"%006%")),GetStringLength(GetStringLeft(sVar2,FindSubString(sVar2,"%006%")))-FindSubString(sVar2,"%005%")-5);iNum2 = StringToInt(sNum2);
sBP3 = GetStringLeft(sVar3,FindSubString(sVar3,"%001%"));sTag31 = GetStringRight(GetStringLeft(sVar3,FindSubString(sVar3,"%002%")),GetStringLength(GetStringLeft(sVar3,FindSubString(sVar3,"%002%")))-FindSubString(sVar3,"%001%")-5);sTag32 = GetStringRight(GetStringLeft(sVar3,FindSubString(sVar3,"%003%")),GetStringLength(GetStringLeft(sVar3,FindSubString(sVar3,"%003%")))-FindSubString(sVar3,"%002%")-5);sNum31 = GetStringRight(GetStringLeft(sVar3,FindSubString(sVar3,"%004%")),GetStringLength(GetStringLeft(sVar3,FindSubString(sVar3,"%004%")))-FindSubString(sVar3,"%003%")-5);iNum31 = StringToInt(sNum31);sNum32 = GetStringRight(GetStringLeft(sVar3,FindSubString(sVar3,"%005%")),GetStringLength(GetStringLeft(sVar3,FindSubString(sVar3,"%005%")))-FindSubString(sVar3,"%004%")-5);iNum32 = StringToInt(sNum32);sNum3 = GetStringRight(GetStringLeft(sVar3,FindSubString(sVar3,"%006%")),GetStringLength(GetStringLeft(sVar3,FindSubString(sVar3,"%006%")))-FindSubString(sVar3,"%005%")-5);iNum3 = StringToInt(sNum3);
sBP4 = GetStringLeft(sVar4,FindSubString(sVar4,"%001%"));sTag41 = GetStringRight(GetStringLeft(sVar4,FindSubString(sVar4,"%002%")),GetStringLength(GetStringLeft(sVar4,FindSubString(sVar4,"%002%")))-FindSubString(sVar4,"%001%")-5);sTag42 = GetStringRight(GetStringLeft(sVar4,FindSubString(sVar4,"%003%")),GetStringLength(GetStringLeft(sVar4,FindSubString(sVar4,"%003%")))-FindSubString(sVar4,"%002%")-5);sNum41 = GetStringRight(GetStringLeft(sVar4,FindSubString(sVar4,"%004%")),GetStringLength(GetStringLeft(sVar4,FindSubString(sVar4,"%004%")))-FindSubString(sVar4,"%003%")-5);iNum41 = StringToInt(sNum41);sNum42 = GetStringRight(GetStringLeft(sVar4,FindSubString(sVar4,"%005%")),GetStringLength(GetStringLeft(sVar4,FindSubString(sVar4,"%005%")))-FindSubString(sVar4,"%004%")-5);iNum42 = StringToInt(sNum42);sNum4 = GetStringRight(GetStringLeft(sVar4,FindSubString(sVar4,"%006%")),GetStringLength(GetStringLeft(sVar4,FindSubString(sVar4,"%006%")))-FindSubString(sVar4,"%005%")-5);iNum4 = StringToInt(sNum4);
sBP5 = GetStringLeft(sVar5,FindSubString(sVar5,"%001%"));sTag51 = GetStringRight(GetStringLeft(sVar5,FindSubString(sVar5,"%002%")),GetStringLength(GetStringLeft(sVar5,FindSubString(sVar5,"%002%")))-FindSubString(sVar5,"%001%")-5);sTag52 = GetStringRight(GetStringLeft(sVar5,FindSubString(sVar5,"%003%")),GetStringLength(GetStringLeft(sVar5,FindSubString(sVar5,"%003%")))-FindSubString(sVar5,"%002%")-5);sNum51 = GetStringRight(GetStringLeft(sVar5,FindSubString(sVar5,"%004%")),GetStringLength(GetStringLeft(sVar5,FindSubString(sVar5,"%004%")))-FindSubString(sVar5,"%003%")-5);iNum51 = StringToInt(sNum51);sNum52 = GetStringRight(GetStringLeft(sVar5,FindSubString(sVar5,"%005%")),GetStringLength(GetStringLeft(sVar5,FindSubString(sVar5,"%005%")))-FindSubString(sVar5,"%004%")-5);iNum52 = StringToInt(sNum52);sNum5 = GetStringRight(GetStringLeft(sVar5,FindSubString(sVar5,"%006%")),GetStringLength(GetStringLeft(sVar5,FindSubString(sVar5,"%006%")))-FindSubString(sVar5,"%005%")-5);iNum5 = StringToInt(sNum5);

////////////////////////////////////////
// Take crafted items & remaining resources
if(iChoice2==1)
  {
////////////////////////////////////////
// Take back items
if(iChoice3<3)
   {
     if(iChoice1==1){i = iNum1;oNew = CreateItemOnObject(sBP1L);iItemCost = GetGoldPieceValue(oNew)*iDomainFacItemCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){if((GetStringLeft(sBP1,1)=="2")||(GetStringLeft(sBP1,1)=="3")||(GetStringLeft(sBP1,1)=="4")){sUpgrade1 = GetStringLeft(sBP1,1);sBP1 = GetStringRight(sBP1,GetStringLength(sBP1)-1);}oNew = CreateItemOnObject(sBP1,oPC,1,sUpgrade1+sBP1);sName = GetName(oNew);if(sUpgrade1=="2"){sName = "Improved "+sName;}else if(sUpgrade1=="3"){sName = "Quality "+sName;}else if(sUpgrade1=="4"){sName = "Precious "+sName;}if(sName!=GetName(oNew)){SetName(oNew,sName);}iGold = iGold-iItemCost;iItems++;iNum1--;}else{j++;}i--;}}
else if(iChoice1==2){i = iNum2;oNew = CreateItemOnObject(sBP2L);iItemCost = GetGoldPieceValue(oNew)*iDomainFacItemCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){if((GetStringLeft(sBP2,1)=="2")||(GetStringLeft(sBP2,1)=="3")||(GetStringLeft(sBP2,1)=="4")){sUpgrade1 = GetStringLeft(sBP2,1);sBP2 = GetStringRight(sBP2,GetStringLength(sBP2)-1);}oNew = CreateItemOnObject(sBP2,oPC,1,sUpgrade1+sBP2);sName = GetName(oNew);if(sUpgrade1=="2"){sName = "Improved "+sName;}else if(sUpgrade1=="3"){sName = "Quality "+sName;}else if(sUpgrade1=="4"){sName = "Precious "+sName;}if(sName!=GetName(oNew)){SetName(oNew,sName);}iGold = iGold-iItemCost;iItems++;iNum2--;}else{j++;}i--;}}
else if(iChoice1==3){i = iNum3;oNew = CreateItemOnObject(sBP3L);iItemCost = GetGoldPieceValue(oNew)*iDomainFacItemCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){if((GetStringLeft(sBP3,1)=="2")||(GetStringLeft(sBP3,1)=="3")||(GetStringLeft(sBP3,1)=="4")){sUpgrade1 = GetStringLeft(sBP3,1);sBP3 = GetStringRight(sBP3,GetStringLength(sBP3)-1);}oNew = CreateItemOnObject(sBP3,oPC,1,sUpgrade1+sBP3);sName = GetName(oNew);if(sUpgrade1=="2"){sName = "Improved "+sName;}else if(sUpgrade1=="3"){sName = "Quality "+sName;}else if(sUpgrade1=="4"){sName = "Precious "+sName;}if(sName!=GetName(oNew)){SetName(oNew,sName);}iGold = iGold-iItemCost;iItems++;iNum3--;}else{j++;}i--;}}
else if(iChoice1==4){i = iNum4;oNew = CreateItemOnObject(sBP4L);iItemCost = GetGoldPieceValue(oNew)*iDomainFacItemCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){if((GetStringLeft(sBP4,1)=="2")||(GetStringLeft(sBP4,1)=="3")||(GetStringLeft(sBP4,1)=="4")){sUpgrade1 = GetStringLeft(sBP4,1);sBP4 = GetStringRight(sBP4,GetStringLength(sBP4)-1);}oNew = CreateItemOnObject(sBP4,oPC,1,sUpgrade1+sBP4);sName = GetName(oNew);if(sUpgrade1=="2"){sName = "Improved "+sName;}else if(sUpgrade1=="3"){sName = "Quality "+sName;}else if(sUpgrade1=="4"){sName = "Precious "+sName;}if(sName!=GetName(oNew)){SetName(oNew,sName);}iGold = iGold-iItemCost;iItems++;iNum4--;}else{j++;}i--;}}
else if(iChoice1==5){i = iNum5;oNew = CreateItemOnObject(sBP5L);iItemCost = GetGoldPieceValue(oNew)*iDomainFacItemCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){if((GetStringLeft(sBP5,1)=="2")||(GetStringLeft(sBP5,1)=="3")||(GetStringLeft(sBP5,1)=="4")){sUpgrade1 = GetStringLeft(sBP5,1);sBP5 = GetStringRight(sBP5,GetStringLength(sBP5)-1);}oNew = CreateItemOnObject(sBP5,oPC,1,sUpgrade1+sBP5);sName = GetName(oNew);if(sUpgrade1=="2"){sName = "Improved "+sName;}else if(sUpgrade1=="3"){sName = "Quality "+sName;}else if(sUpgrade1=="4"){sName = "Precious "+sName;}if(sName!=GetName(oNew)){SetName(oNew,sName);}iGold = iGold-iItemCost;iItems++;iNum5--;}else{j++;}i--;}}

TakeGoldFromCreature(iItems*iItemCost,oPC,TRUE);
if(j>0){FloatingTextStringOnCreature("you miss some money to grab all the items",oPC);}else if(((iChoice1==1)&&(iNum1==0))||((iChoice2==1)&&(iNum2==0))||((iChoice3==1)&&(iNum3==0))||((iChoice4==1)&&(iNum4==0))||((iChoice5==1)&&(iNum5==0))){FloatingTextStringOnCreature("container empty",oPC);}

     if(iChoice1==1){iNum1 = iNum11;iNum2 = iNum12;sTag1 = sTag11;sTag2 = sTag12;sVar1 = sBP1+"%001%"+sTag11+"%002%"+sTag12+"%003%0%004%0%005%0%006%";}
else if(iChoice1==2){iNum2 = iNum21;iNum2 = iNum22;sTag1 = sTag21;sTag2 = sTag22;sVar2 = sBP2+"%001%"+sTag21+"%002%"+sTag22+"%003%0%004%0%005%0%006%";}
else if(iChoice1==3){iNum3 = iNum31;iNum2 = iNum32;sTag1 = sTag31;sTag2 = sTag32;sVar3 = sBP3+"%001%"+sTag31+"%002%"+sTag32+"%003%0%004%0%005%0%006%";}
else if(iChoice1==4){iNum4 = iNum41;iNum2 = iNum42;sTag1 = sTag41;sTag2 = sTag42;sVar4 = sBP4+"%001%"+sTag41+"%002%"+sTag42+"%003%0%004%0%005%0%006%";}
else if(iChoice1==5){iNum5 = iNum51;iNum2 = iNum52;sTag1 = sTag51;sTag2 = sTag52;sVar5 = sBP5+"%001%"+sTag51+"%002%"+sTag52+"%003%0%004%0%005%0%006%";}

while(iNum1>0){if((GetStringLeft(sTag1,1)=="2")||(GetStringLeft(sTag1,1)=="3")||(GetStringLeft(sTag1,1)=="4")){sUpgrade1 = GetStringLeft(sTag1,1);sTag1 = GetStringRight(sTag1,GetStringLength(sTag1)-1);}oNew = CreateItemOnObject(sTag1,oPC,1,sUpgrade1+sTag1);sName = GetName(oNew);if(sUpgrade1=="2"){sName = "Improved "+sName;}else if(sUpgrade1=="3"){sName = "Quality "+sName;}else if(sUpgrade1=="4"){sName = "Precious "+sName;}if(sName!=GetName(oNew)){SetName(oNew,sName);}iNum1--;}
while(iNum2>0){if((GetStringLeft(sTag2,1)=="2")||(GetStringLeft(sTag2,1)=="3")||(GetStringLeft(sTag2,1)=="4")){sUpgrade2 = GetStringLeft(sTag2,1);sTag2 = GetStringRight(sTag2,GetStringLength(sTag2)-1);}oNew = CreateItemOnObject(sTag2,oPC,1,sUpgrade2+sTag2);sName = GetName(oNew);if(sUpgrade2=="2"){sName = "Improved "+sName;}else if(sUpgrade2=="3"){sName = "Quality "+sName;}else if(sUpgrade2=="4"){sName = "Precious "+sName;}if(sName!=GetName(oNew)){SetName(oNew,sName);}iNum2--;}
   }
////////////////////////////////////////
// Add resources
else if(iChoice3==3)
   {
     if(iChoice1==1){sBP = sBP1;sTag1 = sTag11;sTag2 = sTag12;}
else if(iChoice1==2){sBP = sBP2;sTag1 = sTag21;sTag2 = sTag22;}
else if(iChoice1==3){sBP = sBP3;sTag1 = sTag31;sTag2 = sTag32;}
else if(iChoice1==4){sBP = sBP4;sTag1 = sTag41;sTag2 = sTag42;}
else if(iChoice1==5){sBP = sBP5;sTag1 = sTag51;sTag2 = sTag52;}

oItems = GetFirstItemInInventory(oPC);while(GetIsObjectValid(oItems)){if(GetTag(oItems)==sTag1){i1++;}else if(GetTag(oItems)==sTag2){i2++;}oItems = GetNextItemInInventory(oPC);}
if(i2==0){i1 = i1/2;i2 = i1;}if(iChoice4>0){if(i1>iChoice4){i1 = iChoice4;}if(i2>iChoice4){i2 = iChoice4;}}
if(i2>i1){i2 = i1;}else if(i1>i2){i1 = i2;}i = i1;
oItems = GetFirstItemInInventory(oPC);while(GetIsObjectValid(oItems)){if((GetTag(oItems)==sTag1)&&(i1>0)){i1--;DestroyObject(oItems);}else if((GetTag(oItems)==sTag2)&&(i2>0)){i2--;DestroyObject(oItems);}oItems = GetNextItemInInventory(oPC);}

// i = Number of items that can be added with oPC's resources
     if(iChoice1==1){sVar1 = sBP+"%001%"+sTag1+"%002%"+sTag2+"%003%"+IntToString(iNum11+i)+"%004%"+IntToString(iNum12+i)+"%005%"+sNum1+"%006%";}
else if(iChoice1==2){sVar2 = sBP+"%001%"+sTag1+"%002%"+sTag2+"%003%"+IntToString(iNum21+i)+"%004%"+IntToString(iNum22+i)+"%005%"+sNum2+"%006%";}
else if(iChoice1==3){sVar3 = sBP+"%001%"+sTag1+"%002%"+sTag2+"%003%"+IntToString(iNum31+i)+"%004%"+IntToString(iNum32+i)+"%005%"+sNum3+"%006%";}
else if(iChoice1==4){sVar4 = sBP+"%001%"+sTag1+"%002%"+sTag2+"%003%"+IntToString(iNum41+i)+"%004%"+IntToString(iNum42+i)+"%005%"+sNum4+"%006%";}
else if(iChoice1==5){sVar5 = sBP+"%001%"+sTag1+"%002%"+sTag2+"%003%"+IntToString(iNum51+i)+"%004%"+IntToString(iNum52+i)+"%005%"+sNum5+"%006%";}

FloatingTextStringOnCreature(IntToString(i)+" more items will be crafted",oPC);
   }
////////////////////////////////////////
// Empty container
else
   {
FloatingTextStringOnCreature("container empty",oPC);

     if(iChoice1==1){iNum1 = iNum11;iNum2 = iNum12;sTag1 = sTag11;sTag2 = sTag12;sVar1 = sBP1+"%001%"+sTag11+"%002%"+sTag12+"%003%0%004%0%005%0%006%";}
else if(iChoice1==2){iNum1 = iNum21;iNum2 = iNum22;sTag1 = sTag21;sTag2 = sTag22;sVar2 = sBP2+"%001%"+sTag21+"%002%"+sTag22+"%003%0%004%0%005%0%006%";}
else if(iChoice1==3){iNum1 = iNum31;iNum2 = iNum32;sTag1 = sTag31;sTag2 = sTag32;sVar3 = sBP3+"%001%"+sTag31+"%002%"+sTag32+"%003%0%004%0%005%0%006%";}
else if(iChoice1==4){iNum1 = iNum41;iNum2 = iNum42;sTag1 = sTag41;sTag2 = sTag42;sVar4 = sBP4+"%001%"+sTag41+"%002%"+sTag42+"%003%0%004%0%005%0%006%";}
else if(iChoice1==5){iNum1 = iNum51;iNum2 = iNum52;sTag1 = sTag51;sTag2 = sTag52;sVar5 = sBP5+"%001%"+sTag51+"%002%"+sTag52+"%003%0%004%0%005%0%006%";}

while(iNum>0){if((GetStringLeft(sTag1,1)=="2")||(GetStringLeft(sTag1,1)=="3")||(GetStringLeft(sTag1,1)=="4")){sUpgrade1 = GetStringLeft(sTag1,1);sTag1 = GetStringRight(sTag1,GetStringLength(sTag1)-1);}oNew = CreateItemOnObject(sTag1,oPC,1,sUpgrade1+sTag1);sName = GetName(oNew);if(sUpgrade1=="2"){sName = "Improved "+sName;}else if(sUpgrade1=="3"){sName = "Quality "+sName;}else if(sUpgrade1=="4"){sName = "Precious "+sName;}if(sName!=GetName(oNew)){SetName(oNew,sName);}if((GetStringLeft(sTag2,1)=="2")||(GetStringLeft(sTag2,1)=="3")||(GetStringLeft(sTag2,1)=="4")){sUpgrade2 = GetStringLeft(sTag2,1);sTag2 = GetStringRight(sTag2,GetStringLength(sTag2)-1);}oNew = CreateItemOnObject(sTag2,oPC,1,sUpgrade2+sTag2);sName = GetName(oNew);if(sUpgrade2=="2"){sName = "Improved "+sName;}else if(sUpgrade2=="3"){sName = "Quality "+sName;}else if(sUpgrade2=="4"){sName = "Precious "+sName;}if(sName!=GetName(oNew)){SetName(oNew,sName);}iNum--;}
   }
  }
////////////////////////////////////////
// Set crafting
else if(iChoice2==2)
  {
sBP = GetLocalString(OBJECT_SELF,"ItemBP"+IntToString(iChoice3));
sName = GetLocalString(OBJECT_SELF,"ItemName"+IntToString(iChoice3));
sTag1 = GetLocalString(OBJECT_SELF,"ItemTag1"+IntToString(iChoice3));
sTag2 = GetLocalString(OBJECT_SELF,"ItemTag2"+IntToString(iChoice3));

if(iChoice4!=2) // Don't take resources from inventory when choice = link factory
   {
oItems = GetFirstItemInInventory(oPC);while(GetIsObjectValid(oItems)){if(GetTag(oItems)==sTag1){i1++;}else if(GetTag(oItems)==sTag2){i2++;}oItems = GetNextItemInInventory(oPC);}
if(i2==0){i1 = i1/2;i2 = i1;}if(iChoice4>0){if(i1>iChoice4){i1 = iChoice4;}if(i2>iChoice4){i2 = iChoice4;}}
if(i2>i1){i2 = i1;}else if(i1>i2){i1 = i2;}i = i1;
oItems = GetFirstItemInInventory(oPC);while(GetIsObjectValid(oItems)){if((GetTag(oItems)==sTag1)&&(i1>0)){i1--;DestroyObject(oItems);}else if((GetTag(oItems)==sTag2)&&(i2>0)){i2--;DestroyObject(oItems);}oItems = GetNextItemInInventory(oPC);}
   }
// i = Number of items that can be created with oPC's resources
     if(iChoice1==1){sVar1 = sBP+"%001%"+sTag1+"%002%"+sTag2+"%003%"+IntToString(i)+"%004%"+IntToString(i)+"%005%0%006%";}
else if(iChoice1==2){sVar2 = sBP+"%001%"+sTag1+"%002%"+sTag2+"%003%"+IntToString(i)+"%004%"+IntToString(i)+"%005%0%006%";}
else if(iChoice1==3){sVar3 = sBP+"%001%"+sTag1+"%002%"+sTag2+"%003%"+IntToString(i)+"%004%"+IntToString(i)+"%005%0%006%";}
else if(iChoice1==4){sVar4 = sBP+"%001%"+sTag1+"%002%"+sTag2+"%003%"+IntToString(i)+"%004%"+IntToString(i)+"%005%0%006%";}
else if(iChoice1==5){sVar5 = sBP+"%001%"+sTag1+"%002%"+sTag2+"%003%"+IntToString(i)+"%004%"+IntToString(i)+"%005%0%006%";}

if(iChoice4==2){FloatingTextStringOnCreature(sName+" will be crafted with automatic resources",oPC);}else{FloatingTextStringOnCreature(IntToString(i)+" "+sName+" will be crafted",oPC);}
SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(iChoice1),iCounter);
  }
SetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot),sVar1+"_A_"+sVar2+"_B_"+sVar3+"_C_"+sVar4+"_D_"+sVar5+"_E_");
 }
////////////////////////////////////////////////////////////////////////////////
// Farm
else if(iStructure==7)
 {
sVar = GetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot));

sVar1 = GetStringLeft(sVar,FindSubString(sVar,"_A_"));
sVar2 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_B_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_B_")))-FindSubString(sVar,"_A_")-3);
sVar3 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_C_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_C_")))-FindSubString(sVar,"_B_")-3);
sVar4 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_D_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_D_")))-FindSubString(sVar,"_C_")-3);
sVar5 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_E_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_E_")))-FindSubString(sVar,"_D_")-3);

sBP1L = GetStringLeft(sVar1,FindSubString(sVar1,"%"));sNum1R = GetStringRight(sVar1,GetStringLength(sVar1)-FindSubString(sVar1,"%")-1);iNum1 = StringToInt(sNum1R);
sBP2L = GetStringLeft(sVar2,FindSubString(sVar2,"%"));sNum2R = GetStringRight(sVar2,GetStringLength(sVar2)-FindSubString(sVar2,"%")-1);iNum2 = StringToInt(sNum2R);
sBP3L = GetStringLeft(sVar3,FindSubString(sVar3,"%"));sNum3R = GetStringRight(sVar3,GetStringLength(sVar3)-FindSubString(sVar3,"%")-1);iNum3 = StringToInt(sNum3R);
sBP4L = GetStringLeft(sVar4,FindSubString(sVar4,"%"));sNum4R = GetStringRight(sVar4,GetStringLength(sVar4)-FindSubString(sVar4,"%")-1);iNum4 = StringToInt(sNum4R);
sBP5L = GetStringLeft(sVar5,FindSubString(sVar5,"%"));sNum5R = GetStringRight(sVar5,GetStringLength(sVar5)-FindSubString(sVar5,"%")-1);iNum5 = StringToInt(sNum5R);

if(iChoice2==1)
  {
if(iChoice3<3)
   {
     if(iChoice1==1){i = StringToInt(sNum1R);oNew = CreateItemOnObject(sBP1L+"t");iItemCost = GetGoldPieceValue(oNew)*iDomainAniCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP1L+"t",oPC);iGold = iGold-iItemCost;iItems++;iNum1--;}else{j++;}i--;}}
else if(iChoice1==2){i = StringToInt(sNum2R);oNew = CreateItemOnObject(sBP2L+"t");iItemCost = GetGoldPieceValue(oNew)*iDomainAniCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP2L+"t",oPC);iGold = iGold-iItemCost;iItems++;iNum2--;}else{j++;}i--;}}
else if(iChoice1==3){i = StringToInt(sNum3R);oNew = CreateItemOnObject(sBP3L+"t");iItemCost = GetGoldPieceValue(oNew)*iDomainAniCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP3L+"t",oPC);iGold = iGold-iItemCost;iItems++;iNum3--;}else{j++;}i--;}}
else if(iChoice1==4){i = StringToInt(sNum4R);oNew = CreateItemOnObject(sBP4L+"t");iItemCost = GetGoldPieceValue(oNew)*iDomainAniCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP4L+"t",oPC);iGold = iGold-iItemCost;iItems++;iNum4--;}else{j++;}i--;}}
else if(iChoice1==5){i = StringToInt(sNum5R);oNew = CreateItemOnObject(sBP5L+"t");iItemCost = GetGoldPieceValue(oNew)*iDomainAniCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP5L+"t",oPC);iGold = iGold-iItemCost;iItems++;iNum5--;}else{j++;}i--;}}

TakeGoldFromCreature(iItems*iItemCost,oPC,TRUE);
if(j>0){FloatingTextStringOnCreature("you miss some money to take all the animals",oPC);}else{FloatingTextStringOnCreature("container empty",oPC);}

     if(iChoice1==1){sNum1R = IntToString(iNum1);sVar1 = sBP1L+"%"+sNum1R;}
else if(iChoice1==2){sNum2R = IntToString(iNum2);sVar2 = sBP2L+"%"+sNum2R;}
else if(iChoice1==3){sNum3R = IntToString(iNum3);sVar3 = sBP3L+"%"+sNum3R;}
else if(iChoice1==4){sNum4R = IntToString(iNum4);sVar4 = sBP4L+"%"+sNum4R;}
else if(iChoice1==5){sNum5R = IntToString(iNum5);sVar5 = sBP5L+"%"+sNum5R;}
   }
else
   {
     if(iChoice1==1){sVar1 = sBP1L+"%0";}
else if(iChoice1==2){sVar2 = sBP2L+"%0";}
else if(iChoice1==3){sVar3 = sBP3L+"%0";}
else if(iChoice1==4){sVar4 = sBP4L+"%0";}
else if(iChoice1==5){sVar5 = sBP5L+"%0";}
FloatingTextStringOnCreature("container empty",oPC);
   }
  }
else if(iChoice2==2)
  {
sChoice = GetLocalString(oModule,sPlanet+"Ani"+IntToString(iChoice3));
sBP = GetStringLeft(sChoice,FindSubString(sChoice,"%"));

     if(iChoice1==1){sVar1 = sBP+"%0";fX = fX-5.0;fY = fY+3.0;}
else if(iChoice1==2){sVar2 = sBP+"%0";fX = fX+5.0;fY = fY+3.0;}
else if(iChoice1==3){sVar3 = sBP+"%0";fX = fX+5.0;fY = fY+13.0;}
else if(iChoice1==4){sVar4 = sBP+"%0";}
else if(iChoice1==5){sVar5 = sBP+"%0";}
SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(iChoice1),iCounter);

if(iChoice1<=3)
   {
while(GetIsObjectValid(oObjects)){if((GetLocalInt(oObjects,"Slot")==iSlot)&&(GetLocalInt(oObjects,"Garden")==iChoice1)){SetImmortal(oObjects,FALSE);SetPlotFlag(oObjects,FALSE);AssignCommand(oObjects,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oObjects);}oObjects = GetNextObjectInArea(oArea);}
i=0;while(i<4){i++;oNew = CreateObject(OBJECT_TYPE_CREATURE,sBP,Location(oArea,Vector(fX,fY,0.0),IntToFloat(Random(360))));ChangeToStandardFaction(oNew,STANDARD_FACTION_MERCHANT);SetPlotFlag(oNew,TRUE);SetLocalInt(oNew,"Stop",1);SetLocalInt(oNew,"DontSave",1);SetLocalString(oNew,"Master",GetName(oPC));SetLocalInt(oNew,"Slot",iSlot);SetLocalInt(oNew,"Garden",iChoice1);SetLocalInt(oNew,"NotFlee",1);SetLocalInt(oNew,"NoReaction",1);DeleteLocalInt(oNew,"Hench");AssignCommand(oNew,ActionRandomWalk());}

sVar = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot));
sBP1 = GetStringLeft(sVar,FindSubString(sVar,"_A_"));
sBP2 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_B_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_B_")))-FindSubString(sVar,"_A_")-3);
sBP3 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_C_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_C_")))-FindSubString(sVar,"_B_")-3);

     if(iChoice1==1){sBP1 = sBP;}
else if(iChoice1==2){sBP2 = sBP;}
else if(iChoice1==3){sBP3 = sBP;}

SetPersistentString(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot),sBP1+"_A_"+sBP2+"_B_"+sBP3+"_C_");
   }
  }
SetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot),sVar1+"_A_"+sVar2+"_B_"+sVar3+"_C_"+sVar4+"_D_"+sVar5+"_E_");
 }
////////////////////////////////////////////////////////////////////////////////
// Field
else if(iStructure==8)
 {
sVar = GetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot));

sVar1 = GetStringLeft(sVar,FindSubString(sVar,"_A_"));
sVar2 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_B_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_B_")))-FindSubString(sVar,"_A_")-3);
sVar3 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_C_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_C_")))-FindSubString(sVar,"_B_")-3);
sVar4 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_D_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_D_")))-FindSubString(sVar,"_C_")-3);
sVar5 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_E_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_E_")))-FindSubString(sVar,"_D_")-3);

sBP1L = GetStringLeft(sVar1,FindSubString(sVar1,"%"));sNum1R = GetStringRight(sVar1,GetStringLength(sVar1)-FindSubString(sVar1,"%")-1);iNum1 = StringToInt(sNum1R);
sBP2L = GetStringLeft(sVar2,FindSubString(sVar2,"%"));sNum2R = GetStringRight(sVar2,GetStringLength(sVar2)-FindSubString(sVar2,"%")-1);iNum2 = StringToInt(sNum2R);
sBP3L = GetStringLeft(sVar3,FindSubString(sVar3,"%"));sNum3R = GetStringRight(sVar3,GetStringLength(sVar3)-FindSubString(sVar3,"%")-1);iNum3 = StringToInt(sNum3R);
sBP4L = GetStringLeft(sVar4,FindSubString(sVar4,"%"));sNum4R = GetStringRight(sVar4,GetStringLength(sVar4)-FindSubString(sVar4,"%")-1);iNum4 = StringToInt(sNum4R);
sBP5L = GetStringLeft(sVar5,FindSubString(sVar5,"%"));sNum5R = GetStringRight(sVar5,GetStringLength(sVar5)-FindSubString(sVar5,"%")-1);iNum5 = StringToInt(sNum5R);

if(iChoice2==1)
  {
if(iChoice3<3)
   {
     if(iChoice1==1){i = StringToInt(sNum1R);oNew = CreateItemOnObject(sBP1L);iItemCost = GetGoldPieceValue(oNew)*iDomainPlantCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP1L,oPC);iGold = iGold-iItemCost;iItems++;iNum1--;}else{j++;}i--;}}
else if(iChoice1==2){i = StringToInt(sNum2R);oNew = CreateItemOnObject(sBP2L);iItemCost = GetGoldPieceValue(oNew)*iDomainPlantCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP2L,oPC);iGold = iGold-iItemCost;iItems++;iNum2--;}else{j++;}i--;}}
else if(iChoice1==3){i = StringToInt(sNum3R);oNew = CreateItemOnObject(sBP3L);iItemCost = GetGoldPieceValue(oNew)*iDomainPlantCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP3L,oPC);iGold = iGold-iItemCost;iItems++;iNum3--;}else{j++;}i--;}}
else if(iChoice1==4){i = StringToInt(sNum4R);oNew = CreateItemOnObject(sBP4L);iItemCost = GetGoldPieceValue(oNew)*iDomainPlantCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP4L,oPC);iGold = iGold-iItemCost;iItems++;iNum4--;}else{j++;}i--;}}
else if(iChoice1==5){i = StringToInt(sNum5R);oNew = CreateItemOnObject(sBP5L);iItemCost = GetGoldPieceValue(oNew)*iDomainPlantCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP5L,oPC);iGold = iGold-iItemCost;iItems++;iNum5--;}else{j++;}i--;}}

TakeGoldFromCreature(iItems*iItemCost,oPC,TRUE);
if(j>0){FloatingTextStringOnCreature("you miss some money to cut all the plants",oPC);}else if(((iChoice1==1)&&(iNum1==0))||((iChoice2==1)&&(iNum2==0))||((iChoice3==1)&&(iNum3==0))||((iChoice4==1)&&(iNum4==0))||((iChoice5==1)&&(iNum5==0))){FloatingTextStringOnCreature("container empty",oPC);}

     if(iChoice1==1){sNum1R = IntToString(iNum1);sVar1 = sBP1L+"%"+sNum1R;}
else if(iChoice1==2){sNum2R = IntToString(iNum2);sVar2 = sBP2L+"%"+sNum2R;}
else if(iChoice1==3){sNum3R = IntToString(iNum3);sVar3 = sBP3L+"%"+sNum3R;}
else if(iChoice1==4){sNum4R = IntToString(iNum4);sVar4 = sBP4L+"%"+sNum4R;}
else if(iChoice1==5){sNum5R = IntToString(iNum5);sVar5 = sBP5L+"%"+sNum5R;}
   }
else
   {
     if(iChoice1==1){sVar1 = sBP1L+"%0";}
else if(iChoice1==2){sVar2 = sBP2L+"%0";}
else if(iChoice1==3){sVar3 = sBP3L+"%0";}
else if(iChoice1==4){sVar4 = sBP4L+"%0";}
else if(iChoice1==5){sVar5 = sBP5L+"%0";}
FloatingTextStringOnCreature("container empty",oPC);
   }
  }
else if(iChoice2==2)
  {
sChoice = GetLocalString(oModule,sPlanet+"Plant"+IntToString(iChoice3));
sBP = GetStringLeft(sChoice,FindSubString(sChoice,"%"));

     if(iChoice1==1){sVar1 = sBP+"%0";}
else if(iChoice1==2){sVar2 = sBP+"%0";}
else if(iChoice1==3){sVar3 = sBP+"%0";}
else if(iChoice1==4){sVar4 = sBP+"%0";}
else if(iChoice1==5){sVar5 = sBP+"%0";}
SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(iChoice1),iCounter);
  }
SetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot),sVar1+"_A_"+sVar2+"_B_"+sVar3+"_C_"+sVar4+"_D_"+sVar5+"_E_");
 }
////////////////////////////////////////////////////////////////////////////////
// Sawmill
else if(iStructure==21)
 {
sVar = GetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot));

sVar1 = GetStringLeft(sVar,FindSubString(sVar,"_A_"));
sVar2 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_B_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_B_")))-FindSubString(sVar,"_A_")-3);
sVar3 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_C_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_C_")))-FindSubString(sVar,"_B_")-3);
sVar4 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_D_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_D_")))-FindSubString(sVar,"_C_")-3);
sVar5 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_E_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_E_")))-FindSubString(sVar,"_D_")-3);

sBP1L = GetStringLeft(sVar1,FindSubString(sVar1,"%"));sNum1R = GetStringRight(sVar1,GetStringLength(sVar1)-FindSubString(sVar1,"%")-1);iNum1 = StringToInt(sNum1R);
sBP2L = GetStringLeft(sVar2,FindSubString(sVar2,"%"));sNum2R = GetStringRight(sVar2,GetStringLength(sVar2)-FindSubString(sVar2,"%")-1);iNum2 = StringToInt(sNum2R);
sBP3L = GetStringLeft(sVar3,FindSubString(sVar3,"%"));sNum3R = GetStringRight(sVar3,GetStringLength(sVar3)-FindSubString(sVar3,"%")-1);iNum3 = StringToInt(sNum3R);
sBP4L = GetStringLeft(sVar4,FindSubString(sVar4,"%"));sNum4R = GetStringRight(sVar4,GetStringLength(sVar4)-FindSubString(sVar4,"%")-1);iNum4 = StringToInt(sNum4R);
sBP5L = GetStringLeft(sVar5,FindSubString(sVar5,"%"));sNum5R = GetStringRight(sVar5,GetStringLength(sVar5)-FindSubString(sVar5,"%")-1);iNum5 = StringToInt(sNum5R);

if(iChoice2==1)
  {
if(iChoice3<3)
   {
     if(iChoice1==1){i = StringToInt(sNum1R);oNew = CreateItemOnObject(sBP1L);iItemCost = GetGoldPieceValue(oNew)*iDomainPlankCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP1L,oPC);iGold = iGold-iItemCost;iItems++;iNum1--;}else{j++;}i--;}}
else if(iChoice1==2){i = StringToInt(sNum2R);oNew = CreateItemOnObject(sBP2L);iItemCost = GetGoldPieceValue(oNew)*iDomainPlankCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP2L,oPC);iGold = iGold-iItemCost;iItems++;iNum2--;}else{j++;}i--;}}
else if(iChoice1==3){i = StringToInt(sNum3R);oNew = CreateItemOnObject(sBP3L);iItemCost = GetGoldPieceValue(oNew)*iDomainPlankCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP3L,oPC);iGold = iGold-iItemCost;iItems++;iNum3--;}else{j++;}i--;}}
else if(iChoice1==4){i = StringToInt(sNum4R);oNew = CreateItemOnObject(sBP4L);iItemCost = GetGoldPieceValue(oNew)*iDomainPlankCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP4L,oPC);iGold = iGold-iItemCost;iItems++;iNum4--;}else{j++;}i--;}}
else if(iChoice1==5){i = StringToInt(sNum5R);oNew = CreateItemOnObject(sBP5L);iItemCost = GetGoldPieceValue(oNew)*iDomainPlankCost/100;DestroyObject(oNew);if(iChoice3==1){i=1;}while(i>0){if(iGold>=iItemCost){CreateItemOnObject(sBP5L,oPC);iGold = iGold-iItemCost;iItems++;iNum5--;}else{j++;}i--;}}

TakeGoldFromCreature(iItems*iItemCost,oPC,TRUE);
if(j>0){FloatingTextStringOnCreature("you miss some money to grab all the items",oPC);}else if(((iChoice1==1)&&(iNum1==0))||((iChoice2==1)&&(iNum2==0))||((iChoice3==1)&&(iNum3==0))||((iChoice4==1)&&(iNum4==0))||((iChoice5==1)&&(iNum5==0))){FloatingTextStringOnCreature("container empty",oPC);}

     if(iChoice1==1){sNum1R = IntToString(iNum1);sVar1 = sBP1L+"%"+sNum1R;}
else if(iChoice1==2){sNum2R = IntToString(iNum2);sVar2 = sBP2L+"%"+sNum2R;}
else if(iChoice1==3){sNum3R = IntToString(iNum3);sVar3 = sBP3L+"%"+sNum3R;}
else if(iChoice1==4){sNum4R = IntToString(iNum4);sVar4 = sBP4L+"%"+sNum4R;}
else if(iChoice1==5){sNum5R = IntToString(iNum5);sVar5 = sBP5L+"%"+sNum5R;}
   }
else
   {
     if(iChoice1==1){sVar1 = sBP1L+"%0";}
else if(iChoice1==2){sVar2 = sBP2L+"%0";}
else if(iChoice1==3){sVar3 = sBP3L+"%0";}
else if(iChoice1==4){sVar4 = sBP4L+"%0";}
else if(iChoice1==5){sVar5 = sBP5L+"%0";}
FloatingTextStringOnCreature("container empty",oPC);
   }
  }
else if(iChoice2==2)
  {
sChoice = GetLocalString(oModule,sPlanet+"Tree"+IntToString(iChoice3));
sBP = GetStringLeft(sChoice,FindSubString(sChoice,"%"));

     if(iChoice1==1){sVar1 = sBP+"%0";}
else if(iChoice1==2){sVar2 = sBP+"%0";}
else if(iChoice1==3){sVar3 = sBP+"%0";}
else if(iChoice1==4){sVar4 = sBP+"%0";}
else if(iChoice1==5){sVar5 = sBP+"%0";}
SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(iChoice1),iCounter);
  }
SetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot),sVar1+"_A_"+sVar2+"_B_"+sVar3+"_C_"+sVar4+"_D_"+sVar5+"_E_");
 }
////////////////////////////////////////////////////////////////////////////////
// Hall
else if(iStructure==10)
 {
SetPersistentInt(oModule,"Log",1);
WriteTimestampedLogEntry(GetName(oPC)+" asks for "+sPlanet+" regency !");
 }
////////////////////////////////////////////////////////////////////////////////
// House
else if(iStructure==11)
 {
int iGain = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain");
// Rent
if(iChoice1==1)
  {
SetPersistentString(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot),GetName(oPC));
SetLocalInt(oGoldbag,sPlanet+"&"+sArea+"&Rent&"+IntToString(iSlot),17280);
SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter",iCounter);
TakeGoldFromCreature(iPrice,oPC,TRUE);

     if(iLevel>=5){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iPrice/1));}
else if(iLevel>=3){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iPrice/2));}
  }
// Pay month rent
else if(iChoice1==2)
  {
SetLocalInt(oGoldbag,sPlanet+"&"+sArea+"&Rent&"+IntToString(iSlot),GetLocalInt(oGoldbag,sPlanet+"&"+sArea+"&Rent&"+IntToString(iSlot))+17280);
TakeGoldFromCreature(iPrice,oPC,TRUE);

     if(iLevel>=5){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iPrice/1));}
else if(iLevel>=3){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iPrice/2));}
  }
// Leave
else if(iChoice1==3)
  {
DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot));
DeleteLocalInt(oGoldbag,sPlanet+"&"+sArea+"&Rent&"+IntToString(iSlot));
  }
// Expulse renter
else if(iChoice1==4)
  {
DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot));
  }
//
 }
////////////////////////////////////////////////////////////////////////////////
// Shop
else if(iStructure==16)
 {
if(iChoice1==20){iChoice1 = 0;}if(iChoice1<10){sVar = "00"+IntToString(iChoice1);}else{sVar = "0"+IntToString(iChoice1);}
SetPersistentString(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot),sVar);
if(sVar==""){sVar = "Shop";}else if(sVar=="000"){sVar = "Players Shop";}else if(sVar=="001"){sVar = "General Shop";}else if(sVar=="002"){sVar = "Weaponsmith";}else if(sVar=="003"){sVar = "Armorsmith";}else if(sVar=="004"){sVar = "Arcane shop";}else if(sVar=="005"){sVar = "Alchemist shop";}else if(sVar=="006"){sVar = "Jeweler";}else if(sVar=="007"){sVar = "Rogue shop";}else if(sVar=="008"){sVar = "Tailor";}else if(sVar=="009"){sVar = "Library";}else if(sVar=="010"){sVar = "Bank";}else if(sVar=="011"){sVar = "Animal shop";}else if(sVar=="012"){sVar = "Blacksmith";}else if(sVar=="013"){sVar = "Tavern";}else if(sVar=="014"){sVar = "Inn";}else if(sVar=="015"){sVar = "Temple";}else if(sVar=="016"){sVar = "Architect";}else if(sVar=="017"){sVar = "Trainer";}
SetName(GetLocalObject(OBJECT_SELF,"ShopSign"),sVar);
 }
////////////////////////////////////////////////////////////////////////////////
}
