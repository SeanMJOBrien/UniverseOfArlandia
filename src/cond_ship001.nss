int StartingConditional()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sArea = GetTag(oArea);
string sItemTag = GetLocalString(oPC,"shiptool");

if((sItemTag=="tool_ship")&&(GetStringLeft(sArea,5)=="ocean")){return TRUE;}else{return FALSE;}
}
