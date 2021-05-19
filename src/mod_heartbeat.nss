#include "aps_include"
#include "_module"
#include "nwnx_admin"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetFirstPC();
int iReset = iReboot*600;
int iCounter = GetLocalInt(oModule,"Counter")+1;
int iCounter2 = GetLocalInt(oModule,"Counter2")+1;
int iCounter3 = GetLocalInt(oModule,"Counter3")+1;
int iCounter4 = (iReset/10)-iCounter3;
int iResetOff = GetLocalInt(oModule,"ResetOff");
int iTime = GetLocalInt(oModule,"Hour");
//
object oGoldbag;string sName;object oArea;string sAreaName;string sAreaTag;string sPlanet;string sArea;int iGold;float fX;float fY;location lLoc;object oTrans;object oObject;int i;int j;int iWear;int iWearTot;int iValue;object oNew;string sBP;int iRand;int iAreaX;int iAreaY;int iGP;int iGPdelay;int iIV;int iIVdelay;string sItemName;int iAbility;string sInterests;object oPoint;object oWP;object oItem;
object oFamiliar1;object oFamiliar2;object oFamiliar3;object oFamiliar4;object oFamiliar5;
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Countdown
if(iResetOff==0)
 {
SetLocalInt(oModule,"Counter",iCounter);
SetLocalInt(oModule,"Counter2",iCounter2);
if(iCounter2>=10){SetLocalInt(oModule,"Counter3",iCounter3);DeleteLocalInt(oModule,"Counter2");SetPersistentString(oModule,"Reboot",IntToString(iCounter3)+"&&&"+IntToString(iCounter4));}
if(iCounter>=iReset){SetPersistentString(oModule,"Calendar",IntToString(GetCalendarYear())+"/C1/"+IntToString(GetCalendarMonth())+"/C2/"+IntToString(GetCalendarDay())+"/C3/"+IntToString(GetTimeHour())+"/C4/");SetPersistentString(oModule,"Reboot","rebooting");NWNX_CallFunction(NWNX_Administration, "ShutdownServer");}
 }
