#include "_spacenav"
// cabin_helm - hatch reply "take the helm", for the ship's own pilot. Climbing
// up to the pilot is no use to the pilot; this puts them back out in space.
void main()
{
    object oPC = GetPCSpeaker();
    SpaceReturnToHelm(oPC, GetArea(oPC));
}
