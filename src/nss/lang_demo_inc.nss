// lang_demo_inc - demo of language-aware dialog: a goblin who speaks Goblin
// stands beside the first plot giver in an area a player enters.
// ---
// The goblin (blueprint lang_goblin, dialog lang_demo, npc_language 6) is
// spawned at runtime because the build never ships changes to area .git
// files. It is created once per area: a goblin already in the area stops a
// second one (checked by scanning the area). To remove the demo, delete the LangDemoSpawn call in area_enter
// and the goblin from any area it was spawned in.

// Creatures in oArea with sTag. Keeps the first and destroys any extras (left
// by earlier spawns), then returns the one kept, or OBJECT_INVALID if none.
object DemoKeepOne(object oArea, string sTag)
{
    object oKept = OBJECT_INVALID;
    object oObj = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oObj))
    {
        if (GetObjectType(oObj) == OBJECT_TYPE_CREATURE && GetTag(oObj) == sTag)
        {
            if (!GetIsObjectValid(oKept)) oKept = oObj;
            else DestroyObject(oObj);
        }
        oObj = GetNextObjectInArea(oArea);
    }
    return oKept;
}

// Spawns sResRef beside oPlot unless the area already has one (by tag, which
// also covers CopyArea clones and creatures from earlier spawns).
void DemoSpawnOnce(object oPlot, string sResRef, float fOffset, float fFacing)
{
    object oArea = GetArea(oPlot);
    if (GetIsObjectValid(DemoKeepOne(oArea, sResRef))) return;
    vector vPlot = GetPosition(oPlot);
    location lSpot = Location(oArea, Vector(vPlot.x + fOffset, vPlot.y, vPlot.z), fFacing);
    object oNew = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lSpot);
    // Defender faction, like the plot giver: never hostile to players.
    if (GetIsObjectValid(oNew)) ChangeToStandardFaction(oNew, STANDARD_FACTION_DEFENDER);
}

// Wren (dialog quest_demo, docs/QUEST_DIALOG_EXAMPLE.md) and Gruk, once each per area.
void LangDemoSpawn(object oPC)
{
    object oPlot = GetNearestObjectByTag("plotgiver", oPC);
    if (!GetIsObjectValid(oPlot)) return;
    DemoSpawnOnce(oPlot, "quest_wren", -1.5, 0.0);
    DemoSpawnOnce(oPlot, "lang_goblin", 1.5, 180.0);
}
