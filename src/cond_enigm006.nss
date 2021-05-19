int StartingConditional()
{
object oPC = GetPCSpeaker();
int iCheckCode = GetLocalInt(oPC,"CheckCode");

if(iCheckCode==1){return TRUE;}else{return FALSE;}
}
