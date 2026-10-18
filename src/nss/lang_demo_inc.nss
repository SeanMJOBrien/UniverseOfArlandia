// lang_demo_inc - demo of language-aware dialog: a goblin who speaks Goblin
// stands beside the first plot giver in an area a player enters.
// ---
// The goblin (blueprint lang_goblin, dialog lang_demo, npc_language 6) is
// spawned at runtime because the build never ships changes to area .git
// files. It is created once per area: a goblin already in the area stops a
// second one. To remove the demo, delete the LangDemoSpawn call in area_enter
// and the goblin from any area it was spawned in.

void LangDemoSpawn(object oPC)
{
    object oPlot = GetNearestObjectByTag("plotgiver", oPC);
    if (!GetIsObjectValid(oPlot)) return;
    if (GetIsObjectValid(GetNearestObjectByTag("lang_goblin", oPlot))) return;

    vector vPlot = GetPosition(oPlot);
    location lSpot = Location(GetArea(oPlot), Vector(vPlot.x + 1.5, vPlot.y, vPlot.z), 180.0);
    object oGoblin = CreateObject(OBJECT_TYPE_CREATURE, "lang_goblin", lSpot);
    // Defender faction, like the plot giver: never hostile to players.
    if (GetIsObjectValid(oGoblin))
        ChangeToStandardFaction(oGoblin, STANDARD_FACTION_DEFENDER);
}
