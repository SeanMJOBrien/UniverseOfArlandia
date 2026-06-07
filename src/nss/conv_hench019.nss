void main()
{
object oPC = GetPCSpeaker();

object oNullhuman = CreateObject(OBJECT_TYPE_CREATURE,"nullhuman",GetLocation(oPC));
SetLocalObject(oPC,"oTarget",OBJECT_SELF);
SetLocalInt(oPC,"Null",2);
AssignCommand(oNullhuman,ActionStartConversation(oPC,"null",TRUE,FALSE));
DelayCommand(4.0,FloatingTextStringOnCreature("Ready",oPC,FALSE));
}
