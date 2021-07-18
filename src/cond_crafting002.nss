int StartingConditional()
{
object oPC = GetPCSpeaker();
string sBonus = GetLocalString(oPC,"Bonus");

if(sBonus=="Bonus Skill"){return TRUE;}else{return FALSE;}
}
