#include "_module"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = OBJECT_SELF;
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oObject;object oNew;string sBP;int iValue;int iWear;int iWearTot;int iFix;int i;int j;
////////////////////////////////////////////////////////////////////////////////
if(GetIsInCombat(oPC)){i = 10;}else{i = 1;}

while(j<12)
 {
j++;
     if(j==1) {oObject = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);sBP = "brokenitem";}
else if(j==2) {oObject = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);sBP = "brokenitem";}
else if(j==3) {oObject = GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);sBP = "brokenitem";}
else if(j==4) {oObject = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);sBP = "brokenitem";}
else if(j==5) {oObject = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);sBP = "brokenarmor";}
else if(j==6) {oObject = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);sBP = "brokenitem";}
else if(j==7) {oObject = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);sBP = "brokenhelmet";}
else if(j==8) {oObject = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);sBP = "brokenitem";if((GetBaseItemType(oObject)==BASE_ITEM_LARGESHIELD)||(GetBaseItemType(oObject)==BASE_ITEM_SMALLSHIELD)||(GetBaseItemType(oObject)==BASE_ITEM_TOWERSHIELD)){sBP = "brokenshield";}else if((GetBaseItemType(oObject)==BASE_ITEM_BASTARDSWORD)||(GetBaseItemType(oObject)==BASE_ITEM_BATTLEAXE)||(GetBaseItemType(oObject)==BASE_ITEM_CBLUDGWEAPON)||(GetBaseItemType(oObject)==BASE_ITEM_CLUB)||(GetBaseItemType(oObject)==BASE_ITEM_CPIERCWEAPON)||(GetBaseItemType(oObject)==BASE_ITEM_CSLASHWEAPON)||(GetBaseItemType(oObject)==BASE_ITEM_CSLSHPRCWEAP)||(GetBaseItemType(oObject)==BASE_ITEM_DAGGER)||(GetBaseItemType(oObject)==BASE_ITEM_DIREMACE)||(GetBaseItemType(oObject)==BASE_ITEM_DOUBLEAXE)||(GetBaseItemType(oObject)==BASE_ITEM_DWARVENWARAXE)||(GetBaseItemType(oObject)==BASE_ITEM_GREATAXE)||(GetBaseItemType(oObject)==BASE_ITEM_GREATSWORD)||(GetBaseItemType(oObject)==BASE_ITEM_HALBERD)||(GetBaseItemType(oObject)==BASE_ITEM_HANDAXE)||(GetBaseItemType(oObject)==BASE_ITEM_HEAVYCROSSBOW)||(GetBaseItemType(oObject)==BASE_ITEM_HEAVYFLAIL)||(GetBaseItemType(oObject)==BASE_ITEM_KAMA)||(GetBaseItemType(oObject)==BASE_ITEM_KATANA)||(GetBaseItemType(oObject)==BASE_ITEM_KUKRI)||(GetBaseItemType(oObject)==BASE_ITEM_LIGHTCROSSBOW)||(GetBaseItemType(oObject)==BASE_ITEM_LIGHTFLAIL)||(GetBaseItemType(oObject)==BASE_ITEM_LIGHTHAMMER)||(GetBaseItemType(oObject)==BASE_ITEM_LIGHTMACE)||(GetBaseItemType(oObject)==BASE_ITEM_LONGBOW)||(GetBaseItemType(oObject)==BASE_ITEM_LONGSWORD)||(GetBaseItemType(oObject)==BASE_ITEM_MORNINGSTAR)||(GetBaseItemType(oObject)==BASE_ITEM_QUARTERSTAFF)||(GetBaseItemType(oObject)==BASE_ITEM_RAPIER)||(GetBaseItemType(oObject)==BASE_ITEM_SCIMITAR)||(GetBaseItemType(oObject)==BASE_ITEM_SCYTHE)||(GetBaseItemType(oObject)==BASE_ITEM_SHORTBOW)||(GetBaseItemType(oObject)==BASE_ITEM_SHORTSPEAR)||(GetBaseItemType(oObject)==BASE_ITEM_SHORTSWORD)||(GetBaseItemType(oObject)==BASE_ITEM_SICKLE)||(GetBaseItemType(oObject)==BASE_ITEM_SLING)||(GetBaseItemType(oObject)==BASE_ITEM_TRIDENT)||(GetBaseItemType(oObject)==BASE_ITEM_TWOBLADEDSWORD)||(GetBaseItemType(oObject)==BASE_ITEM_WARHAMMER)||(GetBaseItemType(oObject)==BASE_ITEM_WHIP)){sBP = "brokenweapon";}}
else if(j==9) {oObject = GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC);sBP = "brokenitem2";}
else if(j==10){oObject = GetItemInSlot(INVENTORY_SLOT_NECK,oPC);sBP = "brokenitem";}
else if(j==11){oObject = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);sBP = "brokenitem";if((GetBaseItemType(oObject)==BASE_ITEM_LARGESHIELD)||(GetBaseItemType(oObject)==BASE_ITEM_SMALLSHIELD)||(GetBaseItemType(oObject)==BASE_ITEM_TOWERSHIELD)){sBP = "brokenshield";}else if((GetBaseItemType(oObject)==BASE_ITEM_BASTARDSWORD)||(GetBaseItemType(oObject)==BASE_ITEM_BATTLEAXE)||(GetBaseItemType(oObject)==BASE_ITEM_CBLUDGWEAPON)||(GetBaseItemType(oObject)==BASE_ITEM_CLUB)||(GetBaseItemType(oObject)==BASE_ITEM_CPIERCWEAPON)||(GetBaseItemType(oObject)==BASE_ITEM_CSLASHWEAPON)||(GetBaseItemType(oObject)==BASE_ITEM_CSLSHPRCWEAP)||(GetBaseItemType(oObject)==BASE_ITEM_DAGGER)||(GetBaseItemType(oObject)==BASE_ITEM_DIREMACE)||(GetBaseItemType(oObject)==BASE_ITEM_DOUBLEAXE)||(GetBaseItemType(oObject)==BASE_ITEM_DWARVENWARAXE)||(GetBaseItemType(oObject)==BASE_ITEM_GREATAXE)||(GetBaseItemType(oObject)==BASE_ITEM_GREATSWORD)||(GetBaseItemType(oObject)==BASE_ITEM_HALBERD)||(GetBaseItemType(oObject)==BASE_ITEM_HANDAXE)||(GetBaseItemType(oObject)==BASE_ITEM_HEAVYCROSSBOW)||(GetBaseItemType(oObject)==BASE_ITEM_HEAVYFLAIL)||(GetBaseItemType(oObject)==BASE_ITEM_KAMA)||(GetBaseItemType(oObject)==BASE_ITEM_KATANA)||(GetBaseItemType(oObject)==BASE_ITEM_KUKRI)||(GetBaseItemType(oObject)==BASE_ITEM_LIGHTCROSSBOW)||(GetBaseItemType(oObject)==BASE_ITEM_LIGHTFLAIL)||(GetBaseItemType(oObject)==BASE_ITEM_LIGHTHAMMER)||(GetBaseItemType(oObject)==BASE_ITEM_LIGHTMACE)||(GetBaseItemType(oObject)==BASE_ITEM_LONGBOW)||(GetBaseItemType(oObject)==BASE_ITEM_LONGSWORD)||(GetBaseItemType(oObject)==BASE_ITEM_MORNINGSTAR)||(GetBaseItemType(oObject)==BASE_ITEM_QUARTERSTAFF)||(GetBaseItemType(oObject)==BASE_ITEM_RAPIER)||(GetBaseItemType(oObject)==BASE_ITEM_SCIMITAR)||(GetBaseItemType(oObject)==BASE_ITEM_SCYTHE)||(GetBaseItemType(oObject)==BASE_ITEM_SHORTBOW)||(GetBaseItemType(oObject)==BASE_ITEM_SHORTSPEAR)||(GetBaseItemType(oObject)==BASE_ITEM_SHORTSWORD)||(GetBaseItemType(oObject)==BASE_ITEM_SICKLE)||(GetBaseItemType(oObject)==BASE_ITEM_SLING)||(GetBaseItemType(oObject)==BASE_ITEM_TRIDENT)||(GetBaseItemType(oObject)==BASE_ITEM_TWOBLADEDSWORD)||(GetBaseItemType(oObject)==BASE_ITEM_WARHAMMER)||(GetBaseItemType(oObject)==BASE_ITEM_WHIP)){sBP = "brokenweapon";}}
else if(j==12){oObject = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC);sBP = "brokenitem2";}

