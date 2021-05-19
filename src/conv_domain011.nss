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
string sMaster = GetLocalString(oArea,"Master");
int iChoice1 = GetLocalInt(OBJECT_SELF,"Choice1");
int iPrice1 = GetLocalInt(OBJECT_SELF,"Price1");
int iPrice2 = GetLocalInt(OBJECT_SELF,"Price2");
//
int iLevel = GetLocalInt(oArea,"Level");
int iSlot = GetLocalInt(oArea,"Slot");
int iGain = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain");
////////////////////////////////////////////////////////////////////////////////
// Enter guild
if(iChoice1==1)
 {
SetLocalString(oGoldbag,"Guild",sMaster);
SetLocalInt(oGoldbag,"GuildMB",iDomainGuildMB*576);
SetLocalInt(oGoldbag,"GuildLevel",iLevel);FloatingTextStringOnCreature("Guild level : "+IntToString(iLevel),oPC);
TakeGoldFromCreature(iPrice1,oPC,TRUE);

     if(iLevel>=5){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iPrice1/1));}
else if(iLevel>=3){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iPrice1/2));}
 }
////////////////////////////////////////////////////////////////////////////////
// Renew membership
else if(iChoice1==2)
 {
SetLocalInt(oGoldbag,"GuildMB",iDomainGuildMB*576);
SetLocalInt(oGoldbag,"GuildLevel",iLevel);FloatingTextStringOnCreature("Guild level : "+IntToString(iLevel),oPC);
TakeGoldFromCreature(iPrice2,oPC,TRUE);

     if(iLevel>=5){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot),iGain+(iPrice2/1));}
else if(iLevel>=3){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot),iGain+(iPrice2/2));}
 }
////////////////////////////////////////////////////////////////////////////////
// Leave guild
else if(iChoice1==3)
 {
DeleteLocalString(oGoldbag,"Guild");
DeleteLocalInt(oGoldbag,"GuildMB");
DeleteLocalInt(oGoldbag,"GuildLevel");
 }
////////////////////////////////////////////////////////////////////////////////
}
