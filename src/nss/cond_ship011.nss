#include "_spacenav"
// "Return to the helm." - the owner, standing in their own flight cabin.
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    if (GetLocalObject(oArea, FLIGHT_OWNER) != oPC) { return FALSE; }
    return (GetLocalString(oArea, "SpaceFrom") != "");
}