// Torch
if(GetTag(oObject)=="NW_IT_TORCH001")
  {
SetLocalInt(oObject,"Wear",GetLocalInt(oObject,"Wear")+1);SetLocalInt(oObject,"Wear%",100-(GetLocalInt(oObject,"Wear")*100/(iTorch*12)));

if(GetLocalInt(oObject,"Wear")>=iTorch*12)
   {
DestroyObject(oObject);
FloatingTextStringOnCreature("Your torch has burned out",oPC);
   }
  }
// Others
else if((GetStringLeft(GetTag(oObject),4)!="tool")&&(GetTag(oObject)!="racialproperties"))
  {
if(FindSubString(GetName(oObject),"(Quality")!=-1){SetLocalInt(oObject,"Wear",GetLocalInt(oObject,"Wear")+(i/2));}else{SetLocalInt(oObject,"Wear",GetLocalInt(oObject,"Wear")+i);}
iValue = GetGoldPieceValue(oObject);if(iValue<iCatA){iWearTot = iWearA;iFix = iFixA;}else if(iValue<iCatB){iWearTot = iWearB;iFix = iFixB;}else if(iValue<iCatC){iWearTot = iWearC;iFix = iFixC;}else if(iValue<iCatD){iWearTot = iWearD;iFix = iFixD;}else{iWearTot = iWearE;iFix = iFixE;}if(GetTag(oObject)=="NW_IT_TORCH001"){iWearTot = iTorch*12;}iWear = GetLocalInt(oObject,"Wear");iWear = 100-(iWear*100/(576*iWearTot));
SetLocalInt(oObject,"Wear%",iWear);
SetLocalInt(oObject,"Fix",iValue*iFix/100);

if(GetLocalInt(oObject,"Wear")>=(iWear*576))
   {
oNew = CreateItemOnObject(sBP,oPC);SetName(oNew,"Broken "+GetName(oObject));SetLocalInt(oNew,"Fix",iValue*iFix/100);SetLocalInt(oNew,"Wear%",100);SetLocalString(oNew,"Master",GetResRef(oObject));SetLocalString(oNew,"Var",GetLocalString(oObject,"Var"));SetLocalString(oNew,"Bonus",GetLocalString(oObject,"Bonus"));SetPlotFlag(oObject,FALSE);DestroyObject(oObject);FloatingTextStringOnCreature("item broken",oPC);
// First
int a = 22;int b;if(GetLocalInt(oGoldbag,"Uoabook"+IntToString(a))!=1){SetLocalInt(oGoldbag,"Uoabook"+IntToString(a),1);while(b<iUOAreferences){b++;SetLocalInt(oPC,"ChoiceDone"+IntToString(b),1);}DeleteLocalInt(oPC,"ChoiceDone"+IntToString(a));DelayCommand(2.0,AssignCommand(oPC,ActionStartConversation(oPC,"uoa",TRUE,FALSE)));}
   }
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
