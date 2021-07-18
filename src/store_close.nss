#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLastClosedBy();
string sTag = GetTag(OBJECT_SELF);
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}
string sMaster = GetLocalString(OBJECT_SELF,"Master");
//
int iPrice = GetStoreGold(OBJECT_SELF);
int iLevel = GetLocalInt(oArea,"Level");
int iSlot = GetLocalInt(oArea,"Slot");
int iStructure = GetLocalInt(oArea,"Structure");
int iGain = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain");
int jTot = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&SaleShopTot");
//
object oItem = GetFirstItemInInventory();
string sItemBP;string sItemTag;string sItemName;string sItemStack;string sItemMaster;string sItemWear;string sItemWear2;string sItemFix;string sItemBonus;string sItemVar;string sItemValue;string sItemCharges;string sAll;string sVar;string sCount;int i;int j;
int iOpen = GetLocalInt(OBJECT_SELF,"Open")-1;
////////////////////////////////////////////////////////////////////////////////
// Player Shop
if(sTag=="store000")
 {
SetLocalInt(OBJECT_SELF,"Open",iOpen);

if(iOpen==0)
  {
while(GetIsObjectValid(oItem))
   {
sItemBP = GetResRef(oItem);
sItemTag = GetTag(oItem);
sItemName = GetName(oItem);if(GetStringRight(sItemName,2)=="%)"){sItemName = GetStringLeft(sItemName,FindSubString(sItemName," ("));}
sItemStack = IntToString(GetItemStackSize(oItem));
sItemMaster = GetLocalString(oItem,"Master");
sItemWear = IntToString(GetLocalInt(oItem,"Wear"));
sItemWear2 = IntToString(GetLocalInt(oItem,"Wear%"));if(sItemWear2=="0"){sItemWear2 = "100";}else if(StringToInt(sItemWear2)<0){sItemWear2 = "0";}
sItemFix = IntToString(GetLocalInt(oItem,"Fix"));
sItemVar = GetLocalString(oItem,"Var");
sItemCharges = IntToString(GetItemCharges(oItem));
sItemValue = IntToString(GetGoldPieceValue(oItem)*3/4);
sItemBonus = GetLocalString(oItem,"Bonus");
sAll = sItemBP+"_A_"+sItemTag+"_B_"+sItemName+"_C_"+sItemStack+"_D_"+sItemMaster+"_E_"+sItemWear+"_F_"+sItemWear2+"_G_"+sItemFix+"_H_"+sItemVar+"_I_"+sItemCharges+"_J_"+sItemValue+"_K_"+sItemBonus+"_L_";

i++;
sCount = IntToString(i);if(i<10){sCount = "00"+IntToString(i);}else if(i<100){sCount = "0"+IntToString(i);}sCount = "&"+sCount+"&";
sVar = sVar+sAll+sCount;

if(i>=10){j++;SetPersistentString(oModule,sPlanet+"&"+sArea+"&SaleShop"+IntToString(j),sVar);i=0;sVar = "";}

DestroyObject(oItem);
oItem = GetNextItemInInventory();
   }
if(i>=1){j++;SetPersistentString(oModule,sPlanet+"&"+sArea+"&SaleShop"+IntToString(j),sVar);}
SetPersistentInt(oModule,sPlanet+"&"+sArea+"&SaleShopTot",j);
if((i==0)&&(j==0)){DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&SaleShopTot");}
while(j<jTot){j++;DeletePersistentVariable(oModule,sPlanet+"&"+sArea+"&SaleShop"+IntToString(j));}
  }
 }
////////////////////////////////////////////////////////////////////////////////
// Other shops
else
 {
while(GetIsObjectValid(oItem))
  {
if(GetInfiniteFlag(oItem)==FALSE){DestroyObject(oItem);}
oItem = GetNextItemInInventory();
  }
// Domain shops
if((iLevel!=0)&&(iPrice!=-1))
  {
iPrice = iPrice-10000;
if(iPrice!=10000)
   {
if(GetName(oPC)!=sMaster)
   {
if(iStructure==15)
    {
     if(iLevel>=5){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iPrice/5));}
else if(iLevel>=3){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iPrice/10));}
     }
else
     {
     if(iLevel>=5){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iPrice/1));}
else if(iLevel>=3){SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Domain&"+IntToString(iSlot)+"Gain",iGain+(iPrice/2));}
     }
    }
SetStoreGold(OBJECT_SELF,10000);
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
DeleteLocalInt(oPC,"Seller");
////////////////////////////////////////////////////////////////////////////////
}
