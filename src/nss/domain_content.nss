#include "aps_include"
#include "_module"
#include "dmfi_dmw_inc"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();if(oPC==OBJECT_INVALID){oPC = GetLocalObject(OBJECT_SELF,"PC");}
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
int iBonus = GetLocalInt(oArea,"Bonus");
int iStructure = GetLocalInt(OBJECT_SELF,"Structure");
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
int iLevel = StringToInt(GetStringRight(GetName(OBJECT_SELF),1));
string sRent = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot));
//
int iCounter = GetLocalInt(oGoldbag,"Counter");
//
object oNew;object oStructure;string sBP;string sNum;int iDays;int iNum;int iNumR;int iOrigCounter;int iHBPassed;int iRent;int i;int j;
string sVar;string sVar1;string sVar2;string sVar3;string sVar4;string sVar5;string sVar6;string sVar7;string sVar8;string sVar9;string sVar10;string sBP1L;string sBP2L;string sBP3L;string sBP4L;string sBP5L;string sNum1R;string sNum2R;string sNum3R;string sNum4R;string sNum5R;int iNum1;int iNum2;int iNum3;int iNum4;int iNum5;
string sBP1;string sTag11;string sTag12;string sNum1;string sBP2;string sTag21;string sTag22;string sNum2;string sBP3;string sTag31;string sTag32;string sNum3;string sBP4;string sTag41;string sTag42;string sNum4;string sBP5;string sTag51;string sTag52;string sNum5;int iNum11;int iNum21;int iNum31;int iNum41;int iNum51;int iNum12;int iNum22;int iNum32;int iNum42;int iNum52;string sNum11;string sNum21;string sNum31;string sNum41;string sNum51;string sNum12;string sNum22;string sNum32;string sNum42;string sNum52;string sUpgrade0;string sUpgrade1;string sUpgrade2;
string sBP1Lb;string sTag11b;string sTag12b;string sNum11b;int iNum11b;string sNum12b;int iNum12b;string sNum1b;int iNum1b;string sBP2Lb;string sTag21b;string sTag22b;string sNum21b;int iNum21b;string sNum22b;int iNum22b;string sNum2b;int iNum2b;string sBP3Lb;string sTag31b;string sTag32b;string sNum31b;int iNum31b;string sNum32b;int iNum32b;string sNum3b;int iNum3b;string sBP4Lb;string sTag41b;string sTag42b;string sNum41b;int iNum41b;string sNum42b;int iNum42b;string sNum4b;int iNum4b;string sBP5Lb;string sTag51b;string sTag52b;string sNum51b;int iNum51b;string sNum52b;int iNum52b;string sNum5b;int iNum5b;string sNum1Rb;string sNum2Rb;string sNum3Rb;string sNum4Rb;string sNum5Rb;
string sBP1Lc;string sBP2Lc;string sBP3Lc;string sBP4Lc;string sBP5Lc;
////////////////////////////////////////////////////////////////////////////////
// Extractor
if(iStructure==5)
 {
iDays = iDomainExtractor*24;iDays = iDays-(iDays*iBonus/100);
if(iLevel>=3){iDomainContainer = iDomainContainer*2;}
if(iLevel>=5){iDays/2;}

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

while(i<5)
  {
i++;
iOrigCounter = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(i));
iHBPassed = iCounter-iOrigCounter;
iNum = iHBPassed/iDays;
iOrigCounter = iOrigCounter+(iNum*iDays);

if(iNum>0)
   {
     if((i==1)&&(sBP1L!="")){iNum1 = iNum1+iNum;if(iNum1>iDomainContainer){iNum1 = iDomainContainer;}}
else if((i==2)&&(sBP2L!="")){iNum2 = iNum2+iNum;if(iNum2>iDomainContainer){iNum2 = iDomainContainer;}}
else if((i==3)&&(sBP3L!="")){iNum3 = iNum3+iNum;if(iNum3>iDomainContainer){iNum3 = iDomainContainer;}}
else if((i==4)&&(sBP4L!="")){iNum4 = iNum4+iNum;if(iNum4>iDomainContainer){iNum4 = iDomainContainer;}}
else if((i==5)&&(sBP5L!="")){iNum5 = iNum5+iNum;if(iNum5>iDomainContainer){iNum5 = iDomainContainer;}}

SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(i),iOrigCounter);
   }
  }
sNum1R = IntToString(iNum1);
sNum2R = IntToString(iNum2);
sNum3R = IntToString(iNum3);
sNum4R = IntToString(iNum4);
sNum5R = IntToString(iNum5);

sVar1 = sBP1L+"%"+sNum1R;
sVar2 = sBP2L+"%"+sNum2R;
sVar3 = sBP3L+"%"+sNum3R;
sVar4 = sBP4L+"%"+sNum4R;
sVar5 = sBP5L+"%"+sNum5R;

SetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot),sVar1+"_A_"+sVar2+"_B_"+sVar3+"_C_"+sVar4+"_D_"+sVar5+"_E_");
//
oNew = CreateItemOnObject(sBP1L);sVar1 = GetName(oNew);DestroyObject(oNew);
oNew = CreateItemOnObject(sBP2L);sVar2 = GetName(oNew);DestroyObject(oNew);
oNew = CreateItemOnObject(sBP3L);sVar3 = GetName(oNew);DestroyObject(oNew);
oNew = CreateItemOnObject(sBP4L);sVar4 = GetName(oNew);DestroyObject(oNew);
oNew = CreateItemOnObject(sBP5L);sVar5 = GetName(oNew);DestroyObject(oNew);

if(sBP1L!=""){sVar1 = "Extractor 1 : "+sNum1R+" "+sVar1;}else{sVar1 = "";}
if(sBP2L!=""){sVar2 = "Extractor 2 : "+sNum2R+" "+sVar2;}else{sVar2 = "";}
if(sBP3L!=""){sVar3 = "Extractor 3 : "+sNum3R+" "+sVar3;}else{sVar3 = "";}
if(sBP4L!=""){sVar4 = "Extractor 4 : "+sNum4R+" "+sVar4;}else{sVar4 = "";}
if(sBP5L!=""){sVar5 = "Extractor 5 : "+sNum5R+" "+sVar5;}else{sVar5 = "";}

SetCustomToken(10521,sVar1);
SetCustomToken(10522,sVar2);
SetCustomToken(10523,sVar3);
SetCustomToken(10524,sVar4);
SetCustomToken(10525,sVar5);
 }
