#include "inc_flight"
// "Climb up to the pilot." - passengers only. The pilot is standing in the
// cabin themselves, so for them there is nobody up there to climb to.
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return (GetLocalObject(GetArea(oPC), FLIGHT_OWNER) != oPC);
}
