// pcstore_distu - OnInvDisturbed for a player's storage object.
//
// Two jobs:
//   1. Enforce iPCStorageMaxItems. NWN has no per-container item cap - capacity
//      is a slot grid, and baseitems.2da gives every item type its own
//      InvSlotWidth/Height footprint - so a definite, explainable limit has to
//      be imposed here. The cap also bounds the cost of job 2.
//   2. Save the whole object, contents intact, on every add or removal. There
//      is no close event to rely on: the window is forced open by
//      _pcstorage.nss rather than opened by walking up to the placeable.
//
// Note the cap counts item STACKS, not units - a stack of 99 arrows is one.
#include "_pcstorage"

void main()
{
    object oStore = OBJECT_SELF;

    if (GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_ADDED)
    {
        int iCount;
        object oItem = GetFirstItemInInventory(oStore);
        while (GetIsObjectValid(oItem))
        {
            iCount++;
            oItem = GetNextItemInInventory(oStore);
        }

        if (iCount > iPCStorageMaxItems)
        {
            object oAdded = GetInventoryDisturbItem();
            object oPC = GetLastDisturbed();
            if (GetIsObjectValid(oAdded) && GetIsObjectValid(oPC))
            {
                CopyItem(oAdded, oPC, TRUE);
                DestroyObject(oAdded);
                FloatingTextStringOnCreature("That chest is full (" + IntToString(iPCStorageMaxItems) + " items).", oPC, FALSE);
                // Save after the rejected item is actually gone - DestroyObject
                // does not take effect until this script ends, so saving now
                // would persist the over-full state.
                DelayCommand(0.5, PCStorageSave(oStore));
                return;
            }
        }
    }

    PCStorageSave(oStore);
}
