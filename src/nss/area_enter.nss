#include "aps_include"
#include "_module"
#include "zep_inc_phenos"
#include "_string_utils"
#include "_webmap"
#include "dmb_inc"
#include "area_pop_inc"
#include "inc_persist"
#include "_shipname"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetEnteringObject();
////////////////////////////////////////////////////////////////////////////////
// Cluster members can lose their Planet/Area locals (e.g. an area_save
// wipe); re-stamp from the module-local reverse lookup before anything
// below reads them.
if(GetLocalString(OBJECT_SELF,"Planet")=="")
 {
string sCluMember = GetLocalString(oModule,"CluMember_"+GetTag(OBJECT_SELF));
if(sCluMember!=""){DmbStampMember(OBJECT_SELF,Between(sCluMember,"","&"),Between(sCluMember,"&",""));}
 }
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iPlayer = GetLocalInt(oPC,"Player");
string sPlanet = GetLocalString(OBJECT_SELF,"Planet");
string sArea = GetLocalString(OBJECT_SELF,"Area");
string sTag = GetTag(OBJECT_SELF);
string sName = GetName(oPC);
string sPCName = GetPCPlayerName(oPC);
string sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
object oItem = GetFirstItemInInventory(oPC);
object oCode = GetItemPossessedBy(oPC,"code");
effect eEffects = GetFirstEffect(oPC);
//
object oObjects = GetFirstObjectInArea(OBJECT_SELF);
int iPCMissions = GetLocalInt(oGoldbag,"Missions");
object oHenchs;string sMission;string sMissPlanet;string sMissArea;int iNumber;string sDM;string AreaDest;int iCheck;int i;
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// PCs
if((GetIsObjectValid(oPC))&&((GetIsPC(oPC))||(GetIsDMPossessed(oPC))||(GetIsDM(oPC)))){
////////////////////////////////////////////////////////////////////////////////
// Website
if(GetIsDM(oPC)){sDM = "1";}else{sDM = "0";}SetPersistentString(oModule,"Player"+IntToString(GetLocalInt(oModule,sName)),sPCName+"&1&"+sName+"&2&"+sPlanet+"&3&"+sArea+"&4&"+sDM+"&5&");
////////////////////////////////////////////////////////////////////////////////
// Website per-player map: index this character under its public CD key (the
// site logs players in with that key), and record the tile they are standing
// on. transitions.nss covers normal travel; this catches the tile a player
// logs in on, which no transition ever fires for.
if(WebMapKey(oPC)!="")
 {
WebMapRegisterChar(oPC);
if((sPlanet!="")&&(FindSubString(sArea,"_")!=-1))
  {
struct AreaCoord cWebTile = ParseAreaCoord(sArea);
WebMapDiscover(oPC,sPlanet,cWebTile.X,cWebTile.Y);
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Persist last known location for this character (DM lookup tool, never deleted)
vector vPCPos = GetPosition(oPC);
SetPersistentString(oModule,"PCLoc_"+sName,
    sPCName+FIELD_1+sName+FIELD_2+sPlanet+FIELD_3+sArea+FIELD_4
    +GetTag(OBJECT_SELF)+FIELD_5
    +FloatToString(vPCPos.x,0,2)+FIELD_6
    +FloatToString(vPCPos.y,0,2)+FIELD_7
    +FloatToString(vPCPos.z,0,2)+FIELD_8
    +FloatToString(GetFacing(oPC),0,2)+FIELD_9
    +sDM+FIELD_10);
////////////////////////////////////////////////////////////////////////////////
// PC entering module
if((GetLocalInt(oPC,"Entering")==1)&&(sTag!="initialisation")){AssignCommand(oPC,ActionJumpToLocation(GetStartingLocation()));}else{
////////////////////////////////////////////////////////////////////////////////
// Initialisation
if(sTag=="initialisation"){SetLocalInt(oPC,"Entering",2);if((!GetIsDMPossessed(oPC))&&(!GetIsDM(oPC))){if(GetLocalInt(oGoldbag,"Start")==0){AssignCommand(oPC,ActionJumpToObject(GetWaypointByTag("Start")));}else{if((GetLocalString(oGoldbag,"Planet")=="")||(GetLocalString(oGoldbag,"Area")=="")){SetLocalString(oGoldbag,"Planet",GetLocalString(oModule,GetLocalString(oModule,"System1")+"Start"));SetLocalString(oGoldbag,"Area","0_0");SetLocalFloat(oGoldbag,"fX",120.0);SetLocalFloat(oGoldbag,"fY",100.0);SetLocalFloat(oGoldbag,"fFacing",DIRECTION_NORTH);}SetLocalString(oPC,"PlanetDest",GetLocalString(oGoldbag,"Planet"));SetLocalString(oPC,"AreaDest",GetLocalString(oGoldbag,"Area"));if(GetStringRight(GetLocalString(oGoldbag,"Area"),5)=="_Ship"){SetLocalString(oPC,"NewAreaSpecial","clouds");}SetLocalFloat(oPC,"fX",GetLocalFloat(oGoldbag,"fX"));SetLocalFloat(oPC,"fY",GetLocalFloat(oGoldbag,"fY"));SetLocalFloat(oPC,"fFacing",GetLocalFloat(oGoldbag,"fFacing"));ExecuteScript("transitions",oPC);DelayCommand(3.0,ExecuteScript("ini_check",oPC));}}else{DeleteLocalInt(oPC,"Entering");
//SetLocalString(oPC,"PlanetDest","Arland");SetLocalString(oPC,"AreaDest","0_0");SetLocalFloat(oPC,"fX",120.0);SetLocalFloat(oPC,"fY",110.0);SetLocalFloat(oPC,"fFacing",90.0);ExecuteScript("transitions",oPC);
}}else{
////////////////////////////////////////////////////////////////////////////////
// Area recall
if((sPlanet!="")&&(sArea!="")&&(GetLocalInt(OBJECT_SELF,"Used")!=2)){ExecuteScript("area_recall",OBJECT_SELF);}
////////////////////////////////////////////////////////////////////////////////
// Placeable view distance + static-marking (see area_pop_inc.nss for what
// and why). This is the fallback safety net for any jump into an area that
// doesn't route through transitions.nss (DM teleports, quest/dialogue jumps,
// DmbClusterArrive, transitions2.nss interiors, and a PC logging in directly
// into a saved location) - the normal grid-coordinate path now does this
// BEFORE the player arrives (trans_arrive.nss), so for that path these calls
// see VisDistSet already 1 and no-op. Same for area_recall just above when
// it's a daytime pass (its own "Used!=2" guard, unchanged) - trans_arrive
// already ran it for the normal path.
// Staggered like trans_arrive.nss's own catch-up passes, not a single
// synchronous call, for the same reason: area_recall.nss's own
// area_interests/dungeons triggers now run via DelayCommand(0.0,...) (fixed
// instruction-budget truncation - domains.nss's CreateObject calls could
// silently never run when nested in a shared budget), so a domain's
// structures may not exist yet the instant the nested ExecuteScript above
// returns. A single immediate scan here missed them permanently (reported:
// a domain's structure staying non-static/flickering after logging in
// directly into its area, with no transitions.nss pass to catch it later).
DelayCommand(0.1,AreaPopSetupPlaceables(OBJECT_SELF));
DelayCommand(0.5,AreaPopSetupPlaceables(OBJECT_SELF));
DelayCommand(1.5,AreaPopSetupPlaceables(OBJECT_SELF));
DelayCommand(3.0,AreaPopSetupPlaceables(OBJECT_SELF));
////////////////////////////////////////////////////////////////////////////////
// Challenge cheat
if(GetLocalInt(oGoldbag,"Challenge")!=0){DeleteLocalInt(oGoldbag,"Challenge");SetXP(oPC,GetXP(oPC)-iMonsterChallenge);FloatingTextStringOnCreature("-"+IntToString(iMonsterChallenge)+" xps",oPC);}
////////////////////////////////////////////////////////////////////////////////
// Destroy items
if((GetIsObjectValid(GetItemPossessedBy(oPC,"lizardhead")))&&(GetStringLeft(sInterests,1)!="7")){DestroyObject(GetItemPossessedBy(oPC,"lizardhead"));}
if((GetIsObjectValid(GetItemPossessedBy(oPC,"lostshield")))&&(GetStringLeft(sInterests,1)!="7")){DestroyObject(GetItemPossessedBy(oPC,"lostshield"));}
////////////////////////////////////////////////////////////////////////////////
// Discovering the area
if(GetLocalInt(oPC,"Discover")>0){int n;int iXP = GetLocalInt(oPC,"Discover");object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}DelayCommand(1.0,GiveXPToCreature(oPC,iXP));DelayCommand(1.0,FloatingTextStringOnCreature("you discover a new area : "+IntToString(iXP)+" xps",oPC));DelayCommand(1.1,DeleteLocalInt(oPC,"Discover"));}
////////////////////////////////////////////////////////////////////////////////
// Enigm items
if(GetLocalInt(oGoldbag,"Enigm")>0){while(GetIsObjectValid(oItem)){if((oItem!=oGoldbag)&&(GetLocalInt(oItem,"Enigm")!=0)){DestroyObject(oItem);}oItem = GetNextItemInInventory(oPC);}DeleteLocalInt(oGoldbag,"Enigm");}
if(GetIsObjectValid(oCode)){oItem = GetFirstItemInInventory(oPC);while(GetIsObjectValid(oItem)){if(GetTag(oItem)=="code"){DestroyObject(oItem);}oItem = GetNextItemInInventory(oPC);}}
////////////////////////////////////////////////////////////////////////////////
// Gate
if(GetLocalInt(oPC,"Gate")==1){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SUMMON_GATE),oPC);DeleteLocalInt(oPC,"Gate");}
////////////////////////////////////////////////////////////////////////////////
// Hench recall in area
SetLocalInt(oPC,"HenchAction",5);ExecuteScript("henchs",oPC);
////////////////////////////////////////////////////////////////////////////////
// HPs
if((GetLocalInt(oGoldbag,"Dead")==1)&&(GetLocalInt(OBJECT_SELF,"SpecialArea")!=1)){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetMaxHitPoints(oPC)+11),oPC);}else if((GetLocalInt(oGoldbag,"HitPoints")!=0)&&(GetLocalInt(oPC,"Entering")!=0)){if(GetCurrentHitPoints(oPC)>GetLocalInt(oGoldbag,"HitPoints")){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetCurrentHitPoints(oPC)-GetLocalInt(oGoldbag,"HitPoints")),oPC);}else if(GetCurrentHitPoints(oPC)<GetLocalInt(oGoldbag,"HitPoints")){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectTemporaryHitpoints(GetLocalInt(oGoldbag,"HitPoints")-GetCurrentHitPoints(oPC)),oPC);}}
////////////////////////////////////////////////////////////////////////////////
// Interests
if(sInterests!=""){
// First
int a = 12;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}}
////////////////////////////////////////////////////////////////////////////////
// Last city/town visited
if((GetStringLeft(GetTag(OBJECT_SELF),4)=="city")||(GetStringLeft(sInterests,1)=="1")){SetLocalString(oGoldbag,"LastCiv",sArea);}
////////////////////////////////////////////////////////////////////////////////
// Map and pins
if((GetStringLeft(GetTag(OBJECT_SELF),4)=="city")||(GetStringLeft(GetTag(OBJECT_SELF),8)=="townhall")){ExploreAreaForPlayer(OBJECT_SELF,oPC,TRUE);}else if((!GetIsDMPossessed(oPC))&&(!GetIsDM(oPC))){ImportMinimap(oPC,OBJECT_SELF);}
////////////////////////////////////////////////////////////////////////////////
// Missions
if(iPCMissions>0){while(iPCMissions>0){
sMission = GetLocalString(oGoldbag,"Mission"+IntToString(iPCMissions));
sMissPlanet = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&002&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&002&")))-FindSubString(sMission,"&001&")-5);
sMissArea = GetStringRight(GetStringLeft(sMission,FindSubString(sMission,"&004&")),GetStringLength(GetStringLeft(sMission,FindSubString(sMission,"&004&")))-FindSubString(sMission,"&003&")-5);
if((sMissPlanet==sPlanet)&&(sMissArea==sArea)){SetLocalInt(oPC,"MissionToPlace",1);SetLocalInt(oPC,"Mission",iPCMissions);ExecuteScript("missions",oPC);}iPCMissions--;}}
////////////////////////////////////////////////////////////////////////////////
// Phenotypes
     if(GetStringLeft(sTag,10)=="underwater"){if((GetAppearanceType(oPC)!=GetLocalInt(oGoldbag,"OrigApp")-1)&&(GetLocalInt(oGoldbag,"OrigApp")!=0)){SetCreatureAppearanceType(oPC,GetLocalInt(oGoldbag,"OrigApp")-1);}SetFootstepType(FOOTSTEP_TYPE_NONE,oPC);zep_Fly(oPC,0,0.8);iCheck = 1;}
