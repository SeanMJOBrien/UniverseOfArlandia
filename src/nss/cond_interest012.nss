#include "aps_include"
int StartingConditional()
{
object oModule = GetModule();
object oPC = GetPCSpeaker();
//
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}
string sX = IntToString(FloatToInt(GetPosition(OBJECT_SELF).x));
string sY = IntToString(FloatToInt(GetPosition(OBJECT_SELF).y));
//
string sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");

if((GetStringLeft(sInterests,1)=="7")&&(GetLocalInt(oModule,sPlanet+sArea+sX+sY+GetName(oPC)+"Game")==1)){return TRUE;}else{return FALSE;}
}
