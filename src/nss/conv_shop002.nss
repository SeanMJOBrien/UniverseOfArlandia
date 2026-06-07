#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oStore = GetNearestObject(OBJECT_TYPE_STORE);
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
object oItem = GetFirstItemInInventory(oPC);
//
int iStep = 10*(GetLocalInt(OBJECT_SELF,"Step"));
//
int iWear;int iPrice;string s;string sNews;int iGP;int iIV;int iIVdelay;int j;int i = 10;;
////////////////////////////////////////////////////////////////////////////////
// Blacksmith
if(GetTag(oStore)=="store012")
 {
//
while(i>0)
  {
SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);
SetCustomToken(10110+i,"");SetCustomToken(10120+i,"");
i--;
  }
//
while(GetIsObjectValid(oItem))
  {
if((GetStringLeft(GetTag(oItem),6)=="broken")||((GetLocalInt(oItem,"Wear")>0)&&(GetTag(oItem)!="bedroll")&&(GetTag(oItem)!="NW_IT_TORCH001")&&(GetStringLeft(GetTag(oItem),4)!="tool")))
   {
j++;

if((j>iStep)&&(j<=iStep+10))
    {
i++;
iWear = GetLocalInt(oItem,"Wear%");if(GetStringLeft(GetTag(oItem),6)!="broken"){iWear = 100-iWear;}
iPrice = GetLocalInt(oItem,"Fix")*iWear/100;if(iPrice<1){iPrice = 1;}

SetLocalObject(OBJECT_SELF,"BrokenItem"+IntToString(iStep+i),oItem);SetCustomToken(10110+i,GetName(oItem));
SetLocalInt(OBJECT_SELF,"BrokenItemFixPrice"+IntToString(iStep+i),iPrice);SetCustomToken(10120+i,IntToString(iPrice));
DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));
    }
   }
oItem = GetNextItemInInventory(oPC);
  }
//
 }
////////////////////////////////////////////////////////////////////////////////
// Inn
else if(GetTag(oStore)=="store014")
 {
iPrice = iInn;
SetCustomToken(10061,IntToString(iPrice));
SetLocalInt(oPC,"Price",iPrice);
 }
////////////////////////////////////////////////////////////////////////////////
// Tavern
else if(GetTag(oStore)=="store013")
 {
sNews = "Well, everything seems quiet.";
SetCustomToken(10062,sNews);
 }
////////////////////////////////////////////////////////////////////////////////
// Temple
else if(GetTag(oStore)=="store015")
 {
SetCustomToken(10175,IntToString(iReLevelUp));
SetLocalInt(oPC,"Price",iReLevelUp);
 }
////////////////////////////////////////////////////////////////////////////////
// Architect
else if(GetTag(oStore)=="store016")
 {
SetCustomToken(10131,IntToString(iStarshipLvl));
SetCustomToken(10132,IntToString(iStarshipPass));

SetLocalInt(oPC,"Price",iStarshipPass);
 }
////////////////////////////////////////////////////////////////////////////////
// Trainer
else if(GetTag(oStore)=="store017")
 {
// First
int a = 9;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}

SetLocalInt(OBJECT_SELF,"ChoiceDone17",1);SetLocalInt(OBJECT_SELF,"ChoiceDone18",1);SetLocalInt(OBJECT_SELF,"ChoiceDone19",1);

s = "Alchemist";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Animaler";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Architect";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Armorsmith";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Banker";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Blacksmith";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Bookseller";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Caster";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Engineer";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Foodmaker";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Healer";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Jeweler";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Tailor";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Taverner";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Trainer";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}
s = "Weaponsmith";j++;if(GetLocalInt(oGoldbag,s)==1){iPrice++;SetCustomToken(10170+iPrice,s);SetLocalString(oPC,"CraftFeat"+IntToString(iPrice),s);DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(iPrice+16));SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}else{DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j));}

if(iPrice>=3){j=0;while(j<16){j++;SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(j),1);}}
SetLocalInt(oPC,"Price",iPrice);
 }
////////////////////////////////////////////////////////////////////////////////
// Bank
else if(GetTag(oStore)=="store010")
 {
oItem = GetItemPossessedBy(oPC,sPlanet+"account");
iGP = GetLocalInt(oItem,"GP");
iIV = GetLocalInt(oItem,"IV");
iIVdelay = GetLocalInt(oItem,"IVdelay");

// Account price
iPrice = iAccount;
SetCustomToken(10135,IntToString(iPrice));
SetLocalInt(oPC,"Price",iPrice);

// GP on account
SetCustomToken(10136,IntToString(iGP));

// Investments
SetCustomToken(10137,IntToString(iNormalInterest));
SetCustomToken(10138,IntToString(iInvestmentInterest));
SetCustomToken(10139,IntToString(iInvestmentDelay));
SetCustomToken(10140,IntToString(iIV));
SetCustomToken(10141,IntToString(iIVdelay/576));
 }
////////////////////////////////////////////////////////////////////////////////
}
