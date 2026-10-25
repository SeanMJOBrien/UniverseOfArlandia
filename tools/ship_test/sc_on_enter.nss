// Module OnClientEnter: sets the ships out at their moorings.

#include "sc_inc"

void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC)) return;
    DelayCommand(1.0, ScInitAll());
    DelayCommand(3.0, SendMessageToPC(oPC, "Ship combat test: hire Garrick if you want a pilot, then use the battle bell on the dock. See docs/SHIP_COMBAT_PROTOTYPE.md."));
}