////////////////////////////////////////////////////////////////////////////////
// Factory
else if((iStructure==6)&&(GetLocalInt(oPC,sPlanet+"&"+sArea+"&Execute&"+IntToString(iSlot))!=1))
 {
SetLocalInt(oPC,sPlanet+"&"+sArea+"&Execute&"+IntToString(iSlot),1);

iDays = iDomainFactory*24;iDays = iDays-(iDays*iBonus/100);
if(iLevel>=3){iDomainContainer = iDomainContainer*2;}
if(iLevel>=5){iDays/2;}

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
// Check in linked structures if resources are available and take them
i=0;
while(i<9)
 {
i++;
iNum = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+"&DomainLink&"+IntToString(iSlot)+IntToString(i));
oStructure = GetLocalObject(oArea,"StructureFlag"+IntToString(i));
if(iNum==1)
  {
// Update other structures resources and items
SetLocalObject(oStructure,"PC",oPC);ExecuteScript("domain_content",oStructure);
// Take new variables
sVar = GetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(i));

sVar1 = GetStringLeft(sVar,FindSubString(sVar,"_A_"));
sVar2 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_B_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_B_")))-FindSubString(sVar,"_A_")-3);
sVar3 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_C_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_C_")))-FindSubString(sVar,"_B_")-3);
sVar4 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_D_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_D_")))-FindSubString(sVar,"_C_")-3);
sVar5 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_E_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_E_")))-FindSubString(sVar,"_D_")-3);

////////////////////////////////////////
if(GetLocalInt(oStructure,"Structure")==6)
   {
sBP1Lb = GetStringLeft(sVar1,FindSubString(sVar1,"%001%"));sTag11b = GetStringRight(GetStringLeft(sVar1,FindSubString(sVar1,"%002%")),GetStringLength(GetStringLeft(sVar1,FindSubString(sVar1,"%002%")))-FindSubString(sVar1,"%001%")-5);sTag12b = GetStringRight(GetStringLeft(sVar1,FindSubString(sVar1,"%003%")),GetStringLength(GetStringLeft(sVar1,FindSubString(sVar1,"%003%")))-FindSubString(sVar1,"%002%")-5);sNum11b = GetStringRight(GetStringLeft(sVar1,FindSubString(sVar1,"%004%")),GetStringLength(GetStringLeft(sVar1,FindSubString(sVar1,"%004%")))-FindSubString(sVar1,"%003%")-5);iNum11b = StringToInt(sNum11b);sNum12b = GetStringRight(GetStringLeft(sVar1,FindSubString(sVar1,"%005%")),GetStringLength(GetStringLeft(sVar1,FindSubString(sVar1,"%005%")))-FindSubString(sVar1,"%004%")-5);iNum12b = StringToInt(sNum12b);sNum1b = GetStringRight(GetStringLeft(sVar1,FindSubString(sVar1,"%006%")),GetStringLength(GetStringLeft(sVar1,FindSubString(sVar1,"%006%")))-FindSubString(sVar1,"%005%")-5);iNum1b = StringToInt(sNum1b);
sBP2Lb = GetStringLeft(sVar2,FindSubString(sVar2,"%001%"));sTag21b = GetStringRight(GetStringLeft(sVar2,FindSubString(sVar2,"%002%")),GetStringLength(GetStringLeft(sVar2,FindSubString(sVar2,"%002%")))-FindSubString(sVar2,"%001%")-5);sTag22b = GetStringRight(GetStringLeft(sVar2,FindSubString(sVar2,"%003%")),GetStringLength(GetStringLeft(sVar2,FindSubString(sVar2,"%003%")))-FindSubString(sVar2,"%002%")-5);sNum21b = GetStringRight(GetStringLeft(sVar2,FindSubString(sVar2,"%004%")),GetStringLength(GetStringLeft(sVar2,FindSubString(sVar2,"%004%")))-FindSubString(sVar2,"%003%")-5);iNum21b = StringToInt(sNum21b);sNum22b = GetStringRight(GetStringLeft(sVar2,FindSubString(sVar2,"%005%")),GetStringLength(GetStringLeft(sVar2,FindSubString(sVar2,"%005%")))-FindSubString(sVar2,"%004%")-5);iNum22b = StringToInt(sNum22b);sNum2b = GetStringRight(GetStringLeft(sVar2,FindSubString(sVar2,"%006%")),GetStringLength(GetStringLeft(sVar2,FindSubString(sVar2,"%006%")))-FindSubString(sVar2,"%005%")-5);iNum2b = StringToInt(sNum2b);
sBP3Lb = GetStringLeft(sVar3,FindSubString(sVar3,"%001%"));sTag31b = GetStringRight(GetStringLeft(sVar3,FindSubString(sVar3,"%002%")),GetStringLength(GetStringLeft(sVar3,FindSubString(sVar3,"%002%")))-FindSubString(sVar3,"%001%")-5);sTag32b = GetStringRight(GetStringLeft(sVar3,FindSubString(sVar3,"%003%")),GetStringLength(GetStringLeft(sVar3,FindSubString(sVar3,"%003%")))-FindSubString(sVar3,"%002%")-5);sNum31b = GetStringRight(GetStringLeft(sVar3,FindSubString(sVar3,"%004%")),GetStringLength(GetStringLeft(sVar3,FindSubString(sVar3,"%004%")))-FindSubString(sVar3,"%003%")-5);iNum31b = StringToInt(sNum31b);sNum32b = GetStringRight(GetStringLeft(sVar3,FindSubString(sVar3,"%005%")),GetStringLength(GetStringLeft(sVar3,FindSubString(sVar3,"%005%")))-FindSubString(sVar3,"%004%")-5);iNum32b = StringToInt(sNum32b);sNum3b = GetStringRight(GetStringLeft(sVar3,FindSubString(sVar3,"%006%")),GetStringLength(GetStringLeft(sVar3,FindSubString(sVar3,"%006%")))-FindSubString(sVar3,"%005%")-5);iNum3b = StringToInt(sNum3b);
sBP4Lb = GetStringLeft(sVar4,FindSubString(sVar4,"%001%"));sTag41b = GetStringRight(GetStringLeft(sVar4,FindSubString(sVar4,"%002%")),GetStringLength(GetStringLeft(sVar4,FindSubString(sVar4,"%002%")))-FindSubString(sVar4,"%001%")-5);sTag42b = GetStringRight(GetStringLeft(sVar4,FindSubString(sVar4,"%003%")),GetStringLength(GetStringLeft(sVar4,FindSubString(sVar4,"%003%")))-FindSubString(sVar4,"%002%")-5);sNum41b = GetStringRight(GetStringLeft(sVar4,FindSubString(sVar4,"%004%")),GetStringLength(GetStringLeft(sVar4,FindSubString(sVar4,"%004%")))-FindSubString(sVar4,"%003%")-5);iNum41b = StringToInt(sNum41b);sNum42b = GetStringRight(GetStringLeft(sVar4,FindSubString(sVar4,"%005%")),GetStringLength(GetStringLeft(sVar4,FindSubString(sVar4,"%005%")))-FindSubString(sVar4,"%004%")-5);iNum42b = StringToInt(sNum42b);sNum4b = GetStringRight(GetStringLeft(sVar4,FindSubString(sVar4,"%006%")),GetStringLength(GetStringLeft(sVar4,FindSubString(sVar4,"%006%")))-FindSubString(sVar4,"%005%")-5);iNum4b = StringToInt(sNum4b);
sBP5Lb = GetStringLeft(sVar5,FindSubString(sVar5,"%001%"));sTag51b = GetStringRight(GetStringLeft(sVar5,FindSubString(sVar5,"%002%")),GetStringLength(GetStringLeft(sVar5,FindSubString(sVar5,"%002%")))-FindSubString(sVar5,"%001%")-5);sTag52b = GetStringRight(GetStringLeft(sVar5,FindSubString(sVar5,"%003%")),GetStringLength(GetStringLeft(sVar5,FindSubString(sVar5,"%003%")))-FindSubString(sVar5,"%002%")-5);sNum51b = GetStringRight(GetStringLeft(sVar5,FindSubString(sVar5,"%004%")),GetStringLength(GetStringLeft(sVar5,FindSubString(sVar5,"%004%")))-FindSubString(sVar5,"%003%")-5);iNum51b = StringToInt(sNum51b);sNum52b = GetStringRight(GetStringLeft(sVar5,FindSubString(sVar5,"%005%")),GetStringLength(GetStringLeft(sVar5,FindSubString(sVar5,"%005%")))-FindSubString(sVar5,"%004%")-5);iNum52b = StringToInt(sNum52b);sNum5b = GetStringRight(GetStringLeft(sVar5,FindSubString(sVar5,"%006%")),GetStringLength(GetStringLeft(sVar5,FindSubString(sVar5,"%006%")))-FindSubString(sVar5,"%005%")-5);iNum5b = StringToInt(sNum5b);

if((sBP1Lb!="")&&(iNum1b>1))
    {
if((sBP1Lb==sTag11)&&(sBP1Lb==sTag11)){iNumR = (iNum1b/2)-1;iNum11 = iNum11+iNumR;iNum12 = iNum12+iNumR;iNum1b = iNum1b-(iNumR*2);}else{if(sBP1Lb==sTag11){iNumR = iNum1b-1;iNum11 = iNum11+iNumR;iNum1b = iNum1b-iNumR;}if(sBP1Lb==sTag12){iNumR = iNum1b-1;iNum12 = iNum12+iNumR;iNum1b = iNum1b-iNumR;}}
if((sBP1Lb==sTag21)&&(sBP1Lb==sTag21)){iNumR = (iNum1b/2)-1;iNum21 = iNum21+iNumR;iNum22 = iNum22+iNumR;iNum1b = iNum1b-(iNumR*2);}else{if(sBP1Lb==sTag21){iNumR = iNum1b-1;iNum21 = iNum21+iNumR;iNum1b = iNum1b-iNumR;}if(sBP1Lb==sTag22){iNumR = iNum1b-1;iNum22 = iNum22+iNumR;iNum1b = iNum1b-iNumR;}}
if((sBP1Lb==sTag31)&&(sBP1Lb==sTag31)){iNumR = (iNum1b/2)-1;iNum31 = iNum31+iNumR;iNum32 = iNum32+iNumR;iNum1b = iNum1b-(iNumR*2);}else{if(sBP1Lb==sTag31){iNumR = iNum1b-1;iNum31 = iNum31+iNumR;iNum1b = iNum1b-iNumR;}if(sBP1Lb==sTag32){iNumR = iNum1b-1;iNum32 = iNum32+iNumR;iNum1b = iNum1b-iNumR;}}
if((sBP1Lb==sTag41)&&(sBP1Lb==sTag41)){iNumR = (iNum1b/2)-1;iNum41 = iNum41+iNumR;iNum42 = iNum42+iNumR;iNum1b = iNum1b-(iNumR*2);}else{if(sBP1Lb==sTag41){iNumR = iNum1b-1;iNum41 = iNum41+iNumR;iNum1b = iNum1b-iNumR;}if(sBP1Lb==sTag42){iNumR = iNum1b-1;iNum42 = iNum42+iNumR;iNum1b = iNum1b-iNumR;}}
if((sBP1Lb==sTag51)&&(sBP1Lb==sTag51)){iNumR = (iNum1b/2)-1;iNum51 = iNum51+iNumR;iNum52 = iNum52+iNumR;iNum1b = iNum1b-(iNumR*2);}else{if(sBP1Lb==sTag51){iNumR = iNum1b-1;iNum51 = iNum51+iNumR;iNum1b = iNum1b-iNumR;}if(sBP1Lb==sTag52){iNumR = iNum1b-1;iNum52 = iNum52+iNumR;iNum1b = iNum1b-iNumR;}}
    }
if((sBP2Lb!="")&&(iNum2b>1))
    {
if((sBP2Lb==sTag11)&&(sBP2Lb==sTag11)){iNumR = (iNum2b/2)-1;iNum11 = iNum11+iNumR;iNum12 = iNum12+iNumR;iNum2b = iNum2b-(iNumR*2);}else{if(sBP2Lb==sTag11){iNumR = iNum2b-1;iNum11 = iNum11+iNumR;iNum2b = iNum2b-iNumR;}if(sBP2Lb==sTag12){iNumR = iNum2b-1;iNum12 = iNum12+iNumR;iNum2b = iNum2b-iNumR;}}
if((sBP2Lb==sTag21)&&(sBP2Lb==sTag21)){iNumR = (iNum2b/2)-1;iNum21 = iNum21+iNumR;iNum22 = iNum22+iNumR;iNum2b = iNum2b-(iNumR*2);}else{if(sBP2Lb==sTag21){iNumR = iNum2b-1;iNum21 = iNum21+iNumR;iNum2b = iNum2b-iNumR;}if(sBP2Lb==sTag22){iNumR = iNum2b-1;iNum22 = iNum22+iNumR;iNum2b = iNum2b-iNumR;}}
if((sBP2Lb==sTag31)&&(sBP2Lb==sTag31)){iNumR = (iNum2b/2)-1;iNum31 = iNum31+iNumR;iNum32 = iNum32+iNumR;iNum2b = iNum2b-(iNumR*2);}else{if(sBP2Lb==sTag31){iNumR = iNum2b-1;iNum31 = iNum31+iNumR;iNum2b = iNum2b-iNumR;}if(sBP2Lb==sTag32){iNumR = iNum2b-1;iNum32 = iNum32+iNumR;iNum2b = iNum2b-iNumR;}}
if((sBP2Lb==sTag41)&&(sBP2Lb==sTag41)){iNumR = (iNum2b/2)-1;iNum41 = iNum41+iNumR;iNum42 = iNum42+iNumR;iNum2b = iNum2b-(iNumR*2);}else{if(sBP2Lb==sTag41){iNumR = iNum2b-1;iNum41 = iNum41+iNumR;iNum2b = iNum2b-iNumR;}if(sBP2Lb==sTag42){iNumR = iNum2b-1;iNum42 = iNum42+iNumR;iNum2b = iNum2b-iNumR;}}
if((sBP2Lb==sTag51)&&(sBP2Lb==sTag51)){iNumR = (iNum2b/2)-1;iNum51 = iNum51+iNumR;iNum52 = iNum52+iNumR;iNum2b = iNum2b-(iNumR*2);}else{if(sBP2Lb==sTag51){iNumR = iNum2b-1;iNum51 = iNum51+iNumR;iNum2b = iNum2b-iNumR;}if(sBP2Lb==sTag52){iNumR = iNum2b-1;iNum52 = iNum52+iNumR;iNum2b = iNum2b-iNumR;}}
    }
if((sBP3Lb!="")&&(iNum3b>1))
    {
if((sBP3Lb==sTag11)&&(sBP3Lb==sTag11)){iNumR = (iNum3b/2)-1;iNum11 = iNum11+iNumR;iNum12 = iNum12+iNumR;iNum3b = iNum3b-(iNumR*2);}else{if(sBP3Lb==sTag11){iNumR = iNum3b-1;iNum11 = iNum11+iNumR;iNum3b = iNum3b-iNumR;}if(sBP3Lb==sTag12){iNumR = iNum3b-1;iNum12 = iNum12+iNumR;iNum3b = iNum3b-iNumR;}}
if((sBP3Lb==sTag21)&&(sBP3Lb==sTag21)){iNumR = (iNum3b/2)-1;iNum21 = iNum21+iNumR;iNum22 = iNum22+iNumR;iNum3b = iNum3b-(iNumR*2);}else{if(sBP3Lb==sTag21){iNumR = iNum3b-1;iNum21 = iNum21+iNumR;iNum3b = iNum3b-iNumR;}if(sBP3Lb==sTag22){iNumR = iNum3b-1;iNum22 = iNum22+iNumR;iNum3b = iNum3b-iNumR;}}
if((sBP3Lb==sTag31)&&(sBP3Lb==sTag31)){iNumR = (iNum3b/2)-1;iNum31 = iNum31+iNumR;iNum32 = iNum32+iNumR;iNum3b = iNum3b-(iNumR*2);}else{if(sBP3Lb==sTag31){iNumR = iNum3b-1;iNum31 = iNum31+iNumR;iNum3b = iNum3b-iNumR;}if(sBP3Lb==sTag32){iNumR = iNum3b-1;iNum32 = iNum32+iNumR;iNum3b = iNum3b-iNumR;}}
if((sBP3Lb==sTag41)&&(sBP3Lb==sTag41)){iNumR = (iNum3b/2)-1;iNum41 = iNum41+iNumR;iNum42 = iNum42+iNumR;iNum3b = iNum3b-(iNumR*2);}else{if(sBP3Lb==sTag41){iNumR = iNum3b-1;iNum41 = iNum41+iNumR;iNum3b = iNum3b-iNumR;}if(sBP3Lb==sTag42){iNumR = iNum3b-1;iNum42 = iNum42+iNumR;iNum3b = iNum3b-iNumR;}}
if((sBP3Lb==sTag51)&&(sBP3Lb==sTag51)){iNumR = (iNum3b/2)-1;iNum51 = iNum51+iNumR;iNum52 = iNum52+iNumR;iNum3b = iNum3b-(iNumR*2);}else{if(sBP3Lb==sTag51){iNumR = iNum3b-1;iNum51 = iNum51+iNumR;iNum3b = iNum3b-iNumR;}if(sBP3Lb==sTag52){iNumR = iNum3b-1;iNum52 = iNum52+iNumR;iNum3b = iNum3b-iNumR;}}
    }
if((sBP4Lb!="")&&(iNum4b>1))
    {
if((sBP4Lb==sTag11)&&(sBP4Lb==sTag11)){iNumR = (iNum4b/2)-1;iNum11 = iNum11+iNumR;iNum12 = iNum12+iNumR;iNum4b = iNum4b-(iNumR*2);}else{if(sBP4Lb==sTag11){iNumR = iNum4b-1;iNum11 = iNum11+iNumR;iNum4b = iNum4b-iNumR;}if(sBP4Lb==sTag12){iNumR = iNum4b-1;iNum12 = iNum12+iNumR;iNum4b = iNum4b-iNumR;}}
if((sBP4Lb==sTag21)&&(sBP4Lb==sTag21)){iNumR = (iNum4b/2)-1;iNum21 = iNum21+iNumR;iNum22 = iNum22+iNumR;iNum4b = iNum4b-(iNumR*2);}else{if(sBP4Lb==sTag21){iNumR = iNum4b-1;iNum21 = iNum21+iNumR;iNum4b = iNum4b-iNumR;}if(sBP4Lb==sTag22){iNumR = iNum4b-1;iNum22 = iNum22+iNumR;iNum4b = iNum4b-iNumR;}}
if((sBP4Lb==sTag31)&&(sBP4Lb==sTag31)){iNumR = (iNum4b/2)-1;iNum31 = iNum31+iNumR;iNum32 = iNum32+iNumR;iNum4b = iNum4b-(iNumR*2);}else{if(sBP4Lb==sTag31){iNumR = iNum4b-1;iNum31 = iNum31+iNumR;iNum4b = iNum4b-iNumR;}if(sBP4Lb==sTag32){iNumR = iNum4b-1;iNum32 = iNum32+iNumR;iNum4b = iNum4b-iNumR;}}
if((sBP4Lb==sTag41)&&(sBP4Lb==sTag41)){iNumR = (iNum4b/2)-1;iNum41 = iNum41+iNumR;iNum42 = iNum42+iNumR;iNum4b = iNum4b-(iNumR*2);}else{if(sBP4Lb==sTag41){iNumR = iNum4b-1;iNum41 = iNum41+iNumR;iNum4b = iNum4b-iNumR;}if(sBP4Lb==sTag42){iNumR = iNum4b-1;iNum42 = iNum42+iNumR;iNum4b = iNum4b-iNumR;}}
if((sBP4Lb==sTag51)&&(sBP4Lb==sTag51)){iNumR = (iNum4b/2)-1;iNum51 = iNum51+iNumR;iNum52 = iNum52+iNumR;iNum4b = iNum4b-(iNumR*2);}else{if(sBP4Lb==sTag51){iNumR = iNum4b-1;iNum51 = iNum51+iNumR;iNum4b = iNum4b-iNumR;}if(sBP4Lb==sTag52){iNumR = iNum4b-1;iNum52 = iNum52+iNumR;iNum4b = iNum4b-iNumR;}}
    }
if((sBP5Lb!="")&&(iNum5b>1))
    {
if((sBP5Lb==sTag11)&&(sBP5Lb==sTag11)){iNumR = (iNum5b/2)-1;iNum11 = iNum11+iNumR;iNum12 = iNum12+iNumR;iNum5b = iNum5b-(iNumR*2);}else{if(sBP5Lb==sTag11){iNumR = iNum5b-1;iNum11 = iNum11+iNumR;iNum5b = iNum5b-iNumR;}if(sBP5Lb==sTag12){iNumR = iNum5b-1;iNum12 = iNum12+iNumR;iNum5b = iNum5b-iNumR;}}
if((sBP5Lb==sTag21)&&(sBP5Lb==sTag21)){iNumR = (iNum5b/2)-1;iNum21 = iNum21+iNumR;iNum22 = iNum22+iNumR;iNum5b = iNum5b-(iNumR*2);}else{if(sBP5Lb==sTag21){iNumR = iNum5b-1;iNum21 = iNum21+iNumR;iNum5b = iNum5b-iNumR;}if(sBP5Lb==sTag22){iNumR = iNum5b-1;iNum22 = iNum22+iNumR;iNum5b = iNum5b-iNumR;}}
if((sBP5Lb==sTag31)&&(sBP5Lb==sTag31)){iNumR = (iNum5b/2)-1;iNum31 = iNum31+iNumR;iNum32 = iNum32+iNumR;iNum5b = iNum5b-(iNumR*2);}else{if(sBP5Lb==sTag31){iNumR = iNum5b-1;iNum31 = iNum31+iNumR;iNum5b = iNum5b-iNumR;}if(sBP5Lb==sTag32){iNumR = iNum5b-1;iNum32 = iNum32+iNumR;iNum5b = iNum5b-iNumR;}}
if((sBP5Lb==sTag41)&&(sBP5Lb==sTag41)){iNumR = (iNum5b/2)-1;iNum41 = iNum41+iNumR;iNum42 = iNum42+iNumR;iNum5b = iNum5b-(iNumR*2);}else{if(sBP5Lb==sTag41){iNumR = iNum5b-1;iNum41 = iNum41+iNumR;iNum5b = iNum5b-iNumR;}if(sBP5Lb==sTag42){iNumR = iNum5b-1;iNum42 = iNum42+iNumR;iNum5b = iNum5b-iNumR;}}
if((sBP5Lb==sTag51)&&(sBP5Lb==sTag51)){iNumR = (iNum5b/2)-1;iNum51 = iNum51+iNumR;iNum52 = iNum52+iNumR;iNum5b = iNum5b-(iNumR*2);}else{if(sBP5Lb==sTag51){iNumR = iNum5b-1;iNum51 = iNum51+iNumR;iNum5b = iNum5b-iNumR;}if(sBP5Lb==sTag52){iNumR = iNum5b-1;iNum52 = iNum52+iNumR;iNum5b = iNum5b-iNumR;}}
    }
sVar1 = sBP1Lb+"%001%"+sTag11b+"%002%"+sTag12b+"%003%"+sNum11b+"%004%"+sNum12b+"%005%"+IntToString(iNum1b)+"%006%";
sVar2 = sBP2Lb+"%001%"+sTag21b+"%002%"+sTag22b+"%003%"+sNum21b+"%004%"+sNum22b+"%005%"+IntToString(iNum2b)+"%006%";
sVar3 = sBP3Lb+"%001%"+sTag31b+"%002%"+sTag32b+"%003%"+sNum31b+"%004%"+sNum32b+"%005%"+IntToString(iNum3b)+"%006%";
sVar4 = sBP4Lb+"%001%"+sTag41b+"%002%"+sTag42b+"%003%"+sNum41b+"%004%"+sNum42b+"%005%"+IntToString(iNum4b)+"%006%";
sVar5 = sBP5Lb+"%001%"+sTag51b+"%002%"+sTag52b+"%003%"+sNum51b+"%004%"+sNum52b+"%005%"+IntToString(iNum5b)+"%006%";
   }
////////////////////////////////////////
else
   {
sBP1Lb = GetStringLeft(sVar1,FindSubString(sVar1,"%"));sNum1Rb = GetStringRight(sVar1,GetStringLength(sVar1)-FindSubString(sVar1,"%")-1);iNum1b = StringToInt(sNum1Rb);
sBP2Lb = GetStringLeft(sVar2,FindSubString(sVar2,"%"));sNum2Rb = GetStringRight(sVar2,GetStringLength(sVar2)-FindSubString(sVar2,"%")-1);iNum2b = StringToInt(sNum2Rb);
sBP3Lb = GetStringLeft(sVar3,FindSubString(sVar3,"%"));sNum3Rb = GetStringRight(sVar3,GetStringLength(sVar3)-FindSubString(sVar3,"%")-1);iNum3b = StringToInt(sNum3Rb);
sBP4Lb = GetStringLeft(sVar4,FindSubString(sVar4,"%"));sNum4Rb = GetStringRight(sVar4,GetStringLength(sVar4)-FindSubString(sVar4,"%")-1);iNum4b = StringToInt(sNum4Rb);
sBP5Lb = GetStringLeft(sVar5,FindSubString(sVar5,"%"));sNum5Rb = GetStringRight(sVar5,GetStringLength(sVar5)-FindSubString(sVar5,"%")-1);iNum5b = StringToInt(sNum5Rb);

// Animals skins
sBP1Lc = "";sBP2Lc = "";sBP3Lc = "";sBP4Lc = "";sBP5Lc = "";
if(GetLocalInt(oStructure,"Structure")==7)
    {
sBP1Lc = sBP1Lb;sBP2Lc = sBP2Lb;sBP3Lc = sBP3Lb;sBP4Lc = sBP4Lb;sBP5Lc = sBP5Lb;
if(sBP1Lb=="mn_small_ani001"){sBP1Lb = "cr_skinanimal";}else if(sBP1Lb=="henchani011"){sBP1Lb = "cr_skinwolf";}else if(sBP1Lb=="henchani012"){sBP1Lb = "cr_feathers";}else if(sBP1Lb=="mn_goat001"){sBP1Lb = "cr_skinherbivore";}else if(sBP1Lb=="mn_boar003"){sBP1Lb = "cr_meat";}else if(sBP1Lb=="henchani010"){sBP1Lb = "cr_nail";}else if(sBP1Lb=="mn_deer002"){sBP1Lb = "cr_skinherbivore";}else if(sBP1Lb=="henchani001"){sBP1Lb = "cr_hair";}else if(sBP1Lb=="henchani006"){sBP1Lb = "cr_hair";}else if(sBP1Lb=="mn_snake005"){sBP1Lb = "cr_skinsnake";}else if(sBP1Lb=="mn_wildbeef002"){sBP1Lb = "cr_meat";}else if(sBP1Lb=="henchani002"){sBP1Lb = "cr_hair";}else if(sBP1Lb=="henchani009"){sBP1Lb = "cr_nailmedium";}else if(sBP1Lb=="henchani007"){sBP1Lb = "cr_hair";}else if(sBP1Lb=="henchani003"){sBP1Lb = "cr_hair";}else if(sBP1Lb=="henchani008"){sBP1Lb = "cr_hair";}
if(sBP2Lb=="mn_small_ani001"){sBP2Lb = "cr_skinanimal";}else if(sBP2Lb=="henchani011"){sBP2Lb = "cr_skinwolf";}else if(sBP2Lb=="henchani012"){sBP2Lb = "cr_feathers";}else if(sBP2Lb=="mn_goat001"){sBP2Lb = "cr_skinherbivore";}else if(sBP2Lb=="mn_boar003"){sBP2Lb = "cr_meat";}else if(sBP2Lb=="henchani010"){sBP2Lb = "cr_nail";}else if(sBP2Lb=="mn_deer002"){sBP2Lb = "cr_skinherbivore";}else if(sBP2Lb=="henchani001"){sBP2Lb = "cr_hair";}else if(sBP2Lb=="henchani006"){sBP2Lb = "cr_hair";}else if(sBP2Lb=="mn_snake005"){sBP2Lb = "cr_skinsnake";}else if(sBP2Lb=="mn_wildbeef002"){sBP2Lb = "cr_meat";}else if(sBP2Lb=="henchani002"){sBP2Lb = "cr_hair";}else if(sBP2Lb=="henchani009"){sBP2Lb = "cr_nailmedium";}else if(sBP2Lb=="henchani007"){sBP2Lb = "cr_hair";}else if(sBP2Lb=="henchani003"){sBP2Lb = "cr_hair";}else if(sBP2Lb=="henchani008"){sBP2Lb = "cr_hair";}
if(sBP3Lb=="mn_small_ani001"){sBP3Lb = "cr_skinanimal";}else if(sBP3Lb=="henchani011"){sBP3Lb = "cr_skinwolf";}else if(sBP3Lb=="henchani012"){sBP3Lb = "cr_feathers";}else if(sBP3Lb=="mn_goat001"){sBP3Lb = "cr_skinherbivore";}else if(sBP3Lb=="mn_boar003"){sBP3Lb = "cr_meat";}else if(sBP3Lb=="henchani010"){sBP3Lb = "cr_nail";}else if(sBP3Lb=="mn_deer002"){sBP3Lb = "cr_skinherbivore";}else if(sBP3Lb=="henchani001"){sBP3Lb = "cr_hair";}else if(sBP3Lb=="henchani006"){sBP3Lb = "cr_hair";}else if(sBP3Lb=="mn_snake005"){sBP3Lb = "cr_skinsnake";}else if(sBP3Lb=="mn_wildbeef002"){sBP3Lb = "cr_meat";}else if(sBP3Lb=="henchani002"){sBP3Lb = "cr_hair";}else if(sBP3Lb=="henchani009"){sBP3Lb = "cr_nailmedium";}else if(sBP3Lb=="henchani007"){sBP3Lb = "cr_hair";}else if(sBP3Lb=="henchani003"){sBP3Lb = "cr_hair";}else if(sBP3Lb=="henchani008"){sBP3Lb = "cr_hair";}
if(sBP4Lb=="mn_small_ani001"){sBP4Lb = "cr_skinanimal";}else if(sBP4Lb=="henchani011"){sBP4Lb = "cr_skinwolf";}else if(sBP4Lb=="henchani012"){sBP4Lb = "cr_feathers";}else if(sBP4Lb=="mn_goat001"){sBP4Lb = "cr_skinherbivore";}else if(sBP4Lb=="mn_boar003"){sBP4Lb = "cr_meat";}else if(sBP4Lb=="henchani010"){sBP4Lb = "cr_nail";}else if(sBP4Lb=="mn_deer002"){sBP4Lb = "cr_skinherbivore";}else if(sBP4Lb=="henchani001"){sBP4Lb = "cr_hair";}else if(sBP4Lb=="henchani006"){sBP4Lb = "cr_hair";}else if(sBP4Lb=="mn_snake005"){sBP4Lb = "cr_skinsnake";}else if(sBP4Lb=="mn_wildbeef002"){sBP4Lb = "cr_meat";}else if(sBP4Lb=="henchani002"){sBP4Lb = "cr_hair";}else if(sBP4Lb=="henchani009"){sBP4Lb = "cr_nailmedium";}else if(sBP4Lb=="henchani007"){sBP4Lb = "cr_hair";}else if(sBP4Lb=="henchani003"){sBP4Lb = "cr_hair";}else if(sBP4Lb=="henchani008"){sBP4Lb = "cr_hair";}
if(sBP5Lb=="mn_small_ani001"){sBP5Lb = "cr_skinanimal";}else if(sBP5Lb=="henchani011"){sBP5Lb = "cr_skinwolf";}else if(sBP5Lb=="henchani012"){sBP5Lb = "cr_feathers";}else if(sBP5Lb=="mn_goat001"){sBP5Lb = "cr_skinherbivore";}else if(sBP5Lb=="mn_boar003"){sBP5Lb = "cr_meat";}else if(sBP5Lb=="henchani010"){sBP5Lb = "cr_nail";}else if(sBP5Lb=="mn_deer002"){sBP5Lb = "cr_skinherbivore";}else if(sBP5Lb=="henchani001"){sBP5Lb = "cr_hair";}else if(sBP5Lb=="henchani006"){sBP5Lb = "cr_hair";}else if(sBP5Lb=="mn_snake005"){sBP5Lb = "cr_skinsnake";}else if(sBP5Lb=="mn_wildbeef002"){sBP5Lb = "cr_meat";}else if(sBP5Lb=="henchani002"){sBP5Lb = "cr_hair";}else if(sBP5Lb=="henchani009"){sBP5Lb = "cr_nailmedium";}else if(sBP5Lb=="henchani007"){sBP5Lb = "cr_hair";}else if(sBP5Lb=="henchani003"){sBP5Lb = "cr_hair";}else if(sBP5Lb=="henchani008"){sBP5Lb = "cr_hair";}
    }
if((sBP1Lb!="")&&(StringToInt(sNum1Rb)>1))
    {
if((sBP1Lb==sTag11)&&(sBP1Lb==sTag11)){iNumR = (StringToInt(sNum1Rb)/2)-1;iNum11 = iNum11+iNumR;iNum12 = iNum12+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-(iNumR*2));}else{if(sBP1Lb==sTag11){iNumR = StringToInt(sNum1Rb)-1;iNum11 = iNum11+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-iNumR);}if(sBP1Lb==sTag12){iNumR = StringToInt(sNum1Rb)-1;iNum12 = iNum12+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-iNumR);}}
if((sBP1Lb==sTag21)&&(sBP1Lb==sTag21)){iNumR = (StringToInt(sNum1Rb)/2)-1;iNum21 = iNum21+iNumR;iNum22 = iNum22+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-(iNumR*2));}else{if(sBP1Lb==sTag21){iNumR = StringToInt(sNum1Rb)-1;iNum21 = iNum21+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-iNumR);}if(sBP1Lb==sTag22){iNumR = StringToInt(sNum1Rb)-1;iNum22 = iNum22+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-iNumR);}}
if((sBP1Lb==sTag31)&&(sBP1Lb==sTag31)){iNumR = (StringToInt(sNum1Rb)/2)-1;iNum31 = iNum31+iNumR;iNum32 = iNum32+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-(iNumR*2));}else{if(sBP1Lb==sTag31){iNumR = StringToInt(sNum1Rb)-1;iNum31 = iNum31+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-iNumR);}if(sBP1Lb==sTag32){iNumR = StringToInt(sNum1Rb)-1;iNum32 = iNum32+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-iNumR);}}
if((sBP1Lb==sTag41)&&(sBP1Lb==sTag41)){iNumR = (StringToInt(sNum1Rb)/2)-1;iNum41 = iNum41+iNumR;iNum42 = iNum42+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-(iNumR*2));}else{if(sBP1Lb==sTag41){iNumR = StringToInt(sNum1Rb)-1;iNum41 = iNum41+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-iNumR);}if(sBP1Lb==sTag42){iNumR = StringToInt(sNum1Rb)-1;iNum42 = iNum42+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-iNumR);}}
if((sBP1Lb==sTag51)&&(sBP1Lb==sTag51)){iNumR = (StringToInt(sNum1Rb)/2)-1;iNum51 = iNum51+iNumR;iNum52 = iNum52+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-(iNumR*2));}else{if(sBP1Lb==sTag51){iNumR = StringToInt(sNum1Rb)-1;iNum51 = iNum51+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-iNumR);}if(sBP1Lb==sTag52){iNumR = StringToInt(sNum1Rb)-1;iNum52 = iNum52+iNumR;sNum1Rb = IntToString(StringToInt(sNum1Rb)-iNumR);}}
    }
