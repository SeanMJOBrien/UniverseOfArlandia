void main()
{
object oPC = GetPCSpeaker();

object oNullhuman = CreateObject(OBJECT_TYPE_CREATURE,"nullhuman",GetLocation(oPC));
SetLocalInt(oPC,"Null",2);
AssignCommand(oNullhuman,ActionStartConversation(oPC,"null",TRUE,FALSE));
DelayCommand(4.0,FloatingTextStringOnCreature("Ready",oPC,FALSE));
}
