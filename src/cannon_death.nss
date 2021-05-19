#include "_module"
void main()
{
object oPC = GetLastKiller();
object oCannon = GetNearestObjectByTag("ZEP_CANNON001");
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");

int n;int iXP = 10;object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}

if(GetTag(OBJECT_SELF)=="pla_cannon")
 {
while(GetIsObjectValid(oMember))
  {
if((GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oPC,oMember)<=50.0)){GiveXPToCreature(oMember,iXP);FloatingTextStringOnCreature(IntToString(iXP)+" xps",oMember);}
oMember = GetNextFactionMember(oPC);
  }
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1),oCannon);
SetPlotFlag(oCannon,FALSE);DestroyObject(oCannon);
 }
else
 {
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1),OBJECT_SELF);
SetPlotFlag(OBJECT_SELF,FALSE);DestroyObject(OBJECT_SELF);
 }
}
