#include "aps_include"
#include "dmfi_dmw_inc"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLastUsedBy();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sName = GetName(oPC);
string sTag = GetTag(OBJECT_SELF);
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sMaster = GetLocalString(OBJECT_SELF,"Master");
//
int iSlot = GetLocalInt(OBJECT_SELF,"Slot");
int iStructure = GetLocalInt(OBJECT_SELF,"Structure");
int iLevel = StringToInt(GetStringRight(GetName(OBJECT_SELF),1));
//
int iCounter = GetLocalInt(oGoldbag,"Counter");
int iOrigCounter = GetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter");
int iHBPassed = iCounter-iOrigCounter;
int iDays = iHBPassed/576;
int iTavernGain;
//
int iGain = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain");
int iGainBonus = GetLocalInt(OBJECT_SELF,"Gain");
string sRenter = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot));
int iOpen = GetLocalInt(oModule,sPlanet+"&"+sArea+"&Open&"+IntToString(iSlot));
////////////////////////////////////////////////////////////////////////////////
string sInterest = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
string sVar = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")))-FindSubString(sInterest,"&2&")-3);
string sVar11 = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,"_11_")),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,"_11_")))-FindSubString(sVar,"_10_")-4);
////////////////////////////////////////////////////////////////////////////////
if(sTag=="domaincontrol")
 {
// Mail
if(GetPersistentString(oModule,sPlanet+"&"+sArea+"&Mailbox")!=""){FloatingTextStringOnCreature("you have mail",oPC);}

SetCustomToken(10065,ColorText(sVar11,"g"));
if(IsInConversation(oPC)==FALSE){BeginConversation("",oPC);}
 }
////////////////////////////////////////////////////////////////////////////////
else if(sTag=="structureflag")
 {
// Holder
if(sName==sMaster)
  {
// Tavern special gains
if(iStructure==18)
   {
if(iDays>0)
    {
if(iLevel>=2){iTavernGain = 10*iDays;}
if(iLevel>=4){iTavernGain = iTavernGain*3;}
if(iLevel>=5){if(Random(4)==0){iTavernGain = iTavernGain*2;FloatingTextStringOnCreature("shows took place in your tavern",oPC);}}
SetLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(iSlot)+"Counter",iCounter);
    }
   }
if(iGain>0){GiveGoldToCreature(oPC,iGain+(iGain*iGainBonus/100)+iTavernGain);FloatingTextStringOnCreature("you earn some rewards",oPC);DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain");}
if(IsInConversation(oPC)==FALSE){BeginConversation("",oPC);}
  }
// House renter
else if(iStructure==11)
  {
if((sRenter==sName)||(sRenter==""))
   {
if(IsInConversation(oPC)==FALSE){BeginConversation("",oPC);}
   }
else
   {
if(iOpen==1){SetLocalObject(OBJECT_SELF,"PC",oPC);ExecuteScript("transitions2",OBJECT_SELF);}else{FloatingTextStringOnCreature("Closed",oPC);}
   }
  }
// Home
else if(iStructure==14)
  {
if(iOpen==1){SetLocalObject(OBJECT_SELF,"PC",oPC);ExecuteScript("transitions2",OBJECT_SELF);}else{FloatingTextStringOnCreature("Closed",oPC);}
  }
// Visitors
else
  {
// Interiors
if((iStructure==4)||(iStructure==9)||(iStructure==10)||(iStructure==12)||(iStructure==13)||(iStructure==15)||(iStructure==16)||(iStructure==18)||(iStructure==19)||(iStructure==20)){SetLocalObject(OBJECT_SELF,"PC",oPC);ExecuteScript("transitions2",OBJECT_SELF);}
  }
 }
////////////////////////////////////////////////////////////////////////////////
else
 {
SetCustomToken(10600,GetLocalString(oArea,"Master"));
if(IsInConversation(oPC)==FALSE){BeginConversation("",oPC);}
 }
////////////////////////////////////////////////////////////////////////////////
}
