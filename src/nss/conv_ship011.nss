#include "_spacenav"
// Return from the deck to the helm, back out in the space tile the ship is in.
void main()
{
    object oPC = GetPCSpeaker();
    object oCabin = GetArea(oPC);
    string sWhere = GetLocalString(oCabin, "SpaceFrom");
    if (sWhere == "") { return; }

    // Under way: taking the helm breaks off the course and drops the ship
    // wherever it has got to.
    if (GetLocalInt(oCabin, SPACENAV_TRIPEND) == 1) { SpaceTripInterrupt(oPC, oCabin); return; }

    SetLocalString(oPC, "PlanetDest", "Space");
    SetLocalString(oPC, "AreaDest", sWhere);
    SetLocalFloat(oPC, "fX", 120.0);
    SetLocalFloat(oPC, "fY", 120.0);
    SetLocalFloat(oPC, "fFacing", DIRECTION_NORTH);
    AssignCommand(oPC, ClearAllActions(TRUE));
    ExecuteScript("transitions", oPC);
}
