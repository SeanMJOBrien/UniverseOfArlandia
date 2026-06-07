int StartingConditional()
{
object oArea = GetArea(OBJECT_SELF);
string sArea = GetLocalString(oArea,"Area");

if((GetTag(OBJECT_SELF)=="pilot2")||(sArea=="0_0")){return TRUE;}else{return FALSE;}
}
