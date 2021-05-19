#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLastUsedBy();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sTag = GetTag(OBJECT_SELF);
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
////////////////////////////////////////////////////////////////////////////////
// Teleporters enigm
if(sTag=="Instructions")
 {
object oWP = GetNearestObjectByTag("wp_teleporters7");
float fX = GetPosition(oWP).x;
float fY = GetPosition(oWP).y;
string sInstructions = GetLocalString(oModule,sPlanet+sArea+IntToString(FloatToInt(fX))+IntToString(FloatToInt(fY))+"Ins");
if(sInstructions==""){sInstructions = "Activate a lever to initialise the challenge !";}

SetLocalInt(oPC,"CheckCode",1);
SetCustomToken(10405,sInstructions);
AssignCommand(oPC,ActionStartConversation(oPC,"enigm",TRUE,FALSE));
 }
////////////////////////////////////////////////////////////////////////////////
// Challenges room
else if(sTag=="altar_challenges")
 {
object oFireMonster = GetLocalObject(OBJECT_SELF,"FireMonster");
int iFiring = GetLocalInt(OBJECT_SELF,"Firing");
object oChallenger = GetLocalObject(OBJECT_SELF,"PC");
int iMC = GetLocalInt(oModule,sPlanet+sArea+GetName(oChallenger)+"MC");

if((oPC==oChallenger)&&(iFiring>0)&&((oFireMonster==OBJECT_INVALID)||(GetCurrentHitPoints(oFireMonster)<=0)))
  {
SetLocalInt(OBJECT_SELF,"FireEnd",1);
ActionStartConversation(oPC);
  }
else if((iFiring==0)&&(iMC==0))
  {
ActionStartConversation(oPC);
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Animal reserves fences
else if(sTag=="doorinvisible")
 {
float fYPC = GetPosition(oPC).y;
float fYSelf = GetPosition(OBJECT_SELF).y;
float fYDest;if(fYPC>fYSelf){fYDest = fYSelf-1.0;}else{fYDest = fYSelf+2.0;}

AssignCommand(oPC,ActionJumpToLocation(Location(oArea,Vector(GetPosition(oPC).x,fYDest,0.0),GetFacing(oPC))));
 }
////////////////////////////////////////////////////////////////////////////////
// Domain statue
else if((sTag=="pla_statue001")&&(GetLocalInt(oPC,"DomainStatue")!=1))
 {
string sInterest = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
string sVar = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")))-FindSubString(sInterest,"&2&")-3);
string sVar5 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_05_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_05_")))-FindSubString(sVar,"_04_")-4);
string sVar5R = GetStringRight(sVar5,GetStringLength(sVar5)-FindSubString(sVar5,"%")-1);
int iLevel = StringToInt(sVar5R);

if(iLevel>=3){DelayCommand(4.0,ActionCastSpellAtObject(SPELL_STONESKIN,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));}
if(iLevel>=4){if(GetCurrentHitPoints(oPC)<=GetMaxHitPoints(oPC)){DelayCommand(4.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(GetMaxHitPoints(oPC)/2),oPC));}}
if(iLevel>=5){SetLocalInt(oPC,"Gorochem",GetPhenoType(oPC));DelayCommand(4.0,SetPhenoType(PHENOTYPE_BIG,oPC));DelayCommand(4.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAbilityIncrease(ABILITY_STRENGTH,4),oPC));}

AssignCommand(oPC,PlayAnimation(ANIMATION_LOOPING_MEDITATE,1.0,5.0));
DelayCommand(4.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_HOLY_AID),oPC));
SetLocalInt(oPC,"DomainStatue",1);
 }
////////////////////////////////////////////////////////////////////////////////
}
