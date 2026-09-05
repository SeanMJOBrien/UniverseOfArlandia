// pcstore_distu - OnInvDisturbed for a player's storage object.
// Saves the whole object, contents intact, on every add or removal. There is no
// close event to rely on: the window is forced open by _pcstorage.nss rather
// than opened by walking up to the placeable. Mirrors TFN's pc_storage_distu.
#include "_pcstorage"

void main()
{
    PCStorageSave(OBJECT_SELF);
}
