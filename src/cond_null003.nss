int StartingConditional()
{
object oPC = GetPCSpeaker();
object oScroll = GetLocalObject(oPC,"Scroll");

if(GetIsObjectValid(oScroll)){return TRUE;}else{return FALSE;}
}
