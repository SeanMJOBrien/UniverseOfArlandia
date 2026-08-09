#include "aps_include"
#include "inc_persist"
#include "inc_mappin"
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
// Map memory - always fires on disconnect, since area OnExit is not guaranteed
// to fire in that case. May run twice on the dead-PC path below (harmless,
// ExportMinimap upserts the same value).
if(GetIsObjectValid(oPC)&&GetIsPC(oPC)){ExportMinimap(oPC,GetArea(oPC));MapPin_SavePCMapPins(oPC);}
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
