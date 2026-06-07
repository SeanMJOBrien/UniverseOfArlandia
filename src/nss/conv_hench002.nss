void main()
{
object oPC = GetPCSpeaker();
int iHenchsPrice = GetLocalInt(oPC,"Price");

TakeGoldFromCreature(iHenchsPrice,oPC,TRUE);

SetLocalObject(oPC,"Hench",OBJECT_SELF);
SetLocalInt(oPC,"HenchAction",1);

ExecuteScript("henchs",oPC);
}
