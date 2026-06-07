////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetPCItemLastEquippedBy();
object oItem = GetPCItemLastEquipped();
object oArea = GetArea(oPC);
string sBP = GetLocalString(oItem,"Bonus");if((GetStringRight(sBP,3)==" +1")||(GetStringRight(sBP,3)==" +2")||(GetStringRight(sBP,3)==" +3")){sBP = GetStringLeft(sBP,GetStringLength(sBP)-3);}
object oItem2;string sBP2;int iSlot;int i;
////////////////////////////////////////////////////////////////////////////////
// Equip magic items
if(sBP!="")
 {
while(i<15)
  {
i++;
if(i==1){iSlot = INVENTORY_SLOT_ARMS;}
if(i==2){iSlot = INVENTORY_SLOT_BELT;}
if(i==3){iSlot = INVENTORY_SLOT_BOOTS;}
if(i==4){iSlot = INVENTORY_SLOT_CARMOUR;}
if(i==5){iSlot = INVENTORY_SLOT_CHEST;}
if(i==6){iSlot = INVENTORY_SLOT_CLOAK;}
if(i==7){iSlot = INVENTORY_SLOT_CWEAPON_B;}
if(i==8){iSlot = INVENTORY_SLOT_CWEAPON_L;}
if(i==9){iSlot = INVENTORY_SLOT_CWEAPON_R;}
if(i==10){iSlot = INVENTORY_SLOT_HEAD;}
if(i==11){iSlot = INVENTORY_SLOT_LEFTHAND;}
if(i==12){iSlot = INVENTORY_SLOT_LEFTRING;}
if(i==13){iSlot = INVENTORY_SLOT_NECK;}
if(i==14){iSlot = INVENTORY_SLOT_RIGHTHAND;}
if(i==15){iSlot = INVENTORY_SLOT_RIGHTRING;}

oItem2 = GetItemInSlot(iSlot,oPC);
sBP2 = GetLocalString(oItem2,"Bonus");if((GetStringRight(sBP2,3)==" +1")||(GetStringRight(sBP2,3)==" +2")||(GetStringRight(sBP2,3)==" +3")){sBP2 = GetStringLeft(sBP2,GetStringLength(sBP2)-3);}
if((oItem2!=oItem)&&(sBP2==sBP)){i = 20;break;}
  }
if(i==20){AssignCommand(oPC,ActionUnequipItem(oItem));FloatingTextStringOnCreature("you can't equip two items with the same magic properties",oPC);}
 }
////////////////////////////////////////////////////////////////////////////////
// Underwater
if((GetStringLeft(GetTag(oArea),10)=="underwater")&&(GetTag(oItem)=="NW_IT_TORCH001")){AssignCommand(oPC,ActionUnequipItem(oItem));FloatingTextStringOnCreature("no torch under water",oPC);}
////////////////////////////////////////////////////////////////////////////////
}
