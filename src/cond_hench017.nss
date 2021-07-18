int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
int iHorseHorde = GetLocalInt(oGoldbag,"Horse Horde");

if((GetIsObjectValid(GetMaster()))&&(iHorseHorde>0)){return TRUE;}else{return FALSE;}
}
