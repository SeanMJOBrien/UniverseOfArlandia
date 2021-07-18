int StartingConditional()
{
object oPC = GetPCSpeaker();
string sBonus = GetLocalString(oPC,"Bonus");

if(sBonus=="Scroll_Wand"){return TRUE;}else{return FALSE;}
}
