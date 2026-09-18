#include "_spacenav"
// "Take the helm." - the pilot, in their own cabin, with a ship still in space.
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return SpaceMayTakeHelm(oPC, GetArea(oPC));
}
