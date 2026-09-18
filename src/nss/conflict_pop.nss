// conflict_pop - populate a conflict battle instance (TASK-30).
//
// Runs once, with OBJECT_SELF set to the freshly cloned battle area, right
// after transitions2.nss creates it. Reads:
//   int "ConflictTier" - which composition to stamp (0 = unset)
//
// COMPOSITION IS NOT DESIGNED YET and is deliberately not guessed at here.
// The agreed shape, for whoever fills this in:
//
//   - Two opposing groups, stock STANDARD_FACTION_HOSTILE vs
//     STANDARD_FACTION_DEFENDER. They fight each other for free; two groups
//     both set Hostile would be allies and just stand there, because the
//     module has only the 5 stock factions (src/fac/repute.fac.json).
//   - Consequence to keep in mind: Defender is friendly to PCs module-wide, so
//     the party always has an ally side. When a group needs to be hostile to a
//     specific PC as well, SetIsTemporaryEnemy(oPC, oCreature) does it per
//     creature without touching global reputation or adding factions.
//   - Creatures spawn here and simply persist; nothing is simulated between
//     visits, so a party can retreat and come back to the fight as they left it.
//   - The fight is resolved when every creature hostile to the PC is dead.
//     Surviving Defenders do not block resolution.
//
// Until a tier design exists this leaves the clone as a bare arena: the pilot
// arrives, can walk around, and leaves via the exit shaft. That is enough to
// exercise the entry/instance/return plumbing end to end.

void main()
{
    object oArea = OBJECT_SELF;
    int iTier = GetLocalInt(oArea, "ConflictTier");
    if (iTier < 1) { return; }

    // No tiers defined yet - see the header. Fall through with nothing spawned
    // rather than inventing a composition.
}
