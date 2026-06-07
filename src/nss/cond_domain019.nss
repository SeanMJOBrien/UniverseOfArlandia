#include "aps_include"
int StartingConditional()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
string sName = GetName(oPC);
//
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
string sRent = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot));

if(sName==sRent){return TRUE;}else{return FALSE;}
}
