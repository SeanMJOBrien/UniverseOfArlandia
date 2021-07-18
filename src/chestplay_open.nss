////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
object oPC = GetLocalObject(OBJECT_SELF,"PC");
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sPlanet = GetLocalString(oArea,"Planet");
string sArea = GetLocalString(oArea,"Area");
string sMaster = GetLocalString(oArea,"Master");
string sTag = GetStringRight(GetTag(OBJECT_SELF),1);
string sVar = GetLocalString(oGoldbag,sPlanet+sArea+"Chest"+sTag);
int iVar = StringToInt(GetStringLeft(GetStringRight(sVar,4),3));
int iLevel = GetLocalInt(oArea,"Level");
//
object oNew;string sItemBP;string sItemTag;string sItemName;string sItemStack;string sItemMaster;string sItemWear;string sItemWear2;string sItemFix;string sItemBonus;string sItemVar;string sItemCharges;string sItemID;string sAll;string sCount1;string sCount2;int iRand1;int iRand2;int i;
////////////////////////////////////////////////////////////////////////////////
if((sTag=="3")||(sTag=="4"))
 {
if(GetLocalInt(oModule,sPlanet+sArea+"Desk"+sTag)==1)
  {
while(i<5)
   {
i++;
sItemBP = GetLocalString(oModule,sPlanet+sArea+"Desk"+sTag+"ItemBP"+IntToString(i));
sItemStack = GetLocalString(oModule,sPlanet+sArea+"Desk"+sTag+"ItemStack"+IntToString(i));

oNew = CreateItemOnObject(sItemBP,OBJECT_SELF,StringToInt(sItemStack));

DeleteLocalString(oModule,sPlanet+sArea+"Desk"+sTag+"ItemBP"+IntToString(i));
DeleteLocalString(oModule,sPlanet+sArea+"Desk"+sTag+"ItemStack"+IntToString(i));
   }
  }
else
  {
iRand1 = Random(5)+1;
while(iRand1>0)
   {
iRand2 = Random(5)+1;
     if(iRand2==1){sItemBP = "potion_wine";i = 1;}
else if(iRand2==2){sItemBP = "potion_ale";i = 3;}
else if(iRand2==3){sItemBP = "nw_it_torch001";i = 1;}
else if(iRand2==4){sItemBP = "nw_it_medkit001";i = 1;}
else if(iRand2==5){sItemBP = "customscroll";i = 1;}
oNew = CreateItemOnObject(sItemBP,OBJECT_SELF,i);
iRand1--;
   }
SetLocalInt(oModule,sPlanet+sArea+"Desk"+sTag,1);
  }
 }
////////////////////////////////////////////////////////////////////////////////
else
 {
////////////////////////////////////////////////////////////////////////////////
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
sItemVar = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_G_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_G_")))-FindSubString(sAll,"_F_")-3);
sItemCharges = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_H_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_H_")))-FindSubString(sAll,"_G_")-3);
sItemBonus = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_I_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_I_")))-FindSubString(sAll,"_H_")-3);
sItemWear = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_J_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_J_")))-FindSubString(sAll,"_I_")-3);
sItemWear2 = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_K_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_K_")))-FindSubString(sAll,"_J_")-3);
sItemFix = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_L_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_L_")))-FindSubString(sAll,"_K_")-3);
sItemID = GetStringRight(GetStringLeft(sAll,FindSubString(sAll,"_M_")),GetStringLength(GetStringLeft(sAll,FindSubString(sAll,"_M_")))-FindSubString(sAll,"_L_")-3);

oNew = CreateItemOnObject(sItemBP,OBJECT_SELF,StringToInt(sItemStack),sItemTag);
if(GetName(oNew)!=sItemName){SetName(oNew,sItemName);}if(FindSubString(sItemName,"(Quality")!=-1){AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyQuality(IP_CONST_QUALITY_EXCELLENT),oNew);}
SetLocalString(oNew,"Master",sItemMaster);
SetLocalString(oNew,"Var",sItemVar);
if(StringToInt(sItemCharges)>0){SetItemCharges(oNew,StringToInt(sItemCharges));}
SetLocalString(oNew,"Bonus",sItemBonus);if(sItemBonus!=""){ExecuteScript("bonus",oNew);}
SetLocalInt(oNew,"Wear",StringToInt(sItemWear));
SetLocalInt(oNew,"Wear%",StringToInt(sItemWear2));
SetLocalInt(oNew,"Fix",StringToInt(sItemFix));
SetIdentified(oNew,StringToInt(sItemID));
  }
////////////////////////////////////////////////////////////////////////////////
 }
////////////////////////////////////////////////////////////////////////////////
}
