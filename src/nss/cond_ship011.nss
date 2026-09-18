#include "_spacenav"
// "Return to the helm." - the owner, standing in their own flight cabin.
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return SpaceMayTakeHelm(oPC, GetArea(oPC));
}
