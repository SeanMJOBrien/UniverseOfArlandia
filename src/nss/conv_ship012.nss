#include "_spacenav"
// Set course for the planet this character last lifted off from. Arrival sets
// the ship down on the pad itself rather than in orbit - see SpaceFlyStep.
void main()
{
    object oPC = GetPCSpeaker();
    SpaceFlyBegin(oPC, SpaceNavPadBody(oPC));
}