if((sBP2Lb!="")&&(StringToInt(sNum2Rb)>1))
    {
if((sBP2Lb==sTag11)&&(sBP2Lb==sTag11)){iNumR = (StringToInt(sNum2Rb)/2)-1;iNum11 = iNum11+iNumR;iNum12 = iNum12+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-(iNumR*2));}else{if(sBP2Lb==sTag11){iNumR = StringToInt(sNum2Rb)-1;iNum11 = iNum11+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-iNumR);}if(sBP2Lb==sTag12){iNumR = StringToInt(sNum2Rb)-1;iNum12 = iNum12+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-iNumR);}}
if((sBP2Lb==sTag21)&&(sBP2Lb==sTag21)){iNumR = (StringToInt(sNum2Rb)/2)-1;iNum21 = iNum21+iNumR;iNum22 = iNum22+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-(iNumR*2));}else{if(sBP2Lb==sTag21){iNumR = StringToInt(sNum2Rb)-1;iNum21 = iNum21+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-iNumR);}if(sBP2Lb==sTag22){iNumR = StringToInt(sNum2Rb)-1;iNum22 = iNum22+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-iNumR);}}
if((sBP2Lb==sTag31)&&(sBP2Lb==sTag31)){iNumR = (StringToInt(sNum2Rb)/2)-1;iNum31 = iNum31+iNumR;iNum32 = iNum32+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-(iNumR*2));}else{if(sBP2Lb==sTag31){iNumR = StringToInt(sNum2Rb)-1;iNum31 = iNum31+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-iNumR);}if(sBP2Lb==sTag32){iNumR = StringToInt(sNum2Rb)-1;iNum32 = iNum32+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-iNumR);}}
if((sBP2Lb==sTag41)&&(sBP2Lb==sTag41)){iNumR = (StringToInt(sNum2Rb)/2)-1;iNum41 = iNum41+iNumR;iNum42 = iNum42+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-(iNumR*2));}else{if(sBP2Lb==sTag41){iNumR = StringToInt(sNum2Rb)-1;iNum41 = iNum41+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-iNumR);}if(sBP2Lb==sTag42){iNumR = StringToInt(sNum2Rb)-1;iNum42 = iNum42+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-iNumR);}}
if((sBP2Lb==sTag51)&&(sBP2Lb==sTag51)){iNumR = (StringToInt(sNum2Rb)/2)-1;iNum51 = iNum51+iNumR;iNum52 = iNum52+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-(iNumR*2));}else{if(sBP2Lb==sTag51){iNumR = StringToInt(sNum2Rb)-1;iNum51 = iNum51+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-iNumR);}if(sBP2Lb==sTag52){iNumR = StringToInt(sNum2Rb)-1;iNum52 = iNum52+iNumR;sNum2Rb = IntToString(StringToInt(sNum2Rb)-iNumR);}}
    }
