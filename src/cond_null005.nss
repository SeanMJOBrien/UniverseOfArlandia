int StartingConditional()
{
object oPC = GetPCSpeaker();
int iBoard = GetLocalInt(oPC,"Board");

if(iBoard==2){return TRUE;}else{return FALSE;}
}
