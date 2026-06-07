int StartingConditional()
{
string sTag = GetTag(OBJECT_SELF);
object oArea = GetArea(OBJECT_SELF);

if((GetIsObjectValid(GetMaster()))&&(sTag=="henchani012")&&(!GetIsAreaInterior(oArea))){return TRUE;}else{return FALSE;}
}
