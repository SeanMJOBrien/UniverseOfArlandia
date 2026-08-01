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

// Authoritative kill-verification via persisted flags, NOT a live-area scan:
// the camp area is almost never loaded at turn-in time (the player has
// travelled back to town), and an unloaded area used to read as "clear" -
// a free-reward loophole. CampSpawned is set the first time the camp
// populates; CampCleared is set by creatures_death.nss the moment the last
// Camp-tagged guard dies, and wiped whenever the camp repopulates
// (area_creatures.nss). Neither depends on the area being resident.
int iSpawned = (GetPersistentString(oModule,sPlanet+"&"+sCampArea+"&CampSpawned")=="1");
int iCleared = (GetPersistentString(oModule,sPlanet+"&"+sCampArea+"&CampCleared")=="1");

if(!iSpawned)
 {
SetCustomToken(10481,"Nobody's even scouted that far out yet. Come back once you've found it.");
 }
else if(!iCleared)
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
