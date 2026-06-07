#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
//
int iBonus = GetLocalInt(oArea,"Bonus");
int iStructure = GetLocalInt(OBJECT_SELF,"Structure");
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
int iLevel = StringToInt(GetStringRight(GetName(OBJECT_SELF),1));
//
int iCounter = GetLocalInt(oGoldbag,"Counter");
int iOrigCounter = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter");
int iHBPassed = iCounter-iOrigCounter;
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
//
int iNum;int iDays;string sBP;int iPrice;int i;
////////////////////////////////////////////////////////////////////////////////
// Casern
if(iStructure==3)
 {
while(i<5)
  {
i++;
SetLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i),1);
DeleteLocalInt(OBJECT_SELF,"Price"+IntToString(i));
DeleteLocalInt(OBJECT_SELF,"Days"+IntToString(i));
DeleteLocalInt(OBJECT_SELF,"Num"+IntToString(i));
  }

i=0;
if(iLevel>=1)
  {
iDays = iDomainCasern*20*1;iDays = iDays-(iDays*iBonus/100);iNum = iHBPassed/iDays;
i=1;iPrice = 50;DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));SetLocalInt(OBJECT_SELF,"Price"+IntToString(i),iPrice);SetLocalInt(OBJECT_SELF,"Days"+IntToString(i),iDays);SetLocalInt(OBJECT_SELF,"Num"+IntToString(i),iNum);SetCustomToken(10501,IntToString(iNum));
  }
if(iLevel>=2)
  {
iDays = iDomainCasern*20*2;iDays = iDays-(iDays*iBonus/100);iNum = iHBPassed/iDays;
i=2;iPrice = 200;DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));SetLocalInt(OBJECT_SELF,"Price"+IntToString(i),iPrice);SetLocalInt(OBJECT_SELF,"Days"+IntToString(i),iDays);SetLocalInt(OBJECT_SELF,"Num"+IntToString(i),iNum);SetCustomToken(10502,IntToString(iNum));
  }
if(iLevel>=3)
  {
iDays = iDomainCasern*20*3;iDays = iDays-(iDays*iBonus/100);iNum = iHBPassed/iDays;
i=3;iPrice = 400;DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));SetLocalInt(OBJECT_SELF,"Price"+IntToString(i),iPrice);SetLocalInt(OBJECT_SELF,"Days"+IntToString(i),iDays);SetLocalInt(OBJECT_SELF,"Num"+IntToString(i),iNum);SetCustomToken(10503,IntToString(iNum));
  }
if(iLevel>=4)
  {
iDays = iDomainCasern*20*5;iDays = iDays-(iDays*iBonus/100);iNum = iHBPassed/iDays;
i=4;iPrice = 700;DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));SetLocalInt(OBJECT_SELF,"Price"+IntToString(i),iPrice);SetLocalInt(OBJECT_SELF,"Days"+IntToString(i),iDays);SetLocalInt(OBJECT_SELF,"Num"+IntToString(i),iNum);SetCustomToken(10504,IntToString(iNum));
  }
if(iLevel>=5)
  {
iDays = iDomainCasern*20*7;iDays = iDays-(iDays*iBonus/100);iNum = iHBPassed/iDays;
i=5;iPrice = 1200;DeleteLocalInt(OBJECT_SELF,"ChoiceDone"+IntToString(i));SetLocalInt(OBJECT_SELF,"Price"+IntToString(i),iPrice);SetLocalInt(OBJECT_SELF,"Days"+IntToString(i),iDays);SetLocalInt(OBJECT_SELF,"Num"+IntToString(i),iNum);SetCustomToken(10505,IntToString(iNum));
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Dungeon
else if(iStructure==4)
 {
if(iLevel>=4){SetLocalObject(OBJECT_SELF,"PC",oPC);ExecuteScript("transitions2",OBJECT_SELF);}else{FloatingTextStringOnCreature("You can't enter until level 4",oPC);}
 }
////////////////////////////////////////////////////////////////////////////////
// Extractor, Factory, Farm , Field, Sawmill
else if((iStructure==5)||(iStructure==6)||(iStructure==7)||(iStructure==8)||(iStructure==21))
 {
DeleteLocalInt(OBJECT_SELF,"ChoiceDone1");
if(iLevel>=2){DeleteLocalInt(OBJECT_SELF,"ChoiceDone2");DeleteLocalInt(OBJECT_SELF,"ChoiceDone3");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone2",1);SetLocalInt(OBJECT_SELF,"ChoiceDone3",1);}
if(iLevel>=4){DeleteLocalInt(OBJECT_SELF,"ChoiceDone4");DeleteLocalInt(OBJECT_SELF,"ChoiceDone5");}else{SetLocalInt(OBJECT_SELF,"ChoiceDone4",1);SetLocalInt(OBJECT_SELF,"ChoiceDone5",1);}

DeleteLocalInt(OBJECT_SELF,"DontStep");
DeleteLocalInt(OBJECT_SELF,"Step2");
 }
////////////////////////////////////////////////////////////////////////////////
// Interiors
else if((iStructure==9)||(iStructure==10)||(iStructure==12)||(iStructure==13)||(iStructure==15)||(iStructure==16)||(iStructure==18)||(iStructure==19)||(iStructure==20))
 {
SetLocalObject(OBJECT_SELF,"PC",oPC);ExecuteScript("transitions2",OBJECT_SELF);
 }
////////////////////////////////////////////////////////////////////////////////
// Houses
else if((iStructure==11)||(iStructure==14))
 {
int iOpen = GetLocalInt(oModule,sPlanet+"&"+sArea+"&Open&"+IntToString(iSlot));
if(iOpen==1){SetLocalObject(OBJECT_SELF,"PC",oPC);ExecuteScript("transitions2",OBJECT_SELF);}else{FloatingTextStringOnCreature("Closed",oPC);}
 }
////////////////////////////////////////////////////////////////////////////////
}
