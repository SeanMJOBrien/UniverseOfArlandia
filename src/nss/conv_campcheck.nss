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

WriteTimestampedLogEntry("[camp] turn-in by "+GetName(oPC)+" town="+sPlanet+"&"+sArea+" site="+sPlanet+"&"+sCampArea+" tier="+IntToString(iTier)+" spawned="+IntToString(iSpawned)+" cleared="+IntToString(iCleared));

if(!iSpawned)
 {
SetCustomToken(10481,"Nobody's even scouted that far out yet. Come back once you've found it (area : "+sCampArea+").");
 }
else if(!iCleared)
 {
SetCustomToken(10481,"That camp's still crawling with monsters (area : "+sCampArea+"). Come back when it's clear.");
 }
else
 {
int iReward = 100*iTier;

// Only pay whoever creatures_death.nss actually credited with the final
// blow (the killer plus any party PCs it found nearby at that instant) -
// not whoever happens to be standing at the turn-in later. sCreditedBy is
// "&"-wrapped ("&Name1&Name2&") so membership is an exact-name substring
// match, not a partial one.
string sCreditedBy = GetPersistentString(oModule,sPlanet+"&"+sCampArea+"&CampClearedBy");
int iCreditedCount = StringToInt(GetPersistentString(oModule,sPlanet+"&"+sCampArea+"&CampClearedByCount"));
if(iCreditedCount<1){iCreditedCount=1;}

if(FindSubString(sCreditedBy,"&"+GetName(oPC)+"&")==-1)
 {
SetCustomToken(10481,"That camp's clear, but you weren't there for it (area : "+sCampArea+") - talk to whoever actually cleared it out.");
 }
else
 {
int iShare = iReward/iCreditedCount;
GiveGoldToCreature(oPC,iShare);
SetLocalInt(oGoldbag,sPlanet+sArea+"CampMissionDone"+sSite,1);
SetCustomToken(10481,"Well done! That camp's clear (area : "+sCampArea+"). Here's your "+IntToString(iShare)+" gold"+((iCreditedCount>1)?(" (split "+IntToString(iCreditedCount)+" ways)"):"")+".");
 }
 }
}
