#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
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
string sVar11 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_11_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_11_")))-FindSubString(sVar,"_10_")-4);
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
//
string sVariable1;string sVariable2;string sMes;int iLevel;int i;
////////////////////////////////////////////////////////////////////////////////
while(i<10)
 {
i++;
     if(i==1){sVariable1 = sVar1L;sVariable2 = sVar1R;}
else if(i==2){sVariable1 = sVar2L;sVariable2 = sVar2R;}
else if(i==3){sVariable1 = sVar3L;sVariable2 = sVar3R;}
else if(i==4){sVariable1 = sVar4L;sVariable2 = sVar4R;}
else if(i==5){sVariable1 = sVar5L;sVariable2 = sVar5R;}
else if(i==6){sVariable1 = sVar6L;sVariable2 = sVar6R;}
else if(i==7){sVariable1 = sVar7L;sVariable2 = sVar7R;}
else if(i==8){sVariable1 = sVar8L;sVariable2 = sVar8R;}
else if(i==9){sVariable1 = sVar9L;sVariable2 = sVar9R;}
else if(i==10){sVariable1 = sVar10L;sVariable2 = sVar10R;}

     if((i==5)&&(sVariable1=="1")){sMes = "A Central Place";}
else if((i==8)&&(sVariable1=="1")){sMes = "An Entry";}
else if((i==10)&&(sVariable1=="1")){sMes = "Walls";}

else if(sVariable1=="1"){sMes = "An Airship";}
else if(sVariable1=="2"){sMes = "An Amusement Place";}
else if(sVariable1=="3"){sMes = "A Casern";}
else if(sVariable1=="4"){sMes = "A Dungeon";}
else if(sVariable1=="5"){sMes = "An Extractor";}
else if(sVariable1=="6"){sMes = "A Factory";}
else if(sVariable1=="7"){sMes = "A Farm";}
else if(sVariable1=="8"){sMes = "A Field";}
else if(sVariable1=="9"){sMes = "A Guild";}
else if(sVariable1=="10"){sMes = "A Hall";}
else if(sVariable1=="11"){sMes = "A House";}
else if(sVariable1=="12"){sMes = "An Inn";}
else if(sVariable1=="13"){sMes = "A Mission Office";}
else if(sVariable1=="14"){sMes = "A Personal House";}
else if(sVariable1=="15"){sMes = "A School";}
else if(sVariable1=="16"){sMes = "A Shop";}
else if(sVariable1=="17"){sMes = "A Starship";}
else if(sVariable1=="18"){sMes = "A Tavern";}
else if(sVariable1=="19"){sMes = "A Temple";}
else if(sVariable1=="20"){sMes = "A Tower";}
else if(sVariable1=="21"){sMes = "A Sawmill";}
sMes = sMes+" level "+sVariable2;

SetCustomToken(10660+i,sMes);
 }
////////////////////////////////////////////////////////////////////////////////
}
