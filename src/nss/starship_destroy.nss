#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice2");
int iDestroySS = GetLocalInt(OBJECT_SELF,"DestroySS");
//
string sDS;int iDS;int i;int j;string sS;
////////////////////////////////////////////////////////////////////////////////
string sInterest = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
string sVar = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")))-FindSubString(sInterest,"&2&")-3);
// Slots
string sVar1 = GetStringLeft(sVar,FindSubString(sVar,"_01_"));
string sVar2 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_02_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_02_")))-FindSubString(sVar,"_01_")-4);
string sVar3 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_03_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_03_")))-FindSubString(sVar,"_02_")-4);
string sVar4 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_04_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_04_")))-FindSubString(sVar,"_03_")-4);
string sVar6 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_06_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_06_")))-FindSubString(sVar,"_05_")-4);
string sVar7 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_07_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_07_")))-FindSubString(sVar,"_06_")-4);
string sVar9 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_09_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_09_")))-FindSubString(sVar,"_08_")-4);
// Types
string sVar1L = GetStringLeft(sVar1,FindSubString(sVar1,"%"));
string sVar2L = GetStringLeft(sVar2,FindSubString(sVar2,"%"));
string sVar3L = GetStringLeft(sVar3,FindSubString(sVar3,"%"));
string sVar4L = GetStringLeft(sVar4,FindSubString(sVar4,"%"));
string sVar6L = GetStringLeft(sVar6,FindSubString(sVar6,"%"));
string sVar7L = GetStringLeft(sVar7,FindSubString(sVar7,"%"));
string sVar9L = GetStringLeft(sVar9,FindSubString(sVar9,"%"));
////////////////////////////////////////////////////////////////////////////////
     if(iChoice2==1){sS = sVar1L;}
else if(iChoice2==2){sS = sVar2L;}
else if(iChoice2==3){sS = sVar3L;}
else if(iChoice2==4){sS = sVar4L;}
else if(iChoice2==6){sS = sVar6L;}
else if(iChoice2==7){sS = sVar7L;}
else if(iChoice2==9){sS = sVar9L;}
////////////////////////////////////////////////////////////////////////////////
if((sS=="17")||(iDestroySS==1))
 {
iDS = GetPersistentInt(oModule,sPlanet+"_DS");i=0;
while(i<iDS)
  {
i++;
sDS = GetPersistentString(oModule,sPlanet+"_DS_"+IntToString(i));
if(j==1)
   {
SetPersistentString(oModule,sPlanet+"_DS_"+IntToString(i-1),sDS);
   }
else if(GetStringLeft(sDS,FindSubString(sDS,"&001&"))==sArea)
   {
DeletePersistentVariable(oModule,sPlanet+"_DS_"+IntToString(i));j=1;
   }
  }
DeletePersistentVariable(oModule,sPlanet+"_DS_"+IntToString(i));
if((i-1)>0){SetPersistentInt(oModule,sPlanet+"_DS",i-1);}else{DeletePersistentVariable(oModule,sPlanet+"_DS");}
 }
////////////////////////////////////////////////////////////////////////////////
DeleteLocalInt(OBJECT_SELF,"DestroySS");
////////////////////////////////////////////////////////////////////////////////
}
