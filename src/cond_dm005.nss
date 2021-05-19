#include "aps_include"
int StartingConditional()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
object oCamp1 = GetNearestObjectByTag("nomadcamp",oPC);
object oCamp2 = GetNearestObjectByTag("entry",oPC);

if((sInterests=="")&&(!GetIsAreaInterior(oArea))&&(GetStringLeft(GetTag(oArea),6)!="clouds")&&(GetStringLeft(GetTag(oArea),3)!="gaz")&&(GetStringLeft(GetTag(oArea),5)!="ocean")&&(GetStringLeft(GetTag(oArea),5)!="space")&&(GetStringLeft(GetTag(oArea),7)!="airship")&&(oCamp1==OBJECT_INVALID)&&(oCamp2==OBJECT_INVALID)){return TRUE;}else{return FALSE;}
}
