void main()
{
object oCannon = GetNearestObjectByTag("ZEP_CANNON001");
int iWait = GetLocalInt(OBJECT_SELF,"Wait");
object oFoe;
int i = 1;

if(iWait!=1)
 {
while(i<50)
  {
oFoe = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,i);

if(
//
((GetHasSpellEffect(SPELL_INVISIBILITY,oFoe)==FALSE)&&(GetHasSpellEffect(SPELL_SANCTUARY,oFoe)==FALSE)&&((d20(1)+GetSkillRank(SKILL_HIDE,oFoe))<20)
//
||(GetIsInCombat(oFoe)))&&(GetCurrentHitPoints(oFoe)>0)&&(GetDistanceToObject(oFoe)<40.0)&&((GetStandardFactionReputation(STANDARD_FACTION_COMMONER,oFoe)>=90)||(GetStandardFactionReputation(STANDARD_FACTION_DEFENDER,oFoe)>=90)||(GetIsPC(oFoe))||(GetIsPC(GetMaster(oFoe)))))
   {
if(GetLocalInt(oCannon,"CEP_L_AMION")==0){AssignCommand(oCannon,PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));SetLocalInt(oCannon,"CEP_L_AMION",1);}else{AssignCommand(oCannon,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));SetLocalInt(oCannon,"CEP_L_AMION",0);}PlaySound("zep_explosion");
ActionCastSpellAtObject(SPELL_FIREBALL,oFoe,METAMAGIC_NONE,TRUE,0,PROJECTILE_PATH_TYPE_BALLISTIC,TRUE);SetLocalInt(OBJECT_SELF,"Wait",1);DelayCommand(10.0,DeleteLocalInt(OBJECT_SELF,"Wait"));
break;
   }
i++;
  }
 }
}
