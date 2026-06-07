#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
int StartingConditional(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oArea = GetArea(OBJECT_SELF);
string sAreaName = GetName(oArea);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice2");
int iChoice3 = GetLocalInt(OBJECT_SELF,"Choice3");
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
if((((iChoice3==7)||(iChoice3==8))&&(sAreaName=="Forest"))||((iChoice3==21)&&(sAreaName!="Foothills")&&(sAreaName!="Forest"))||(((iChoice3==7)||(iChoice3==8))&&((sAreaName=="Clouds")||(sAreaName=="Desert")||(sAreaName=="Frozen land")||(sAreaName=="Gaz")||(sAreaName=="Moon")||(sAreaName=="Rural Swamp")||(sAreaName=="Snow")||(sAreaName=="Swamp")))){return TRUE;}
else if(((iChoice2==5)&&((iChoice3==1)||(iChoice3==2))&&(StringToInt(sVar5L)==iChoice3))||((iChoice2==8)&&((iChoice3==1)||(iChoice3==2))&&(StringToInt(sVar8L)==iChoice3))||((iChoice2!=5)&&(iChoice2!=8)&&(iChoice2!=10)&&((iChoice3==1)||(iChoice3==4)||(iChoice3==10)||(iChoice3==14)||(iChoice3==17))&&((StringToInt(sVar1L)==iChoice3)||(StringToInt(sVar2L)==iChoice3)||(StringToInt(sVar3L)==iChoice3)||(StringToInt(sVar4L)==iChoice3)||(StringToInt(sVar6L)==iChoice3)||(StringToInt(sVar7L)==iChoice3)||(StringToInt(sVar9L)==iChoice3)))){return TRUE;}
else{return FALSE;}
////////////////////////////////////////////////////////////////////////////////
}
