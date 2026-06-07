void main()
{
object oPC = OBJECT_SELF;

if(GetTag(GetArea(oPC))=="initialisation"){FloatingTextStringOnCreature("Trying in 30 sec again",oPC,FALSE);DelayCommand(30.0,ExecuteScript("000_transitions",oPC));DelayCommand(33.0,ExecuteScript("ini_check",oPC));}
}
