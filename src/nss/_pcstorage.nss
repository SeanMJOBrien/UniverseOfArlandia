#include "nwnx_player"
#include "_module"
// _pcstorage - persistent per-player storage chests, modelled on The Frozen
// North's _pc_storage (pc_storage_distu.nss / storage_onuse.nss).
//
// UOA's existing player chests (chestplay_open/close.nss) write their contents
// to MODULE LOCALS, which are wiped on every reboot - and mod_heartbeat.nss:30
// schedules reboots routinely. So anything a player left in a chest was already
// being lost. This replaces that with TFN's model, which fixes it and sidesteps
// the eviction problem at the same time:
//
//   - Storage belongs to the ACCOUNT (public CD key), not to a house. Losing a
//     rented house therefore cannot cost a player their belongings, so no
//     escrow-on-eviction is needed at all.
//   - Each account gets iPCStorageChests slots. The chest standing in the world
//     is only a portal: using it opens the player's OWN storage object through
//     NWNX_Player_ForcePlaceableInventoryWindow.
//   - The whole storage object is saved as ONE campaign entry per (account,
//     slot) via StoreCampaignObject, contents intact. Row count is bounded by
//     players x slots regardless of how many items are inside, which is why TFN
//     needs no per-chest item cap - and why this doesn't impose one either.
//
// The campaign namespace is deliberately NOT "AdvAreaSnap": mod_load.nss:59
// destroys that one at every boot.

const string PCSTORAGE_CAMPAIGN = "PCStorage";
const string PCSTORAGE_RESREF   = "chestplayer";
const string PCSTORAGE_SLOT     = "StorageSlot";  // int local on the world-side portal chest

// The account a player's storage belongs to. "" when unavailable, in which case
// callers must refuse rather than silently share one anonymous store.
string PCStorageAccount(object oPC)
{
    return GetPCPublicCDKey(oPC);
}

// Campaign key for one of an account's storage slots.
string PCStorageKey(int iSlot)
{
    return "store" + IntToString(iSlot);
}

// Tag the live storage object carries, so it can be found again without
// walking every object in the module.
string PCStorageTag(string sAccount, int iSlot)
{
    return sAccount + "_" + PCStorageKey(iSlot);
}

// Persist a storage object. Called from its OnInvDisturbed, so every add or
// removal is captured - there is no "close" event to rely on when the window
// was forced open rather than opened by walking up to the placeable.
void PCStorageSave(object oStore)
{
    if (!GetIsObjectValid(oStore)) { return; }
    string sAccount = GetLocalString(oStore, "Account");
    int iSlot = GetLocalInt(oStore, PCSTORAGE_SLOT);
    if ((sAccount == "") || (iSlot < 1)) { return; }
    StoreCampaignObject(PCSTORAGE_CAMPAIGN, sAccount + "_" + PCStorageKey(iSlot), oStore);
}

// The live storage object for this account and slot, restoring it from the
// campaign database on first use this boot, or creating an empty one if the
// account has never stored anything in this slot.
//
// Storage objects are parked in the area they are first opened from and made
// non-useable, so nobody can walk up to another player's store: the only way in
// is the forced inventory window below.
object PCStorageGet(object oPC, int iSlot, location lWhere)
{
    string sAccount = PCStorageAccount(oPC);
    if ((sAccount == "") || (iSlot < 1) || (iSlot > iPCStorageChests)) { return OBJECT_INVALID; }

    string sTag = PCStorageTag(sAccount, iSlot);
    object oStore = GetObjectByTag(sTag);
    if (GetIsObjectValid(oStore)) { return oStore; }

    oStore = RetrieveCampaignObject(PCSTORAGE_CAMPAIGN, sAccount + "_" + PCStorageKey(iSlot), lWhere);
    if (!GetIsObjectValid(oStore))
    {
        oStore = CreateObject(OBJECT_TYPE_PLACEABLE, PCSTORAGE_RESREF, lWhere, FALSE, sTag);
    }
    if (!GetIsObjectValid(oStore)) { return OBJECT_INVALID; }

    SetTag(oStore, sTag);
    SetLocalString(oStore, "Account", sAccount);
    SetLocalInt(oStore, PCSTORAGE_SLOT, iSlot);
    SetLocalInt(oStore, "DontSave", 1);      // it is persisted by campaign object, not by area_save
    SetLocalInt(oStore, "NoStatic", 1);
    SetUseableFlag(oStore, FALSE);            // reachable only through the forced window
    SetPlotFlag(oStore, TRUE);
    return oStore;
}

// Open oPC's own storage for the slot the portal chest they used is carrying.
void PCStorageOpen(object oPC, object oPortal)
{
    if ((!GetIsObjectValid(oPC)) || (!GetIsObjectValid(oPortal))) { return; }

    if (PCStorageAccount(oPC) == "")
    {
        FloatingTextStringOnCreature("Your storage is unavailable right now.", oPC, FALSE);
        return;
    }

    int iSlot = GetLocalInt(oPortal, PCSTORAGE_SLOT);
    if (iSlot < 1) { iSlot = 1; }
    if (iSlot > iPCStorageChests) { return; }

    object oStore = PCStorageGet(oPC, iSlot, GetLocation(oPortal));
    if (!GetIsObjectValid(oStore))
    {
        FloatingTextStringOnCreature("Your storage could not be opened.", oPC, FALSE);
        return;
    }
    NWNX_Player_ForcePlaceableInventoryWindow(oPC, oStore);
}
