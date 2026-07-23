// Tavern and town hall henchs - rerolls the town's tavern/townhall roster to 3
// random adventurers whenever it is (re)populated after a server restart (iReady
// is a volatile module local wiped at every boot). It removes the unhired
// adventurers already standing there before spawning the new 3, so restores and
// repeat entries replace the roster instead of stacking on top of it - see the
// population block in main() for details.
//
// Split out of area_recall.nss and run via DelayCommand instead of inline:
// generating 3 full NWNX_Creature-built characters (levels/feats/skills/
// spells) plus weapon/armor picks is a lot of NWNX round-trips and SQLite
// array operations, easily enough to eat into or exceed the per-script
// instruction budget. Inline, a slow/aborted run here could cut
// area_recall.nss off before it reached its own later setup (Interests,
// area_creatures, area_resources, the "&Ready" flag) - which lined up with
// the reported symptom of not being able to change area coordinates on the
// very first login of a session, working again on the second (a second
// area_recall.nss pass for a different, already-"&Ready" town skips this
// block entirely and completes normally). ExecuteScript() runs as a nested
// call in the SAME execution/instruction budget as its caller, so calling
// this script directly wouldn't help - DelayCommand() is what actually hands
// it a fresh budget as an independent scheduled event.
#include "aps_include"
#include "_string_utils"
#include "inc_adventurer"
#include "inc_weaponpick"
////////////////////////////////////////////////////////////////////////////////
void main(){
////////////////////////////////////////////////////////////////////////////////
object oModule = GetModule();
string sPlanet = GetLocalString(OBJECT_SELF,"Planet");
string sArea = GetLocalString(OBJECT_SELF,"Area");
int iAdvSlot;int iAdvHD;int iAdvPath;int iAdvAC;string sAdvItem;object oAdvItem;object oNew;object oAdvScan;
////////////////////////////////////////////////////////////////////////////////
// area_recall.nss already checked iReady!=1 before scheduling this via
// DelayCommand - don't re-check it here. By the time this deferred script
// actually runs, area_recall.nss's own later code (which runs synchronously,
// moments earlier in wall-clock time) has already set "&Ready"=1 for this
// town, so re-reading it here would always find it already set and skip
// spawning every time - exactly the "no henchmen spawning" regression this
// fixes.
if((GetStringLeft(GetTag(OBJECT_SELF),6)=="tavern")||(GetStringLeft(GetTag(OBJECT_SELF),8)=="townhall"))
 {
// Reroll the roster. area_recall.nss restores previously-saved adventurers
// (RetrieveCampaignObject "AdvAreaSnap") moments before this deferred spawn
// runs, and the old code then unconditionally added 3 more on top every pass -
// stacking on those restores (and on night re-entries, where area_recall never
// sets its &Ready/Used guards) into the pile of 5+ at one waypoint that was
// reported. Instead: first remove the unhired adventurers still standing here
// (restored or left from a previous run), then spawn 3 fresh ones - so each
// repopulation replaces the roster instead of piling onto it. Hired henchmen
// have a master and follow their PC, so they're excluded - never remove a
// player's own companion.
oAdvScan = GetFirstObjectInArea(OBJECT_SELF);
while(GetIsObjectValid(oAdvScan))
  {
if((GetObjectType(oAdvScan)==OBJECT_TYPE_CREATURE)&&(GetResRef(oAdvScan)=="adventurer")&&(!GetIsObjectValid(GetMaster(oAdvScan)))){DestroyObject(oAdvScan);}
oAdvScan = GetNextObjectInArea(OBJECT_SELF);
  }
while(iAdvSlot<3)
  {
iAdvSlot++;
iAdvHD = GetPlanetLevel(oModule,sPlanet)+Random(3);if(iAdvHD<2){iAdvHD=2;}
iAdvPath = SelectAdventurerPath();
oNew = SpawnAdventurer(GetLocation(GetWaypointByTag("WPH_"+GetTag(OBJECT_SELF))),iAdvPath,iAdvHD,TRUE,FALSE);

// TFN's GenerateTrueName() (called inside SpawnAdventurer above) only stashes
// the rolled name as local vars, meant to be revealed to individual PCs later
// via NWNX_Player_SetCreatureNameOverride - that hidden-identity mechanic isn't
// part of this feature, so just name the creature directly.
SetName(oNew,GetAdventurerTrueName(oNew));

// Bookkeeping locals - mirrors the fields henchs.nss's hire/recall dispatcher
// reads off any hench (see henchs.nss lines ~62-68). "Class" stores the
// adventurer path enum and "Level" the hit dice, not a CLASS_TYPE_* constant -
// that's what lets henchs.nss recreate the same build via SpawnAdventurer()
// on relog instead of CreateObject()'ing a bare blueprint (see henchs.nss action 0).
SetLocalInt(oNew,"Hench",2);
SetLocalInt(oNew,"Race",GetRacialType(oNew));
SetLocalInt(oNew,"Level",iAdvHD);
SetLocalInt(oNew,"Class",iAdvPath);
SetLocalInt(oNew,"Head",GetCreatureBodyPart(CREATURE_PART_HEAD,oNew));
ChangeToStandardFaction(oNew,STANDARD_FACTION_COMMONER);

// Gear - guaranteed mundane stock items, not the OEI treasure system.
// CTG_CreateSpecificBaseTypeTreasure() turned out to be the wrong tool: it
// looks for a pre-placed "base container" chest to pull items from (this
// module never set one up, so it silently falls back to the generic
// chest-loot table - mostly gold/gems/potions/junk, armor only by chance),
// and it has a "generate once per object" guard, so every call after the
// first on the same creature was already a no-op. Equip known-good stock
// resrefs directly instead - the same approach hench001/010/020's own
// blueprints already use (see their Equip_ItemList: nw_aarcl00x armor +
// nw_ashlw001 shield + a class-appropriate nw_w** weapon).
// Armor: AC tier capped by the creature's own armor-proficiency feat, so a
// caster with no proficiency gets a plain robe (AC 0) instead of something
// that would wreck their spellcasting.
     if(GetHasFeat(FEAT_ARMOR_PROFICIENCY_HEAVY,oNew)){iAdvAC = 6+Random(3);}
else if(GetHasFeat(FEAT_ARMOR_PROFICIENCY_MEDIUM,oNew)){iAdvAC = 3+Random(3);}
else if(GetHasFeat(FEAT_ARMOR_PROFICIENCY_LIGHT,oNew)){iAdvAC = 1+Random(2);}
else{iAdvAC = 0;}
// Starter gear is marked non-droppable (can't be dropped/sold/stolen) so it
// can't be stripped off before the player gets a chance to upgrade it; gear
// the player later gives them equips/saves normally (droppable).
sAdvItem = GetMundaneArmorOfAC(iAdvAC);
if(sAdvItem!=""){oAdvItem = CreateItemOnObject(sAdvItem,oNew);SetDroppableFlag(oAdvItem,FALSE);AssignCommand(oNew,ActionEquipItem(oAdvItem,INVENTORY_SLOT_CHEST));}

// Weapon/offhand: type comes from RollRandomWeaponTypesForCreature (reads
// the creature's own weapon-proficiency feats, set above by
// AdvanceCreatureAlongAdventurerPath) so e.g. a druid never ends up holding
// a mace it can't use, then GetMundaneWeaponOfType maps that type to a real
// stock item resref (covers shields too, for the offhand case).
struct RandomWeaponResults rwrAdv = RollRandomWeaponTypesForCreature(oNew);
if(rwrAdv.nMainHand!=BASE_ITEM_INVALID)
  {
sAdvItem = GetMundaneWeaponOfType(rwrAdv.nMainHand);
if(sAdvItem!=""){oAdvItem = CreateItemOnObject(sAdvItem,oNew);SetDroppableFlag(oAdvItem,FALSE);AssignCommand(oNew,ActionEquipItem(oAdvItem,INVENTORY_SLOT_RIGHTHAND));}
  }
if(rwrAdv.nOffHand!=BASE_ITEM_INVALID)
  {
sAdvItem = GetMundaneWeaponOfType(rwrAdv.nOffHand);
if(sAdvItem!=""){oAdvItem = CreateItemOnObject(sAdvItem,oNew);SetDroppableFlag(oAdvItem,FALSE);AssignCommand(oNew,ActionEquipItem(oAdvItem,INVENTORY_SLOT_LEFTHAND));}
  }
  }
 }
////////////////////////////////////////////////////////////////////////////////
}
