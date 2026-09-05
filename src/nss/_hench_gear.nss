// _hench_gear - gear rules shared by every henchman path.
// ---
// Two rules live here:
//
// 1) Armor is capped by the henchman's level, not just by which armor
//    proficiency feat their class happens to grant. area_tavernspawn.nss used
//    to pick the AC tier from the proficiency feat alone, so any heavy-armor
//    class rolled 6-8 from level 1 - a 3rd level fighter turning up in full
//    plate. GetHenchMaxArmorAC() is the ceiling that stops that.
//
// 2) Armor never leaves the henchman. henchs.nss serialises a hench's gear on
//    dismissal/relog and flips every item droppable on the way through (both
//    the carried-inventory pass and the equipped-slot pass, which includes
//    INVENTORY_SLOT_CHEST), so armor that spawned non-droppable came back
//    droppable after the first save/restore cycle and could then be stripped
//    or looted off the body. HenchSetItemDroppable() replaces those blanket
//    SetDroppableFlag(oItem,TRUE) calls: armor stays locked, everything else
//    keeps behaving as it did.
//
// Tunables live in _module.nss: iHenchArmorACBase, iHenchArmorACLevels,
// iHenchArmorACMax.

#include "_module"

// Highest armor AC a henchman of nHD hit dice may be given.
int GetHenchMaxArmorAC(int nHD);

// TRUE when oItem is body armor. BASE_ITEM_ARMOR covers robes and clothing
// too, which is what we want - a caster's robe is their armor slot.
int HenchItemIsArmor(object oItem);

// Apply the droppable rule to one henchman item: armor never drops, anything
// else stays droppable exactly as before.
void HenchSetItemDroppable(object oItem);

// Force every piece of armor a henchman is wearing or carrying non-droppable.
// Cheap enough to call after any gear rebuild.
void HenchLockArmor(object oHench);

// ---------------------------------------------------------------------------

int GetHenchMaxArmorAC(int nHD)
{
    if (nHD < 1) nHD = 1;
    if (iHenchArmorACLevels < 1) return iHenchArmorACMax;

    // Level 1-3 start at the base tier, then one step per iHenchArmorACLevels
    // hit dice: 4 (scale) at 1-3, 5 (chainmail) at 4-6, 6 (splint/banded) at
    // 7-9, 7 (half plate) at 10-12, 8 (full plate) from 13.
    int nCap = iHenchArmorACBase + ((nHD - 1) / iHenchArmorACLevels);
    if (nCap > iHenchArmorACMax) nCap = iHenchArmorACMax;
    return nCap;
}

int HenchItemIsArmor(object oItem)
{
    if (!GetIsObjectValid(oItem)) return FALSE;
    return (GetBaseItemType(oItem) == BASE_ITEM_ARMOR);
}

void HenchSetItemDroppable(object oItem)
{
    if (!GetIsObjectValid(oItem)) return;
    SetDroppableFlag(oItem, !HenchItemIsArmor(oItem));
}

void HenchLockArmor(object oHench)
{
    if (!GetIsObjectValid(oHench)) return;

    // The worn set first - GetFirstItemInInventory only walks the backpack,
    // never the equipped slots.
    object oWorn = GetItemInSlot(INVENTORY_SLOT_CHEST, oHench);
    if (GetIsObjectValid(oWorn)) SetDroppableFlag(oWorn, FALSE);

    object oItem = GetFirstItemInInventory(oHench);
    while (GetIsObjectValid(oItem))
    {
        if (HenchItemIsArmor(oItem)) SetDroppableFlag(oItem, FALSE);
        oItem = GetNextItemInInventory(oHench);
    }
}
