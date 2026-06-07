int StartingConditional()
{
object oPC = GetPCSpeaker();

if((GetLocalInt(OBJECT_SELF,"Player")==1)&&(GetLocalInt(oPC,"Success")==1)){return TRUE;}else{return FALSE;}
}

