int StartingConditional()
{
object oPC = GetPCSpeaker();
object oGoldbag = GetItemPossessedBy(oPC,"goldbag");
object oArea = GetArea(OBJECT_SELF);
string sMaster = GetLocalString(oArea,"Master");
string sGuild = GetLocalString(oGoldbag,"Guild");

if(sGuild==sMaster){return TRUE;}else{return FALSE;}
}
