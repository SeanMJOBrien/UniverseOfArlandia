#include "_spacenav"
// "Fly back to <planet>." - offered to a starship pilot out in space who has a
// launch pad recorded and is not already in that planet's tile. The planet's
// name goes into the reply through a custom token, since the dialog text is
// fixed and the planet is not.
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetLocalString(oPC, "shiptool") != "tool_starship") { return FALSE; }
    if (GetStringLeft(GetTag(GetArea(oPC)), 5) != "space") { return FALSE; }
    if (GetLocalString(oPC, SPACENAV_FLY_TO) != "") { return FALSE; }

    string sBody = SpaceNavPadBody(oPC);
    if (sBody == "") { return FALSE; }
    if (GetLocalString(GetArea(oPC), "Area") == SpaceNavPlaceOf(sBody)) { return FALSE; }

    SetCustomToken(SPACENAV_PAD_TOKEN, sBody);
    return TRUE;
}
