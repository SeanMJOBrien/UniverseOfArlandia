#include "_module"
void main()
{
object oPC = GetPCSpeaker();
int iHench = GetLocalInt(OBJECT_SELF,"Hench");
// Random tavern/townhall adventurers (see area_recall.nss) are priced by
// level instead of the flat non-domain hench fee.
int iPrice = iHenchsPrice;if(GetTag(OBJECT_SELF)=="adventurer"){iPrice = 20*GetHitDice(OBJECT_SELF);}

if(iHench>1)
 {
SetCustomToken(10063,IntToString(iPrice));
SetLocalInt(oPC,"Price",iPrice);
 }
else
 {
DeleteLocalInt(oPC,"Price");
 }
}
