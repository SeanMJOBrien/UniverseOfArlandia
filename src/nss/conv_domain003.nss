#include "aps_include"
#include "dmfi_dmw_inc"
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
object oObjects = GetFirstObjectInArea(oArea);
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iChoice2 = GetLocalInt(OBJECT_SELF,"Choice2");
int iChoice3 = GetLocalInt(OBJECT_SELF,"Choice3");
int iChoice4 = GetLocalInt(OBJECT_SELF,"Choice4");
//
string s;int i;int j;
////////////////////////////////////////////////////////////////////////////////
string sInterest = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests");
string sInterestType = GetStringLeft(sInterest,FindSubString(sInterest,"&1&"));
string sMaster = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&2&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&2&")))-FindSubString(sInterest,"&1&")-3);
string sVar = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&3&")))-FindSubString(sInterest,"&2&")-3);
string sVisible = GetStringRight(GetStringLeft(sInterest,FindSubString(sInterest,"&4&")),GetStringLength(GetStringLeft(sInterest,FindSubString(sInterest,"&4&")))-FindSubString(sInterest,"&3&")-3);
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
// Execute "domains" script
if(iChoice4==1){ExecuteScript("domains",oArea);}
////////////////////////////////////////////////////////////////////////////////
// Toggle hide domain
else if(iChoice1==0)
 {
if(sVisible=="1"){sVisible = "0";s = ColorText("hidden","g");}else{sVisible = "1";s = ColorText("visible","g");}
SetCustomToken(10065,s);
SetPersistentString(oModule,sPlanet+"&"+sArea+"&Interests",sInterestType+"&1&"+sMaster+"&2&"+sVar+"&3&"+sVisible+"&4&");
 }
////////////////////////////////////////////////////////////////////////////////
// Build domain
else if(iChoice1==1)
 {
SetLocalString(oArea,"Domain_Build",IntToString(iChoice2)+"_+_"+IntToString(iChoice3));
SetLocalObject(oArea,"PC",oPC);
ExecuteScript("domains",oArea);
 }
////////////////////////////////////////////////////////////////////////////////
// Manage domain
else if(iChoice1==2)
 {
// Change domain description
if(iChoice2==1)
  {
object oNullhuman = CreateObject(OBJECT_TYPE_CREATURE,"nullhuman",GetLocation(oPC));
SetLocalInt(oPC,"Domain",1);
SetLocalObject(oNullhuman,"DomainControl",OBJECT_SELF);
AssignCommand(oNullhuman,ActionStartConversation(oPC,"null",TRUE,FALSE));
DelayCommand(4.0,FloatingTextStringOnCreature("Ready",oPC,FALSE));
  }
// Destroy Domain
else if(iChoice2==2)
  {
SetLocalInt(OBJECT_SELF,"DestroySS",1);ExecuteScript("starship_destroy",OBJECT_SELF);
while(GetIsObjectValid(oObjects))
   {
if((GetLocalInt(oObjects,"Hench")==0)&&(GetLocalString(oObjects,"Master")==sMaster)){SetImmortal(oObjects,FALSE);SetPlotFlag(oObjects,FALSE);AssignCommand(oObjects,SetIsDestroyable(TRUE,FALSE,FALSE));DestroyObject(oObjects);}
oObjects = GetNextObjectInArea(oArea);
   }
DeleteLocalInt(oGoldbag,sPlanet+"&BoardPriv");
DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&Interests");
while(j<10){j++;DeletePersistentVariable(oModule,sPlanet+"&"+sArea+IntToString(j));DeleteLocalString(oGoldbag,sPlanet+"&"+sArea+IntToString(j));DeleteLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(j)+"Counter");DeleteLocalInt(oGoldbag,sPlanet+"&"+sArea+"&Rent&"+IntToString(j));i=0;while(i<9){i++;DeleteLocalInt(oGoldbag,sPlanet+"&"+sArea+IntToString(j)+"Counter"+IntToString(i));DeleteLocalInt(oGoldbag,sPlanet+"&"+sArea+"&DomainLink&"+IntToString(j)+IntToString(i));}}
  }
 }
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
}
