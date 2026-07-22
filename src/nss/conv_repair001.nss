#include "aps_include"
#include "_string_utils"

void main()
{
object oPC = GetPCSpeaker();
object oItem = GetLocalObject(oPC,"oItem");
object oTarget = GetLocalObject(oPC,"oTarget");
string sBP = GetLocalString(oTarget,"Master");
// Drop the "Broken " prefix, then any stale " NN%" wear suffix so the repaired
// item shows its restored (full) condition instead of the % it broke at.
string sName = StripWearSuffix(GetStringRight(GetName(oTarget),GetStringLength(GetName(oTarget))-7));
string sVar = GetLocalString(oTarget,"Var");
string sBonus = GetLocalString(oTarget,"Bonus");
int iPrice = GetLocalInt(oTarget,"Fix");
object oNew;

if(GetStringLeft(GetTag(oTarget),6)=="broken")
 {
oNew = CreateItemOnObject(sBP,oPC);
if(GetName(oNew)!=sName){SetName(oNew,sName);}if(FindSubString(sName,"(Quality")!=-1){AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyQuality(IP_CONST_QUALITY_EXCELLENT),oNew);}
SetIdentified(oNew,TRUE);
SetLocalString(oNew,"Var",sVar);
SetLocalString(oNew,"Bonus",sBonus);
DestroyObject(oTarget);
 }
else
 {
DeleteLocalInt(oTarget,"Wear");
DeleteLocalInt(oTarget,"Wear%");
// Item is back to full condition - remove the stale wear-% suffix from its name.
SetName(oTarget,StripWearSuffix(GetName(oTarget)));
 }

TakeGoldFromCreature(iPrice,oPC,TRUE);
FloatingTextStringOnCreature("item fixed",oPC,FALSE);
if(GetItemCharges(oItem)==1){DestroyObject(oItem);}else{SetItemCharges(oItem,GetItemCharges(oItem)-1);}
}
