#include "aps_include"
#include "_string_utils"
void main()
{
object oModule = GetModule();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}

string sSite = GetPersistentString(oModule,sPlanet+"&"+sArea+"&CampMissionSite");
string sCampArea = Between(sSite,"","&");
int iTier = StringToInt(Between(sSite,"&",""));

string sTierName;
     if(iTier==1){sTierName = "small camp";}
else if(iTier==2){sTierName = "larger camp";}
else               {sTierName = "fortified camp";}
int iReward = 100*iTier;

struct AreaCoord townCoord = ParseAreaCoord(sArea);
struct AreaCoord campCoord = ParseAreaCoord(sCampArea);
int iDx = campCoord.X-townCoord.X;
int iDy = campCoord.Y-townCoord.Y;
int iDist = abs(iDx);if(abs(iDy)>iDist){iDist = abs(iDy);}

string sDir = "";
if(iDy>0){sDir = "north";}else if(iDy<0){sDir = "south";}
if(iDx>0){sDir = sDir+"east";}else if(iDx<0){sDir = sDir+"west";}
if(sDir==""){sDir = "right here";}else{sDir = "to the "+sDir;}

SetCustomToken(10480,"There's a "+sTierName+" of monsters "+IntToString(iDist)+" area"+((iDist==1)?"":"s")+" "+sDir+" of here (area : "+sCampArea+"). Clear it out and I'll pay you "+IntToString(iReward)+" gold.");
}
