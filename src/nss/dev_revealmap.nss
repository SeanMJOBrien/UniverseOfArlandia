// dev_revealmap - reveal the whole current area's map to the caller.
//
// Ported from tfn-map-memory's dev_revealmap (originally from The Frozen
// North; dev-server and Discord-logging gates removed there already). Gated
// to DMs so players cannot use it. Bind to a DM item, or run
// ExecuteScript("dev_revealmap", oDM), or use the DM Client's "Run Script"
// action targeting self.
//
// Note: this only reveals the map view for the current session. To make an
// area permanently known to everyone, set its local int "explored" to 1
// instead (see inc_persist.nss).

void main()
{
    object oPC = OBJECT_SELF;
    if (!GetIsDM(oPC) && !GetIsDMPossessed(oPC)) return;

    object oArea = GetArea(oPC);
    if (!GetIsObjectValid(oArea)) return;

    ExploreAreaForPlayer(oArea, oPC, TRUE);
    SendMessageToPC(oPC, "Revealed map for area: " + GetName(oArea) +
                    " (tag: " + GetTag(oArea) + ")");
}
