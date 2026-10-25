// OnUsed of the battle bell: starts the battle for the player who rang it.

#include "sc_inc"

void main()
{
    object oUser = GetLastUsedBy();
    if (!GetIsPC(oUser)) return;
    ScStartBattle(oUser);
}
