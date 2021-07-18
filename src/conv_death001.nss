#include "dmfi_dmw_inc"
#include "_module"
void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iLifePoints = GetLocalInt(oGoldbag,"LifePoints");

if(iLifePoints<0){iLifePoints = 0;DeleteLocalInt(oGoldbag,"LifePoints");}

SetCustomToken(10133,IntToString(iXPlost));
}
