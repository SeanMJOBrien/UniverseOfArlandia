#include "aps_include"
int StartingConditional()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
int iNumber1 = GetLocalInt(oPC,"ResMountain");
int iNumber2 = GetLocalInt(oPC,sPlanet+sArea+"ResMountain");

if((GetStringLeft(sInterests,1)=="6")&&(iNumber1==0)&&(iNumber2==0)){return TRUE;}else{return FALSE;}
}
