#include "aps_include"
int StartingConditional()
{
object oModule = GetModule();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
string sVar = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot));
int iChoice = GetLocalInt(OBJECT_SELF,"ChoiceDone16");

if((iChoice==0)&&(sVar=="")){return TRUE;}else{return FALSE;}
}
