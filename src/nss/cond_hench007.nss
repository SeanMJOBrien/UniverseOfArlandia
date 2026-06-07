int StartingConditional()
{
object oPC = GetMaster();
string sTag = GetTag(OBJECT_SELF);
string sLeftTag = GetStringLeft(sTag,8);
int iRightTag = StringToInt(GetStringRight(sTag,3));

if((sLeftTag=="henchani")&&(iRightTag<9)&&(GetIsObjectValid(oPC))){return TRUE;}else{return FALSE;}
}
