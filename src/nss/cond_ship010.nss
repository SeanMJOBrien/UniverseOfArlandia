#include "_spacenav"
// "Go below to the deck." - a starship pilot out in space.
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetLocalString(oPC, "shiptool") != "tool_starship") { return FALSE; }
    return (GetStringLeft(GetTag(GetArea(oPC)), 5) == "space");
}
