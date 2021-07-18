int StartingConditional()
{
object oPC = GetPCSpeaker();

if((GetLocalInt(OBJECT_SELF,"Player")==8)&&(GetIsObjectValid(GetItemPossessedBy(oPC,"lostshield")))&&(GetLocalInt(OBJECT_SELF,"Round")==1)){return TRUE;}else{return FALSE;}
}

