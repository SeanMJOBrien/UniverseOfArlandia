#include "_spacenav"
// "Fly to Arland." - offered to a starship pilot who is out in space and not
// already under way.
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetLocalString(oPC, "shiptool") != "tool_starship") { return FALSE; }
    if (GetStringLeft(GetTag(GetArea(oPC)), 5) != "space") { return FALSE; }
    if (GetLocalString(oPC, SPACENAV_FLY_TO) != "") { return FALSE; }
    return (GetLocalString(GetArea(oPC), "Area") != SpaceNavPlaceOf("Arland"));
}
