#include "_module"
void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oStore = GetNearestObject(OBJECT_TYPE_STORE);
int iStep = 10*(GetLocalInt(OBJECT_SELF,"Step")-1);
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1")+iStep;
int iPrice = GetLocalInt(oPC,"Price");
int iXPs = GetXP(oPC);
string sFeat;

     if(iChoice1==1) {sFeat = "Alchemist";}
else if(iChoice1==2) {sFeat = "Animaler";}
else if(iChoice1==3) {sFeat = "Architect";}
else if(iChoice1==4) {sFeat = "Armorsmith";}
else if(iChoice1==5) {sFeat = "Banker";}
else if(iChoice1==6) {sFeat = "Blacksmith";}
else if(iChoice1==7) {sFeat = "Bookseller";}
else if(iChoice1==8) {sFeat = "Caster";}
else if(iChoice1==9) {sFeat = "Engineer";}
else if(iChoice1==10) {sFeat = "Foodmaker";}
else if(iChoice1==11) {sFeat = "Healer";}
else if(iChoice1==12) {sFeat = "Jeweler";}
else if(iChoice1==13) {sFeat = "Tailor";}
else if(iChoice1==14) {sFeat = "Taverner";}
else if(iChoice1==15) {sFeat = "Trainer";}
else if(iChoice1==16) {sFeat = "Weaponsmith";}
else if(iChoice1>16){DeleteLocalInt(oGoldbag,GetLocalString(oPC,"CraftFeat"+IntToString(iChoice1-16)));}

if(iChoice1<=16)
 {
SetXP(oPC,GetXP(oPC)-iPrice);
SetLocalInt(oGoldbag,sFeat,1);
 }
}
