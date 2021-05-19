#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetMaster();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sX = IntToString(FloatToInt(GetPosition(OBJECT_SELF).x));
string sY = IntToString(FloatToInt(GetPosition(OBJECT_SELF).y));
int iHench = GetLocalInt(OBJECT_SELF,"HenchNum");
int iNum = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&"+"&SoldierN")+1;
////////////////////////////////////////////////////////////////////////////////
object oGoldbag2 = CreateItemOnObject("goldbag",OBJECT_SELF);
SetLocalInt(OBJECT_SELF,"HenchNum",iNum);
SetLocalObject(OBJECT_SELF,"Hench",OBJECT_SELF);
SetLocalInt(OBJECT_SELF,"HenchAction",13);
ExecuteScript("henchs",OBJECT_SELF);
////////////////////////////////////////////////////////////////////////////////
string sHench = GetName(OBJECT_SELF)+"_A_"+FloatToString(GetPosition(OBJECT_SELF).x)+"_B_"+FloatToString(GetPosition(OBJECT_SELF).y)+"_C_"+FloatToString(GetFacing(OBJECT_SELF))+"_D_"+GetLocalString(OBJECT_SELF,"Master")+"_E_"+IntToString(GetLocalInt(OBJECT_SELF,"Race"))+"_F_"+IntToString(GetLocalInt(OBJECT_SELF,"Level"))+"_G_"+IntToString(GetLocalInt(OBJECT_SELF,"Class"))+"_H_"+IntToString(GetLocalInt(OBJECT_SELF,"Head"))+"_I_"+GetLocalString(OBJECT_SELF,"Var")+"_J_";
string sVar1 = GetLocalString(oGoldbag2,"HenchCasernSlots"+IntToString(iNum));
string sVar2 = GetLocalString(oGoldbag2,"HenchCasernInv"+IntToString(iNum));
//
SetPersistentString(oModule,sPlanet+"&"+sArea+"&Soldier"+IntToString(iNum),sHench+"&&1&&"+sVar1+"&&2&&"+sVar2+"&&3&&");
SetPersistentInt(oModule,sPlanet+"&"+sArea+"&"+"&SoldierN",iNum);
////////////////////////////////////////////////////////////////////////////////
DeleteLocalString(oGoldbag,IntToString(iHench)+"Hench");
DeleteLocalString(oGoldbag,"HenchCasernSlots"+IntToString(iHench));
DeleteLocalString(oGoldbag,"HenchCasernInv"+IntToString(iHench));
DeleteLocalObject(oPC,"HenchObject"+IntToString(iHench));
DeleteLocalInt(OBJECT_SELF,"HenchNum");
SetLocalInt(OBJECT_SELF,"DontSave",1);
SetLocalInt(OBJECT_SELF,"SoldierNum",iNum);
ChangeToStandardFaction(OBJECT_SELF,STANDARD_FACTION_COMMONER);
RemoveHenchman(oPC,OBJECT_SELF);
AssignCommand(OBJECT_SELF,ClearAllActions());

SetLocalObject(oArea,"Guard"+IntToString(iNum),OBJECT_SELF);
//
DestroyObject(oGoldbag2,1.0);
////////////////////////////////////////////////////////////////////////////////
}
