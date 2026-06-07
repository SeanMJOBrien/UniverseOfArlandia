void main()
{
object oPC = GetPCSpeaker();

SetLocalObject(oPC,"Hench",OBJECT_SELF);
SetLocalInt(oPC,"HenchAction",4);

ExecuteScript("henchs",oPC);
DelayCommand(0.1,OpenInventory(OBJECT_SELF,oPC));
}
