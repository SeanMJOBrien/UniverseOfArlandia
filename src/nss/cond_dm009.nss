int StartingConditional()
{
object oPC = GetPCSpeaker();
object oArea = GetArea(oPC);

if(!GetIsAreaInterior(oArea)){return TRUE;}else{return FALSE;}
}