////////////////////////////////////////////////////////////////////////////////
// Time & Calendar
if(iTime!=GetTimeHour()){SetLocalInt(oModule,"Hour",GetTimeHour());SetPersistentString(oModule,"Calendar",IntToString(GetCalendarYear())+"/C1/"+IntToString(GetCalendarMonth())+"/C2/"+IntToString(GetCalendarDay())+"/C3/"+IntToString(GetTimeHour())+"/C4/");}
////////////////////////////////////////////////////////////////////////////////
// Transports
i=0;while(i<5){i++;oTrans = GetObjectByTag("airship00"+IntToString(i));if((GetIsObjectValid(oTrans))&&(GetLocalString(oTrans,"Area")!="")){ExecuteScript("transports",oTrans);}}
i=0;while(i<5){i++;oTrans = GetObjectByTag("starship00"+IntToString(i));if((GetIsObjectValid(oTrans))&&(GetLocalString(oTrans,"Area")!="")){ExecuteScript("transports",oTrans);}}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
while(GetIsObjectValid(oPC)){
////////////////////////////////////////////////////////////////////////////////
oGoldbag = GetItemPossessedBy(oPC,"goldbag");
sName = GetName(oPC);
oArea = GetArea(oPC);
sAreaName = GetName(oArea);
sAreaTag = GetTag(oArea);
sPlanet = GetLocalString(oArea,"Planet");
sArea = GetLocalString(oArea,"Area");
iGold = GetGold(oPC);
fX = GetPosition(oPC).x;
fY = GetPosition(oPC).y;
iAreaX = GetAreaSize(AREA_WIDTH,oArea)*10;
iAreaY = GetAreaSize(AREA_HEIGHT,oArea)*10;
oObject = GetFirstObjectInArea(oArea);
oItem = GetFirstItemInInventory(oPC);
sInterests = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
oWP = GetNearestObjectByTag("wp_ruins",oPC);
////////////////////////////////////////////////////////////////////////////////
// PCs & DMs
//
// Fire plane
if((GetStringLeft(GetTag(oArea),9)=="fireplain")&&(GetLocalInt(oArea,"Countdown")==0)){SetLocalInt(oArea,"Countdown",1);DelayCommand(3.0,DeleteLocalInt(oArea,"Countdown"));lLoc = Location(oArea,Vector(IntToFloat(Random(iAreaX)+1),IntToFloat(Random(iAreaY)+1),0.0),0.0);iRand = Random(3);if(iRand==0){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_FIREBALL),lLoc);oObject = GetFirstObjectInArea(oArea);while(GetIsObjectValid(oObject)){if(GetDistanceBetweenLocations(lLoc,GetLocation(oObject))<5.0){DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(5),DAMAGE_TYPE_FIRE),oObject));}oObject = GetNextObjectInArea(oArea);}}else if(iRand==1){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_FIRESTORM),lLoc);oObject = GetFirstObjectInArea(oArea);while(GetIsObjectValid(oObject)){if(GetDistanceBetweenLocations(lLoc,GetLocation(oObject))<10.0){DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(10),DAMAGE_TYPE_FIRE),oObject));}oObject = GetNextObjectInArea(oArea);}}else if(iRand==2){ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_METEOR_SWARM),lLoc);oObject = GetFirstObjectInArea(oArea);while(GetIsObjectValid(oObject)){if(GetDistanceBetweenLocations(lLoc,GetLocation(oObject))<15.0){DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(15),DAMAGE_TYPE_FIRE),oObject));}oObject = GetNextObjectInArea(oArea);}}}
////////////////////////////////////////////////////////////////////////////////
// Day/Night
if((GetIsNight())&&(GetLocalInt(oArea,"Night")==0)){while(GetIsObjectValid(oObject)){if((GetLocalInt(oObject,"Permanent")!=1)&&((GetStringLeft(GetTag(oObject),8)=="commoner")||(GetLocalInt(oObject,"Pen")!=0))){SetImmortal(oObject,FALSE);SetPlotFlag(oObject,FALSE);AssignCommand(oObject,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oObject);}oObject = GetNextObjectInArea(oArea);}SetLocalInt(oArea,"Night",1);}else if((GetIsDay())&&(GetLocalInt(oArea,"Night")!=0)){ExecuteScript("area_recall",oArea);DeleteLocalInt(oArea,"Night");}
////////////////////////////////////////////////////////////////////////////////
// Log
if((GetIsDM(oPC))&&(GetPersistentInt(oModule,"Log")>0)){SendMessageToAllDMs("MESSAGES IN LOG FILE !!!");DeletePersistentVariable(oModule,"Log");}
////////////////////////////////////////////////////////////////////////////////
// Storm
if((GetLocalInt(oArea,"Storm")==1)&&(GetLocalInt(oArea,"Countdown")==0)&&(sInterests=="")){SetLocalInt(oArea,"Countdown",1);DelayCommand(12.0,DeleteLocalInt(oArea,"Countdown"));lLoc = Location(oArea,Vector(IntToFloat(Random(240)+1),IntToFloat(Random(240)+1),0.0),0.0);oObject = CreateObject(OBJECT_TYPE_CREATURE,"nullhuman",lLoc);lLoc = GetLocation(oObject);AssignCommand(oObject,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oObject,0.1);oObject = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_null",lLoc);AssignCommand(oObject,PlaySound("as_wt_thunderds2"));ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_LIGHTNING_M),lLoc);DestroyObject(oObject,0.5);while(GetIsObjectValid(oObject)){if(((GetObjectType(oObject)==OBJECT_TYPE_CREATURE)||(GetIsPC(oObject)))&&(GetDistanceBetweenLocations(lLoc,GetLocation(oObject))<=10.0)&&(GetLocalInt(oObject,"Mission")==0)){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(3),DAMAGE_TYPE_ELECTRICAL),oObject);}oObject = GetNextObjectInArea(oArea);}}
////////////////////////////////////////////////////////////////////////////////
// Reboot warning
     if(iCounter==iReset-3){FloatingTextStringOnCreature("Server reboot, leaving server...",oPC,FALSE);DelayCommand(3.0,BootPC(oPC));}
else if(iCounter==iReset-12){FloatingTextStringOnCreature("Server reboot in 1 minute",oPC,FALSE);}
else if(iCounter==iReset-24){FloatingTextStringOnCreature("Server reboot in 2 minutes",oPC,FALSE);}
else if(iCounter==iReset-36){FloatingTextStringOnCreature("Server reboot in 3 minutes",oPC,FALSE);}
else if(iCounter==iReset-60){FloatingTextStringOnCreature("Server reboot in 5 minutes",oPC,FALSE);}
else if(iCounter==iReset-120){FloatingTextStringOnCreature("Server reboot in 10 minutes",oPC,FALSE);}
else if(iCounter==iReset-240){FloatingTextStringOnCreature("Server reboot in 20 minutes",oPC,FALSE);}
else if(iCounter==iReset-360){FloatingTextStringOnCreature("Server reboot in 30 minutes",oPC,FALSE);}
////////////////////////////////////////////////////////////////////////////////
// PCs only
if(!GetIsDM(oPC)){
////////////////////////////////////////////////////////////////////////////////
// Bank accounts
while(GetIsObjectValid(oItem)){if(GetStringRight(GetTag(oItem),7)=="account"){oObject = oItem;iGP = GetLocalInt(oObject,"GP");iGPdelay = GetLocalInt(oObject,"GPdelay");iIV = GetLocalInt(oObject,"IV");iIVdelay = GetLocalInt(oObject,"IVdelay");SetLocalInt(oObject,"GPdelay",iGPdelay+1);if(iGPdelay>=576){DeleteLocalInt(oObject,"GPdelay");SetLocalInt(oObject,"GP",iGP+(iGP*iNormalInterest/100));}if((iIV!=0)&&(iIVdelay>=0)){SetLocalInt(oObject,"IVdelay",iIVdelay-1);if(iIVdelay==-1){SetLocalInt(oObject,"IV",iIV+(iIV*iInvestmentInterest/100*iInvestmentDelay));}}}oItem = GetNextItemInInventory(oPC);}
////////////////////////////////////////////////////////////////////////////////
// Counter
SetLocalInt(oGoldbag,"Counter",GetLocalInt(oGoldbag,"Counter")+1);
////////////////////////////////////////////////////////////////////////////////
// Domain relax room & bath
     if((GetName(oArea)=="Home")&&(GetLocalFloat(oPC,"SitX")!=0.0)){if((GetPosition(oPC).x==GetLocalFloat(oPC,"SitX"))&&(GetPosition(oPC).y==GetLocalFloat(oPC,"SitY"))){if(GetLocalInt(oPC,"Wait")>=12){iRand = Random(5)+1;if(iRand==1){iAbility = ABILITY_CHARISMA;}else if(iRand==2){iAbility = ABILITY_CONSTITUTION;}else if(iRand==3){iAbility = ABILITY_DEXTERITY;}else if(iRand==4){iAbility = ABILITY_INTELLIGENCE;}else if(iRand==5){iAbility = ABILITY_STRENGTH;}else if(iRand==6){iAbility = ABILITY_WISDOM;}ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAbilityIncrease(iAbility,1),oPC);FloatingTextStringOnCreature("you feel good",oPC);DeleteLocalInt(oPC,"Wait");}SetLocalInt(oPC,"Wait",GetLocalInt(oPC,"Wait")+1);}else{DeleteLocalFloat(oPC,"SitX");DeleteLocalFloat(oPC,"SitY");DeleteLocalInt(oPC,"Relax");}}
else if((GetName(oArea)=="Home")&&(GetLocalInt(oPC,"InBath")==1)){if(GetLocalInt(oPC,"Wait")>=12){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(50),oPC);AssignCommand(oPC,ActionCastSpellAtObject(SPELL_GREATER_RESTORATION,oPC,METAMAGIC_ANY,TRUE,1,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));FloatingTextStringOnCreature("you feel better",oPC);DeleteLocalInt(oPC,"Wait");}SetLocalInt(oPC,"Wait",GetLocalInt(oPC,"Wait")+1);}
////////////////////////////////////////////////////////////////////////////////
// Dying
if(GetCurrentHitPoints(oPC)>0){DeleteLocalInt(oPC,"Stabilised");}
else if((GetCurrentHitPoints(oPC)<1)&&(GetCurrentHitPoints(oPC)>-11)){if(GetLocalInt(oPC,"Stabilised")!=1){iRand = Random(10);if(GetLevelByPosition(1,oPC)+GetLevelByPosition(2,oPC)+GetLevelByPosition(3,oPC)<6){iRand = Random(4);}if(iRand==1){SetLocalInt(oPC,"Stabilised",1);FloatingTextStringOnCreature("Your health is stabilised !",oPC,TRUE);}SetLocalInt(oPC,"VariDyi",GetLocalInt(oPC,"VariDyi")+1);if(GetLocalInt(oPC,"VariDyi")>=5){DeleteLocalInt(oPC,"VariDyi");ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),oPC);}}
else{SetLocalInt(oPC,"VariDyi",GetLocalInt(oPC,"VariDyi")+1);if(GetLocalInt(oPC,"VariDyi")>=2){DeleteLocalInt(oPC,"VariDyi");ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(1),oPC);FloatingTextStringOnCreature("You're going better !",oPC,TRUE);}}}
////////////////////////////////////////////////////////////////////////////////
// Familiars
oFamiliar1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);
oFamiliar2 = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);
oFamiliar3 = GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC);
oFamiliar4 = GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC);

