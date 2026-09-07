#include "_spacenav"
// Leave the helm for the deck. Remembers where the ship was, so the deck can
// still plot courses once the pilot is no longer in space, and clones a cabin
// for a pilot flying alone.
void main()
{
    object oPC = GetPCSpeaker();
    object oCabin = GetLocalObject(oPC, "OwnCabin");

    if (!GetIsObjectValid(oCabin))
    {
        oCabin = FlightCloneCabin(2);
        if (!GetIsObjectValid(oCabin))
        {
            FloatingTextStringOnCreature("The ship has no deck to go down to.", oPC, FALSE);
            return;
        }
        SetLocalObject(oCabin, FLIGHT_OWNER, oPC);
        SetLocalObject(oPC, "OwnCabin", oCabin);
    }

    SpaceFlyStop(oPC);
    SetLocalString(oCabin, "SpaceFrom", GetLocalString(GetArea(oPC), "Area"));
    object oWP = FlightWaypointIn(oCabin, "WP_cabin_star");
    location lTo = GetIsObjectValid(oWP) ? GetLocation(oWP) : GetLocation(GetFirstObjectInArea(oCabin));
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionJumpToLocation(lTo));
}
