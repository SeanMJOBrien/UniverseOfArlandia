void main()
{
object oPC = GetPCSpeaker();

SetLocalInt(oPC,"TalentAction",2);
ExecuteScript("talents",oPC);
}
