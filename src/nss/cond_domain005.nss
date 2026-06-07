int StartingConditional()
{
object oPC = GetPCSpeaker();
string sName = GetName(oPC);
string sTag = GetTag(OBJECT_SELF);
string sMaster = GetLocalString(OBJECT_SELF,"Master");

if((sTag=="structureflag")&&(sMaster==sName)){return TRUE;}else{return FALSE;}
}
