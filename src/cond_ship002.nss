int StartingConditional()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);
string sArea = GetTag(oArea);
string sItemTag = GetLocalString(oPC,"shiptool");

if((sItemTag=="tool_airship")&&(GetStringLeft(sArea,6)=="clouds")){return TRUE;}else{return FALSE;}
}
