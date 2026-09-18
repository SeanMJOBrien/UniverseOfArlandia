#include "_pcstorage"
////////////////////////////////////////////////////////////////////////////////
// Player house chests.
//
// The four chests (chestplayer1-4) are unlocked by house level as before - 1 at
// level 1, 2 at level 4, 3 and 4 at level 5 - and still only for the character
// the house belongs to (its Master, which for a rented house is the RENTER, set
// by transitions2.nss).
//
// What changed: a chest is now a PORTAL to the player's own account storage
// rather than a container in its own right. Contents used to be written to
// module locals by chestplay_open/close.nss, which are wiped on every reboot -
// and mod_heartbeat.nss:30 schedules those routinely, so players were silently
// losing whatever they stored. Storage now belongs to the account and is saved
// whole as one campaign object per slot (see _pcstorage.nss).
//
// Because storage follows the player rather than the house, losing a house -
// evicted, demolished, rent lapsed - can no longer cost anyone their
// belongings, and renting somewhere new means the chests are already stocked.
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oPC = GetLastUsedBy();
object oArea = GetArea(OBJECT_SELF);
string sMaster = GetLocalString(oArea,"Master");
string sTag = GetStringRight(GetTag(OBJECT_SELF),1);
int iLevel = GetLocalInt(oArea,"Level");
int iClose = GetLocalInt(OBJECT_SELF,"Closing");
int iSlot = StringToInt(sTag);
////////////////////////////////////////////////////////////////////////////////
if((iClose==0)&&(GetName(oPC)==sMaster)&&(((sTag=="1")&&(iLevel>=1))||((sTag=="2")&&(iLevel>=4))||((sTag=="3")&&(iLevel>=5))||((sTag=="4")&&(iLevel>=5))))
 {
SetLocalObject(OBJECT_SELF,"PC",oPC);
SetLocalInt(OBJECT_SELF,PCSTORAGE_SLOT,iSlot);

// One-time migration: anything sitting in the old per-house container is moved
// into the account store the first time its owner opens it, so switching over
// costs nobody the items they had in there. Without this the contents would be
// orphaned behind the portal - they are already doomed at the next reboot, but
// there is no reason to lose them sooner.
object oStore = PCStorageGet(oPC,iSlot,GetLocation(OBJECT_SELF));
if(GetIsObjectValid(oStore))
  {
object oItem = GetFirstItemInInventory(OBJECT_SELF);
int iMoved;
while(GetIsObjectValid(oItem))
   {
object oNext = GetNextItemInInventory(OBJECT_SELF);
CopyItem(oItem,oStore,TRUE);
DestroyObject(oItem);
iMoved++;
oItem = oNext;
   }
if(iMoved>0){PCStorageSave(oStore);FloatingTextStringOnCreature("Moved "+IntToString(iMoved)+" item(s) into your storage.",oPC,FALSE);}
  }

PCStorageOpen(oPC,OBJECT_SELF);
 }
////////////////////////////////////////////////////////////////////////////////
DeleteLocalInt(OBJECT_SELF,"Closing");
////////////////////////////////////////////////////////////////////////////////
}
