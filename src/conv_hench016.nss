void main()
{
object oPC = GetPCSpeaker();

SetLocalObject(oPC,"Hench",OBJECT_SELF);
SetLocalInt(oPC,"HenchAction",12);

ExecuteScript("henchs",oPC);
}
