int StartingConditional()
{
object oPC = GetPCSpeaker();
object oOther = GetLocalObject(oPC,"oOther");

if(!GetIsPC(oOther)){return TRUE;}else{return FALSE;}
}
