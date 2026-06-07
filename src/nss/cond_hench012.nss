int StartingConditional()
{
object oPC = GetMaster();
object oArea = GetArea(OBJECT_SELF);
string sTag = GetTag(OBJECT_SELF);
string sLeftTag = GetStringLeft(sTag,8);
int iRightTag = StringToInt(GetStringRight(sTag,3));

if((sLeftTag=="henchani")&&(iRightTag==11)&&(GetIsObjectValid(oPC))&&(!GetIsAreaInterior(oArea))){return TRUE;}else{return FALSE;}
}
