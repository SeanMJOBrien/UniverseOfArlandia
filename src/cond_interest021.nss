int StartingConditional()
{
object oPC = GetPCSpeaker();

if((GetLocalInt(OBJECT_SELF,"Player")==8)&&(GetLocalInt(OBJECT_SELF,"Round")==2)){return TRUE;}else{return FALSE;}
}
