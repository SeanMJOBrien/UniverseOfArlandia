#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
int StartingConditional(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice2");
int iVar;
////////////////////////////////////////////////////////////////////////////////
string sInterest = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
string sVar = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")))-FindSubString(sInterest,"&2&")-3);
// Slots
string sVar1 = GetStringLeft(sVar,FindSubString(sVar,"_01_"));
string sVar2 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_02_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_02_")))-FindSubString(sVar,"_01_")-4);
string sVar3 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_03_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_03_")))-FindSubString(sVar,"_02_")-4);
string sVar4 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_04_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_04_")))-FindSubString(sVar,"_03_")-4);
string sVar5 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_05_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_05_")))-FindSubString(sVar,"_04_")-4);
string sVar6 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_06_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_06_")))-FindSubString(sVar,"_05_")-4);
string sVar7 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_07_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_07_")))-FindSubString(sVar,"_06_")-4);
string sVar8 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_08_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_08_")))-FindSubString(sVar,"_07_")-4);
string sVar9 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_09_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_09_")))-FindSubString(sVar,"_08_")-4);
string sVar10 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_10_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_10_")))-FindSubString(sVar,"_09_")-4);
// Types & Levels
string sVar1L = GetStringLeft(sVar1,FindSubString(sVar1,"%"));string sVar1R = GetStringRight(sVar1,GetStringLength(sVar1)-FindSubString(sVar1,"%")-1);
string sVar2L = GetStringLeft(sVar2,FindSubString(sVar2,"%"));string sVar2R = GetStringRight(sVar2,GetStringLength(sVar2)-FindSubString(sVar2,"%")-1);
string sVar3L = GetStringLeft(sVar3,FindSubString(sVar3,"%"));string sVar3R = GetStringRight(sVar3,GetStringLength(sVar3)-FindSubString(sVar3,"%")-1);
string sVar4L = GetStringLeft(sVar4,FindSubString(sVar4,"%"));string sVar4R = GetStringRight(sVar4,GetStringLength(sVar4)-FindSubString(sVar4,"%")-1);
string sVar5L = GetStringLeft(sVar5,FindSubString(sVar5,"%"));string sVar5R = GetStringRight(sVar5,GetStringLength(sVar5)-FindSubString(sVar5,"%")-1);
string sVar6L = GetStringLeft(sVar6,FindSubString(sVar6,"%"));string sVar6R = GetStringRight(sVar6,GetStringLength(sVar6)-FindSubString(sVar6,"%")-1);
string sVar7L = GetStringLeft(sVar7,FindSubString(sVar7,"%"));string sVar7R = GetStringRight(sVar7,GetStringLength(sVar7)-FindSubString(sVar7,"%")-1);
string sVar8L = GetStringLeft(sVar8,FindSubString(sVar8,"%"));string sVar8R = GetStringRight(sVar8,GetStringLength(sVar8)-FindSubString(sVar8,"%")-1);
string sVar9L = GetStringLeft(sVar9,FindSubString(sVar9,"%"));string sVar9R = GetStringRight(sVar9,GetStringLength(sVar9)-FindSubString(sVar9,"%")-1);
string sVar10L = GetStringLeft(sVar10,FindSubString(sVar10,"%"));string sVar10R = GetStringRight(sVar10,GetStringLength(sVar10)-FindSubString(sVar10,"%")-1);
////////////////////////////////////////////////////////////////////////////////
     if(iChoice2==1){iVar = StringToInt(sVar1R);}
else if(iChoice2==2){iVar = StringToInt(sVar2R);}
else if(iChoice2==3){iVar = StringToInt(sVar3R);}
else if(iChoice2==4){iVar = StringToInt(sVar4R);}
else if(iChoice2==5){iVar = StringToInt(sVar5R);}
else if(iChoice2==6){iVar = StringToInt(sVar6R);}
else if(iChoice2==7){iVar = StringToInt(sVar7R);}
else if(iChoice2==8){iVar = StringToInt(sVar8R);}
else if(iChoice2==9){iVar = StringToInt(sVar9R);}
else if(iChoice2==10){iVar = StringToInt(sVar10R);}
////////////////////////////////////////////////////////////////////////////////
if(iVar>0){return TRUE;}else{return FALSE;}
////////////////////////////////////////////////////////////////////////////////
}