else if((GetStringLeft(sTag,5)=="ocean")&&(GetAppearanceType(oPC)!=339)){if(GetLocalInt(oGoldbag,"OrigApp")==0){SetLocalInt(oGoldbag,"OrigApp",GetAppearanceType(oPC)+1);}SetCreatureAppearanceType(oPC,339);SetFootstepType(FOOTSTEP_TYPE_NONE,oPC);ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectACIncrease(2),oPC);zep_Fly_Land(oPC);iCheck = 1;}
else if((GetStringLeft(sTag,6)=="clouds")&&(GetAppearanceType(oPC)!=342)){if(GetLocalInt(oGoldbag,"OrigApp")==0){SetLocalInt(oGoldbag,"OrigApp",GetAppearanceType(oPC)+1);}SetCreatureAppearanceType(oPC,342);SetFootstepType(FOOTSTEP_TYPE_NONE,oPC);ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectACIncrease(3),oPC);ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectHaste(),oPC);iCheck = 1;}
else if((GetStringLeft(sTag,5)=="space")&&(GetAppearanceType(oPC)!=338)){if(GetLocalInt(oGoldbag,"OrigApp")==0){SetLocalInt(oGoldbag,"OrigApp",GetAppearanceType(oPC)+1);}SetCreatureAppearanceType(oPC,338);SetFootstepType(FOOTSTEP_TYPE_NONE,oPC);ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectACIncrease(4),oPC);iCheck = 1;}
else if((GetStringLeft(sTag,7)=="airship")||(GetStringLeft(sTag,8)=="starship")){iCheck = 1;}
if(iCheck==1){oHenchs = GetHenchman(oPC);while(GetIsObjectValid(oHenchs)){RemoveHenchman(oPC,oHenchs);SetImmortal(oHenchs,FALSE);SetPlotFlag(oHenchs,FALSE);AssignCommand(oHenchs,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oHenchs);oHenchs = GetHenchman(oPC);}object oFamiliar1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);RemoveSummonedAssociate(oPC,oFamiliar1);AssignCommand(oFamiliar1,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oFamiliar1);object oFamiliar2 = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);RemoveSummonedAssociate(oPC,oFamiliar2);AssignCommand(oFamiliar2,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oFamiliar2);object oFamiliar3 = GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC);RemoveSummonedAssociate(oPC,oFamiliar3);AssignCommand(oFamiliar3,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oFamiliar3);object oFamiliar4 = GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC);RemoveSummonedAssociate(oPC,oFamiliar4);AssignCommand(oFamiliar4,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oFamiliar4);object oFamiliar5 = GetLocalObject(oPC,"Familiar4");AssignCommand(oFamiliar5,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oFamiliar5);}
else{if((GetStringLeft(sTag,5)!="ocean")&&(GetStringLeft(sTag,6)!="clouds")&&(GetStringLeft(sTag,5)!="space")&&(GetLocalInt(oGoldbag,"OrigApp")!=0)&&(GetAppearanceType(oPC)!=GetLocalInt(oGoldbag,"OrigApp")-1)){SetCreatureAppearanceType(oPC,GetLocalInt(oGoldbag,"OrigApp")-1);SetFootstepType(FOOTSTEP_TYPE_DEFAULT,oPC);DeleteLocalInt(oPC,"HenchAction");ExecuteScript("henchs",oPC);effect eEffects = GetFirstEffect(oPC);while(GetIsEffectValid(eEffects)){if((GetEffectType(eEffects)==EFFECT_TYPE_HASTE)||(GetEffectType(eEffects)==EFFECT_TYPE_AC_INCREASE)){RemoveEffect(oPC,eEffects);}eEffects = GetNextEffect(oPC);}}
     if(GetLocalInt(oGoldbag,"NewPheno")!=0){SetPhenoType(GetLocalInt(oGoldbag,"NewPheno"),oPC);SetFootstepType(GetLocalInt(oGoldbag,"FootStep"),oPC);if(GetLocalInt(oPC,"Mounted")!=1){SetLocalInt(oPC,"HenchAction",10);ExecuteScript("henchs",oPC);}}
     if((GetPhenoType(oPC)>4)&&(GetIsAreaInterior(OBJECT_SELF))){SetLocalInt(oPC,"HenchAction",9);ExecuteScript("henchs",oPC);}}
