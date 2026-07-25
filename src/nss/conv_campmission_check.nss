#include "aps_include"
#include "_string_utils"
void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oModule = GetModule();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}

string sSite = GetPersistentString(oModule,sPlanet+"&"+sArea+"&CampMissionSite");
string sCampArea = Between(sSite,"","&");
int iTier = StringToInt(Between(sSite,"&",""));

int iSpawned = (GetPersistentString(oModule,sPlanet+"&"+sCampArea+"&CampSpawned")=="1");
object oCampAreaObj = GetLocalObject(oModule,sPlanet+"_"+sCampArea);

int iStillGuarded;
if(GetIsObjectValid(oCampAreaObj))
 {
object oCre = GetFirstObjectInArea(oCampAreaObj);
while(GetIsObjectValid(oCre))
  {
if((GetObjectType(oCre)==OBJECT_TYPE_CREATURE)&&(GetLocalInt(oCre,"Camp")==1)&&(GetCurrentHitPoints(oCre)>0)){iStillGuarded=1;}
oCre = GetNextObjectInArea(oCampAreaObj);
  }
 }

if(!iSpawned)
 {
SetCustomToken(10481,"Nobody's even scouted that far out yet. Come back once you've found it.");
 }
else if(iStillGuarded)
 {
SetCustomToken(10481,"That camp's still crawling with monsters. Come back when it's clear.");
 }
else
 {
int iReward = 100*iTier;
GiveGoldToCreature(oPC,iReward);
SetLocalInt(oGoldbag,sPlanet+sArea+"CampMissionDone",1);
SetCustomToken(10481,"Well done! That camp's clear. Here's your "+IntToString(iReward)+" gold.");
 }
}
