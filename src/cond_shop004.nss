int StartingConditional()
{
object oPC = GetPCSpeaker();
object oStore = GetNearestObject(OBJECT_TYPE_STORE);
int iGold = GetGold(oPC);
int iXP = GetXP(oPC);
int iStep = 10*(GetLocalInt(OBJECT_SELF,"Step")-1);
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1")+iStep;
int iPrice;

// Blacksmith
if(GetTag(oStore)=="store012")
 {
iPrice = GetLocalInt(OBJECT_SELF,"BrokenItemFixPrice"+IntToString(iChoice1));
 }

// Inn / Architect / Bank
else if((GetTag(oStore)=="store014")||(GetTag(oStore)=="store016")||(GetTag(oStore)=="store010"))
 {
iPrice = GetLocalInt(oPC,"Price");
 }

// Domain Temple
else if(GetTag(oStore)=="store015")
 {
iPrice = GetLocalInt(oPC,"Price"+IntToString(iChoice1));
 }

// Trainer
else if(GetTag(oStore)=="store017")
 {
iPrice = GetLocalInt(oPC,"Price");
iGold = iXP;if(GetIsDM(oPC)){iPrice = 0;}
 }

if(iGold>=iPrice){return TRUE;}else{return FALSE;}
}