// A named ship replaces the pilot's own name for as long as they are wearing
// the ship model set just above (see _shipname.nss). Keyed off the area tag,
// not iCheck - that flag is also set for underwater and for airship/starship
// interiors, none of which put the PC in a ship model.
ShipApplyNameForArea(oPC,sTag);
     if((GetStringLeft(sTag,3)=="gaz")&&(GetLocalInt(oPC,"Flying")!=1)){SetLocalInt(oPC,"Flying",1);zep_Fly(oPC);SetFootstepType(FOOTSTEP_TYPE_NONE,oPC);ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectMovementSpeedIncrease(50),oPC);}else if((GetStringLeft(sTag,3)!="gaz")&&(GetLocalInt(oPC,"Flying")==1)){DeleteLocalInt(oPC,"Flying");zep_Fly_Land(oPC);SetFootstepType(FOOTSTEP_TYPE_DEFAULT,oPC);while(GetIsEffectValid(eEffects)){if(GetEffectType(eEffects)==EFFECT_TYPE_MOVEMENT_SPEED_INCREASE){     RemoveEffect(oPC,eEffects);}eEffects = GetNextEffect(oPC);}}
////////////////////////////////////////////////////////////////////////////////
// Sewers int
if((GetStringLeft(GetTag(OBJECT_SELF),5)=="sewer")){ExecuteScript("sewers",OBJECT_SELF);}
////////////////////////////////////////////////////////////////////////////////
// Start area
if(sTag=="start"){DeleteLocalInt(oGoldbag,"Start");}else{
// First
int a = 11;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}}
////////////////////////////////////////////////////////////////////////////////
// Transports
if(GetLocalInt(oPC,"TransArrival")!=0){if(GetLocalInt(OBJECT_SELF,"TransArrival")==0){SetLocalInt(OBJECT_SELF,"TransArrival",GetLocalInt(oPC,"TransArrival"));SetLocalLocation(OBJECT_SELF,"TransArrivalLoc",GetLocation(GetNearestObjectByTag("planettakeoff",oPC)));ExecuteScript("transports",OBJECT_SELF);}DeleteLocalInt(oPC,"HenchAction");ExecuteScript("henchs",oPC);}
////////////////////////////////////////////////////////////////////////////////
// Delete variables
DeleteLocalInt(oPC,"Entering");
DeleteLocalInt(oPC,"TransArrival");
DeleteLocalString(oPC,"PlayerAreaTo");
DeleteLocalInt(oPC,"Training");
DeleteLocalInt(oPC,"AniReserve");
if((GetStringLeft(sTag,11)!="h_mountain_")&&(GetStringLeft(sInterests,1)!="6")){DeleteLocalInt(oPC,"ResMountain");}
////////////////////////////////////////////////////////////////////////////////
}}}
////////////////////////////////////////////////////////////////////////////////
DeleteLocalInt(oPC,"TransMess1");DeleteLocalInt(oPC,"TransMess2");DeleteLocalInt(oPC,"TransMess3");DeleteLocalInt(oPC,"TransMess4");
if(GetLocalInt(oObjects,"DontSave3")!=0){DelayCommand(0.5,DeleteLocalInt(oObjects,"DontSave3"));}
////////////////////////////////////////////////////////////////////////////////
// Register player last area visited (see mod_exit)
SetLocalString(oPC,"PlayerLastAreaIn",sTag);
////////////////////////////////////////////////////////////////////////////////
}
