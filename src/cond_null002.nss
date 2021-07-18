int StartingConditional()
{
object oPC = GetPCSpeaker();
int iNull = GetLocalInt(oPC,"Null");

if(iNull==1){return TRUE;}else{return FALSE;}
}
