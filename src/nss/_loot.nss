// _loot - shared gold pickup for corpses and treasure containers.
// ---
// UOA seeds loot with nw_it_gold001 stacks (treasures.nss for chests and
// crates, creature blueprints and creatures_spawn.nss for bodies), so coin
// arrives as an inventory ITEM that has to be dragged out of the loot window by
// hand. These helpers take it straight to the player's purse instead.
//
// Two callers, because the two cases become lootable at different moments:
//   loot_gold.nss  - corpses and bodybags, off NWNX_ON_OBJECT_USE_BEFORE
//                    (creatures have no OnUsed event).
//   treasures.nss  - chests and crates, at the end of their OnOpen, which is
//                    where the gold is created in the first place. An
//                    OBJECT_USE hook fires before that and would find nothing.
//
// Gold reaches a corpse from two independent places, which is worth knowing
// before touching the matching below:
//   - creatures_spawn.nss, for bandits only (Random(5)/Random(4) - a few coins).
//   - the stock OnSpawn nw_c2_default9, which calls CTG_GenerateNPCTreasure().
//     UOA never set up the "base container" chests that needs, so it falls back
//     to GenerateNPCTreasure() in nw_o2_coninclude, which creates coin with
//     CreateItemOnObject("NW_IT_GOLD001", ...) - UPPERCASE. That path is why
//     goblins and lizardfolk occasionally carry 1-3 gold despite no creature
//     blueprint in the module holding any.
//
// Tunables live in _module.nss: iAutoLootGold, iAutoLootGoldClose, sGoldResRef.

#include "_module"

// Take every gold stack out of oContainer and give it to oPC as coin.
// Returns the amount transferred, or 0 when there was none to take.
int LootGoldSweep(object oContainer, object oPC);

// TRUE when oContainer holds anything besides gold - i.e. there is still a
// reason to show the player its inventory.
int LootHasNonGold(object oContainer);

// TRUE when oItem is a coin stack. Tested by base item type, not by resref:
// the two systems that seed gold here disagree on spelling ("nw_it_gold001" in
// treasures.nss, "NW_IT_GOLD001" in nw_o2_coninclude), and a string compare
// that silently misses is precisely how this feature failed before. The base
// type is the same either way and cannot be spelled wrong.
int LootItemIsGold(object oItem);

// ---------------------------------------------------------------------------

int LootItemIsGold(object oItem)
{
    if (!GetIsObjectValid(oItem)) return FALSE;
    if (GetBaseItemType(oItem) == BASE_ITEM_GOLD) return TRUE;
    // Belt and braces for any custom coin blueprint that is not base-type gold.
    return (GetStringLowerCase(GetResRef(oItem)) == GetStringLowerCase(sGoldResRef));
}

int LootGoldSweep(object oContainer, object oPC)
{
    if (iAutoLootGold != 1) return 0;
    if (!GetIsObjectValid(oContainer)) return 0;
    if (!GetIsPC(oPC)) return 0;
    // DMs get the container's contents as they are - they inspect loot rather
    // than collect it, and a DM click should not empty a body or a chest.
    if (GetIsDM(oPC) || GetIsDMPossessed(oPC)) return 0;

    int iGold;

    // Coin lives in one of two places depending on what is holding it. Drop a
    // nw_it_gold001 stack on a CREATURE and the engine folds it straight into
    // that creature's gold value, leaving no item behind - so a corpse's coin
    // is only ever visible through GetGold(). A placeable keeps it as an item
    // stack in its inventory. Sweep both.
    if (GetObjectType(oContainer) == OBJECT_TYPE_CREATURE)
    {
        iGold = GetGold(oContainer);
        // bDestroy, so the coin does not land on whoever OBJECT_SELF happens
        // to be - this runs from an NWNX handler as well as an OnOpen.
        if (iGold > 0) TakeGoldFromCreature(iGold, oContainer, TRUE);
    }

    object oItem = GetFirstItemInInventory(oContainer);
    while (GetIsObjectValid(oItem))
    {
        if (LootItemIsGold(oItem))
        {
            iGold = iGold + GetItemStackSize(oItem);
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oContainer);
    }

    if (iAutoLootGoldDebug == 1)
    {
        // List what is actually left inside. A bare "gold=0" cannot distinguish
        // "this corpse had no coin" from "the coin is here and I failed to
        // recognise it", and telling those two apart is the whole question.
        string sLeft;
        object oScan = GetFirstItemInInventory(oContainer);
        while (GetIsObjectValid(oScan))
        {
            sLeft = sLeft + GetResRef(oScan) + "(bt" + IntToString(GetBaseItemType(oScan))
                  + "x" + IntToString(GetItemStackSize(oScan)) + ") ";
            oScan = GetNextItemInInventory(oContainer);
        }
        WriteTimestampedLogEntry("[loot] sweep " + GetTag(oContainer)
            + " type=" + IntToString(GetObjectType(oContainer))
            + " by=" + GetName(oPC)
            + " gold=" + IntToString(iGold)
            + " left=[" + sLeft + "]");
    }

    if (iGold <= 0) return 0;

    GiveGoldToCreature(oPC, iGold);
    FloatingTextStringOnCreature("You pick up " + IntToString(iGold) + " gold", oPC, FALSE);
    // OBJECT_SELF is the container in the OnOpen caller, so play this on the
    // player explicitly rather than wherever the script happens to be running.
    AssignCommand(oPC, PlaySound("it_coins"));
    return iGold;
}

int LootHasNonGold(object oContainer)
{
    object oItem = GetFirstItemInInventory(oContainer);
    while (GetIsObjectValid(oItem))
    {
        if (!LootItemIsGold(oItem)) return TRUE;
        oItem = GetNextItemInInventory(oContainer);
    }
    return FALSE;
}
