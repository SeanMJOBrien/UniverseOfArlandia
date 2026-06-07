#include "_module"
void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oStore = GetNearestObject(OBJECT_TYPE_STORE);
int iStep = 10*(GetLocalInt(OBJECT_SELF,"Step")-1);if(iStep<0){iStep = 0;}
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1")+iStep;
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
int iLevel = GetLocalInt(oArea,"Level");
int iXPs = GetXP(oPC);
int iClones = GetLocalInt(oGoldbag,"Clones");
object oItem;string sBP;string sName;int iPrice;object oNew;

// Blacksmith
if(GetTag(oStore)=="store012")
 {
oItem = GetLocalObject(OBJECT_SELF,"BrokenItem"+IntToString(iChoice1));
sBP = GetLocalString(oItem,"Master");
sName = GetStringRight(GetName(oItem),GetStringLength(GetName(oItem))-7);
iPrice = GetLocalInt(OBJECT_SELF,"BrokenItemFixPrice"+IntToString(iChoice1));

if(GetStringLeft(GetTag(oItem),6)=="broken")
  {
oNew = CreateItemOnObject(sBP,oPC,1);
if(GetName(oNew)!=sName){SetName(oNew,sName);}if(FindSubString(sName,"(Quality")!=-1){AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyQuality(IP_CONST_QUALITY_EXCELLENT),oNew);}
SetLocalString(oNew,"Var",GetLocalString(oItem,"Var"));
SetLocalString(oNew,"Bonus",GetLocalString(oItem,"Bonus"));if(GetLocalString(oItem,"Bonus")!=""){ExecuteScript("bonus",oNew);}
SetIdentified(oNew,TRUE);
DestroyObject(oItem);
  }
else
  {
DeleteLocalInt(oItem,"Wear");
  }
TakeGoldFromCreature(iPrice,oPC,TRUE);
FloatingTextStringOnCreature("item fixed",oPC,FALSE);
 }

// Inn
else if(GetTag(oStore)=="store014")
 {
iPrice = GetLocalInt(oPC,"Price");
SetLocalInt(oGoldbag,"Inn",1);
TakeGoldFromCreature(iPrice,oPC,TRUE);
 }

// Temple
else if(GetTag(oStore)=="store015")
 {
iPrice = GetLocalInt(oPC,"Price"+IntToString(iChoice1));
     if(iChoice1==0){SetXP(oPC,0);DelayCommand(0.5,GiveXPToCreature(oPC,iXPs-iReLevelUp));}
else if(iChoice1==1){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints()),oPC);TakeGoldFromCreature(iPrice,oPC,TRUE);}
else if(iChoice1==2){AssignCommand(oPC,ActionCastSpellAtObject(SPELL_GREATER_RESTORATION,oPC,METAMAGIC_ANY,TRUE,1,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));TakeGoldFromCreature(iPrice,oPC,TRUE);}
else if(iChoice1==3){object oMember = GetFirstFactionMember(oPC);while(GetIsObjectValid(oMember)){if(GetIsDead(oMember)){ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oMember);ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(100000),oMember);}oMember = GetNextFactionMember(oPC);}TakeGoldFromCreature(iPrice,oPC,TRUE);}
else if(iChoice1==4){SetXP(oPC,iXPs/2);SetLocalInt(oGoldbag,"Clones",iClones+1);if(GetItemPossessedBy(oPC,"clones")==OBJECT_INVALID){CreateItemOnObject("clones",oPC);}FloatingTextStringOnCreature("you can now summon "+IntToString(iClones+1)+" clones",oPC);}
 }

// Architect
else if(GetTag(oStore)=="store016")
 {
iPrice = GetLocalInt(oPC,"Price");
CreateItemOnObject("starpass",oPC);
TakeGoldFromCreature(iPrice,oPC,TRUE);
 }

// Trainer
else if(GetTag(oStore)=="store017")
 {
iPrice = GetLocalInt(oPC,"Price")+1;
     if(iPrice==1){iPrice = iCraftingFeat1;}
else if(iPrice==2){iPrice = iCraftingFeat2;}
else if(iPrice==3){iPrice = iCraftingFeat3;}

     if(iChoice1==1) {iPrice = iAlchemistFeat*iPrice;}
else if(iChoice1==2) {iPrice = iAnimalerFeat*iPrice;}
else if(iChoice1==3) {iPrice = iArchitectFeat*iPrice;}
else if(iChoice1==4) {iPrice = iArmorsmithFeat*iPrice;}
else if(iChoice1==5) {iPrice = iBankerFeat*iPrice;}
else if(iChoice1==6) {iPrice = iBlacksmithFeat*iPrice;}
else if(iChoice1==7) {iPrice = iBooksellerFeat*iPrice;}
else if(iChoice1==8) {iPrice = iCasterFeat*iPrice;}
else if(iChoice1==9) {iPrice = iEngineerFeat*iPrice;}
else if(iChoice1==10){iPrice = iFoodmakerFeat*iPrice;}
else if(iChoice1==11){iPrice = iHealerFeat*iPrice;}
else if(iChoice1==12){iPrice = iJewelerFeat*iPrice;}
else if(iChoice1==13){iPrice = iTailorFeat*iPrice;}
else if(iChoice1==14){iPrice = iTavernerFeat*iPrice;}
else if(iChoice1==15){iPrice = iTrainerFeat*iPrice;}
else if(iChoice1==16){iPrice = iWeaponsmithFeat*iPrice;}

if(iLevel>=4){iPrice = iPrice/2;}

SetCustomToken(10174,IntToString(iPrice));
SetLocalInt(oPC,"Price",iPrice);
 }

// Bank
else if(GetTag(oStore)=="store010")
 {
iPrice = GetLocalInt(oPC,"Price");
oItem = CreateItemOnObject("bankaccount",oPC,1,sPlanet+"account");
SetName(oItem,sPlanet+" bank account");
TakeGoldFromCreature(iPrice,oPC,TRUE);
 }

}
