#include "aps_include"
#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLastClosedBy();
string sName = GetName(oPC);
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
object oItem = GetFirstItemInInventory();
string sMaster = GetLocalString(OBJECT_SELF,"Master");
int iGold = GetGold(oPC);
//
string sVar = GetPersistentString(oModule,sPlanet+"&"+sArea+"&Mailbox");if(sName==sMaster){sVar = "";}
int iVar = StringToInt(GetStringLeft(GetStringRight(sVar,4),3));
//
int iCheck;string sPlanetDest;string sAreaDest;string sItemBP;string sItemTag;string sItemName;string sItemStack;string sItemMaster;string sItemWear;string sItemWear2;string sItemFix;string sItemBonus;string sItemVar;string sItemCharges;string sAll;string sCount;int iPrice;int i;int j;
////////////////////////////////////////////////////////////////////////////////
// Send mail
if(GetTag(OBJECT_SELF)=="mailbox_inv")
 {
sPlanetDest = GetLocalString(OBJECT_SELF,"MailPlanet");
sAreaDest = GetLocalString(OBJECT_SELF,"MailArea");
sVar = GetPersistentString(oModule,sPlanetDest+"&"+sAreaDest+"&Mailbox");
if(sPlanetDest==sPlanet){iPrice = 5;}else{iPrice = 20;}

while(GetIsObjectValid(oItem))
  {
sItemBP = GetResRef(oItem);
sItemTag = GetTag(oItem);
sItemName = GetName(oItem);
sItemStack = IntToString(GetItemStackSize(oItem));
sItemMaster = GetLocalString(oItem,"Master");
sItemWear = IntToString(GetLocalInt(oItem,"Wear"));
sItemWear2 = IntToString(GetLocalInt(oItem,"Wear%"));
sItemFix = IntToString(GetLocalInt(oItem,"Fix"));
sItemVar = GetLocalString(oItem,"Var");
sItemCharges = IntToString(GetItemCharges(oItem));
sItemBonus = GetLocalString(oItem,"Bonus");
sAll = sItemBP+"_A_"+sItemTag+"_B_"+sItemName+"_C_"+sItemStack+"_D_"+sItemMaster+"_E_"+sItemWear+"_F_"+sItemWear2+"_G_"+sItemFix+"_H_"+sItemVar+"_I_"+sItemCharges+"_J_"+sItemBonus+"_K_";

if(iGold>=iPrice)
   {
i++;
sCount = IntToString(i);if(i<10){sCount = "00"+IntToString(i);}else if(i<100){sCount = "0"+IntToString(i);}sCount = "&"+sCount+"&";
sVar = sVar+sAll+sCount;
iGold = iGold-iPrice;
   }
else
   {
j++;
CopyItem(oItem,oPC,TRUE);
   }
DestroyObject(oItem);
oItem = GetNextItemInInventory();
  }
if(i>0){SetPersistentString(oModule,sPlanetDest+"&"+sAreaDest+"&Mailbox",sVar);TakeGoldFromCreature(iPrice,oPC,TRUE);}
if(j>0){FloatingTextStringOnCreature("not enough money to send all the mail",oPC);}
DestroyObject(OBJECT_SELF,0.2);
 }
////////////////////////////////////////////////////////////////////////////////
// Save mail
else
 {
i = iVar;
while(GetIsObjectValid(oItem))
  {
sItemBP = GetResRef(oItem);
sItemTag = GetTag(oItem);
sItemName = GetName(oItem);
sItemStack = IntToString(GetItemStackSize(oItem));
sItemMaster = GetLocalString(oItem,"Master");
sItemWear = IntToString(GetLocalInt(oItem,"Wear"));
sItemWear2 = IntToString(GetLocalInt(oItem,"Wear%"));
sItemFix = IntToString(GetLocalInt(oItem,"Fix"));
sItemVar = GetLocalString(oItem,"Var");
sItemCharges = IntToString(GetItemCharges(oItem));
sItemBonus = GetLocalString(oItem,"Bonus");
sAll = sItemBP+"_A_"+sItemTag+"_B_"+sItemName+"_C_"+sItemStack+"_D_"+sItemMaster+"_E_"+sItemWear+"_F_"+sItemWear2+"_G_"+sItemFix+"_H_"+sItemVar+"_I_"+sItemCharges+"_J_"+sItemBonus+"_K_";

if(i<iDomainMailItems)
   {
i++;
sCount = IntToString(i);if(i<10){sCount = "00"+IntToString(i);}else if(i<100){sCount = "0"+IntToString(i);}sCount = "&"+sCount+"&";
sVar = sVar+sAll+sCount;
   }
else
   {
CopyItem(oItem,oPC,TRUE);iCheck = 1;
   }
DestroyObject(oItem);
oItem = GetNextItemInInventory();
  }
if(sVar!=""){SetPersistentString(oModule,sPlanet+"&"+sArea+"&Mailbox",sVar);}else{DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&Mailbox");}
if(iCheck==1){FloatingTextStringOnCreature("mailbox full",oPC);}
 }
////////////////////////////////////////////////////////////////////////////////
}
