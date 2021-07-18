#include "_module"
void main()
{
object oPC = GetLastUnlocked();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iUnlockDC = GetLockUnlockDC(OBJECT_SELF);
int iTrapDC = GetTrapDisarmDC(OBJECT_SELF);
int iXP = iUnlockDC/3;

if(oPC==OBJECT_INVALID){oPC = GetLastDisarmed();iXP = iTrapDC/3;}
if(GetIsObjectValid(GetMaster(oPC))){oPC = GetMaster(oPC);}
object oParty = GetFirstFactionMember(oPC);
int iParty;

if((GetIsObjectValid(oPC))&&(oPC!=OBJECT_SELF))
 {
while(GetIsObjectValid(oParty))
  {
if((GetArea(oParty)==GetArea(oPC))&&(GetDistanceBetween(oPC,oParty)<40.0)){iParty++;SetLocalObject(oPC,"PartyMember"+IntToString(iParty),oParty);}
oParty = GetNextFactionMember(oPC);
  }
if(iParty<1){iParty = 1;}iXP = iXP/iParty;if(iXP<1){iXP=1;}
int n;object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}

while(iParty>0)
  {
if(GetLocalObject(oPC,"PartyMember"+IntToString(iParty))==oPC){GiveXPToCreature(GetLocalObject(oPC,"PartyMember"+IntToString(iParty)),iXP*2);FloatingTextStringOnCreature(IntToString(iXP*2)+" xps",GetLocalObject(oPC,"PartyMember"+IntToString(iParty)));}else{GiveXPToCreature(GetLocalObject(oPC,"PartyMember"+IntToString(iParty)),iXP);FloatingTextStringOnCreature(IntToString(iXP)+" xps",GetLocalObject(oPC,"PartyMember"+IntToString(iParty)));}
DeleteLocalObject(oPC,"PartyMember"+IntToString(iParty));
iParty--;
  }
 }
}
