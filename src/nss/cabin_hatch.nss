// cabin_hatch - OnUsed for the personal-flight cabin hatch placeable.
// Sends the user to the flight owner (or back to their boarding spot if the
// owner has logged out). See inc_flight.nss.
#include "inc_flight"
void main()
{
    FlightHatchToOwner(GetLastUsedBy());
}