if((sBP3Lb!="")&&(StringToInt(sNum3Rb)>1))
    {
if((sBP3Lb==sTag11)&&(sBP3Lb==sTag11)){iNumR = (StringToInt(sNum3Rb)/2)-1;iNum11 = iNum11+iNumR;iNum12 = iNum12+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-(iNumR*2));}else{if(sBP3Lb==sTag11){iNumR = StringToInt(sNum3Rb)-1;iNum11 = iNum11+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-iNumR);}if(sBP3Lb==sTag12){iNumR = StringToInt(sNum3Rb)-1;iNum12 = iNum12+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-iNumR);}}
if((sBP3Lb==sTag21)&&(sBP3Lb==sTag21)){iNumR = (StringToInt(sNum3Rb)/2)-1;iNum21 = iNum21+iNumR;iNum22 = iNum22+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-(iNumR*2));}else{if(sBP3Lb==sTag21){iNumR = StringToInt(sNum3Rb)-1;iNum21 = iNum21+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-iNumR);}if(sBP3Lb==sTag22){iNumR = StringToInt(sNum3Rb)-1;iNum22 = iNum22+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-iNumR);}}
if((sBP3Lb==sTag31)&&(sBP3Lb==sTag31)){iNumR = (StringToInt(sNum3Rb)/2)-1;iNum31 = iNum31+iNumR;iNum32 = iNum32+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-(iNumR*2));}else{if(sBP3Lb==sTag31){iNumR = StringToInt(sNum3Rb)-1;iNum31 = iNum31+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-iNumR);}if(sBP3Lb==sTag32){iNumR = StringToInt(sNum3Rb)-1;iNum32 = iNum32+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-iNumR);}}
if((sBP3Lb==sTag41)&&(sBP3Lb==sTag41)){iNumR = (StringToInt(sNum3Rb)/2)-1;iNum41 = iNum41+iNumR;iNum42 = iNum42+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-(iNumR*2));}else{if(sBP3Lb==sTag41){iNumR = StringToInt(sNum3Rb)-1;iNum41 = iNum41+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-iNumR);}if(sBP3Lb==sTag42){iNumR = StringToInt(sNum3Rb)-1;iNum42 = iNum42+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-iNumR);}}
if((sBP3Lb==sTag51)&&(sBP3Lb==sTag51)){iNumR = (StringToInt(sNum3Rb)/2)-1;iNum51 = iNum51+iNumR;iNum52 = iNum52+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-(iNumR*2));}else{if(sBP3Lb==sTag51){iNumR = StringToInt(sNum3Rb)-1;iNum51 = iNum51+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-iNumR);}if(sBP3Lb==sTag52){iNumR = StringToInt(sNum3Rb)-1;iNum52 = iNum52+iNumR;sNum3Rb = IntToString(StringToInt(sNum3Rb)-iNumR);}}
    }
