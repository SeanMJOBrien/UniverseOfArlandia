#include "_spacenav"
// Return from the deck to the helm, back out in the space tile the ship is in.
void main()
{
    object oPC = GetPCSpeaker();
    SpaceReturnToHelm(oPC, GetArea(oPC));
}
