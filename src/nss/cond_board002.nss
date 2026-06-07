int StartingConditional()
{
object oPC = GetPCSpeaker();

if(GetIsDM(oPC)){return TRUE;}else{return FALSE;}
}
