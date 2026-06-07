int StartingConditional()
{
object oPC = GetPCSpeaker();
int iNull = GetLocalInt(oPC,"Null");

if(iNull==2){return TRUE;}else{return FALSE;}
}
