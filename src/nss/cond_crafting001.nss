int StartingConditional()
{
object oPC = GetPCSpeaker();
string sBonus = GetLocalString(oPC,"Bonus");

if(sBonus=="Bonus Feat"){return TRUE;}else{return FALSE;}
}
