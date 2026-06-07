////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLocalObject(OBJECT_SELF,"PC");
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sTag = GetStringRight(GetTag(OBJECT_SELF),1);
object oItem = GetFirstItemInInventory(OBJECT_SELF);
string sItemBP;string sItemTag;string sItemName;string sItemStack;string sItemMaster;string sItemWear;string sItemWear2;string sItemFix;string sItemBonus;string sItemVar;string sItemCharges;string sItemID;string sAll;string sVar;string sCount;int i;
////////////////////////////////////////////////////////////////////////////////
if((sTag=="3")||(sTag=="4"))
 {
while(GetIsObjectValid(oItem))
  {
i++;
SetLocalString(oModule,sPlanet+sArea+"Desk"+sTag+"ItemBP"+IntToString(i),GetResRef(oItem));
SetLocalString(oModule,sPlanet+sArea+"Desk"+sTag+"ItemStack"+IntToString(i),IntToString(GetItemStackSize(oItem)));

DestroyObject(oItem);
oItem = GetNextItemInInventory(OBJECT_SELF);
  }
 }
////////////////////////////////////////////////////////////////////////////////
else
 {
//
while(GetIsObjectValid(oItem))
  {
sItemBP = GetResRef(oItem);
sItemTag = GetTag(oItem);
sItemName = GetName(oItem);
sItemStack = IntToString(GetItemStackSize(oItem));
sItemMaster = GetLocalString(oItem,"Master");
sItemWear = IntToString(GetLocalInt(oItem,"Wear"));
sItemVar = GetLocalString(oItem,"Var");
sItemCharges = IntToString(GetItemCharges(oItem));
sItemBonus = GetLocalString(oItem,"Bonus");
sItemWear = IntToString(GetLocalInt(oItem,"Wear"));
sItemWear2 = IntToString(GetLocalInt(oItem,"Wear%"));
sItemFix = IntToString(GetLocalInt(oItem,"Fix"));
sItemID = IntToString(GetIdentified(oItem));
sAll = sItemBP+"_A_"+sItemTag+"_B_"+sItemName+"_C_"+sItemStack+"_D_"+sItemMaster+"_E_"+sItemWear+"_F_"+sItemVar+"_G_"+sItemCharges+"_H_"+sItemBonus+"_I_"+sItemWear+"_J_"+sItemWear2+"_K_"+sItemFix+"_L_"+sItemID+"_M_";

i++;
sCount = IntToString(i);if(i<10){sCount = "00"+IntToString(i);}else if(i<100){sCount = "0"+IntToString(i);}sCount = "&"+sCount+"&";
sVar = sVar+sAll+sCount;

DestroyObject(oItem);
oItem = GetNextItemInInventory(OBJECT_SELF);
  }
SetLocalString(oGoldbag,sPlanet+sArea+"Chest"+sTag,sVar);
//
SetLocalInt(OBJECT_SELF,"Closing",1);DelayCommand(0.2,DeleteLocalInt(OBJECT_SELF,"Closing"));SetLocked(OBJECT_SELF,TRUE);SpeakString("Locked");
 }
////////////////////////////////////////////////////////////////////////////////
}
