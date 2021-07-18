#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
string sTag = GetTag(OBJECT_SELF);
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
float fX = GetPosition(OBJECT_SELF).x;
float fY = GetPosition(OBJECT_SELF).y;
//
object oFiring;location lLoc;int iXP;
////////////////////////////////////////////////////////////////////////////////
// Monster challenges
if(sTag=="altar_challenges")
 {
int iFiring = GetLocalInt(OBJECT_SELF,"Firing");

if(iFiring>0)
  {
oFiring = GetNearestObjectByTag("altar_firing",OBJECT_SELF,Random(8)+1);
lLoc = Location(oArea,Vector(IntToFloat(Random(75)+32),IntToFloat(Random(75)+42),GetPosition(oFiring).z),0.0);
AssignCommand(oFiring,ActionCastSpellAtLocation(iFiring-1,lLoc,METAMAGIC_NONE,TRUE,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Traning session
else if(sTag=="ArcheryTarget")
 {
object oPC = GetLastDamager();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iTraining = GetLocalInt(oPC,"Training");
int iTrain = GetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+GetName(oPC)+"Train");

if((iTraining==1)&&(iTrain<5)&&(GetWeaponRanged(GetLastWeaponUsed(oPC))))
  {
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetTotalDamageDealt()),OBJECT_SELF);
SetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+GetName(oPC)+"Train",iTrain+1);
iXP = GetTotalDamageDealt()/10;if(iXP<1){iXP = 1;}
int n;object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}
GiveXPToCreature(oPC,iXP);FloatingTextStringOnCreature(IntToString(iXP)+" xps",oPC);
  }
 }
else if(sTag=="CombatDummy")
 {
object oPC = GetLastDamager();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iTraining = GetLocalInt(oPC,"Training");
int iTrain = GetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+GetName(oPC)+"Train");

if((iTraining==1)&&(iTrain<5)&&(!GetWeaponRanged(GetLastWeaponUsed(oPC))))
  {
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetTotalDamageDealt()),OBJECT_SELF);
SetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+GetName(oPC)+"Train",iTrain+1);
iXP = GetTotalDamageDealt()/10;if(iXP<1){iXP = 1;}
int n;object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}
GiveXPToCreature(oPC,iXP);FloatingTextStringOnCreature(IntToString(iXP)+" xps",oPC);
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
