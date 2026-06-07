int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
string sGuild = GetLocalString(oGoldbag,"Guild");

if(sGuild==""){return TRUE;}else{return FALSE;}
}
