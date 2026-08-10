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

// Split the reward across any party PCs present. GetFirstFactionMember with
// the default bPCOnly=TRUE enumerates fellow party PCs only (not henchmen) -
// the same convention creatures_death.nss uses to split XP among a party.
int iPartyCount = 1;
object oPartyPC = GetFirstFactionMember(oPC);
while(GetIsObjectValid(oPartyPC))
 {
if((oPartyPC!=oPC)&&(GetArea(oPartyPC)==GetArea(OBJECT_SELF))&&(GetDistanceToObject(oPartyPC)<=40.0)){iPartyCount++;}
oPartyPC = GetNextFactionMember(oPC);
 }
int iShare = iReward/iPartyCount;

GiveGoldToCreature(oPC,iShare);
SetLocalInt(oGoldbag,sPlanet+sArea+"CampMissionDone"+sSite,1);

oPartyPC = GetFirstFactionMember(oPC);
while(GetIsObjectValid(oPartyPC))
 {
if((oPartyPC!=oPC)&&(GetArea(oPartyPC)==GetArea(OBJECT_SELF))&&(GetDistanceToObject(oPartyPC)<=40.0))
  {
GiveGoldToCreature(oPartyPC,iShare);
SetLocalInt(GetItemPossessedBy(oPartyPC,"goldbag"),sPlanet+sArea+"CampMissionDone"+sSite,1);
  }
oPartyPC = GetNextFactionMember(oPC);
 }

SetCustomToken(10481,"Well done! That camp's clear (area : "+sCampArea+"). Here's your "+IntToString(iShare)+" gold"+((iPartyCount>1)?(" (split "+IntToString(iPartyCount)+" ways)"):"")+".");
 }
}
