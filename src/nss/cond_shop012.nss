int StartingConditional()
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
int iGold = GetGold(oPC);
int iPrice;int i;

// Deposit
if(iChoice1==1)
 {
     if(iChoice2==1){iPrice = 100;}
else if(iChoice2==2){iPrice = 500;}
else if(iChoice2==3){iPrice = 1000;}
if(iGold>=iPrice){i = 1;}
 }
// Withdraw
else if(iChoice1==2)
 {
     if(iChoice2==1){iPrice = 100;}
else if(iChoice2==2){iPrice = 500;}
else if(iChoice2==3){iPrice = 1000;}
if(iGP>=iPrice){i = 1;}
 }
// Investment
else if(iChoice1==4)
 {
if(iChoice2==0)
  {
if(iIVdelay==-1){i = 1;}
  }
else if(iChoice2==1)
  {
     if(iChoice3==0){if(iIVdelay>0){i = 1;}}
else if(iChoice3==1){iPrice = 1000;if(iGold>=iPrice){i = 1;}}
else if(iChoice3==2){iPrice = 5000;if(iGold>=iPrice){i = 1;}}
else if(iChoice3==3){iPrice = 10000;if(iGold>=iPrice){i = 1;}}
  }
else if(iChoice2==2)
  {
if(iIV==0){i = 1;}
  }
 }
// bank notes
else if(iChoice1==5)
 {
     if(iChoice2==1){if(iGold>=100){i = 1;}}
else if(iChoice2==2){if(iGold>=1000){i = 1;}}
else if(iChoice2==3){if(iGold>=10000){i = 1;}}
else if(iChoice2==4){if(GetIsObjectValid(GetItemPossessedBy(oPC,"banknote001"))){i = 1;}}
else if(iChoice2==5){if(GetIsObjectValid(GetItemPossessedBy(oPC,"banknote002"))){i = 1;}}
else if(iChoice2==6){if(GetIsObjectValid(GetItemPossessedBy(oPC,"banknote003"))){i = 1;}}
 }
if(i==1){return TRUE;}else{return FALSE;}
}
