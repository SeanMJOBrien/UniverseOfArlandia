#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetLastPCRested();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(oPC);
object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
effect eSnore = EffectVisualEffect(VFX_IMP_SLEEP);
object oBedroll = GetItemPossessedBy(oPC,"bedroll");
location lLoc = GetLocation(oPC);
int iPCInn = GetLocalInt(oGoldbag,"Inn");
object oTent1 = GetNearestObjectByTag("pla_tent001",oPC);
object oTent2 = GetNearestObjectByTag("pla_tent002",oPC);
object oTent3 = GetNearestObjectByTag("pla_tent003",oPC);
object oFire = GetNearestObjectByTag("campfire",oPC);
int iRace = GetLocalInt(oGoldbag,"Race");
//
string sGuild = GetLocalString(oGoldbag,"Guild");
int iGuild = GetLocalInt(oGoldbag,"GuildMB");
object oMember = GetFirstFactionMember(oPC);
//
object oFood;object oRoll;int iBroken;int n;
object oItem = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItem)){if((GetTag(oItem)=="cr_apple")||(GetTag(oItem)=="cr_banana")||(GetTag(oItem)=="cr_cereal")||(GetTag(oItem)=="cr_cherry")||(GetTag(oItem)=="cr_egg")||(GetTag(oItem)=="cr_food")||(GetTag(oItem)=="cr_grape")||(GetTag(oItem)=="cr_jelly")||(GetTag(oItem)=="cr_milk")||(GetTag(oItem)=="cr_pemican")||(GetTag(oItem)=="cr_arabano")||(GetTag(oItem)=="cr_sandwich")||(GetTag(oItem)=="cr_strawberry")||(GetTag(oItem)=="food")){oFood = oItem;break;}oItem = GetNextItemInInventory(oPC);}
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
if(GetLocalInt(oPC,"Sleep")!=1)
 {
////////////////////////////////////////////////////////////////////////////////
// Horse
if(GetLocalInt(oPC,"Mounted")==1){AssignCommand(oPC,ClearAllActions());FloatingTextStringOnCreature("You can't rest on your mount !",oPC,TRUE);}
////////////////////////////////////////////////////////////////////////////////
// Armor
else if(GetWeight(oArmor)>iWeight*10){AssignCommand(oPC,ClearAllActions());FloatingTextStringOnCreature("You can't rest wearing an armor !",oPC,TRUE);}
////////////////////////////////////////////////////////////////////////////////
// Food
else if(oFood==OBJECT_INVALID){AssignCommand(oPC,ClearAllActions());FloatingTextStringOnCreature("You need more food to rest !",oPC,TRUE);}
////////////////////////////////////////////////////////////////////////////////
// Sleep
else
  {
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)/4),oPC);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSnore,oPC,9.0);DelayCommand(9.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSnore,oPC,9.0));FadeToBlack(oPC,FADE_SPEED_MEDIUM);DelayCommand(9.0,FadeFromBlack(oPC,FADE_SPEED_FAST));
DestroyObject(oFood);
if(GetIsObjectValid(oBedroll)){oRoll = CreateObject(OBJECT_TYPE_PLACEABLE,"pla_bedroll",lLoc);DestroyObject(oRoll,9.0);if(GetLocalInt(oBedroll,"Wear")>iBedrollBrake){iBroken = Random(100/iBedrollBrakeProb);if(iBroken==0){DestroyObject(oBedroll);DelayCommand(9.0,SendMessageToPC(oPC,"Your Bedroll is broken !"));}}else{SetLocalInt(oBedroll,"Wear",GetLocalInt(oBedroll,"Wear")+1);}}
////////////////////////////////////////////////////////////////////////////////
// Variables
SetLocalInt(oPC,"Sleep",1);
////////////////////////////////////////////////////////////////////////////////
  }
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
else
 {
////////////////////////////////////////////////////////////////////////////////
// Hit Points
if(GetCurrentHitPoints(oPC)>GetMaxHitPoints(oPC)){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetCurrentHitPoints(oPC)-GetMaxHitPoints(oPC),DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),oPC);}
////////////////////////////////////////////////////////////////////////////////
// Bedroll
if(GetIsObjectValid(oBedroll)){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectTemporaryHitpoints(iRestBonus),oPC);}
////////////////////////////////////////////////////////////////////////////////
// Houses HitPoints
if(((GetName(oArea)=="Inn")||(GetName(oArea)=="Town Hall"))&&(iPCInn==1)){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(GetMaxHitPoints(oPC)),oPC);if(GetLocalInt(oArea,"Level")>=4){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(GetMaxHitPoints(oPC)),oPC);}else if(GetLocalInt(oArea,"Level")>=2){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(GetMaxHitPoints(oPC)/2),oPC);}DeleteLocalInt(oGoldbag,"Inn");}
else if(GetName(oArea)=="House"){if(GetLocalInt(oArea,"Level")>=4){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(GetMaxHitPoints(oPC)),oPC);}else if(GetLocalInt(oArea,"Level")>=2){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(GetMaxHitPoints(oPC)/2),oPC);}}
else if(GetName(oArea)=="Home"){if(GetLocalInt(oArea,"Level")>=5){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(GetMaxHitPoints(oPC)*2),oPC);}else if(GetLocalInt(oArea,"Level")>=4){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints((GetMaxHitPoints(oPC)*3)/2),oPC);}else if(GetLocalInt(oArea,"Level")>=2){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(GetMaxHitPoints(oPC)),oPC);}else{ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(GetMaxHitPoints(oPC)/2),oPC);}}
////////////////////////////////////////////////////////////////////////////////
// Tent HitPoints
else if((GetIsObjectValid(oTent3))&&(GetDistanceBetween(oPC,oTent3)<=fTentRest)){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints((GetMaxHitPoints(oPC)*iTentRest*3)/100),oPC);SetLocalInt(oTent3,"Wear",GetLocalInt(oTent3,"Wear")+1);if(GetLocalInt(oTent3,"Wear")>=iTentBig){FloatingTextStringOnCreature("The tent is destroyed",oPC,TRUE);DestroyObject(oTent3);}}
else if((GetIsObjectValid(oTent2))&&(GetDistanceBetween(oPC,oTent2)<=fTentRest)){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints((GetMaxHitPoints(oPC)*iTentRest*2)/100),oPC);SetLocalInt(oTent2,"Wear",GetLocalInt(oTent2,"Wear")+1);if(GetLocalInt(oTent2,"Wear")>=iTentMedium){FloatingTextStringOnCreature("The tent is destroyed",oPC,TRUE);DestroyObject(oTent2);}}
else if((GetIsObjectValid(oTent1))&&(GetDistanceBetween(oPC,oTent1)<=fTentRest)){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints((GetMaxHitPoints(oPC)*iTentRest*1)/100),oPC);SetLocalInt(oTent1,"Wear",GetLocalInt(oTent1,"Wear")+1);if(GetLocalInt(oTent1,"Wear")>=iTentSmall){FloatingTextStringOnCreature("The tent is destroyed",oPC,TRUE);DestroyObject(oTent1);}}
////////////////////////////////////////////////////////////////////////////////
// Fire HitPoints
else if((GetIsObjectValid(oFire))&&(GetDistanceBetween(oPC,oFire)<=fTentRest)){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(iFireRest),oPC);}
////////////////////////////////////////////////////////////////////////////////
SetLocalInt(oGoldbag,"HitPoints",GetCurrentHitPoints(oPC));
////////////////////////////////////////////////////////////////////////////////
// Clones item
if(GetIsObjectValid(GetItemPossessedBy(oPC,"clones"))){DeleteLocalInt(GetItemPossessedBy(oPC,"clones"),"Uses");}
////////////////////////////////////////////////////////////////////////////////
// Gorochem
if(GetLocalInt(oPC,"Gorochem")>0){SetPhenoType(GetLocalInt(oPC,"Gorochem"),oPC);}
////////////////////////////////////////////////////////////////////////////////
// Special areas
if(GetStringLeft(GetTag(oArea),6)=="clouds"){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectHaste(),oPC);}
////////////////////////////////////////////////////////////////////////////////
// Domain Guild
if(iGuild>0){n=0;while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=4){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(GetMaxHitPoints(oPC)),oPC);}if(GetLocalInt(oGoldbag,"GuildLevel")>=5){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectACIncrease(2),oPC);}}}
////////////////////////////////////////////////////////////////////////////////
// Gaz areas
if((GetStringLeft(GetTag(oArea),3)=="gaz")&&(GetLocalInt(oPC,"Flying")==1)){ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectMovementSpeedIncrease(50),oPC);}
////////////////////////////////////////////////////////////////////////////////
// Misc
SetCreatureWingType(CREATURE_WING_TYPE_NONE,oPC);
////////////////////////////////////////////////////////////////////////////////
// Forbid spells
n=10;while(n>0){DecrementRemainingSpellUses(oPC,SPELL_CONTINUAL_FLAME);n--;}
n=10;while(n>0){DecrementRemainingSpellUses(oPC,SPELL_DARKFIRE);n--;}
n=10;while(n>0){DecrementRemainingSpellUses(oPC,SPELL_FLAME_WEAPON);n--;}
////////////////////////////////////////////////////////////////////////////////
// First
int a = 16;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
////////////////////////////////////////////////////////////////////////////////
// Remove summoneds
object oFamiliar1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);
object oFamiliar2 = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);
object oFamiliar3 = GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC);
object oFamiliar4 = GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC);

if(GetIsObjectValid(oFamiliar1)){RemoveSummonedAssociate(oPC,oFamiliar1);AssignCommand(oFamiliar1,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar1,FALSE);DestroyObject(oFamiliar1);}
if(GetIsObjectValid(oFamiliar2)){RemoveSummonedAssociate(oPC,oFamiliar2);AssignCommand(oFamiliar2,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar2,FALSE);DestroyObject(oFamiliar2);}
if(GetIsObjectValid(oFamiliar3)){RemoveSummonedAssociate(oPC,oFamiliar3);AssignCommand(oFamiliar3,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar3,FALSE);DestroyObject(oFamiliar3);}
if(GetIsObjectValid(oFamiliar4)){RemoveSummonedAssociate(oPC,oFamiliar4);AssignCommand(oFamiliar4,SetIsDestroyable(TRUE,FALSE,FALSE));SetPlotFlag(oFamiliar4,FALSE);DestroyObject(oFamiliar4);}
////////////////////////////////////////////////////////////////////////////////
// Delete variables
DeleteLocalInt(oPC,"Sleep");
DeleteLocalInt(oPC,"DomainStatue");
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
}
