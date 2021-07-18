#include "aps_include"
int StartingConditional()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");

if(sInterests!=""){return TRUE;}else{return FALSE;}
}
