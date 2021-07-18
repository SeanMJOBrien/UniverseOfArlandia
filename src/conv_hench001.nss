#include "_module"
void main()
{
object oPC = GetPCSpeaker();
int iHench = GetLocalInt(OBJECT_SELF,"Hench");

if(iHench>1)
 {
SetCustomToken(10063,IntToString(iHenchsPrice));
SetLocalInt(oPC,"Price",iHenchsPrice);
 }
else
 {
DeleteLocalInt(oPC,"Price");
 }
}
