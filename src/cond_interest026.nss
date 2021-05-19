#include "aps_include"
int StartingConditional()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");

if((GetStringLeft(sInterests,1)=="5")||(GetStringLeft(sInterests,1)=="6")){return TRUE;}else{return FALSE;}
}
