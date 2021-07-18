int StartingConditional()
{
object oPC = GetPCSpeaker();
int iDomain = GetLocalInt(oPC,"Domain");

if(iDomain==1){return TRUE;}else{return FALSE;}
}
