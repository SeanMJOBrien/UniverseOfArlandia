#include "aps_include"
int StartingConditional()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sInterest = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
int iPlaceDomain = GetLocalInt(oPC,"PlaceDomain");

if((iPlaceDomain==1)&&(sInterest!="")){return TRUE;}else{return FALSE;}
}
