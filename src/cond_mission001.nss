#include "_module"
int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}
int iMissionsPC = GetLocalInt(oGoldbag,"Missions");
string sMission;string sMissPlanet;string sProvArea;int i;

while(iMissionsPC>0)
 {
sMission = GetLocalString(oGoldbag,"Mission"+IntToString(iMissionsPC));
sMissPlanet = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&002&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&002&")))-FindSubString(sMission,"&001&")-5);
sProvArea = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&003&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&003&")))-FindSubString(sMission,"&002&")-5);
if((sMissPlanet==sPlanet)&&(sProvArea==sArea)){i++;}
iMissionsPC--;
 }

if(i>=iMaxMissions){return TRUE;}else{return FALSE;}
}
