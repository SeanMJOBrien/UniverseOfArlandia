////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC);
object oArea = GetArea(OBJECT_SELF);
string sTag = GetTag(oArea);
int iAreaWidth = GetAreaSize(AREA_WIDTH,oArea)*10;int iAreaHeight = GetAreaSize(AREA_HEIGHT,oArea)*10;
float fX = GetPosition(OBJECT_SELF).x;
float fY = GetPosition(OBJECT_SELF).y;
//
object oLeader;int iRand;int iFaction;location lLoc;int i;
////////////////////////////////////////////////////////////////////////////////
// Everybody :
// Not hench :
if((GetMaster(OBJECT_SELF)==OBJECT_INVALID)&&(GetLocalInt(OBJECT_SELF,"Hench")==0))
 {
////////////////////////////////////////////////////////////////////////////////
// Dancers
if(GetTag(OBJECT_SELF)=="Dancer"){ActionPlayAnimation(ANIMATION_FIREFORGET_SPASM,0.5,0.0);ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED,2.0,0.0);ActionPlayAnimation(ANIMATION_FIREFORGET_SPASM,0.5,0.0);ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0,0.0);}
////////////////////////////////////////////////////////////////////////////////
// Combat
if(GetIsInCombat(OBJECT_SELF)){SetLocalInt(OBJECT_SELF,"InCombat",1);}else{DeleteLocalInt(OBJECT_SELF,"InCombat");}
////////////////////////////////////////////////////////////////////////////////
// Mouse
if((GetTag(OBJECT_SELF)=="mn_mouse001")&&((GetCurrentAction(OBJECT_SELF)==ACTION_INVALID)||(GetCurrentAction(OBJECT_SELF)==ACTION_ATTACKOBJECT))){ActionMoveToLocation(Location(oArea,Vector(IntToFloat(Random(iAreaWidth)),IntToFloat(Random(iAreaHeight)),0.0),0.0),TRUE);return;}
////////////////////////////////////////////////////////////////////////////////
// Fleeing animals back to hostile
if(GetLocalInt(OBJECT_SELF,"ChangeToHostile")>1){SetLocalInt(OBJECT_SELF,"ChangeToHostile",GetLocalInt(OBJECT_SELF,"ChangeToHostile")-1);}
else if((GetLocalInt(OBJECT_SELF,"ChangeToHostile")==1)&&(GetDistanceBetween(OBJECT_SELF,GetLocalObject(OBJECT_SELF,"PC"))>40.0)){DeleteLocalInt(OBJECT_SELF,"Flee");DeleteLocalObject(OBJECT_SELF,"PC");DeleteLocalInt(OBJECT_SELF,"ChangeToHostile");ChangeToStandardFaction(OBJECT_SELF,STANDARD_FACTION_HOSTILE);ClearAllActions();}
////////////////////////////////////////////////////////////////////////////////
// Flee
if((GetLocalInt(OBJECT_SELF,"NotFlee")!=1)&&(GetLocalInt(OBJECT_SELF,"Flee")!=1)&&(GetLocalInt(OBJECT_SELF,"Fleeing")==0)&&(GetLocalInt(OBJECT_SELF,"Knock")==0)&&(GetStringLeft(GetResRef(oArea),5)!="death")&&(GetRacialType(OBJECT_SELF)!=RACIAL_TYPE_CONSTRUCT)&&(GetRacialType(OBJECT_SELF)!=RACIAL_TYPE_UNDEAD)&&(GetRacialType(OBJECT_SELF)!=RACIAL_TYPE_OOZE)&&(GetRacialType(OBJECT_SELF)!=RACIAL_TYPE_VERMIN))
  {
if(((GetCurrentHitPoints(OBJECT_SELF)<=GetMaxHitPoints(OBJECT_SELF)/3)&&(WillSave(OBJECT_SELF,12)==0))||((GetCurrentHitPoints(OBJECT_SELF)<=GetMaxHitPoints(OBJECT_SELF)/10)&&(WillSave(OBJECT_SELF,18)==0)))
   {
if(GetStandardFactionReputation(STANDARD_FACTION_COMMONER,OBJECT_SELF)>=90){iFaction = 1;}else if(GetStandardFactionReputation(STANDARD_FACTION_DEFENDER,OBJECT_SELF)>=90){iFaction = 2;}else if(GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,OBJECT_SELF)>=90){iFaction = 3;}else{iFaction = 4;}SetLocalInt(OBJECT_SELF,"Faction",iFaction);
ChangeToStandardFaction(OBJECT_SELF,STANDARD_FACTION_MERCHANT);
SetLocalInt(OBJECT_SELF,"Fleeing",1);ClearPersonalReputation(oPC);ClearAllActions();ActionMoveToLocation(Location(GetArea(OBJECT_SELF),Vector(IntToFloat(Random(iAreaWidth)),IntToFloat(Random(iAreaHeight)),0.0),IntToFloat(Random(360))),TRUE);
   }
  }
