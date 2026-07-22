int StartingConditional()
{
object oPC = GetMaster();
string sTag = GetTag(OBJECT_SELF);

if((sTag=="hench001")||(sTag=="hench010")||(sTag=="adventurer")||(sTag=="hench020")&&(GetIsObjectValid(oPC))){return TRUE;}else{return FALSE;}
}

