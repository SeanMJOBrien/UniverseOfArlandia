void main()
{
object oPC = GetAttemptedAttackTarget();
object oItem = GetFirstItemInInventory(oPC);
object oVol;object oNew;int i;int j;int iRand1 = Random(30)+1;

     if(iRand1==1){i = INVENTORY_SLOT_ARMS;}
else if(iRand1==2){i = INVENTORY_SLOT_ARROWS;}
else if(iRand1==3){i = INVENTORY_SLOT_BELT;}
else if(iRand1==4){i = INVENTORY_SLOT_BOLTS;}
else if(iRand1==5){i = INVENTORY_SLOT_BOOTS;}
else if(iRand1==6){i = INVENTORY_SLOT_BULLETS;}
else if(iRand1==7){i = INVENTORY_SLOT_CARMOUR;}
else if(iRand1==8){i = INVENTORY_SLOT_CLOAK;}
else if(iRand1==9){i = INVENTORY_SLOT_CWEAPON_L;}
else if(iRand1==10){i = INVENTORY_SLOT_CWEAPON_R;}
else if(iRand1==11){i = INVENTORY_SLOT_HEAD;}
else if(iRand1==12){i = INVENTORY_SLOT_LEFTHAND;}
else if(iRand1==13){i = INVENTORY_SLOT_LEFTRING;}
else if(iRand1==14){i = INVENTORY_SLOT_NECK;}
else if(iRand1==15){i = INVENTORY_SLOT_RIGHTHAND;}
else if(iRand1==16){i = INVENTORY_SLOT_RIGHTRING;}

if(iRand1<17)
 {
oVol = GetItemInSlot(i,oPC);
 }
else if((iRand1>16)&&(iRand1<31))
 {
while(GetIsObjectValid(oItem))
  {
j++;SetLocalObject(OBJECT_SELF,GetName(oPC)+IntToString(j),oItem);
oItem = GetNextItemInInventory(oPC);
  }
oVol = GetLocalObject(OBJECT_SELF,GetName(oPC)+IntToString(Random(j)+1));
 }
if((GetMaster(oPC)==OBJECT_INVALID)&&(GetBaseItemType(oVol)!=BASE_ITEM_CREATUREITEM)&&(iRand1<31)&&(GetName(oVol)!="")&&(GetTag(oVol)!="goldbag")&&(GetTag(oVol)!="analyser")&&(GetTag(oVol)!="barbariankit")&&(GetTag(oVol)!="trapkit")&&(GetStringLeft(GetTag(oVol),4)!="dmfi")&&(GetStringLeft(GetTag(oVol),7)!="hlslang")&&(GetStringLeft(GetTag(oVol),6)!="cr_bag")&&(GetStringLeft(GetTag(oVol),6)!="cr_box")){oNew = CopyItem(oVol,OBJECT_SELF,TRUE);DeleteLocalInt(oNew,"DontSave");SetDroppableFlag(oNew,TRUE);DestroyObject(oVol,0.1);SetLocalObject(OBJECT_SELF,"oPC",oPC);ClearAllActions();DelayCommand(0.2,ActionMoveAwayFromObject(oPC,TRUE,60.0));}
}
