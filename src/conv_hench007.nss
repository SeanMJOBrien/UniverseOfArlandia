void main()
{
object oPC = GetPCSpeaker();

SetLocalObject(oPC,"Hench",OBJECT_SELF);
SetLocalInt(oPC,"NoHorsePaladin",1);
SetLocalInt(oPC,"HenchAction",8);

ExecuteScript("henchs",oPC);
}
