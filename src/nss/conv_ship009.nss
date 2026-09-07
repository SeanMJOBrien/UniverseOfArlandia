#include "_spacenav"
// Break off a manual flight.
void main()
{
    object oPC = GetPCSpeaker();
    SpaceFlyStop(oPC);
    AssignCommand(oPC, ClearAllActions(TRUE));
    FloatingTextStringOnCreature("You break off course.", oPC, FALSE);
}
