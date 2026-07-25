#include "aps_include"
#include "_string_utils"
int StartingConditional()
{
// Per-player completion (goldbag, same persistence convention as the
// hire price flow etc.) rather than a server-wide flag: the underlying
// camp is a shared world objective (once dead, it's dead for everyone
// until the next server boot re-forces it - see area_creatures.nss's
// CampSpawned/ForcedCamp handling), but each player who turns it in
// while it's clear collects their own reward once, bounty-board style.
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oModule = GetModule();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}

string sSite = GetPersistentString(oModule,sPlanet+"&"+sArea+"&CampMissionSite");
int iDone = GetLocalInt(oGoldbag,sPlanet+sArea+"CampMissionDone");

if((sSite!="")&&(sSite!="none")&&(iDone!=1)){return TRUE;}else{return FALSE;}
}
