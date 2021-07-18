int StartingConditional()
{
object oPC = GetMaster();
string sTag = GetTag(OBJECT_SELF);

if((sTag=="hench001")&&(GetIsObjectValid(oPC))){return TRUE;}else{return FALSE;}
}
