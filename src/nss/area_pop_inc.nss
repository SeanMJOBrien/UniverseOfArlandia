// Area population helpers shared between area_enter.nss (population-after-
// arrival fallback, for any jump that doesn't route through transitions.nss)
// and trans_arrive.nss (population-before-arrival, the normal path - see
// transitions.nss). Both call sites are guarded by the same locals, so
// whichever fires first does the real work and the other is a cheap no-op -
// no double-run, no ordering hazard between the two callers.
#include "nwnx_object"

// Placeable view distance (default 45m -> 200m) and marking non-interactive
// scenery placeables static (network-optimization flag, fewer per-client
// updates), both set once per area instantiation since static/pooled areas
// are destroyed and recreated fresh (see area_save.nss) - area object locals
// don't survive that, or a server restart, so this naturally re-runs once per
// boot per area.
//
// Only placeables with Useable OFF get marked static: GetUseableFlag is the
// same signal the toolset uses to mean "the player can click/use this"
// (chests, doors-as-placeables, shop stores, sit-able furniture, ...) -
// NWNX_Object_SetPlaceableIsStatic disables per-client interaction updates,
// so marking a useable placeable static would make it un-lootable/un-usable.
//
// Lamp posts are excluded even though they're non-useable: they exist as two
// separate blueprints, "lampposton"/"lamppostoff" (src/utp/), swapped for the
// day/night cycle - marking one static would break that swap (or freeze the
// client's view of it) for the same reason a useable placeable is excluded
// above. Matched by tag prefix "lamppost" so any future on/off/broken
// variant is covered without needing another exact-tag entry here.
//
// This call was disabled once, briefly, after a placeable-built castle was
// reported missing on arrival. Root cause turned out to be unrelated: a
// nested ExecuteScript in trans_arrive.nss's population kickoff was sharing
// (and could exhaust) its caller's instruction budget mid-restore, silently
// truncating a large object-restore pass regardless of what ran afterward -
// fixed there (each population step now gets its own DelayCommand-granted
// budget). Re-enabled on that basis; if placeables ever go missing again,
// suspect that budget/timing path again before this static-marking call.
void AreaPopSetupPlaceables(object oArea)
{
    if(GetLocalInt(oArea,"VisDistSet")!=0){return;}
    SetLocalInt(oArea,"VisDistSet",1);
    object oPlaceable = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oPlaceable))
     {
    if(GetObjectType(oPlaceable)==OBJECT_TYPE_PLACEABLE)
      {
    SetObjectVisibleDistance(oPlaceable,200.0);
    if((!GetUseableFlag(oPlaceable))&&(GetStringLeft(GetTag(oPlaceable),8)!="lamppost")){NWNX_Object_SetPlaceableIsStatic(oPlaceable,TRUE);}
      }
    oPlaceable = GetNextObjectInArea(oArea);
     }
}

// "Ready" = the population pipeline has been run at least once for this area
// instance: PopStarted (set by AreaPopClaim, below) AND VisDistSet (set by
// AreaPopSetupPlaceables above). Deliberately NOT area_recall.nss's own
// "Used"==2 flag: that only reaches 2 inside area_recall.nss's own
// "if(iNight==0)" gate (area_recall.nss:33-321), which wraps its ENTIRE
// object-restore pass, not just a tail bookkeeping step. "Night" is a real
// in-game day/night toggle set by mod_heartbeat.nss - not a one-time boot
// flag - so an area currently in its nighttime phase would never reach
// Used==2 at all. Gating readiness on Used would mean every transition into
// a nighttime area re-hits the poll timeout in trans_arrive.nss, forever,
// not just on first visit. PopStarted has no such day/night
// coupling: once population has been attempted for an area instance, it
// stays attempted regardless of later day/night cycling.
int AreaPopIsReady(object oArea)
{
    return (GetLocalInt(oArea,"PopStarted")!=0) && (GetLocalInt(oArea,"VisDistSet")==1);
}

// Test-and-set guard so two callers landing on the same not-yet-populated
// area in the same tick (e.g. two PCs both hitting transitions.nss's fast
// path before the first one's population has finished) don't both kick off
// area_recall/placeable setup - only the first claim succeeds.
int AreaPopClaim(object oArea)
{
    if(GetLocalInt(oArea,"PopStarted")!=0){return FALSE;}
    SetLocalInt(oArea,"PopStarted",1);
    return TRUE;
}

// Call whenever a static/pooled area instance (transitions2.nss's shared
// interior pool - taverns/shops/dungeons/castles/domains/camps/sewers)
// transitions from released (Used==0) to freshly claimed by a occupant.
// PopStarted/VisDistSet are plain locals on the area OBJECT, not scoped to
// which logical coordinate currently owns it - without resetting them
// here, AreaPopClaim() only ever returns TRUE once per physical object's
// entire server-boot lifetime, so every occupant after the first-ever one
// to claim a given shared slot would silently skip both area_recall's
// dungeons.nss creature population and AreaPopSetupPlaceables' static-
// marking, forever - exactly the "no creatures, not static" symptom
// reported for a revisited d_oldcastle1_00N slot.
void AreaPopReset(object oArea)
{
    DeleteLocalInt(oArea,"PopStarted");
    DeleteLocalInt(oArea,"VisDistSet");
}
