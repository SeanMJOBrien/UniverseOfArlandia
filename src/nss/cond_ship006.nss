int StartingConditional()
{
object oPC = GetPCSpeaker();
object oSpaceDung = GetNearestObject(OBJECT_TYPE_PLACEABLE,oPC);

if(GetStringLeft(GetTag(oSpaceDung),13)=="pla_spacedung"){return TRUE;}else{return FALSE;}
}
