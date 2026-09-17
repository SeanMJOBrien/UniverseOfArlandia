#include "inc_flight"
// "Drop back down to where you boarded." - only for someone who boarded from
// somewhere. The pilot took the ship up, so they have no such spot, and an
// unset location would jump them nowhere at all.
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    location lBoard = GetLocalLocation(oPC, FLIGHT_BOARD_LOC);
    return GetIsObjectValid(GetAreaFromLocation(lBoard));
}
