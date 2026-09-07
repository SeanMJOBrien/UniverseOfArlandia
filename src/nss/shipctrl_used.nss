// shipctrl_used - OnUsed for the ship's navigation control (tag "shipcontrol").
#include "_spacenav"

void main()
{
    object oPC = GetLastUsedBy();
    if (!GetIsPC(oPC)) { return; }
    SpaceDeckOpen(oPC, OBJECT_SELF);
}
