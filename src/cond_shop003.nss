int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iPCInn = GetLocalInt(oGoldbag,"Inn");

if(iPCInn>0){return TRUE;}else{return FALSE;}
}
