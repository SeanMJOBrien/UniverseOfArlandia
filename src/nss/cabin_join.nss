// cabin_join - hatch reply "climb up to the pilot". See inc_flight.nss.
#include "inc_flight"
void main()
{
    FlightHatchJoinOwner(GetPCSpeaker());
}