if((sBP4Lb!="")&&(StringToInt(sNum4Rb)>1))
    {
if((sBP4Lb==sTag11)&&(sBP4Lb==sTag11)){iNumR = (StringToInt(sNum4Rb)/2)-1;iNum11 = iNum11+iNumR;iNum12 = iNum12+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-(iNumR*2));}else{if(sBP4Lb==sTag11){iNumR = StringToInt(sNum4Rb)-1;iNum11 = iNum11+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-iNumR);}if(sBP4Lb==sTag12){iNumR = StringToInt(sNum4Rb)-1;iNum12 = iNum12+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-iNumR);}}
if((sBP4Lb==sTag21)&&(sBP4Lb==sTag21)){iNumR = (StringToInt(sNum4Rb)/2)-1;iNum21 = iNum21+iNumR;iNum22 = iNum22+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-(iNumR*2));}else{if(sBP4Lb==sTag21){iNumR = StringToInt(sNum4Rb)-1;iNum21 = iNum21+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-iNumR);}if(sBP4Lb==sTag22){iNumR = StringToInt(sNum4Rb)-1;iNum22 = iNum22+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-iNumR);}}
if((sBP4Lb==sTag31)&&(sBP4Lb==sTag31)){iNumR = (StringToInt(sNum4Rb)/2)-1;iNum31 = iNum31+iNumR;iNum32 = iNum32+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-(iNumR*2));}else{if(sBP4Lb==sTag31){iNumR = StringToInt(sNum4Rb)-1;iNum31 = iNum31+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-iNumR);}if(sBP4Lb==sTag32){iNumR = StringToInt(sNum4Rb)-1;iNum32 = iNum32+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-iNumR);}}
if((sBP4Lb==sTag41)&&(sBP4Lb==sTag41)){iNumR = (StringToInt(sNum4Rb)/2)-1;iNum41 = iNum41+iNumR;iNum42 = iNum42+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-(iNumR*2));}else{if(sBP4Lb==sTag41){iNumR = StringToInt(sNum4Rb)-1;iNum41 = iNum41+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-iNumR);}if(sBP4Lb==sTag42){iNumR = StringToInt(sNum4Rb)-1;iNum42 = iNum42+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-iNumR);}}
if((sBP4Lb==sTag51)&&(sBP4Lb==sTag51)){iNumR = (StringToInt(sNum4Rb)/2)-1;iNum51 = iNum51+iNumR;iNum52 = iNum52+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-(iNumR*2));}else{if(sBP4Lb==sTag51){iNumR = StringToInt(sNum4Rb)-1;iNum51 = iNum51+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-iNumR);}if(sBP4Lb==sTag52){iNumR = StringToInt(sNum4Rb)-1;iNum52 = iNum52+iNumR;sNum4Rb = IntToString(StringToInt(sNum4Rb)-iNumR);}}
    }
if((sBP5Lb!="")&&(StringToInt(sNum5Rb)>1))
    {
if((sBP5Lb==sTag11)&&(sBP5Lb==sTag11)){iNumR = (StringToInt(sNum5Rb)/2)-1;iNum11 = iNum11+iNumR;iNum12 = iNum12+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-(iNumR*2));}else{if(sBP5Lb==sTag11){iNumR = StringToInt(sNum5Rb)-1;iNum11 = iNum11+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-iNumR);}if(sBP5Lb==sTag12){iNumR = StringToInt(sNum5Rb)-1;iNum12 = iNum12+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-iNumR);}}
if((sBP5Lb==sTag21)&&(sBP5Lb==sTag21)){iNumR = (StringToInt(sNum5Rb)/2)-1;iNum21 = iNum21+iNumR;iNum22 = iNum22+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-(iNumR*2));}else{if(sBP5Lb==sTag21){iNumR = StringToInt(sNum5Rb)-1;iNum21 = iNum21+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-iNumR);}if(sBP5Lb==sTag22){iNumR = StringToInt(sNum5Rb)-1;iNum22 = iNum22+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-iNumR);}}
if((sBP5Lb==sTag31)&&(sBP5Lb==sTag31)){iNumR = (StringToInt(sNum5Rb)/2)-1;iNum31 = iNum31+iNumR;iNum32 = iNum32+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-(iNumR*2));}else{if(sBP5Lb==sTag31){iNumR = StringToInt(sNum5Rb)-1;iNum31 = iNum31+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-iNumR);}if(sBP5Lb==sTag32){iNumR = StringToInt(sNum5Rb)-1;iNum32 = iNum32+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-iNumR);}}
if((sBP5Lb==sTag41)&&(sBP5Lb==sTag41)){iNumR = (StringToInt(sNum5Rb)/2)-1;iNum41 = iNum41+iNumR;iNum42 = iNum42+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-(iNumR*2));}else{if(sBP5Lb==sTag41){iNumR = StringToInt(sNum5Rb)-1;iNum41 = iNum41+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-iNumR);}if(sBP5Lb==sTag42){iNumR = StringToInt(sNum5Rb)-1;iNum42 = iNum42+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-iNumR);}}
if((sBP5Lb==sTag51)&&(sBP5Lb==sTag51)){iNumR = (StringToInt(sNum5Rb)/2)-1;iNum51 = iNum51+iNumR;iNum52 = iNum52+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-(iNumR*2));}else{if(sBP5Lb==sTag51){iNumR = StringToInt(sNum5Rb)-1;iNum51 = iNum51+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-iNumR);}if(sBP5Lb==sTag52){iNumR = StringToInt(sNum5Rb)-1;iNum52 = iNum52+iNumR;sNum5Rb = IntToString(StringToInt(sNum5Rb)-iNumR);}}
    }
if(sBP1Lc!=""){sVar1 = sBP1Lc+"%"+sNum1Rb;}else{sVar1 = sBP1Lb+"%"+sNum1Rb;}
if(sBP2Lc!=""){sVar2 = sBP2Lc+"%"+sNum2Rb;}else{sVar2 = sBP2Lb+"%"+sNum2Rb;}
if(sBP3Lc!=""){sVar3 = sBP3Lc+"%"+sNum3Rb;}else{sVar3 = sBP3Lb+"%"+sNum3Rb;}
if(sBP4Lc!=""){sVar4 = sBP4Lc+"%"+sNum4Rb;}else{sVar4 = sBP4Lb+"%"+sNum4Rb;}
if(sBP5Lc!=""){sVar5 = sBP5Lc+"%"+sNum5Rb;}else{sVar5 = sBP5Lb+"%"+sNum5Rb;}
////////////////////////////////////////
   }
SetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(i),sVar1+"_A_"+sVar2+"_B_"+sVar3+"_C_"+sVar4+"_D_"+sVar5+"_E_");
  }
 }
////////////////////////////////////////
// Count new resources
i=0;
while(i<5)
  {
i++;
iOrigCounter = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(i));
iHBPassed = iCounter-iOrigCounter;
iNum = iHBPassed/iDays;
iOrigCounter = iOrigCounter+(iNum*iDays);

if(iNum>0)
   {
     if((i==1)&&(sBP1!="")){iNumR = iNum;if(iNumR>iNum11){iNumR = iNum11;}if(iNumR>iNum12){iNumR = iNum12;}if(iNumR>iDomainContainer-iNum1){iNumR = iDomainContainer-iNum1;}iNum1 = iNum1+iNumR;iNum11 = iNum11-iNumR;iNum12 = iNum12-iNumR;}
else if((i==2)&&(sBP2!="")){iNumR = iNum;if(iNumR>iNum21){iNumR = iNum21;}if(iNumR>iNum22){iNumR = iNum22;}if(iNumR>iDomainContainer-iNum2){iNumR = iDomainContainer-iNum2;}iNum2 = iNum2+iNumR;iNum21 = iNum21-iNumR;iNum22 = iNum22-iNumR;}
else if((i==3)&&(sBP3!="")){iNumR = iNum;if(iNumR>iNum31){iNumR = iNum31;}if(iNumR>iNum32){iNumR = iNum32;}if(iNumR>iDomainContainer-iNum3){iNumR = iDomainContainer-iNum3;}iNum3 = iNum3+iNumR;iNum31 = iNum31-iNumR;iNum32 = iNum32-iNumR;}
else if((i==4)&&(sBP4!="")){iNumR = iNum;if(iNumR>iNum41){iNumR = iNum41;}if(iNumR>iNum42){iNumR = iNum42;}if(iNumR>iDomainContainer-iNum4){iNumR = iDomainContainer-iNum4;}iNum4 = iNum4+iNumR;iNum41 = iNum41-iNumR;iNum42 = iNum42-iNumR;}
else if((i==5)&&(sBP5!="")){iNumR = iNum;if(iNumR>iNum51){iNumR = iNum51;}if(iNumR>iNum52){iNumR = iNum52;}if(iNumR>iDomainContainer-iNum5){iNumR = iDomainContainer-iNum5;}iNum5 = iNum5+iNumR;iNum51 = iNum51-iNumR;iNum52 = iNum52-iNumR;}

SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(i),iOrigCounter);
   }
  }
////////////////////////////////////////
// Check if other slots have resources available and take them
// Unit 2
iNum = (iNum-2)/2;
if(sBP1!="")
  {
if((sBP1==sTag21)&&(sBP1==sTag22)){iNumR = iNum1/2;iNum21 = iNum21+iNumR;iNum22 = iNum22+iNumR;iNum1 = iNum1-(iNumR*2);}else{if(sBP1==sTag21){iNum21 = iNum21+iNum1;iNum1=0;}if(sBP1==sTag22){iNum22 = iNum22+iNum1;iNum1=0;}}if(iNum>0){iNumR = iNum;if(iNumR>iNum21){iNumR = iNum21;}if(iNumR>iNum22){iNumR = iNum22;}if(iNumR>iDomainContainer-iNum2){iNumR = iDomainContainer-iNum2;}iNum2 = iNum2+iNumR;iNum21 = iNum21-iNumR;iNum22 = iNum22-iNumR;}
if((sBP1==sTag31)&&(sBP1==sTag32)){iNumR = iNum1/2;iNum31 = iNum31+iNumR;iNum32 = iNum32+iNumR;iNum1 = iNum1-(iNumR*2);}else{if(sBP1==sTag31){iNum31 = iNum31+iNum1;iNum1=0;}if(sBP1==sTag32){iNum32 = iNum32+iNum1;iNum1=0;}}if(iNum>0){iNumR = iNum;if(iNumR>iNum31){iNumR = iNum31;}if(iNumR>iNum32){iNumR = iNum32;}if(iNumR>iDomainContainer-iNum2){iNumR = iDomainContainer-iNum2;}iNum2 = iNum2+iNumR;iNum31 = iNum31-iNumR;iNum32 = iNum32-iNumR;}
if((sBP1==sTag41)&&(sBP1==sTag42)){iNumR = iNum1/2;iNum41 = iNum41+iNumR;iNum42 = iNum42+iNumR;iNum1 = iNum1-(iNumR*2);}else{if(sBP1==sTag41){iNum41 = iNum41+iNum1;iNum1=0;}if(sBP1==sTag42){iNum42 = iNum42+iNum1;iNum1=0;}}if(iNum>0){iNumR = iNum;if(iNumR>iNum41){iNumR = iNum41;}if(iNumR>iNum42){iNumR = iNum42;}if(iNumR>iDomainContainer-iNum2){iNumR = iDomainContainer-iNum2;}iNum2 = iNum2+iNumR;iNum41 = iNum41-iNumR;iNum42 = iNum42-iNumR;}
if((sBP1==sTag51)&&(sBP1==sTag52)){iNumR = iNum1/2;iNum51 = iNum51+iNumR;iNum52 = iNum52+iNumR;iNum1 = iNum1-(iNumR*2);}else{if(sBP1==sTag51){iNum51 = iNum51+iNum1;iNum1=0;}if(sBP1==sTag52){iNum52 = iNum52+iNum1;iNum1=0;}}if(iNum>0){iNumR = iNum;if(iNumR>iNum51){iNumR = iNum51;}if(iNumR>iNum52){iNumR = iNum52;}if(iNumR>iDomainContainer-iNum2){iNumR = iDomainContainer-iNum2;}iNum2 = iNum2+iNumR;iNum51 = iNum51-iNumR;iNum52 = iNum52-iNumR;}
  }
