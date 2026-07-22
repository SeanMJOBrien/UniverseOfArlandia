int StartingConditional()
{
object oPC = GetMaster();
string sTag = GetTag(OBJECT_SELF);

if(((sTag=="henchani009")||(sTag=="hench000")||(sTag=="adventurer"))&&(GetIsObjectValid(oPC))){return TRUE;}else{return FALSE;}
}
