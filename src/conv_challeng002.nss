#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sTag = GetTag(OBJECT_SELF);
//
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
//
object oDoor = GetNearestObjectByTag("door_challenge");
//
int n;int iXP = iMonsterChallenge;object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}
////////////////////////////////////////////////////////////////////////////////
// Monster challenges
if(sTag=="altar_challenges")
 {
GiveXPToCreature(oPC,iXP);
FloatingTextStringOnCreature(IntToString(iXP)+" xps",oPC);

DeleteLocalObject(OBJECT_SELF,"FireMonster");
DeleteLocalObject(OBJECT_SELF,"PC");
DeleteLocalInt(OBJECT_SELF,"Firing");
SetLocked(oDoor,FALSE);
DeleteLocalInt(oGoldbag,"Challenge");
 }
////////////////////////////////////////////////////////////////////////////////
// Training session
else if(sTag=="trainer")
 {
DeleteLocalInt(oPC,"Training");
 }
////////////////////////////////////////////////////////////////////////////////
}
