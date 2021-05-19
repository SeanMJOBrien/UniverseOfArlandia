#include "aps_include"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLastOpenedBy();
string sTag = GetTag(OBJECT_SELF);
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");if(FindSubString(sArea,"&")!=-1){sArea = GetStringLeft(sArea,FindSubString(sArea,"&"));}
//
int jTot = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&SaleShopTot");
string sVar;int iVar;string sItemBP;string sItemTag;string sItemName;string sItemStack;string sItemMaster;string sItemWear;string sItemWear2;string sItemFix;string sItemBonus;string sItemVar;string sItemValue;string sItemCharges;string sAll;string sCount1;string sCount2;int i;object oNew;
int iOpen = GetLocalInt(OBJECT_SELF,"Open")+1;
////////////////////////////////////////////////////////////////////////////////
// Player Shop
if(sTag=="store000")
 {
SendMessageToPC(oPC,"Player Shop Advice : Don't drop an item to the ground while you handle with the player shop !");
SetLocalInt(OBJECT_SELF,"Open",iOpen);

while(jTot>0)
  {
sVar = GetPersistentString(oModule,sPlanet+"&"+sArea+"&SaleShop"+IntToString(jTot));
iVar = StringToInt(GetStringLeft(GetStringRight(sVar,4),3));
i=0;

while(i<iVar)
   {
i++;
sCount1 = IntToString(i);if(i<10){sCount1 = "00"+IntToString(i);}else if(i<100){sCount1 = "0"+IntToString(i);}sCount1 = "&"+sCount1+"&";
sCount2 = IntToString(i-1);if((i-1)<10){sCount2 = "00"+IntToString(i-1);}else if((i-1)<100){sCount2 = "0"+IntToString(i-1);}sCount2 = "&"+sCount2+"&";

if(i==1){sAll = GetStringLeft(sVar,FindSubString(sVar,sCount1));}else{sAll = GetStringRight(GetStringLeft(sVar,FindSubString(sVar,sCount1)),GetStringLength(GetStringLeft(sVar,FindSubString(sVar,sCount1)))-FindSubString(sVar,sCount2)-5);}
sItemBP = GetStringLeft(sAll,FindSubString(sAll,"_A_"));
sItemTag = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_B_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_B_")))-FindSubString(sAll,"_A_")-3);
sItemName = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_C_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_C_")))-FindSubString(sAll,"_B_")-3);
sItemStack = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_D_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_D_")))-FindSubString(sAll,"_C_")-3);
sItemMaster = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_E_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_E_")))-FindSubString(sAll,"_D_")-3);
sItemWear = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_F_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_F_")))-FindSubString(sAll,"_E_")-3);
sItemWear2 = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_G_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_G_")))-FindSubString(sAll,"_F_")-3);
sItemFix = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_H_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_H_")))-FindSubString(sAll,"_G_")-3);
sItemVar = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_I_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_I_")))-FindSubString(sAll,"_H_")-3);
sItemCharges = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_J_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_J_")))-FindSubString(sAll,"_I_")-3);
sItemBonus = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_L_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_L_")))-FindSubString(sAll,"_K_")-3);

oNew = CreateItemOnObject(sItemBP,OBJECT_SELF,StringToInt(sItemStack),sItemTag);
SetName(oNew,sItemName+" ("+sItemWear2+"%)");if(FindSubString(sItemName,"(Quality")!=-1){AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyQuality(IP_CONST_QUALITY_EXCELLENT),oNew);}
SetLocalString(oNew,"Master",sItemMaster);
SetLocalInt(oNew,"Wear",StringToInt(sItemWear));
SetLocalInt(oNew,"Wear%",StringToInt(sItemWear2));
SetLocalInt(oNew,"Fix",StringToInt(sItemFix));
SetLocalString(oNew,"Var",sItemVar);
if(StringToInt(sItemCharges)>0){SetItemCharges(oNew,StringToInt(sItemCharges));}
SetLocalString(oNew,"Bonus",sItemBonus);if(sItemBonus!=""){ExecuteScript("bonus",oNew);}
SetIdentified(oNew,TRUE);
   }
jTot--;
  }
SetLocalInt(oPC,"Seller",1);
 }
////////////////////////////////////////////////////////////////////////////////
}
