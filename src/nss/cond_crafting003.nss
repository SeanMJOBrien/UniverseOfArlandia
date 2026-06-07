int StartingConditional()
{
object oPC = GetPCSpeaker();
string sBonus = GetLocalString(oPC,"Bonus");

if(sBonus=="Immunity"){return TRUE;}else{return FALSE;}
}
