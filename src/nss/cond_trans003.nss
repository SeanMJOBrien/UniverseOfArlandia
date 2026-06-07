int StartingConditional()
{
object oPC = GetPCSpeaker();
object oPass = GetItemPossessedBy(oPC,"starpass");

if(oPass==OBJECT_INVALID){return TRUE;}else{return FALSE;}
}
