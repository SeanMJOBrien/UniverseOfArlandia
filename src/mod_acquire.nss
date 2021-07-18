#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetModuleItemAcquiredBy();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oItem = GetModuleItemAcquired();
string sItemTag = GetTag(oItem);
string sItemName = GetName(oItem);
object oArea = GetArea(oPC);
object oPCs = GetFirstPC();
object oMaster = GetMaster(oPC);
string sMaster = GetLocalString(oPC,"Master");
//
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}
int iItem;
////////////////////////////////////////////////////////////////////////////////
// PCS
if(((GetIsPC(oPC))||(GetIsDM(oPC))))
 {
////////////////////////////////////////////////////////////////////////////////
// Shop Players
if(GetLocalInt(oPC,"Seller")==1)
  {
iItem = GetGoldPieceValue(oItem)*3/4;
sMaster = GetLocalString(oItem,"Master");
SetPersistentInt(oModule,"Sold_"+sMaster+"_"+sPlanet+"_"+sArea,GetPersistentInt(oModule,"Sold_"+sMaster+"_"+sPlanet+"_"+sArea)+iItem);
DeleteLocalString(oItem,"Master");
SetName(oItem,GetStringLeft(sItemName,FindSubString(sItemName," (")));
  }
////////////////////////////////////////////////////////////////////////////////
// Domain school xps bonus when buying a talent
if((GetStringLeft(sItemTag,4)=="tal_")&&(GetStringLeft(GetTag(oArea),8)=="h_school")&&(GetLocalInt(oItem,"XpGiven")!=1))
 {
int n;int iXP = 50;object oMember = GetFirstFactionMember(oPC);string sGuild = GetLocalString(oGoldbag,"Guild");int iGuild = GetLocalInt(oGoldbag,"GuildMB");if(iGuild>0){while(GetIsObjectValid(oMember)){if((GetLocalString(GetItemPossessedBy(oMember,"goldbag"),"Guild")==sGuild)&&(GetArea(oMember)==GetArea(oPC))&&(GetDistanceBetween(oMember,oPC)<=50.0)){n++;}oMember = GetNextFactionMember(oPC);}if(n>=iDomainGuildMin){if(GetLocalInt(oGoldbag,"GuildLevel")>=3){iXP = iXP*(100+iDomainGuildXP3)/100;}else{iXP = iXP*(100+iDomainGuildXP1)/100;}}}
SetLocalInt(oItem,"XpGiven",1);GiveXPToCreature(oPC,iXP);FloatingTextStringOnCreature(IntToString(iXP)+" xps",oPC);
 }
////////////////////////////////////////////////////////////////////////////////
// Enigm items
if(GetLocalInt(oItem,"Enigm")==1){SetLocalInt(oGoldbag,"Enigm",GetLocalInt(oGoldbag,"Enigm")+1);}
////////////////////////////////////////////////////////////////////////////////
// Missions items
if(GetStringRight(GetName(oItem),1)=="*"){SetLocalObject(oPC,"MissionObject",oItem);SetLocalInt(oPC,"MissionToPlace",2);ExecuteScript("missions",oPC);}
////////////////////////////////////////////////////////////////////////////////
DeleteLocalInt(oItem,"DontSave");
 }
////////////////////////////////////////////////////////////////////////////////
// NPCs
else
 {
// Ox
if((GetIsObjectValid(oItem))&&(GetTag(oPC)=="henchani009")&&(GetCurrentHitPoints(oPC)>0)&&(GetLocalInt(oPC,"HenchRecall")!=1)){if(GetIsObjectValid(GetMaster(oPC))){oPCs = GetMaster(oPC);}else{while(GetIsObjectValid(oPCs)){if(GetName(oPCs)==sMaster){break;}oPCs = GetNextPC();}}SetLocalObject(oPCs,"Hench",oPC);SetLocalInt(oPCs,"HenchAction",6);ExecuteScript("henchs",oPCs);}
// Henchs casern
else if((GetIsObjectValid(oItem))&&(GetTag(oPC)=="hench000")&&(GetCurrentHitPoints(oPC)>0)&&(GetLocalInt(oPC,"HenchRecall")!=1)){if(GetIsObjectValid(oMaster)){oPCs = oMaster;}else{while(GetIsObjectValid(oPCs)){if(GetName(oPCs)==sMaster){break;}oPCs = GetNextPC();}}SetLocalObject(oPCs,"Hench",oPC);SetLocalInt(oPCs,"HenchAction",13);ExecuteScript("henchs",oPCs);}
// Falcon
else if((GetTag(oPC)=="henchani012")&&(GetLocalString(oPC,"Dest")!="")){SetLocalObject(oPC,"Item",oItem);ExecuteScript("falcon",oPC);}
 }
////////////////////////////////////////////////////////////////////////////////
DeleteLocalInt(oItem,"Persistent");
////////////////////////////////////////////////////////////////////////////////
}
