#include "inc_flight"
// inc_conflict - "Join the conflict" battle instances (TASK-30, hybrid model).
//
// A conflict placeable (tag "conflict", a red light shaft) stands in a
// ship-travel area - space, clouds or ocean. Clicking it drops the pilot into a
// battle area cloned from that tile's OWN terrain template, and brings any
// party members riding the flight cabin along with them.
//
// Hybrid, as agreed: the cabin (inc_flight.nss) still carries followers for
// ordinary travel - the pilot hops between tiles constantly and a detached
// clone is the only thing that survives that cheaply - and only a conflict
// moves them out of it. That is one bounded transition instead of dragging
// passengers through every hop.
//
// One rule covers every environment. transitions.nss builds each exterior tile
// as CopyArea() of a "<type>000" template, and a clone keeps its source's tag
// forever, so from inside a live tile GetTag(oArea) IS its own template tag:
// space000 -> blank space, clouds000 -> blank sky, ocean000 -> blank sea. No
// per-environment branching.
//
// Instances are shared, keyed by origin coordinate + the placeable's position -
// the same key shape transitions2.nss already uses for tent/dungeon entries -
// so everyone who clicks the same shaft lands in the same live fight.

// Set on the cloned battle area, so area_save.nss leaves it alone while the
// fight is unresolved (an instance has to survive its last occupant leaving).
const string CONFLICT_IS_AREA = "IsConflictArea";
// Set on the flight owner while they are inside a conflict. inc_flight.nss's
// cabin hatch reads it to refuse "climb up to the pilot" mid-battle.
const string CONFLICT_ACTIVE  = "ConflictActive";

// The true master template for oArea's own terrain type.
//
// MUST go through the AreaTemplate_ cache rather than GetObjectByTag: a
// CopyArea() clone shares its source's tag forever, so once any clone of this
// type is alive, GetObjectByTag("space000") can resolve to that live, already
// populated clone and we would copy its contents wholesale. That is exactly
// the bug area_tmpl_boot.nss exists to prevent (and TASK-22 documents).
object ConflictTemplateFor(object oArea)
{
    object oTemplate = GetLocalObject(GetModule(), "AreaTemplate_" + GetTag(oArea));
    if (!GetIsObjectValid(oTemplate)) { oTemplate = GetObjectByTag(GetTag(oArea)); }
    return oTemplate;
}

// Clone oArea's terrain template into a fresh battle area, or OBJECT_INVALID
// if the template can't be resolved.
object ConflictCloneFor(object oArea)
{
    object oTemplate = ConflictTemplateFor(oArea);
    if (!GetIsObjectValid(oTemplate)) { return OBJECT_INVALID; }
    object oClone = CopyArea(oTemplate);
    if (!GetIsObjectValid(oClone)) { return OBJECT_INVALID; }
    SetLocalInt(oClone, CONFLICT_IS_AREA, 1);
    return oClone;
}

// The point PCs arrive at, and where the exit shaft stands: the area centre,
// matching where spawngrp_load.nss stamps and where area_resources.nss keeps
// a clear 20m box in space tiles.
vector ConflictArrivalPoint(object oArea)
{
    return Vector(IntToFloat(GetAreaSize(AREA_WIDTH,  oArea) * 10) / 2.0,
                  IntToFloat(GetAreaSize(AREA_HEIGHT, oArea) * 10) / 2.0,
                  0.0);
}

// Plant the way out. Tagged "exit", so transitions2.nss's existing exit branch
// handles the return with no new code - it reads fXExit/fYExit/AreaExitObj off
// the area, which the entry sets, and already falls back to transitions.nss
// when the origin tile was destroyed while we were inside (the usual case for
// a lone pilot, whose tile empties the moment they leave).
void ConflictSpawnExit(object oArea)
{
    vector vAt = ConflictArrivalPoint(oArea);
    object oExit = CreateObject(OBJECT_TYPE_PLACEABLE, "conflict_exit",
                                Location(oArea, Vector(vAt.x, vAt.y - 3.0, vAt.z), DIRECTION_SOUTH));
    SetLocalInt(oExit, "DontSave", 1);
    SetObjectVisibleDistance(oExit, 200.0);
}

// Record where the fight came from, so the exit branch can send people back.
// Mirrors exactly the locals transitions2.nss's entry branch writes.
void ConflictSetReturn(object oClone, object oOrigin, object oShaft, string sPlanet, string sArea)
{
    SetLocalString(oClone, "Planet",   sPlanet);
    SetLocalString(oClone, "Area",     sArea);
    SetLocalString(oClone, "AreaExit", sArea);
    SetLocalObject(oClone, "AreaExitObj", oOrigin);
    SetLocalFloat(oClone, "fXExit", GetPosition(oShaft).x);
    SetLocalFloat(oClone, "fYExit", GetPosition(oShaft).y - 1.0);
}

// Move oPC and their henchmen into the battle.
void ConflictJump(object oPC, location lDest)
{
    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionJumpToLocation(lDest));
    int iHench = 1;
    object oHench = GetHenchman(oPC, iHench);
    while (GetIsObjectValid(oHench))
    {
        AssignCommand(oHench, ClearAllActions(TRUE));
        AssignCommand(oHench, ActionJumpToLocation(lDest));
        iHench++;
        oHench = GetHenchman(oPC, iHench);
    }
}

// Bring the pilot's cabin passengers into the fight with them, clearing the
// flight locals FlightExitTo would normally clear so the cabin tears itself
// down behind them. Followers keep their FLIGHT_BOARD_LOC-free state: the
// conflict's own exit is what returns them, alongside the pilot.
void ConflictBoardCabinParty(object oOwner, location lDest)
{
    object oMember = GetFirstFactionMember(oOwner, TRUE);
    object oCabin = OBJECT_INVALID;
    while (GetIsObjectValid(oMember))
    {
        if (oMember != oOwner)
        {
            object oTheirCabin = GetLocalObject(oMember, FLIGHT_CABIN);
            if (GetIsObjectValid(oTheirCabin) && (GetArea(oMember) == oTheirCabin))
            {
                oCabin = oTheirCabin;
                DeleteLocalObject(oMember, FLIGHT_CABIN);
                DeleteLocalLocation(oMember, FLIGHT_BOARD_LOC);
                ConflictJump(oMember, lDest);
            }
        }
        oMember = GetNextFactionMember(oOwner, TRUE);
    }
    // Anchored to the module via the owner, not to the cabin we are emptying -
    // destroying the object a DelayCommand was scheduled from cancels it, the
    // lesson TASK-17 spent several iterations on.
    if (GetIsObjectValid(oCabin))
    {
        AssignCommand(oOwner, DelayCommand(6.0, FlightDestroyCabinIfEmpty(oCabin)));
    }
}
