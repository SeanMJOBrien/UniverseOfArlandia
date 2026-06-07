void main()
{
object oPC = GetPCSpeaker();
location lLoc = GetLocation(oPC);
SetLocalLocation(oPC,"Loc1",lLoc);
}
