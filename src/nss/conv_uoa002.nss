#include "dmfi_dmw_inc"
#include "_module"
void main()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(oPC);
int iLevel = GetLocalInt(oArea,"Level");
int iLifePoints = GetLocalInt(oGoldbag,"LifePoints");
if((GetStringLeft(GetTag(oArea),6)=="temple")&&(iLevel>=4)){iXPLifePoints = iXPLifePoints/2;}

if(iLifePoints<0){iLifePoints = 0;DeleteLocalInt(oGoldbag,"LifePoints");}

SetCustomToken(10133,ColorText(IntToString(iXPLifePoints),"g"));
SetCustomToken(10134,ColorText(IntToString(iLifePoints),"g"));
}
