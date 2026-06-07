void main()
{
object oPC = GetPCSpeaker();
location lLoc = GetLocation(oPC);
SetLocalLocation(oPC,"Loc2",lLoc);
}