// Unit 3
if(sBP2!="")
  {
iNum = (iNum-2)/2;
if((sBP2==sTag31)&&(sBP2==sTag32)){iNumR = iNum2/2;iNum31 = iNum31+iNumR;iNum32 = iNum32+iNumR;iNum2 = iNum2-(iNumR*2);}else{if(sBP2==sTag31){iNum31 = iNum31+iNum2;iNum2=0;}if(sBP2==sTag32){iNum32 = iNum32+iNum2;iNum2=0;}}if(iNum>0){iNumR = iNum;if(iNumR>iNum31){iNumR = iNum31;}if(iNumR>iNum32){iNumR = iNum32;}if(iNumR>iDomainContainer-iNum3){iNumR = iDomainContainer-iNum3;}iNum3 = iNum3+iNumR;iNum31 = iNum31-iNumR;iNum32 = iNum32-iNumR;}
if((sBP2==sTag41)&&(sBP2==sTag42)){iNumR = iNum2/2;iNum41 = iNum41+iNumR;iNum42 = iNum42+iNumR;iNum2 = iNum2-(iNumR*2);}else{if(sBP2==sTag41){iNum41 = iNum41+iNum2;iNum2=0;}if(sBP2==sTag42){iNum42 = iNum42+iNum2;iNum2=0;}}if(iNum>0){iNumR = iNum;if(iNumR>iNum41){iNumR = iNum41;}if(iNumR>iNum42){iNumR = iNum42;}if(iNumR>iDomainContainer-iNum3){iNumR = iDomainContainer-iNum3;}iNum3 = iNum3+iNumR;iNum41 = iNum41-iNumR;iNum42 = iNum42-iNumR;}
if((sBP2==sTag51)&&(sBP2==sTag52)){iNumR = iNum2/2;iNum51 = iNum51+iNumR;iNum52 = iNum52+iNumR;iNum2 = iNum2-(iNumR*2);}else{if(sBP2==sTag51){iNum51 = iNum51+iNum2;iNum2=0;}if(sBP2==sTag52){iNum52 = iNum52+iNum2;iNum2=0;}}if(iNum>0){iNumR = iNum;if(iNumR>iNum51){iNumR = iNum51;}if(iNumR>iNum52){iNumR = iNum52;}if(iNumR>iDomainContainer-iNum3){iNumR = iDomainContainer-iNum3;}iNum3 = iNum3+iNumR;iNum51 = iNum51-iNumR;iNum52 = iNum52-iNumR;}
  }
// Unit 4
if(sBP3!="")
  {
iNum = (iNum-2)/2;
if((sBP3==sTag41)&&(sBP3==sTag42)){iNumR = iNum3/2;iNum41 = iNum41+iNumR;iNum42 = iNum42+iNumR;iNum3 = iNum3-(iNumR*2);}else{if(sBP3==sTag41){iNum41 = iNum41+iNum3;iNum3=0;}if(sBP3==sTag42){iNum42 = iNum42+iNum3;iNum3=0;}}if(iNum>0){iNumR = iNum;if(iNumR>iNum41){iNumR = iNum41;}if(iNumR>iNum42){iNumR = iNum42;}if(iNumR>iDomainContainer-iNum4){iNumR = iDomainContainer-iNum4;}iNum4 = iNum4+iNumR;iNum41 = iNum41-iNumR;iNum42 = iNum42-iNumR;}
if((sBP3==sTag51)&&(sBP3==sTag52)){iNumR = iNum3/2;iNum51 = iNum51+iNumR;iNum52 = iNum52+iNumR;iNum3 = iNum3-(iNumR*2);}else{if(sBP3==sTag51){iNum51 = iNum51+iNum3;iNum3=0;}if(sBP3==sTag52){iNum52 = iNum52+iNum3;iNum3=0;}}if(iNum>0){iNumR = iNum;if(iNumR>iNum51){iNumR = iNum51;}if(iNumR>iNum52){iNumR = iNum52;}if(iNumR>iDomainContainer-iNum4){iNumR = iDomainContainer-iNum4;}iNum4 = iNum4+iNumR;iNum51 = iNum51-iNumR;iNum52 = iNum52-iNumR;}
  }
// Unit 5
if(sBP4!="")
  {
iNum = (iNum-2)/2;
if((sBP4==sTag51)&&(sBP4==sTag52)){iNumR = iNum4/2;iNum51 = iNum51+iNumR;iNum52 = iNum52+iNumR;iNum4 = iNum4-(iNumR*2);}else{if(sBP4==sTag51){iNum51 = iNum51+iNum4;iNum4=0;}if(sBP4==sTag52){iNum52 = iNum52+iNum4;iNum4=0;}}if(iNum>0){iNumR = iNum;if(iNumR>iNum51){iNumR = iNum51;}if(iNumR>iNum52){iNumR = iNum52;}if(iNumR>iDomainContainer-iNum5){iNumR = iDomainContainer-iNum5;}iNum5 = iNum5+iNumR;iNum51 = iNum51-iNumR;iNum52 = iNum52-iNumR;}
  }
////////////////////////////////////////
sNum11 = IntToString(iNum11);sNum12 = IntToString(iNum12);sNum1 = IntToString(iNum1);
sNum21 = IntToString(iNum21);sNum22 = IntToString(iNum22);sNum2 = IntToString(iNum2);
sNum31 = IntToString(iNum31);sNum32 = IntToString(iNum32);sNum3 = IntToString(iNum3);
sNum41 = IntToString(iNum41);sNum42 = IntToString(iNum42);sNum4 = IntToString(iNum4);
sNum51 = IntToString(iNum51);sNum52 = IntToString(iNum52);sNum5 = IntToString(iNum5);

sVar1 = sBP1+"%001%"+sTag11+"%002%"+sTag12+"%003%"+sNum11+"%004%"+sNum12+"%005%"+sNum1+"%006%";
sVar2 = sBP2+"%001%"+sTag21+"%002%"+sTag22+"%003%"+sNum21+"%004%"+sNum22+"%005%"+sNum2+"%006%";
sVar3 = sBP3+"%001%"+sTag31+"%002%"+sTag32+"%003%"+sNum31+"%004%"+sNum32+"%005%"+sNum3+"%006%";
sVar4 = sBP4+"%001%"+sTag41+"%002%"+sTag42+"%003%"+sNum41+"%004%"+sNum42+"%005%"+sNum4+"%006%";
sVar5 = sBP5+"%001%"+sTag51+"%002%"+sTag52+"%003%"+sNum51+"%004%"+sNum52+"%005%"+sNum5+"%006%";

SetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot),sVar1+"_A_"+sVar2+"_B_"+sVar3+"_C_"+sVar4+"_D_"+sVar5+"_E_");
////////////////////////////////////////
if((GetStringLeft(sBP1,1)=="2")||(GetStringLeft(sBP1,1)=="3")||(GetStringLeft(sBP1,1)=="4")){sUpgrade0 = GetStringLeft(sBP1,1);sBP1 = GetStringRight(sBP1,GetStringLength(sBP1)-1);}oNew = CreateItemOnObject(sBP1);sVar = GetName(oNew);if(sUpgrade0=="2"){sVar = "Improved "+sVar;}else if(sUpgrade0=="3"){sVar = "Quality "+sVar;}else if(sUpgrade0=="4"){sVar = "Precious "+sVar;}DestroyObject(oNew);if((GetStringLeft(sTag11,1)=="2")||(GetStringLeft(sTag11,1)=="3")||(GetStringLeft(sTag11,1)=="4")){sUpgrade1 = GetStringLeft(sTag11,1);sTag11 = GetStringRight(sTag11,GetStringLength(sTag11)-1);}oNew = CreateItemOnObject(sTag11);sVar1 = GetName(oNew);if(sUpgrade1=="2"){sVar1 = "Improved "+sVar1;}else if(sUpgrade1=="3"){sVar1 = "Quality "+sVar1;}else if(sUpgrade1=="4"){sVar1 = "Precious "+sVar1;}DestroyObject(oNew);if((GetStringLeft(sTag12,1)=="2")||(GetStringLeft(sTag12,1)=="3")||(GetStringLeft(sTag12,1)=="4")){sUpgrade2 = GetStringLeft(sTag12,1);sTag12 = GetStringRight(sTag12,GetStringLength(sTag12)-1);}oNew = CreateItemOnObject(sTag12);sVar2 = GetName(oNew);if(sUpgrade2=="2"){sVar2 = "Improved "+sVar2;}else if(sUpgrade2=="3"){sVar2 = "Quality "+sVar2;}else if(sUpgrade2=="4"){sVar2 = "Precious "+sVar2;}DestroyObject(oNew);if(sBP1!=""){sVar = "Unit 1 : "+sNum1+" "+ColorText(sVar,"g")+", "+sNum11+" "+ColorText(sVar1,"y")+", "+sNum12+" "+ColorText(sVar2,"y");}else{sVar = "";}SetCustomToken(10521,sVar);
if((GetStringLeft(sBP2,1)=="2")||(GetStringLeft(sBP2,1)=="3")||(GetStringLeft(sBP2,1)=="4")){sUpgrade0 = GetStringLeft(sBP2,1);sBP2 = GetStringRight(sBP2,GetStringLength(sBP2)-1);}oNew = CreateItemOnObject(sBP2);sVar = GetName(oNew);if(sUpgrade0=="2"){sVar = "Improved "+sVar;}else if(sUpgrade0=="3"){sVar = "Quality "+sVar;}else if(sUpgrade0=="4"){sVar = "Precious "+sVar;}DestroyObject(oNew);if((GetStringLeft(sTag21,1)=="2")||(GetStringLeft(sTag21,1)=="3")||(GetStringLeft(sTag21,1)=="4")){sUpgrade1 = GetStringLeft(sTag21,1);sTag21 = GetStringRight(sTag21,GetStringLength(sTag21)-1);}oNew = CreateItemOnObject(sTag21);sVar1 = GetName(oNew);if(sUpgrade1=="2"){sVar1 = "Improved "+sVar1;}else if(sUpgrade1=="3"){sVar1 = "Quality "+sVar1;}else if(sUpgrade1=="4"){sVar1 = "Precious "+sVar1;}DestroyObject(oNew);if((GetStringLeft(sTag22,1)=="2")||(GetStringLeft(sTag22,1)=="3")||(GetStringLeft(sTag22,1)=="4")){sUpgrade2 = GetStringLeft(sTag22,1);sTag22 = GetStringRight(sTag22,GetStringLength(sTag22)-1);}oNew = CreateItemOnObject(sTag22);sVar2 = GetName(oNew);if(sUpgrade2=="2"){sVar2 = "Improved "+sVar2;}else if(sUpgrade2=="3"){sVar2 = "Quality "+sVar2;}else if(sUpgrade2=="4"){sVar2 = "Precious "+sVar2;}DestroyObject(oNew);if(sBP2!=""){sVar = "Unit 2 : "+sNum2+" "+ColorText(sVar,"g")+", "+sNum21+" "+ColorText(sVar1,"y")+", "+sNum22+" "+ColorText(sVar2,"y");}else{sVar = "";}SetCustomToken(10522,sVar);
if((GetStringLeft(sBP3,1)=="2")||(GetStringLeft(sBP3,1)=="3")||(GetStringLeft(sBP3,1)=="4")){sUpgrade0 = GetStringLeft(sBP3,1);sBP3 = GetStringRight(sBP3,GetStringLength(sBP3)-1);}oNew = CreateItemOnObject(sBP3);sVar = GetName(oNew);if(sUpgrade0=="2"){sVar = "Improved "+sVar;}else if(sUpgrade0=="3"){sVar = "Quality "+sVar;}else if(sUpgrade0=="4"){sVar = "Precious "+sVar;}DestroyObject(oNew);if((GetStringLeft(sTag31,1)=="2")||(GetStringLeft(sTag31,1)=="3")||(GetStringLeft(sTag31,1)=="4")){sUpgrade1 = GetStringLeft(sTag31,1);sTag31 = GetStringRight(sTag31,GetStringLength(sTag31)-1);}oNew = CreateItemOnObject(sTag31);sVar1 = GetName(oNew);if(sUpgrade1=="2"){sVar1 = "Improved "+sVar1;}else if(sUpgrade1=="3"){sVar1 = "Quality "+sVar1;}else if(sUpgrade1=="4"){sVar1 = "Precious "+sVar1;}DestroyObject(oNew);if((GetStringLeft(sTag32,1)=="2")||(GetStringLeft(sTag32,1)=="3")||(GetStringLeft(sTag32,1)=="4")){sUpgrade2 = GetStringLeft(sTag32,1);sTag32 = GetStringRight(sTag32,GetStringLength(sTag32)-1);}oNew = CreateItemOnObject(sTag32);sVar2 = GetName(oNew);if(sUpgrade2=="2"){sVar2 = "Improved "+sVar2;}else if(sUpgrade2=="3"){sVar2 = "Quality "+sVar2;}else if(sUpgrade2=="4"){sVar2 = "Precious "+sVar2;}DestroyObject(oNew);if(sBP3!=""){sVar = "Unit 3 : "+sNum3+" "+ColorText(sVar,"g")+", "+sNum31+" "+ColorText(sVar1,"y")+", "+sNum32+" "+ColorText(sVar2,"y");}else{sVar = "";}SetCustomToken(10523,sVar);
if((GetStringLeft(sBP4,1)=="2")||(GetStringLeft(sBP4,1)=="3")||(GetStringLeft(sBP4,1)=="4")){sUpgrade0 = GetStringLeft(sBP4,1);sBP4 = GetStringRight(sBP4,GetStringLength(sBP4)-1);}oNew = CreateItemOnObject(sBP4);sVar = GetName(oNew);if(sUpgrade0=="2"){sVar = "Improved "+sVar;}else if(sUpgrade0=="3"){sVar = "Quality "+sVar;}else if(sUpgrade0=="4"){sVar = "Precious "+sVar;}DestroyObject(oNew);if((GetStringLeft(sTag41,1)=="2")||(GetStringLeft(sTag41,1)=="3")||(GetStringLeft(sTag41,1)=="4")){sUpgrade1 = GetStringLeft(sTag41,1);sTag41 = GetStringRight(sTag41,GetStringLength(sTag41)-1);}oNew = CreateItemOnObject(sTag41);sVar1 = GetName(oNew);if(sUpgrade1=="2"){sVar1 = "Improved "+sVar1;}else if(sUpgrade1=="3"){sVar1 = "Quality "+sVar1;}else if(sUpgrade1=="4"){sVar1 = "Precious "+sVar1;}DestroyObject(oNew);if((GetStringLeft(sTag42,1)=="2")||(GetStringLeft(sTag42,1)=="3")||(GetStringLeft(sTag42,1)=="4")){sUpgrade2 = GetStringLeft(sTag42,1);sTag42 = GetStringRight(sTag42,GetStringLength(sTag42)-1);}oNew = CreateItemOnObject(sTag42);sVar2 = GetName(oNew);if(sUpgrade2=="2"){sVar2 = "Improved "+sVar2;}else if(sUpgrade2=="3"){sVar2 = "Quality "+sVar2;}else if(sUpgrade2=="4"){sVar2 = "Precious "+sVar2;}DestroyObject(oNew);if(sBP4!=""){sVar = "Unit 4 : "+sNum4+" "+ColorText(sVar,"g")+", "+sNum41+" "+ColorText(sVar1,"y")+", "+sNum42+" "+ColorText(sVar2,"y");}else{sVar = "";}SetCustomToken(10524,sVar);
if((GetStringLeft(sBP5,1)=="2")||(GetStringLeft(sBP5,1)=="3")||(GetStringLeft(sBP5,1)=="4")){sUpgrade0 = GetStringLeft(sBP5,1);sBP5 = GetStringRight(sBP5,GetStringLength(sBP5)-1);}oNew = CreateItemOnObject(sBP5);sVar = GetName(oNew);if(sUpgrade0=="2"){sVar = "Improved "+sVar;}else if(sUpgrade0=="3"){sVar = "Quality "+sVar;}else if(sUpgrade0=="4"){sVar = "Precious "+sVar;}DestroyObject(oNew);if((GetStringLeft(sTag51,1)=="2")||(GetStringLeft(sTag51,1)=="3")||(GetStringLeft(sTag51,1)=="4")){sUpgrade1 = GetStringLeft(sTag51,1);sTag51 = GetStringRight(sTag51,GetStringLength(sTag51)-1);}oNew = CreateItemOnObject(sTag51);sVar1 = GetName(oNew);if(sUpgrade1=="2"){sVar1 = "Improved "+sVar1;}else if(sUpgrade1=="3"){sVar1 = "Quality "+sVar1;}else if(sUpgrade1=="4"){sVar1 = "Precious "+sVar1;}DestroyObject(oNew);if((GetStringLeft(sTag52,1)=="2")||(GetStringLeft(sTag52,1)=="3")||(GetStringLeft(sTag52,1)=="4")){sUpgrade2 = GetStringLeft(sTag52,1);sTag52 = GetStringRight(sTag52,GetStringLength(sTag52)-1);}oNew = CreateItemOnObject(sTag52);sVar2 = GetName(oNew);if(sUpgrade2=="2"){sVar2 = "Improved "+sVar2;}else if(sUpgrade2=="3"){sVar2 = "Quality "+sVar2;}else if(sUpgrade2=="4"){sVar2 = "Precious "+sVar2;}DestroyObject(oNew);if(sBP5!=""){sVar = "Unit 5 : "+sNum5+" "+ColorText(sVar,"g")+", "+sNum51+" "+ColorText(sVar1,"y")+", "+sNum52+" "+ColorText(sVar2,"y");}else{sVar = "";}SetCustomToken(10525,sVar);

DeleteLocalInt(oPC,sPlanet+"&"+sArea+"&Execute&"+IntToString(iSlot));
 }
////////////////////////////////////////////////////////////////////////////////
// Farm
else if(iStructure==7)
 {
iDays = iDomainFarm*24;iDays = iDays-(iDays*iBonus/100);
if(iLevel>=3){iDomainContainer = iDomainContainer*2;}
if(iLevel>=5){iDays/2;}

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

while(i<5)
  {
i++;
iOrigCounter = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(i));
iHBPassed = iCounter-iOrigCounter;
iNum = iHBPassed/iDays;
iOrigCounter = iOrigCounter+(iNum*iDays);

if(iNum>0)
   {
     if((i==1)&&(sBP1L!="")){iNum1 = iNum1+iNum;if(iNum1>iDomainContainer){iNum1 = iDomainContainer;}}
else if((i==2)&&(sBP2L!="")){iNum2 = iNum2+iNum;if(iNum2>iDomainContainer){iNum2 = iDomainContainer;}}
else if((i==3)&&(sBP3L!="")){iNum3 = iNum3+iNum;if(iNum3>iDomainContainer){iNum3 = iDomainContainer;}}
else if((i==4)&&(sBP4L!="")){iNum4 = iNum4+iNum;if(iNum4>iDomainContainer){iNum4 = iDomainContainer;}}
else if((i==5)&&(sBP5L!="")){iNum5 = iNum5+iNum;if(iNum5>iDomainContainer){iNum5 = iDomainContainer;}}

SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(i),iOrigCounter);
   }
  }
sNum1R = IntToString(iNum1);
sNum2R = IntToString(iNum2);
sNum3R = IntToString(iNum3);
sNum4R = IntToString(iNum4);
sNum5R = IntToString(iNum5);

sVar1 = sBP1L+"%"+sNum1R;
sVar2 = sBP2L+"%"+sNum2R;
sVar3 = sBP3L+"%"+sNum3R;
sVar4 = sBP4L+"%"+sNum4R;
sVar5 = sBP5L+"%"+sNum5R;

SetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot),sVar1+"_A_"+sVar2+"_B_"+sVar3+"_C_"+sVar4+"_D_"+sVar5+"_E_");
//
string s1a = "mn_small_ani001";string s1b = "Badger";
string s2a = "henchani011";string s2b = "Dog";
string s3a = "henchani012";string s3b = "Falcon";
string s4a = "mn_goat001";string s4b = "Goat";
string s5a = "mn_boar003";string s5b = "Boar";
string s6a = "henchani010";string s6b = "Cow";
string s7a = "mn_deer002";string s7b = "Deer";
string s8a = "henchani001";string s8b = "Brown Horse";
string s9a = "henchani006";string s9b = "Brown Pony";
string s10a = "mn_snake005";string s10b = "Snake";
string s11a = "mn_wildbeef002";string s11b = "Angus Wild";
string s12a = "henchani002";string s12b = "Black horse";
string s13a = "henchani009";string s13b = "Ox";
string s14a = "henchani007";string s14b = "Stain Pony";
string s15a = "henchani003";string s15b = "White Horse";
string s16a = "henchani008";string s16b = "White Pony";

