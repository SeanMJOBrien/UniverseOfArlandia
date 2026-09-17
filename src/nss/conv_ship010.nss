#include "_spacenav"
// Leave the helm for the deck. Remembers where the ship was, so the deck can
// still plot courses once the pilot is no longer in space, and clones a cabin
// for a pilot flying alone.
void main()
{
    object oPC = GetPCSpeaker();
    // The party's own cabin if one is already flying with this ship, so the
    // pilot goes down to where their passengers are rather than to a second
    // deck of their own.
    object oCabin = FlightOwnerCabin(oPC, 2);

    if (!GetIsObjectValid(oCabin))
    {
        oCabin = FlightCloneCabin(2);
        if (!GetIsObjectValid(oCabin))
        {
            FloatingTextStringOnCreature("The ship has no deck to go down to.", oPC, FALSE);
            return;
        }
        FlightSetOwnerCabin(oPC, 2, oCabin);
    }

    SpaceFlyStop(oPC);
    SetLocalString(oCabin, "SpaceFrom", GetLocalString(GetArea(oPC), "Area"));
    object oWP = FlightWaypointIn(oCabin, "WP_cabin_star");
    location lTo = GetIsObjectValid(oWP) ? GetLocation(oWP) : GetLocation(GetFirstObjectInArea(oCabin));
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionJumpToLocation(lTo));
}
