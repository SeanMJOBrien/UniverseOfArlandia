void main()
{
object oPC = GetLastAttacker();

FloatingTextStringOnCreature("*puts some water on the fire*",oPC,TRUE);
DestroyObject(OBJECT_SELF,0.5);
}
