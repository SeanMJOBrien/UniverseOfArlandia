#include "_module"
#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetModuleItemLostBy();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oItem = GetModuleItemLost();
string sItemTag = GetTag(oItem);
string sItemName = GetName(oItem);
object oArea = GetArea(oPC);
object oPCs = GetFirstPC();
object oMaster = GetMaster(oPC);
string sMaster = GetLocalString(oPC,"Master");
//
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}
int iItem;object oNew;
////////////////////////////////////////////////////////////////////////////////
// PCS
if(((GetIsPC(oPC))||(GetIsDM(oPC))))
 {
// Shop Players
if(GetLocalInt(oPC,"Seller")==1)
  {
iItem = GetGoldPieceValue(oItem)*3/4;
SetLocalString(oItem,"Master",GetName(oPC));
AssignCommand(oPC,TakeGoldFromCreature(iItem,oPC,TRUE));
  }
////////////////////////////////////////////////////////////////////////////////
// Enigm items
if(GetLocalInt(oItem,"Enigm")==1){SetLocalInt(oGoldbag,"Enigm",GetLocalInt(oGoldbag,"Enigm")-1);}
////////////////////////////////////////////////////////////////////////////////
// Furnitures
if((GetStringLeft(sItemTag,10)=="ofurniture")&&((GetName(oArea)=="Home")||(GetName(oArea)=="House"))&&(GetName(oPC)==GetLocalString(oArea,"Master"))){DeleteLocalInt(oPC,"Choice1");DeleteLocalInt(oPC,"Step");SetLocalInt(oPC,"PlaceFurniture",1);SetLocalObject(oPC,"Furniture",oItem);AssignCommand(oPC,ActionStartConversation(oPC,"furniture",TRUE,FALSE));}
////////////////////////////////////////////////////////////////////////////////
if(GetLocalInt(oGoldbag,"Start")==1){int a = 25;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}}
 }
////////////////////////////////////////////////////////////////////////////////
// NPCs
else
 {
// Ox
if((GetIsObjectValid(oItem))&&(GetTag(oPC)=="henchani009")&&(GetCurrentHitPoints(oPC)>0)){if(GetIsObjectValid(GetMaster(oPC))){SetLocalInt(oItem,"DontSave",1);oPCs = GetMaster(oPC);}else{while(GetIsObjectValid(oPCs)){if(GetName(oPCs)==sMaster){break;}oPCs = GetNextPC();}}SetLocalObject(oPCs,"Hench",oPC);SetLocalInt(oPCs,"HenchAction",6);ExecuteScript("henchs",oPCs);}
// Henchs casern
else if((GetIsObjectValid(oItem))&&(GetTag(oPC)=="hench000")&&(GetCurrentHitPoints(oPC)>0)&&(GetLocalInt(oPC,"HenchRecall")!=1)){if(GetIsObjectValid(oMaster)){oPCs = oMaster;}else{while(GetIsObjectValid(oPCs)){if(GetName(oPCs)==sMaster){break;}oPCs = GetNextPC();}}SetLocalObject(oPCs,"Hench",oPC);SetLocalInt(oPCs,"HenchAction",13);ExecuteScript("henchs",oPCs);}
// Falcon
else if((GetTag(oPC)=="henchani012")&&(GetLocalString(oPC,"Dest")!="")){SetLocalObject(oPC,"Item",oItem);ExecuteScript("falcon",oPC);}
 }
////////////////////////////////////////////////////////////////////////////////
}
