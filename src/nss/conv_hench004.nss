void main()
{
object oPC = GetPCSpeaker();

SetLocalObject(oPC,"Hench",OBJECT_SELF);
SetLocalInt(oPC,"HenchAction",2);

ExecuteScript("henchs",oPC);
}
