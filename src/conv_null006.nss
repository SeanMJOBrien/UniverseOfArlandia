#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
object oDomainControl = GetLocalObject(OBJECT_SELF,"DomainControl");
////////////////////////////////////////////////////////////////////////////////
string sInterest = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
string sInterestType = GetStringLeft(sInterest,FindSubString(sInterest,"&1&"));
string sMaster = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&2&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&2&")))-FindSubString(sInterest,"&1&")-3);
string sVar = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")))-FindSubString(sInterest,"&2&")-3);
string sVisible = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&4&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&4&")))-FindSubString(sInterest,"&3&")-3);
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
string sVar11 = GetLocalString(OBJECT_SELF,"title");
////////////////////////////////////////////////////////////////////////////////
sVar = sVar1+"_01_"+sVar2+"_02_"+sVar3+"_03_"+sVar4+"_04_"+sVar5+"_05_"+sVar6+"_06_"+sVar7+"_07_"+sVar8+"_08_"+sVar9+"_09_"+sVar10+"_10_"+sVar11+"_11_";
SetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests",sInterestType+"&1&"+sMaster+"&2&"+sVar+"&3&"+sVisible+"&4&");
SetName(oDomainControl,sVar11);
////////////////////////////////////////////////////////////////////////////////
DeleteLocalString(OBJECT_SELF,"title");
DeleteLocalObject(OBJECT_SELF,"DomainControl");
////////////////////////////////////////////////////////////////////////////////
}
