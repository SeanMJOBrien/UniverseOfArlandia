#include "_module"
void main()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
object oItem = GetItemPossessedBy(oPC,sPlanet+"account");
int iGP = GetLocalInt(oItem,"GP");
int iIV = GetLocalInt(oItem,"IV");
int iIVdelay = GetLocalInt(oItem,"IVdelay");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice2");
int iChoice3 = GetLocalInt(OBJECT_SELF,"Choice3");
int iPrice;int i;

// Deposit
if(iChoice1==1)
 {
     if(iChoice2==1){iPrice = 100;}
else if(iChoice2==2){iPrice = 500;}
else if(iChoice2==3){iPrice = 1000;}
SetLocalInt(oItem,"GP",iGP+iPrice);TakeGoldFromCreature(iPrice,oPC,TRUE);
FloatingTextStringOnCreature("Account GP : "+IntToString(iGP+iPrice),oPC);
 }
// Withdraw
else if(iChoice1==2)
 {
     if(iChoice2==1){iPrice = 100;}
else if(iChoice2==2){iPrice = 500;}
else if(iChoice2==3){iPrice = 1000;}
SetLocalInt(oItem,"GP",iGP-iPrice);GiveGoldToCreature(oPC,iPrice);
FloatingTextStringOnCreature("Account GP : "+IntToString(iGP-iPrice),oPC);
 }
// Close account
else if(iChoice1==3)
 {
if(iGP>0){GiveGoldToCreature(oPC,iGP);}
if(iIV>0){GiveGoldToCreature(oPC,iIV);}
DestroyObject(oItem);
 }
// Manage investments
else if(iChoice1==4)
 {
     if(iChoice2==0){GiveGoldToCreature(oPC,iIV);DeleteLocalInt(oItem,"IV");DeleteLocalInt(oItem,"IVdelay");FloatingTextStringOnCreature("Investment gain : "+IntToString(iIV),oPC);}
else if(iChoice3==1){iPrice = 1000;SetLocalInt(oItem,"IV",iPrice);SetLocalInt(oItem,"IVdelay",iInvestmentDelay*576);TakeGoldFromCreature(iPrice,oPC,TRUE);FloatingTextStringOnCreature("Investment : "+IntToString(iPrice)+", Delay : "+IntToString(iInvestmentDelay)+" days",oPC);}
else if(iChoice3==2){iPrice = 5000;SetLocalInt(oItem,"IV",iPrice);SetLocalInt(oItem,"IVdelay",iInvestmentDelay*576);TakeGoldFromCreature(iPrice,oPC,TRUE);FloatingTextStringOnCreature("Investment : "+IntToString(iPrice)+", Delay : "+IntToString(iInvestmentDelay)+" days",oPC);}
else if(iChoice3==3){iPrice = 10000;SetLocalInt(oItem,"IV",iPrice);SetLocalInt(oItem,"IVdelay",iInvestmentDelay*576);TakeGoldFromCreature(iPrice,oPC,TRUE);FloatingTextStringOnCreature("Investment : "+IntToString(iPrice)+", Delay : "+IntToString(iInvestmentDelay)+" days",oPC);}
 }
// Bank notes
else if(iChoice1==5)
 {
     if(iChoice2==1){CreateItemOnObject("banknote001",oPC);TakeGoldFromCreature(100,oPC,TRUE);}
else if(iChoice2==2){CreateItemOnObject("banknote002",oPC);TakeGoldFromCreature(1000,oPC,TRUE);}
else if(iChoice2==3){CreateItemOnObject("banknote003",oPC);TakeGoldFromCreature(10000,oPC,TRUE);}
else if(iChoice2==4){DestroyObject(GetItemPossessedBy(oPC,"banknote001"));GiveGoldToCreature(oPC,100);}
else if(iChoice2==5){DestroyObject(GetItemPossessedBy(oPC,"banknote002"));GiveGoldToCreature(oPC,1000);}
else if(iChoice2==6){DestroyObject(GetItemPossessedBy(oPC,"banknote003"));GiveGoldToCreature(oPC,10000);}
 }
}
