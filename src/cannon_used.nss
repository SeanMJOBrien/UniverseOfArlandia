////////////////////////////////////////////////////////////////////////////////
void main()
{
object oPC = GetLastUsedBy();
int iWait = GetLocalInt(OBJECT_SELF,"Wait");
object oFoe;object oNew;
int i = 1;
////////////////////////////////////////////////////////////////////////////////
if(GetTag(OBJECT_SELF)=="cannonhostile")
 {
if((GetIsPC(oPC))&&(!GetIsDM(oPC))&&(!GetIsDMPossessed(oPC)))
  {
oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"cannoncommoner",GetLocation(OBJECT_SELF));SetLocalInt(oNew,"Num",5);DestroyObject(OBJECT_SELF);
FloatingTextStringOnCreature("cannon taken",oPC);
  }
else
  {
if(iWait!=1)
   {
while(i<50)
    {
oFoe = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,i);

if(((GetHasSpellEffect(SPELL_INVISIBILITY,oFoe)==FALSE)&&(GetHasSpellEffect(SPELL_SANCTUARY,oFoe)==FALSE)&&((d20(1)+GetSkillRank(SKILL_HIDE,oFoe))<20)&&(GetCurrentHitPoints(oFoe)>0)&&(GetDistanceToObject(oFoe)<40.0)&&((GetStandardFactionReputation(STANDARD_FACTION_COMMONER,oFoe)>=90)||(GetStandardFactionReputation(STANDARD_FACTION_DEFENDER,oFoe)>=90)||(GetIsPC(oFoe))||(GetIsPC(GetMaster(oFoe))))))
     {
if(GetLocalInt(OBJECT_SELF,"CEP_L_AMION")==0){AssignCommand(OBJECT_SELF,PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));SetLocalInt(OBJECT_SELF,"CEP_L_AMION",1);}else{AssignCommand(OBJECT_SELF,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));SetLocalInt(OBJECT_SELF,"CEP_L_AMION",0);}AssignCommand(OBJECT_SELF,PlaySound("zep_explosion"));
AssignCommand(OBJECT_SELF,ActionCastSpellAtObject(SPELL_FIREBALL,oFoe,METAMAGIC_NONE,TRUE,0,PROJECTILE_PATH_TYPE_BALLISTIC,TRUE));
SetLocalInt(OBJECT_SELF,"Num",GetLocalInt(OBJECT_SELF,"Num")-1);
SetLocalInt(OBJECT_SELF,"Wait",1);DelayCommand(10.0,DeleteLocalInt(OBJECT_SELF,"Wait"));
break;
     }
i++;
    }
   }
  }
 }
else
 {
////////////////////////////////////////////////////////////////////////////////
if((!GetIsInCombat(oPC))&&(!IsInConversation(oPC)))
  {
ActionStartConversation(oPC,"",TRUE,FALSE);
  }
////////////////////////////////////////////////////////////////////////////////
else
  {
////////////////////////////////////////////////////////////////////////////////
if(iWait==1)
   {
FloatingTextStringOnCreature("not ready",oPC);
   }
else if(GetLocalInt(OBJECT_SELF,"Num")<1)
    {
FloatingTextStringOnCreature("uncharged",oPC);
   }
//
else
   {
while(i<50)
    {
oFoe = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,i);

if(((GetHasSpellEffect(SPELL_INVISIBILITY,oFoe)==FALSE)&&(GetHasSpellEffect(SPELL_SANCTUARY,oFoe)==FALSE)&&((d20(1)+GetSkillRank(SKILL_HIDE,oFoe))<20)&&(GetCurrentHitPoints(oFoe)>0)&&(GetDistanceToObject(oFoe)<40.0)&&((GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,oFoe)>=90))))
     {
if(GetLocalInt(OBJECT_SELF,"CEP_L_AMION")==0){AssignCommand(OBJECT_SELF,PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));SetLocalInt(OBJECT_SELF,"CEP_L_AMION",1);}else{AssignCommand(OBJECT_SELF,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));SetLocalInt(OBJECT_SELF,"CEP_L_AMION",0);}AssignCommand(OBJECT_SELF,PlaySound("zep_explosion"));
AssignCommand(OBJECT_SELF,ActionCastSpellAtObject(SPELL_FIREBALL,oFoe,METAMAGIC_NONE,TRUE,0,PROJECTILE_PATH_TYPE_BALLISTIC,TRUE));
SetLocalInt(OBJECT_SELF,"Num",GetLocalInt(OBJECT_SELF,"Num")-1);
SetLocalInt(OBJECT_SELF,"Wait",1);DelayCommand(10.0,DeleteLocalInt(OBJECT_SELF,"Wait"));
break;
     }
i++;
    }
   }
////////////////////////////////////////////////////////////////////////////////
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