if(GetIsObjectValid(oFamiliar1)){SetLocalInt(oFamiliar1,"DontSave",1);if((sAreaName=="Sky")||(sAreaName=="Ocean")||(sAreaName=="Space")||(sAreaName=="Underwater")){RemoveSummonedAssociate(oPC,oFamiliar1);DestroyObject(oFamiliar1);}else{SetLocalString(oGoldbag,"Familiar1","1");}}else{DeleteLocalString(oGoldbag,"Familiar1");}
if(GetIsObjectValid(oFamiliar2)){SetLocalInt(oFamiliar2,"DontSave",1);if((sAreaName=="Sky")||(sAreaName=="Ocean")||(sAreaName=="Space")||(sAreaName=="Underwater")){RemoveSummonedAssociate(oPC,oFamiliar2);DestroyObject(oFamiliar2);}else{SetLocalString(oGoldbag,"Familiar2","1");}}else{DeleteLocalString(oGoldbag,"Familiar2");}
if(GetIsObjectValid(oFamiliar3)){SetLocalInt(oFamiliar3,"DontSave",1);if((sAreaName=="Sky")||(sAreaName=="Ocean")||(sAreaName=="Space")||(sAreaName=="Underwater")){RemoveSummonedAssociate(oPC,oFamiliar3);DestroyObject(oFamiliar3);}else{SetLocalString(oGoldbag,"Familiar3",GetResRef(oFamiliar3));}}else{DeleteLocalString(oGoldbag,"Familiar3");}
if((GetIsObjectValid(oFamiliar4))&&(GetLocalString(oGoldbag,"Familiar4")=="")){if(GetStringLeft(GetTag(oArea),10)=="underwater"){RemoveHenchman(oPC,oFamiliar4);FloatingTextStringOnCreature("you can't take creatures under water",oPC);}else{oFamiliar5 = CreateObject(OBJECT_TYPE_CREATURE,GetResRef(oFamiliar4),GetLocation(oFamiliar4));SetLocalString(oGoldbag,"Familiar4",GetResRef(oFamiliar4));ChangeToStandardFaction(oFamiliar5,STANDARD_FACTION_COMMONER);SetStandardFactionReputation(STANDARD_FACTION_MERCHANT,50,oPC);SetLocalInt(oFamiliar5,"Hench",1);SetLocalInt(oFamiliar5,"DontSave",1);SetLocalString(oFamiliar5,"Master",sName);SetLocalObject(oPC,"Familiar4",oFamiliar5);AddHenchman(oPC,oFamiliar5);AssignCommand(oFamiliar4,SetIsDestroyable(TRUE,TRUE,TRUE));DestroyObject(oFamiliar4);DeleteLocalString(oGoldbag,"0StayHench");}}
////////////////////////////////////////////////////////////////////////////////
// Gold weight
// Qlippoth disabled   if(GetLocalInt(oPC,"Gold")!=iGold){SetLocalInt(oPC,"Gold",iGold);DelayCommand(0.1,ExecuteScript("gold",oPC));}
////////////////////////////////////////////////////////////////////////////////
// Guild membership
if(GetLocalInt(oGoldbag,"GuildMB")>0){SetLocalInt(oGoldbag,"GuildMB",GetLocalInt(oGoldbag,"GuildMB")-1);}
////////////////////////////////////////////////////////////////////////////////
// Mount
if((GetPhenoType(oPC)>4)&&(GetPhenoType(oPC)<14)){iRand = Random(15);if(iRand>13){AssignCommand(oPC,PlaySound("c_horsexxx_dead"));}else if(iRand>11){AssignCommand(oPC,PlaySound("c_horsexxx_slct"));}}
////////////////////////////////////////////////////////////////////////////////
// Position & Hit points
if((sArea!="")&&(GetLocalInt(oArea,"SpecialArea")!=1))
 {
if((!GetIsAreaInterior(oArea))&&(GetStringLeft(sAreaTag,7)!="airship"))
  {
// Exterior position
SetLocalString(oGoldbag,"Planet",sPlanet);
SetLocalString(oGoldbag,"Area",sArea);
SetLocalFloat(oGoldbag,"fX",GetPosition(oPC).x);
SetLocalFloat(oGoldbag,"fY",GetPosition(oPC).y);
SetLocalFloat(oGoldbag,"fZ",GetPosition(oPC).z);
SetLocalFloat(oGoldbag,"fFacing",GetFacing(oPC));
  }
// Hit points
SetLocalInt(oGoldbag,"HitPoints",GetCurrentHitPoints(oPC));if(GetCurrentHitPoints(oPC)>-11){DeleteLocalInt(oGoldbag,"Dead");}
 }