if(sBP1L==s1a){sVar1 = s1b;}else if(sBP1L==s2a){sVar1 = s2b;}else if(sBP1L==s3a){sVar1 = s3b;}else if(sBP1L==s4a){sVar1 = s4b;}else if(sBP1L==s5a){sVar1 = s5b;}else if(sBP1L==s6a){sVar1 = s6b;}else if(sBP1L==s7a){sVar1 = s7b;}else if(sBP1L==s8a){sVar1 = s8b;}else if(sBP1L==s9a){sVar1 = s9b;}else if(sBP1L==s10a){sVar1 = s10b;}else if(sBP1L==s11a){sVar1 = s11b;}else if(sBP1L==s12a){sVar1 = s12b;}else if(sBP1L==s13a){sVar1 = s13b;}else if(sBP1L==s14a){sVar1 = s14b;}else if(sBP1L==s15a){sVar1 = s15b;}else if(sBP1L==s16a){sVar1 = s16b;}
if(sBP2L==s1a){sVar2 = s1b;}else if(sBP2L==s2a){sVar2 = s2b;}else if(sBP2L==s3a){sVar2 = s3b;}else if(sBP2L==s4a){sVar2 = s4b;}else if(sBP2L==s5a){sVar2 = s5b;}else if(sBP2L==s6a){sVar2 = s6b;}else if(sBP2L==s7a){sVar2 = s7b;}else if(sBP2L==s8a){sVar2 = s8b;}else if(sBP2L==s9a){sVar2 = s9b;}else if(sBP2L==s10a){sVar2 = s10b;}else if(sBP2L==s11a){sVar2 = s11b;}else if(sBP2L==s12a){sVar2 = s12b;}else if(sBP2L==s13a){sVar2 = s13b;}else if(sBP2L==s14a){sVar2 = s14b;}else if(sBP2L==s15a){sVar2 = s15b;}else if(sBP2L==s16a){sVar2 = s16b;}
if(sBP3L==s1a){sVar3 = s1b;}else if(sBP3L==s2a){sVar3 = s2b;}else if(sBP3L==s3a){sVar3 = s3b;}else if(sBP3L==s4a){sVar3 = s4b;}else if(sBP3L==s5a){sVar3 = s5b;}else if(sBP3L==s6a){sVar3 = s6b;}else if(sBP3L==s7a){sVar3 = s7b;}else if(sBP3L==s8a){sVar3 = s8b;}else if(sBP3L==s9a){sVar3 = s9b;}else if(sBP3L==s10a){sVar3 = s10b;}else if(sBP3L==s11a){sVar3 = s11b;}else if(sBP3L==s12a){sVar3 = s12b;}else if(sBP3L==s13a){sVar3 = s13b;}else if(sBP3L==s14a){sVar3 = s14b;}else if(sBP3L==s15a){sVar3 = s15b;}else if(sBP3L==s16a){sVar3 = s16b;}
if(sBP4L==s1a){sVar4 = s1b;}else if(sBP4L==s2a){sVar4 = s2b;}else if(sBP4L==s3a){sVar4 = s3b;}else if(sBP4L==s4a){sVar4 = s4b;}else if(sBP4L==s5a){sVar4 = s5b;}else if(sBP4L==s6a){sVar4 = s6b;}else if(sBP4L==s7a){sVar4 = s7b;}else if(sBP4L==s8a){sVar4 = s8b;}else if(sBP4L==s9a){sVar4 = s9b;}else if(sBP4L==s10a){sVar4 = s10b;}else if(sBP4L==s11a){sVar4 = s11b;}else if(sBP4L==s12a){sVar4 = s12b;}else if(sBP4L==s13a){sVar4 = s13b;}else if(sBP4L==s14a){sVar4 = s14b;}else if(sBP4L==s15a){sVar4 = s15b;}else if(sBP4L==s16a){sVar4 = s16b;}
if(sBP5L==s1a){sVar5 = s1b;}else if(sBP5L==s2a){sVar5 = s2b;}else if(sBP5L==s3a){sVar5 = s3b;}else if(sBP5L==s4a){sVar5 = s4b;}else if(sBP5L==s5a){sVar5 = s5b;}else if(sBP5L==s6a){sVar5 = s6b;}else if(sBP5L==s7a){sVar5 = s7b;}else if(sBP5L==s8a){sVar5 = s8b;}else if(sBP5L==s9a){sVar5 = s9b;}else if(sBP5L==s10a){sVar5 = s10b;}else if(sBP5L==s11a){sVar5 = s11b;}else if(sBP5L==s12a){sVar5 = s12b;}else if(sBP5L==s13a){sVar5 = s13b;}else if(sBP5L==s14a){sVar5 = s14b;}else if(sBP5L==s15a){sVar5 = s15b;}else if(sBP5L==s16a){sVar5 = s16b;}

if(sBP1L!=""){sVar1 = "Pen 1 : "+sNum1R+" "+sVar1;}else{sVar1 = "";}
if(sBP2L!=""){sVar2 = "Pen 2 : "+sNum2R+" "+sVar2;}else{sVar2 = "";}
if(sBP3L!=""){sVar3 = "Pen 3 : "+sNum3R+" "+sVar3;}else{sVar3 = "";}
if(sBP4L!=""){sVar4 = "Pen 4 : "+sNum4R+" "+sVar4;}else{sVar4 = "";}
if(sBP5L!=""){sVar5 = "Pen 5 : "+sNum5R+" "+sVar5;}else{sVar5 = "";}

SetCustomToken(10521,sVar1);
SetCustomToken(10522,sVar2);
SetCustomToken(10523,sVar3);
SetCustomToken(10524,sVar4);
SetCustomToken(10525,sVar5);
 }
////////////////////////////////////////////////////////////////////////////////
// Field
else if(iStructure==8)
 {
iDays = iDomainField*24;iDays = iDays-(iDays*iBonus/100);
if(iLevel>=3){iDomainContainer = iDomainContainer*2;}
if(iLevel>=5){iDays/2;}

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

while(i<5)
  {
i++;
iOrigCounter = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(i));
iHBPassed = iCounter-iOrigCounter;
iNum = iHBPassed/iDays;
iOrigCounter = iOrigCounter+(iNum*iDays);

if(iNum>0)
   {
     if((i==1)&&(sBP1L!="")){iNum1 = iNum1+iNum;if(iNum1>iDomainContainer){iNum1 = iDomainContainer;}}
else if((i==2)&&(sBP2L!="")){iNum2 = iNum2+iNum;if(iNum2>iDomainContainer){iNum2 = iDomainContainer;}}
else if((i==3)&&(sBP3L!="")){iNum3 = iNum3+iNum;if(iNum3>iDomainContainer){iNum3 = iDomainContainer;}}
else if((i==4)&&(sBP4L!="")){iNum4 = iNum4+iNum;if(iNum4>iDomainContainer){iNum4 = iDomainContainer;}}
else if((i==5)&&(sBP5L!="")){iNum5 = iNum5+iNum;if(iNum5>iDomainContainer){iNum5 = iDomainContainer;}}

SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(i),iOrigCounter);
   }
  }
sNum1R = IntToString(iNum1);
sNum2R = IntToString(iNum2);
sNum3R = IntToString(iNum3);
sNum4R = IntToString(iNum4);
sNum5R = IntToString(iNum5);

sVar1 = sBP1L+"%"+sNum1R;
sVar2 = sBP2L+"%"+sNum2R;
sVar3 = sBP3L+"%"+sNum3R;
sVar4 = sBP4L+"%"+sNum4R;
sVar5 = sBP5L+"%"+sNum5R;

SetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot),sVar1+"_A_"+sVar2+"_B_"+sVar3+"_C_"+sVar4+"_D_"+sVar5+"_E_");
//
oNew = CreateItemOnObject(sBP1L);sVar1 = GetName(oNew);DestroyObject(oNew);
oNew = CreateItemOnObject(sBP2L);sVar2 = GetName(oNew);DestroyObject(oNew);
oNew = CreateItemOnObject(sBP3L);sVar3 = GetName(oNew);DestroyObject(oNew);
oNew = CreateItemOnObject(sBP4L);sVar4 = GetName(oNew);DestroyObject(oNew);
oNew = CreateItemOnObject(sBP5L);sVar5 = GetName(oNew);DestroyObject(oNew);

if(sBP1L!=""){sVar1 = "Garden 1 : "+sNum1R+" "+sVar1;}else{sVar1 = "";}
if(sBP2L!=""){sVar2 = "Garden 2 : "+sNum2R+" "+sVar2;}else{sVar2 = "";}
if(sBP3L!=""){sVar3 = "Garden 3 : "+sNum3R+" "+sVar3;}else{sVar3 = "";}
if(sBP4L!=""){sVar4 = "Garden 4 : "+sNum4R+" "+sVar4;}else{sVar4 = "";}
if(sBP5L!=""){sVar5 = "Garden 5 : "+sNum5R+" "+sVar5;}else{sVar5 = "";}

SetCustomToken(10521,sVar1);
SetCustomToken(10522,sVar2);
SetCustomToken(10523,sVar3);
SetCustomToken(10524,sVar4);
SetCustomToken(10525,sVar5);
 }
////////////////////////////////////////////////////////////////////////////////
// Sawmill
else if(iStructure==21)
 {
iDays = iDomainSawmill*24;iDays = iDays-(iDays*iBonus/100);
if(iLevel>=3){iDomainContainer = iDomainContainer*2;}
if(iLevel>=5){iDays/2;}

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

while(i<5)
  {
i++;
iOrigCounter = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(i));
iHBPassed = iCounter-iOrigCounter;
iNum = iHBPassed/iDays;
iOrigCounter = iOrigCounter+(iNum*iDays);

if(iNum>0)
   {
     if((i==1)&&(sBP1L!="")){iNum1 = iNum1+iNum;if(iNum1>iDomainContainer){iNum1 = iDomainContainer;}}
else if((i==2)&&(sBP2L!="")){iNum2 = iNum2+iNum;if(iNum2>iDomainContainer){iNum2 = iDomainContainer;}}
else if((i==3)&&(sBP3L!="")){iNum3 = iNum3+iNum;if(iNum3>iDomainContainer){iNum3 = iDomainContainer;}}
else if((i==4)&&(sBP4L!="")){iNum4 = iNum4+iNum;if(iNum4>iDomainContainer){iNum4 = iDomainContainer;}}
else if((i==5)&&(sBP5L!="")){iNum5 = iNum5+iNum;if(iNum5>iDomainContainer){iNum5 = iDomainContainer;}}

SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter"+IntToString(i),iOrigCounter);
   }
  }
sNum1R = IntToString(iNum1);
sNum2R = IntToString(iNum2);
sNum3R = IntToString(iNum3);
sNum4R = IntToString(iNum4);
sNum5R = IntToString(iNum5);

sVar1 = sBP1L+"%"+sNum1R;
sVar2 = sBP2L+"%"+sNum2R;
sVar3 = sBP3L+"%"+sNum3R;
sVar4 = sBP4L+"%"+sNum4R;
sVar5 = sBP5L+"%"+sNum5R;

SetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot),sVar1+"_A_"+sVar2+"_B_"+sVar3+"_C_"+sVar4+"_D_"+sVar5+"_E_");
//
oNew = CreateItemOnObject(sBP1L);sVar1 = GetName(oNew);DestroyObject(oNew);
oNew = CreateItemOnObject(sBP2L);sVar2 = GetName(oNew);DestroyObject(oNew);
oNew = CreateItemOnObject(sBP3L);sVar3 = GetName(oNew);DestroyObject(oNew);
oNew = CreateItemOnObject(sBP4L);sVar4 = GetName(oNew);DestroyObject(oNew);
oNew = CreateItemOnObject(sBP5L);sVar5 = GetName(oNew);DestroyObject(oNew);

if(sBP1L!=""){sVar1 = "Sawmill 1 : "+sNum1R+" "+sVar1;}else{sVar1 = "";}
if(sBP2L!=""){sVar2 = "Sawmill 2 : "+sNum2R+" "+sVar2;}else{sVar2 = "";}
if(sBP3L!=""){sVar3 = "Sawmill 3 : "+sNum3R+" "+sVar3;}else{sVar3 = "";}
if(sBP4L!=""){sVar4 = "Sawmill 4 : "+sNum4R+" "+sVar4;}else{sVar4 = "";}
if(sBP5L!=""){sVar5 = "Sawmill 5 : "+sNum5R+" "+sVar5;}else{sVar5 = "";}

SetCustomToken(10521,sVar1);
SetCustomToken(10522,sVar2);
SetCustomToken(10523,sVar3);
SetCustomToken(10524,sVar4);
SetCustomToken(10525,sVar5);
 }
////////////////////////////////////////////////////////////////////////////////
// House
else if(iStructure==11)
 {
if(GetName(oPC)==sRent)
  {
iRent = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+"&Rent&"+IntToString(iSlot));
iOrigCounter = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter");
iHBPassed = iCounter-iOrigCounter;
iRent = iRent-iHBPassed;

SendMessageToPC(oPC,"Rent : "+IntToString(iRent/576)+" days.");

SetLocalInt(oGoldbag,sPlanet+"&"+sArea+"&Rent&"+IntToString(iSlot),iRent);
SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter",iCounter);
  }
SetCustomToken(10604,IntToString(iDomainHouseGP));SetLocalInt(OBJECT_SELF,"Price1",iDomainHouseGP);SetLocalInt(OBJECT_SELF,"Price2",iDomainHouseGP);if(sRent==""){sRent = "nobody";}SetCustomToken(10605,sRent);
 }
////////////////////////////////////////////////////////////////////////////////
DeleteLocalObject(OBJECT_SELF,"PC");
////////////////////////////////////////////////////////////////////////////////
}