else if((GetLocalInt(OBJECT_SELF,"Fleeing")==1)&&(GetLocalInt(OBJECT_SELF,"Resting")!=1))
  {
if((GetIsObjectValid(oPC))&&(!GetIsDMPossessed(oPC))&&(!GetIsDM(oPC))&&(GetDistanceBetween(OBJECT_SELF,oPC)>30.0))
   {
SetLocalInt(OBJECT_SELF,"Resting",1);ClearAllActions();ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS,1.0,10.0);ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_SLEEP),OBJECT_SELF,9.0);
DelayCommand(10.0,ActionRest(TRUE));
DelayCommand(10.0,SetLocalInt(OBJECT_SELF,"Fleeing",2));
DelayCommand(10.0,DeleteLocalInt(OBJECT_SELF,"Resting"));
iFaction = GetLocalInt(OBJECT_SELF,"Faction");if(iFaction==1){DelayCommand(10.0,ChangeToStandardFaction(OBJECT_SELF,STANDARD_FACTION_COMMONER));}else if(iFaction==2){DelayCommand(10.0,ChangeToStandardFaction(OBJECT_SELF,STANDARD_FACTION_DEFENDER));}else if(iFaction==3){DelayCommand(10.0,ChangeToStandardFaction(OBJECT_SELF,STANDARD_FACTION_HOSTILE));}else if(iFaction==4){DelayCommand(10.0,ChangeToStandardFaction(OBJECT_SELF,STANDARD_FACTION_MERCHANT));}
DelayCommand(11.0,ActionAttack(oPC));
   }
else if(GetCurrentAction(OBJECT_SELF)!=ACTION_MOVETOPOINT)
   {
ActionMoveToLocation(Location(GetArea(OBJECT_SELF),Vector(IntToFloat(Random(iAreaWidth)),IntToFloat(Random(iAreaHeight)),0.0),IntToFloat(Random(360))),TRUE);
   }
  }
////////////////////////////////////////////////////////////////////////////////
// Random wandering
if((GetLocalInt(OBJECT_SELF,"Stop")==0)&&(GetCurrentAction(OBJECT_SELF)==ACTION_INVALID)&&(GetLastAttacker(OBJECT_SELF)==OBJECT_INVALID))
  {
// Leader in exteriors
if((!GetIsAreaInterior(oArea))&&(GetLocalInt(OBJECT_SELF,"Leader")!=1)&&(GetCurrentHitPoints(OBJECT_SELF)>0))
   {
while(i<10)
    {
i++;
oLeader = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,i);
if((GetStringLeft(GetTag(oLeader),6)==GetStringLeft(GetTag(OBJECT_SELF),6))&&(GetLocalInt(oLeader,"Leader")==1)&&(GetCurrentHitPoints(oLeader)>0)){i = 100;break;}else if(oLeader==OBJECT_INVALID){break;}
    }
if(i==100){ActionMoveToObject(oLeader,FALSE,1.0);}else{ActionMoveToLocation(Location(oArea,Vector(IntToFloat(Random(iAreaWidth)),IntToFloat(Random(iAreaHeight)),0.0),0.0));}
   }
// Others
else
   {
// Castle interior
if(GetStringLeft(sTag,9)=="h_castle1")
    {
if(fX<IntToFloat(iAreaWidth/2)){fX = IntToFloat(Random(iAreaWidth/2)+1);}else{fX = IntToFloat(Random(iAreaWidth/2)+1+(iAreaWidth/2));}
if(fY<IntToFloat(iAreaHeight/2)){fY = IntToFloat(Random(iAreaHeight/2)+1);}else{fY = IntToFloat(Random(iAreaHeight/2)+1+(iAreaHeight/2));}
lLoc = Location(oArea,Vector(fX,fY,0.0),0.0);
    }
// Others
else
    {
lLoc = Location(oArea,Vector(IntToFloat(Random(iAreaWidth)),IntToFloat(Random(iAreaHeight)),0.0),90.0);
    }
ActionMoveToLocation(lLoc);
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Sit
if(GetLocalInt(OBJECT_SELF,"Sit")>0){ActionSit(GetNearestObject(OBJECT_TYPE_PLACEABLE));}
////////////////////////////////////////////////////////////////////////////////
}