////////////////////////////////////////////////////////////////////////////////
// Resting bug
if(!GetIsResting(oPC)){DeleteLocalInt(oPC,"Sleep");}
////////////////////////////////////////////////////////////////////////////////
// Ruins
if(GetIsObjectValid(oWP)){float fWPX = GetPosition(oWP).x;float fWPY = GetPosition(oWP).y;float fWPZ = 0.0;if(GetStringLeft(GetTag(oArea),8)=="tropical"){fWPZ = 1.0;}else if((GetStringLeft(GetTag(oArea),6)=="ground")||(GetStringLeft(GetTag(oArea),11)=="ruralcastle")){fWPZ = 5.0;}int iUsed = GetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fWPX))+IntToString(FloatToInt(fWPY))+"Used");if((GetDistanceBetween(oPC,oWP)<=10.0)&&(iUsed<5)){SetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fWPX))+IntToString(FloatToInt(fWPY))+"Used",iUsed+1);int iSkill = GetSkillRank(SKILL_LISTEN,oPC)+GetSkillRank(SKILL_SEARCH,oPC)+GetSkillRank(SKILL_SPOT,oPC);if((d20(1)+iSkill)>=20){if((GetIsAreaInterior(oArea))&&(GetLocalInt(oWP,"Special")==0)){iRand = Random(3)+1;}else{iRand = Random(4)+1;}if(iRand==1){sBP = "crate001";sItemName = "Crate";}else if(iRand==2){sBP = "crate002";sItemName = "Crate";}else if(iRand==3){sBP = "coffin001";sItemName = "Coffin";}else if(iRand==4){sBP = "trap001";sItemName = "Trap";}oNew = CreateObject(OBJECT_TYPE_PLACEABLE,sBP,Location(oArea,Vector(fWPX,fWPY,fWPZ),GetFacing(oWP)+180.0));SetName(oNew,sItemName);SetLocalInt(oModule,sPlanet+sArea+IntToString(FloatToInt(fWPX))+IntToString(FloatToInt(fWPY))+"Used",5);GiveXPToCreature(oPC,10);FloatingTextStringOnCreature("You discover something : 10 xps",oPC);}}}
////////////////////////////////////////////////////////////////////////////////
// Save characters
if(GetLocalInt(oModule,"SaveCharacters")>=(2*600)){DeleteLocalInt(oModule,"SaveCharacters");ExportAllCharacters();}else{SetLocalInt(oModule,"SaveCharacters",GetLocalInt(oModule,"SaveCharacters")+1);}
////////////////////////////////////////////////////////////////////////////////
// Stars and black holes damages
     if(GetStringLeft(sAreaTag,7)=="space_b"){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityDecrease(DAMAGE_TYPE_NEGATIVE,30),oPC);ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(Random(11)+10,DAMAGE_TYPE_NEGATIVE,DAMAGE_POWER_ENERGY),oPC);FloatingTextStringOnCreature("aspired in the black hole",oPC);}
else if(GetStringLeft(sAreaTag,7)=="space_s"){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE,30),oPC);ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(Random(11)+10,DAMAGE_TYPE_FIRE,DAMAGE_POWER_ENERGY),oPC);FloatingTextStringOnCreature("damaged from the star heat",oPC);}
////////////////////////////////////////////////////////////////////////////////
// Underwater maluses
if(sAreaName=="Underwater"){oObject = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);if((oObject==OBJECT_INVALID)||(GetTag(oObject)!="maskunderwater")){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(3),oPC);FloatingTextStringOnCreature("No Oxigen",oPC,FALSE);}}
////////////////////////////////////////////////////////////////////////////////
// Wear
ExecuteScript("wear",oPC);
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
}oPC = GetNextPC();}
////////////////////////////////////////////////////////////////////////////////
}
