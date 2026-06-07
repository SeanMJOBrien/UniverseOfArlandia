////////////////////////////////////////////////////////////////////////////////
int StartingConditional(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
int iStructure = GetLocalInt(OBJECT_SELF,"Structure");
//
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
//
int iNum;string sVar;string sVar1;string sVar2;string sVar3;string sVar4;string sVar5;string sBP1L;string sBP2L;string sBP3L;string sBP4L;string sBP5L;string sNum11;string sNum21;string sNum31;string sNum41;string sNum51;string sNum12;string sNum22;string sNum32;string sNum42;string sNum52;int iNum11;int iNum21;int iNum31;int iNum41;int iNum51;int iNum12;int iNum22;int iNum32;int iNum42;int iNum52;string sNum1;string sNum2;string sNum3;string sNum4;string sNum5;int iNum1;int iNum2;int iNum3;int iNum4;int iNum5;
////////////////////////////////////////////////////////////////////////////////
sVar = GetLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot));

sVar1 = GetStringLeft(sVar,FindSubString(sVar,"_A_"));
sVar2 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_B_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_B_")))-FindSubString(sVar,"_A_")-3);
sVar3 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_C_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_C_")))-FindSubString(sVar,"_B_")-3);
sVar4 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_D_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_D_")))-FindSubString(sVar,"_C_")-3);
sVar5 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_E_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_E_")))-FindSubString(sVar,"_D_")-3);

if(iStructure==6)
 {
sNum11 = GetStringRight(GetStringLeft(sVar1,FindSubString(sVar1,"%004%")),GetStringLength(GetStringLeft(sVar1,FindSubString(sVar1,"%004%")))-FindSubString(sVar1,"%003%")-5);iNum11 = StringToInt(sNum11);sNum12 = GetStringRight(GetStringLeft(sVar1,FindSubString(sVar1,"%005%")),GetStringLength(GetStringLeft(sVar1,FindSubString(sVar1,"%005%")))-FindSubString(sVar1,"%004%")-5);iNum12 = StringToInt(sNum12);sNum1 = GetStringRight(GetStringLeft(sVar1,FindSubString(sVar1,"%006%")),GetStringLength(GetStringLeft(sVar1,FindSubString(sVar1,"%006%")))-FindSubString(sVar1,"%005%")-5);iNum1 = iNum11+iNum12+StringToInt(sNum1);
sNum21 = GetStringRight(GetStringLeft(sVar2,FindSubString(sVar2,"%004%")),GetStringLength(GetStringLeft(sVar2,FindSubString(sVar2,"%004%")))-FindSubString(sVar2,"%003%")-5);iNum21 = StringToInt(sNum21);sNum22 = GetStringRight(GetStringLeft(sVar2,FindSubString(sVar2,"%005%")),GetStringLength(GetStringLeft(sVar2,FindSubString(sVar2,"%005%")))-FindSubString(sVar2,"%004%")-5);iNum22 = StringToInt(sNum22);sNum2 = GetStringRight(GetStringLeft(sVar2,FindSubString(sVar2,"%006%")),GetStringLength(GetStringLeft(sVar2,FindSubString(sVar2,"%006%")))-FindSubString(sVar2,"%005%")-5);iNum2 = iNum21+iNum22+StringToInt(sNum2);
sNum31 = GetStringRight(GetStringLeft(sVar3,FindSubString(sVar3,"%004%")),GetStringLength(GetStringLeft(sVar3,FindSubString(sVar3,"%004%")))-FindSubString(sVar3,"%003%")-5);iNum31 = StringToInt(sNum31);sNum32 = GetStringRight(GetStringLeft(sVar3,FindSubString(sVar3,"%005%")),GetStringLength(GetStringLeft(sVar3,FindSubString(sVar3,"%005%")))-FindSubString(sVar3,"%004%")-5);iNum32 = StringToInt(sNum32);sNum3 = GetStringRight(GetStringLeft(sVar3,FindSubString(sVar3,"%006%")),GetStringLength(GetStringLeft(sVar3,FindSubString(sVar3,"%006%")))-FindSubString(sVar3,"%005%")-5);iNum3 = iNum31+iNum32+StringToInt(sNum3);
sNum41 = GetStringRight(GetStringLeft(sVar4,FindSubString(sVar4,"%004%")),GetStringLength(GetStringLeft(sVar4,FindSubString(sVar4,"%004%")))-FindSubString(sVar4,"%003%")-5);iNum41 = StringToInt(sNum41);sNum42 = GetStringRight(GetStringLeft(sVar4,FindSubString(sVar4,"%005%")),GetStringLength(GetStringLeft(sVar4,FindSubString(sVar4,"%005%")))-FindSubString(sVar4,"%004%")-5);iNum42 = StringToInt(sNum42);sNum4 = GetStringRight(GetStringLeft(sVar4,FindSubString(sVar4,"%006%")),GetStringLength(GetStringLeft(sVar4,FindSubString(sVar4,"%006%")))-FindSubString(sVar4,"%005%")-5);iNum4 = iNum41+iNum42+StringToInt(sNum4);
sNum51 = GetStringRight(GetStringLeft(sVar5,FindSubString(sVar5,"%004%")),GetStringLength(GetStringLeft(sVar5,FindSubString(sVar5,"%004%")))-FindSubString(sVar5,"%003%")-5);iNum51 = StringToInt(sNum51);sNum52 = GetStringRight(GetStringLeft(sVar5,FindSubString(sVar5,"%005%")),GetStringLength(GetStringLeft(sVar5,FindSubString(sVar5,"%005%")))-FindSubString(sVar5,"%004%")-5);iNum52 = StringToInt(sNum52);sNum5 = GetStringRight(GetStringLeft(sVar5,FindSubString(sVar5,"%006%")),GetStringLength(GetStringLeft(sVar5,FindSubString(sVar5,"%006%")))-FindSubString(sVar5,"%005%")-5);iNum5 = iNum51+iNum52+StringToInt(sNum5);
 }
else
 {
sNum11 = GetStringRight(sVar1,GetStringLength(sVar1)-FindSubString(sVar1,"%")-1);iNum1 = StringToInt(sNum11);
sNum21 = GetStringRight(sVar2,GetStringLength(sVar2)-FindSubString(sVar2,"%")-1);iNum2 = StringToInt(sNum21);
sNum31 = GetStringRight(sVar3,GetStringLength(sVar3)-FindSubString(sVar3,"%")-1);iNum3 = StringToInt(sNum31);
sNum41 = GetStringRight(sVar4,GetStringLength(sVar4)-FindSubString(sVar4,"%")-1);iNum4 = StringToInt(sNum41);
sNum51 = GetStringRight(sVar5,GetStringLength(sVar5)-FindSubString(sVar5,"%")-1);iNum5 = StringToInt(sNum51);
 }
////////////////////////////////////////////////////////////////////////////////
     if(iChoice1==1){iNum = iNum1;}
else if(iChoice1==2){iNum = iNum2;}
else if(iChoice1==3){iNum = iNum3;}
else if(iChoice1==4){iNum = iNum4;}
else if(iChoice1==5){iNum = iNum5;}
////////////////////////////////////////////////////////////////////////////////
if(iNum>0){return TRUE;}else{return FALSE;}
////////////////////////////////////////////////////////////////////////////////
}
