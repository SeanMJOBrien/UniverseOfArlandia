int StartingConditional()
{
object oPC = GetPCSpeaker();

if((GetLocalString(OBJECT_SELF,"PC")!="")&&(GetLocalString(OBJECT_SELF,"PC")!=GetName(oPC))){return TRUE;}else{return FALSE;}
}
