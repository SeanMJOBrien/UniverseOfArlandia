#include "dmfi_dmw_inc"
#include "_module"
void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iLifePoints = GetLocalInt(oGoldbag,"LifePoints");
int iChoice = GetLocalInt(OBJECT_SELF,"Choice1");
int iXP;

if(iChoice==1)
 {
iLifePoints = iLifePoints+1;
iXP = -iXPLifePoints;
 }
else if(iChoice==2)
 {
iLifePoints = iLifePoints-1;
iXP = iXPLifePoints;
 }
int n;object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}

SetXP(oPC,GetXP(oPC)+iXP);
FloatingTextStringOnCreature(IntToString(iXP)+" xps",oPC);
SetLocalInt(oGoldbag,"LifePoints",iLifePoints);
SetCustomToken(10134,ColorText(IntToString(iLifePoints),"g"));
}
