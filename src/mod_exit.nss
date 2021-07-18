#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetExitingObject();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sName = GetName(oPC);
string sPCName = GetPCPlayerName(oPC);
string sPlayerLastAreaIn = GetLocalString(oPC,"PlayerLastAreaIn");
object oArea;
////////////////////////////////////////////////////////////////////////////////
// Execute area_exit before and delete players area variables
DeleteLocalString(oPC,"PlayerAreaTo");
if(GetLocalInt(oGoldbag,"Dead")==1)
 {
oArea = GetObjectByTag(sPlayerLastAreaIn);
SetLocalInt(oArea,"SpecialSavePCDead",1);
ExecuteScript("area_exit",oArea);
 }
////////////////////////////////////////////////////////////////////////////////
// Website
DeletePersistentVariable(oModule,"Player"+IntToString(GetLocalInt(oModule,sName)));
////////////////////////////////////////////////////////////////////////////////
}
