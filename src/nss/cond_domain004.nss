int StartingConditional()
{
object oPC = GetPCSpeaker();
string sName = GetName(oPC);
string sTag = GetTag(OBJECT_SELF);
string sMaster = GetLocalString(OBJECT_SELF,"Master");

if((sTag=="domaincontrol")&&((sMaster==sName)||(GetIsDM(oPC)))){return TRUE;}else{return FALSE;}
}
