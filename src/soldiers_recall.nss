#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
string sPlanet = GetLocalString(OBJECT_SELF,"Planet");
string sArea = GetLocalString(OBJECT_SELF,"Area");
int iNum = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&"+"&SoldierN");
//
object oGuard;object oGoldbag;string sPer;string sHench;string sVar1;string sVar2;int iX;int iY;string sX;string sY;string sName;string sPosX;string sPosY;string sPosF;string sMaster;string sAppearance;string sLevel;string sClass;string sHead;string sVar;
////////////////////////////////////////////////////////////////////////////////
while(iNum>0)
 {
sPer = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Soldier"+IntToString(iNum));

if(sPer!="")
  {
sHench = GetStringLeft(sPer,FindSubString(sPer,"&&1&&"));
sVar1 = GetStringRight(GetStringLeft(sPer,FindSubString(sPer,"&&2&&")),GetStringLength(GetStringLeft(sPer,FindSubString(sPer,"&&2&&")))-FindSubString(sPer,"&&1&&")-5);
sVar2 = GetStringRight(GetStringLeft(sPer,FindSubString(sPer,"&&3&&")),GetStringLength(GetStringLeft(sPer,FindSubString(sPer,"&&3&&")))-FindSubString(sPer,"&&2&&")-5);

sName = GetStringLeft(sHench,FindSubString(sHench,"_A_"));
sPosX = GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"_B_")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"_B_")))-FindSubString(sHench,"_A_")-3);
sPosY = GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"_C_")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"_C_")))-FindSubString(sHench,"_B_")-3);
sPosF = GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"_D_")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"_D_")))-FindSubString(sHench,"_C_")-3);
sMaster = GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"_E_")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"_E_")))-FindSubString(sHench,"_D_")-3);
sAppearance = GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"_F_")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"_F_")))-FindSubString(sHench,"_E_")-3);
sLevel = GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"_G_")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"_G_")))-FindSubString(sHench,"_F_")-3);
sClass = GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"_H_")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"_H_")))-FindSubString(sHench,"_G_")-3);
sHead = GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"_I_")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"_I_")))-FindSubString(sHench,"_H_")-3);
sVar = GetStringRight(GetStringLeft(sHench,FindSubString(sHench,"_J_")),GetStringLength(GetStringLeft(sHench,FindSubString(sHench,"_J_")))-FindSubString(sHench,"_I_")-3);

oGuard = CreateObject(OBJECT_TYPE_CREATURE,"hench000",Location(OBJECT_SELF,Vector(StringToFloat(sPosX),StringToFloat(sPosY),0.0),StringToFloat(sPosF)));
ChangeToStandardFaction(oGuard,STANDARD_FACTION_COMMONER);
if(GetName(oGuard)!=sName){SetName(oGuard,sName);}
SetLocalString(oGuard,"Master",sMaster);
SetLocalString(oGuard,"Var",sVar);
SetLocalInt(oGuard,"DontSave",1);
SetLocalInt(oGuard,"SoldierNum",iNum);
SetLocalInt(oGuard,"HenchNum",iNum);

oGoldbag = CreateItemOnObject("goldbag",oGuard);
SetLocalString(oGoldbag,"HenchCasernSlots"+IntToString(iNum),sVar1);
SetLocalString(oGoldbag,"HenchCasernInv"+IntToString(iNum),sVar2);
SetLocalInt(oGuard,"Race",StringToInt(sAppearance));
SetLocalInt(oGuard,"Level",StringToInt(sLevel));
SetLocalInt(oGuard,"Class",StringToInt(sClass));
SetLocalInt(oGuard,"Head",StringToInt(sHead));
SetLocalObject(oGuard,"Hench",oGuard);
SetLocalInt(oGuard,"HenchAction",14);
ExecuteScript("henchs",oGuard);
DestroyObject(oGoldbag,1.0);

SetLocalObject(OBJECT_SELF,"Guard"+IntToString(iNum),oGuard);
  }
iNum--;
 }
////////////////////////////////////////////////////////////////////////////////
}
