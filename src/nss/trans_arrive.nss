// Deferred population + bounded poll for transitions.nss's non-fast-path
// jumps. transitions.nss defers here (DelayCommand(0.0,...), OBJECT_SELF=oPC)
// instead of jumping immediately whenever the destination area hasn't
// finished population yet (AreaPopIsReady false) - see area_pop_inc.nss for
// what "ready" means and why area_recall + placeable setup must run in that
// order. (Named trans_arrive, not transitions_arrive: NWN resrefs cap at 16
// characters - transitions_arrive is 18 and nwn_erf refuses to pack it.)
//
// Every invocation (the initial kickoff and each subsequent poll) runs the
// same idempotent body: try to claim+run population (a no-op after the first
// successful claim, via AreaPopClaim), check readiness, and either jump or
// reschedule. No separate "phase" tracking needed.
//
// Bounded, not infinite, unlike ini_check.nss's login retry: that script
// guards a genuinely-recoverable "no area at all" state, so looping forever
// is correct there. Here a valid target area already exists by construction
// - if population somehow never finishes (a sub-script error), jumping in
// under-populated after a short timeout is a graceful degrade to exactly
// today's (pre-this-feature) status quo, not a new failure mode, so we don't
// risk stranding the player waiting forever.
#include "area_pop_inc"

const float ARRIVE_POLL_INTERVAL = 0.25;
const int ARRIVE_MAX_POLLS = 10;   // ~2.5s worst case before jumping anyway

void main()
{
object oPC = OBJECT_SELF;
object oModule = GetModule();
object oTargetArea = GetLocalObject(oPC,"PendingArriveArea");
int iPoll = GetLocalInt(oPC,"ArrivePoll");

// Area vanished from under us (e.g. destroyed by an unrelated concurrent
// abort elsewhere) - nothing sane to do, drop the pending state and bail.
if(!GetIsObjectValid(oTargetArea))
 {
DeleteLocalObject(oPC,"PendingArriveArea");
DeleteLocalInt(oPC,"ArrivePoll");
return;
 }

WriteTimestampedLogEntry("[trans_arrive] obj="+ObjectToString(oTargetArea)+" tag="+GetTag(oTargetArea)
    +" poll="+IntToString(iPoll)
    +" popStarted="+IntToString(GetLocalInt(oTargetArea,"PopStarted"))
    +" visDistSet="+IntToString(GetLocalInt(oTargetArea,"VisDistSet"))
    +" ready="+IntToString(AreaPopIsReady(oTargetArea)));

// Each population step gets its OWN DelayCommand-granted instruction budget,
// not a nested ExecuteScript sharing this script's - area_recall.nss's
// object-restore loop recreates every saved object one by one and can be
// heavy for a large placeable-built structure (a reported symptom: an entire
// castle silently missing - most likely this loop running out of a SHARED
// budget partway through, with no error, just incomplete restoration). The
// first AreaPopSetupPlaceables call (0.1s) sequences the placeable pass
// after area_recall reliably and sets VisDistSet, same timing as before -
// the poll loop below still waits on that for when to jump the player in.
// The three later re-scans (deliberately NOT tied to the poll/readiness
// loop - AreaPopIsReady() would already be TRUE right after the first
// call, so re-scanning inside that loop would never actually recur for a
// single arriving player) are a widening safety net: a light area (one
// dungeon placeable) finishes near-instantly, but a heavy one (a domain's
// ~10 slots, each several CreateObject calls via domains.nss) can still be
// mid-creation well past 0.1s or even 0.5s, silently missing static-
// marking for anything created after whichever call ran first.
// AreaPopSetupPlaceables is idempotent/repeat-safe, so these are cheap.
if(AreaPopClaim(oTargetArea))
 {
DelayCommand(0.0,ExecuteScript("area_recall",oTargetArea));
DelayCommand(0.1,AreaPopSetupPlaceables(oTargetArea));
DelayCommand(0.5,AreaPopSetupPlaceables(oTargetArea));
DelayCommand(1.5,AreaPopSetupPlaceables(oTargetArea));
DelayCommand(3.0,AreaPopSetupPlaceables(oTargetArea));
 }

if((!AreaPopIsReady(oTargetArea))&&(iPoll<ARRIVE_MAX_POLLS))
 {
SetLocalInt(oPC,"ArrivePoll",iPoll+1);
DelayCommand(ARRIVE_POLL_INTERVAL,ExecuteScript("trans_arrive",oPC));
return;
 }

if(iPoll>=ARRIVE_MAX_POLLS){WriteTimestampedLogEntry("[trans_arrive] timed out waiting for "+GetTag(oTargetArea)+" - jumping "+GetName(oPC)+" anyway");}

// Jump - identical to transitions.nss's normal (non-Gate) jump block.
location lLoc = GetLocalLocation(oModule,GetName(oPC)+"Loc");
AssignCommand(oPC,ActionJumpToLocation(lLoc));
int iH=1;object oH=GetHenchman(oPC,iH);
while(GetIsObjectValid(oH))
 {
AssignCommand(oH,ClearAllActions(TRUE));
AssignCommand(oH,ActionJumpToLocation(lLoc));
iH++;oH=GetHenchman(oPC,iH);
 }
DeleteLocalInt(oPC,"Gate");
DeleteLocalObject(oPC,"PendingArriveArea");
DeleteLocalInt(oPC,"ArrivePoll");
}
