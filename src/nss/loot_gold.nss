// loot_gold - auto-collect a corpse's gold when a player clicks it.
// ---
// NWScript has no event for opening a corpse: creatures have no OnUsed, and
// OnDisturbed only fires once something has already been taken - which is the
// very step this removes. So this hangs off NWNX instead.
// NWNX_ON_OBJECT_USE_BEFORE fires with OBJECT_SELF as the player and event data
// "OBJECT" as whatever they clicked, covering both the creature body and the
// BodyBag placeable it decays into. Subscribed once in mod_load.nss.
//
// Chests and crates are NOT handled here - they create their gold in their own
// OnOpen (treasures.nss), which runs after this event, so the sweep for those
// lives at the end of that script. Both share _loot.nss.
//
// Note that the bundled nwnx_events.nss include predates this event and does
// not document it; the running NWNX_Events plugin does provide it, and
// subscription is by event name, so the stale include costs nothing here.

#include "nwnx_events"
#include "_loot"

void main()
{
    if (iAutoLootGold != 1) return;

    object oPC = OBJECT_SELF;
    if (!GetIsPC(oPC)) return;

    // Vanilla StringToObject(), not NWNX_Object_StringToObject(). The bundled
    // nwnx_object.nss still declares the latter, but the running plugin dropped
    // it once NWN:EE added the function to base nwscript - calling it logged
    // "Plugin 'NWNX_Object' does not have an event 'StringToObject' registered"
    // on every single corpse click and returned an invalid object, so this
    // script bailed one line later and never swept anything. inc_array.nss
    // already uses the base-game function.
    object oTarget = StringToObject(NWNX_Events_GetEventData("OBJECT"));
    if (!GetIsObjectValid(oTarget)) return;

    // Proves whether the engine routes a corpse click through this event at
    // all - the one thing that could not be established outside the game.
    if (iAutoLootGoldDebug == 1)
    {
        WriteTimestampedLogEntry("[loot] use " + GetTag(oTarget)
            + " type=" + IntToString(GetObjectType(oTarget))
            + " dead=" + IntToString(GetIsDead(oTarget))
            + " by=" + GetName(oPC));
    }

    // Strictly a dead NPC body or the bodybag left behind. Never a living
    // creature - that would turn a click into a free pickpocket on any NPC
    // carrying coin - and never a player, whose corpse is their own business.
    int iType = GetObjectType(oTarget);
    if (iType == OBJECT_TYPE_CREATURE)
    {
        if (GetIsPC(oTarget)) return;
        if (!GetIsDead(oTarget)) return;
    }
    else if (iType == OBJECT_TYPE_PLACEABLE)
    {
        if (GetTag(oTarget) != "BodyBag") return;
    }
    else return;

    // Read this before the sweep: DestroyObject is deferred to the end of the
    // script, so afterwards the spent gold stacks would still be reported.
    int bMoreToSee = LootHasNonGold(oTarget);

    if (LootGoldSweep(oTarget, oPC) <= 0) return;

    // Gold was everything it held, so there is nothing left worth opening -
    // skipping the use spares the player an empty loot window.
    if ((iAutoLootGoldClose == 1) && (!bMoreToSee))
    {
        NWNX_Events_SkipEvent();
    }
}
