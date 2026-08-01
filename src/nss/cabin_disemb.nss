// cabin_disemb - hatch reply "drop back to where you boarded" (works even
// while the owner is still piloting, TASK-24). See inc_flight.nss.
#include "inc_flight"
void main()
{
    FlightHatchToBoarding(GetPCSpeaker());
}
