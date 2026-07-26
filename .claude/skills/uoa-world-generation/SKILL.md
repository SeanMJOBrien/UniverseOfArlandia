---
name: uoa-world-generation
description: Use this skill when working on UniverseOfArlandia's procedural world-building systems - the area population/spawn pipeline (pooled/cloned areas, creature and resource spawns, tavern henches), the player-built domain/structure system (build menus, resource costs, structure placement and rotation), or the monster camp/fort layout system (tiered camps up to walled forts with cannons). Trigger on "spawn", "population", "domain", "structure", "camp", "fort placement", "rotate", "area recall", or a report that spawned content is missing/duplicated/misplaced.
---

# UniverseOfArlandia world-generation systems

Three interlocking procedural-content systems, all built the same way: a
NWScript dispatcher reads persisted state off an area/module object and
calls `CreateObject` in a loop with hardcoded local offsets. None of it has
a design doc beyond the code itself - this skill is that map, plus the bug
classes specific to "generate a pile of placeables/creatures into an area on
demand" that have bitten this codebase repeatedly.

For the general NWScript logic-bug-hunting method (not specific to these
systems), see the `nwn-logic-debug` skill. This skill is the domain
knowledge that method needs applied here.

## 1. Area population ("spawn") pipeline

Entry coordinate → physical area object → content. Read in this order when
touching any of it:

```
transitions.nss      resolves planet+area coordinate -> physical area object
                      (CopyArea() clone, or a claim from transitions2.nss's
                      shared pool for interiors: taverns/shops/dungeons/
                      castles/domains/camps/sewers). Caches the resolved
                      object per coordinate on the module
                      (GetLocalObject(oModule, sPlanet+"_"+sArea)).
trans_arrive.nss      deferred population + bounded poll (DelayCommand(0.0,...),
                      its own instruction budget). Claims population via
                      AreaPopClaim, kicks off area_recall.nss, then re-scans
                      for static-marking/view-distance at 0.1/0.5/1.5/3.0s.
area_pop_inc.nss      AreaPopClaim/AreaPopIsReady/AreaPopSetupPlaceables/
                      AreaPopReset - the population-state locals shared
                      between trans_arrive.nss and area_enter.nss (the
                      fallback path for jumps that skip transitions.nss).
area_recall.nss       the main dispatcher: cities/commoners, area_interests
                      (-> domains.nss for Domain interests), area_creatures
                      (-> monster camps, see section 3), area_resources,
                      dungeons.nss, area_tavernspawn.nss (reroll 3 random
                      adventurer henches for tavern hire).
```

Every trigger in `area_recall.nss`'s dispatch block is gated on some
combination of `iReady!=1` / `GetIsDay()` / `iNight==0` so it only fires on
genuine first population, not on every `OnAreaEnter` - if you add a new
trigger here, gate it the same way or it will silently duplicate its output
on every re-entry (see Pitfall 3 below).

### Pooled/cloned area gotchas

- **Static/pooled interiors are reused, not recreated.** `transitions2.nss`
  claims a shared physical object from a pool (`SetLocalInt(oTargetArea,
  "Used",1)`) rather than cloning fresh. `PopStarted`/`VisDistSet` locals
  live on the physical object, not the logical coordinate - `AreaPopReset()`
  must run on every claim or the second-ever occupant of a slot gets no
  population at all (Pitfall 2).
- **`area_save.nss` destroys per-coordinate clones** (`IsCopy==1`) and must
  clear the module's coordinate→area cache (`DeleteLocalObject`) in the same
  breath, or the next resolve to that pooled object returns a stale/wrong
  reference (Pitfall 1).

## 2. Domain (player-built structure) system

`domains.nss` is the core dispatcher - one `while(iSlot<iTot)` loop over up
to 10 building slots per domain, each slot computing a pivot
(`fPX,fPY,fPZ`) and branching on structure type (`if(iChoice3==N){...}`,
~20 types, School/Extractor/Factory/Farm/Shop/etc).

### Persisted state

- **Interests string** (`GetPersistentString(oModule,sPlanet+"&"+sArea+
  "&Interests")`): hand-rolled delimited encoding,
  `type&1&master&2&slotdata&3&visible&4&`, where slotdata is
  `type%level_01_type%level_02_..._10_name_11_`. Parsed via 10x copy-pasted
  `GetStringLeft/Right/FindSubString` chains (domains.nss:16-45) - fragile,
  flagged in TODO.md TASK-01 for migration to `Between()`/`EncodedField()`.
  **Don't add new fields to this format** - see the `Rot` key below for the
  pattern to follow instead.
- **`Domain_Build`** (area local string, `"<slot>_+_<structureType>"`):
  scopes the slot loop to one slot (`iChoice2!=0` at domains.nss:99
  sets `iTot=iChoice2; iSlot=iChoice2-1`, so exactly one iteration runs).
  Used by both the interactive build flow and the rotate-rebuild flow.
- **`Domain_Ini`** (area local int, one-shot, self-deletes at the end of
  `main()`): **1 = "just re-render already-persisted state, don't charge
  anything"** (the normal area-population call, and the rotate-rebuild
  call). **0 (default) = "this is an interactive purchase/upgrade, run the
  payment footer"** (deducts resources+gold, rewrites the Interests string).
  Every caller must set this explicitly before `ExecuteScript("domains",
  oArea)` - domains.nss deletes it itself afterward, so callers never need
  to clean up. Get this backwards and you either silently skip building
  content or double-charge the player.
- **`Domain_Upgrade`** (area local int, same one-shot shape): set by
  `conv_domain004.nss` for the level-up flow; makes the slot loop re-read
  `iChoice3` from the persisted type even when not doing a fresh build.
- **`Rot`** (new, per-slot persistent int, `sPlanet+"&"+sArea+"&Rot&"+slot`):
  0-3, one of {0°,90°,180°,270°}. Deliberately **not** folded into the
  Interests string - a parallel independent key so old domains default to
  rotation 0 via `GetPersistentInt`'s natural default, no migration needed.
  This is the pattern to follow for any future per-slot metadata: a new
  parallel persistent key, not a new field jammed into the fragile encoded
  string.

### Placement and rotation

Every structure block places each piece (flag/house/doors/sign/etc) via a
local offset (`fX,fY,fZ,fF`) relative to the slot's pivot, historically via
`Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF)` - **all 358 call
sites in the file used this exact literal pattern** (verified by grep, zero
exceptions), which is why rotation could be added as one wrapper function
instead of ~20 hand-edits:

```nss
location DomainLoc(object oArea, float fPX, float fPY, float fPZ, float fX, float fY, float fZ, float fF, int iRot)
{
    vector vOff = RotateOffset90(fX, fY, iRot);
    return Location(oArea, Vector(fPX+vOff.x, fPY+vOff.y, fPZ+fZ), RotateFacing90(fF, iRot));
}
```

`RotateOffset90`/`RotateFacing90` live in `_string_utils.nss` - exact
axis-swap + sign-flip (no trig, always a 90° multiple). `iRot` is read once
per slot iteration from the `Rot` persistent key. **Any new structure type
or new piece within an existing type should call `DomainLoc(...)` the same
way as everything else in the file** - don't hand-roll a `Location()` call,
or that piece silently won't rotate with the rest of the structure.

Rotating an *already-built* structure (`domain_rotate.nss`, the action
script on the structureflag's own dialog reply) is: bump `Rot`, destroy the
slot's existing pieces (matched on `Slot`+`Master` locals, every piece
carries both), then re-run `domains.nss` for that one slot with
`Domain_Ini=1` (skips payment - see above). If you add a similar
"regenerate this slot" flow elsewhere, follow the same shape.

### The dialog wizard state machine

`domain.dlg.json` is one large tree (145 entries / 388+ replies) serving
**two different speaking contexts** with the same conversation resref
(`Conversation="domain"` on both the `domaincontrol` blueprint and the
`structureflag` blueprint) - `StartingList`'s `Active` conditions
(`cond_domain004`/`cond_domain005`/etc) branch on `GetTag(OBJECT_SELF)` to
pick the right greeting. When editing this dialog, know which context
you're in: `domaincontrol` (found/manage the whole domain) or
`structureflag` (interact with one already-built structure - `Slot`/
`Structure`/`Master` locals already present on `OBJECT_SELF`, no picker
needed).

Numbered choices are captured by a generic `conv_choiceN.nss` family
(N=0..25ish): each increments `GetLocalInt(OBJECT_SELF,"Step")` and records
`SetLocalInt(OBJECT_SELF,"Choice"+iStep,N)` - so a multi-screen menu walk
produces `Choice1`, `Choice2`, `Choice3`... in order, read back by the
terminal action script (`conv_domain003.nss` for the main build/manage
menu). `cond_choiceN.nss` gates a numbered reply on
`GetLocalInt(OBJECT_SELF,"ChoiceDoneN")!=1` - a "screen setup" script
(e.g. `conv_domain006.nss`) runs on entering a menu and sets/clears
`ChoiceDoneN` per option to show only what's currently valid.

**Editing the GFF directly**: `EntryList`/`ReplyList` are flat arrays;
`__struct_id` always equals array position (verified, not just assumed -
check this holds before appending if the tool version changes). A new
node is a pure append (new `__struct_id` = old array length) plus one new
`{Active, Index, IsChild}` pointer added to the parent's
`RepliesList`/`EntriesList` - existing structs are never renumbered, so
this is safe to do without touching anything else. **Always round-trip
through `nwn_gff`** after hand-editing dialog JSON:
```
nwn_gff -i src/dlg/X.dlg.json -o /tmp/X.dlg -k gff       # pack (NOT -k json - see below)
nwn_gff -i /tmp/X.dlg -o /tmp/X_roundtrip.json -k json -p # unpack
python3 -c "import json; a=json.load(open('src/dlg/X.dlg.json')); b=json.load(open('/tmp/X_roundtrip.json')); print(a==b)"
```
**Gotcha**: `-k json` on the *output* of the pack step silently writes JSON
back out instead of packing to binary GFF (both files start with `{` -
easy to miss). Use `-k gff` for JSON→GFF, `-k json -p` for GFF→JSON.

## 3. Monster camp / fort layout system

`area_creatures.nss` (~line 850-1040), gated on the area being an exterior,
non-cloud/gaz/ocean/space/airship tile. Tier is `iCampSize` (1/2/3, or a
plain `Random(45)+1` roll if no override), mapped to `iRandom1`:

| iCampSize | iRandom1 | Tier | Contents |
|---|---|---|---|
| 1 | 1 | **Little camp** (`iRandom1<6`) | one campfire + food, `DungeonRespawn=2` |
| 2 | 6 | **Big camp** (`iRandom1<9`) | full tent camp: wagons, crates, loot bags, ~15 tents, `DungeonRespawn=3` |
| 3 | 9 | **Fort** (`iRandom1<10 && iLevel>=3` - planet level gate!) | walled perimeter (`zep_fort` wall segments, 2 rows high, N/S/E/W), `zep_gateblock001` perimeter posts, 4 corner cannons (`zep_cannon001` mounted + `pla_cannon` usable variant), interior tents, `DungeonRespawn=4` |
| 0 (unset) | `Random(45)+1` | natural roll: ~11% little, ~7% big, ~2% fort (fort only above planet level 3), ~80% no camp | |

**Gotcha**: on the natural roll, landing exactly on `iRandom1==9` on a
planet below level 3 matches *no* branch (the Fort `else if` requires
`iLevel>=3`) - the roll is silently wasted, no camp spawns. Not obviously a
bug (reserving Fort for higher-level planets looks intentional) but worth
knowing if a "camp roll happened but nothing appeared" report comes in.

`iCampSize` can be forced two ways, both read before the natural roll:
`GetLocalInt(OBJECT_SELF,"CampSize")` (live DM override, always wins) or
`GetPersistentString(oModule,sPlanet+"&"+sArea+"&ForcedCamp")` (permanent
assignment from TASK-14/15's guaranteed-nearby-camp-with-mission feature in
`missions.nss`). Every camp placeable gets `SetLocalInt(oNew,"Camp",1)` -
the marker used to identify/destroy camp content elsewhere (e.g. when a
domain is founded on a former camp site, `conv_domain002.nss` iterates and
destroys everything tagged `Camp==1`). `CampSpawned` (persistent string,
set after any tier successfully spawns) lets the plot-giver clear-it-out
mission tell "never visited" apart from "visited and cleared" without the
area's live object needing to still be loaded.

All camp placement is **hardcoded local offsets**, same shape as the domain
system but with no rotation support today - if that's ever wanted, the
domain system's `DomainLoc`/`RotateOffset90` approach is the template,
though camp offsets aren't all built from a single common literal pattern
the way domains.nss's were, so verify the call-site pattern with grep
before assuming a single mechanical rewrite covers it.

## Pitfall catalog (all previously hit in this codebase)

Full symptom→mechanism→fix writeups with commit hashes live in the
`area-population-bug-reference` project memory
(`~/.claude/projects/-home-qlippoth-git-UniverseOfArlandia/memory/`) - read
that before re-diagnosing one of these from scratch:

1. **Stale coordinate→area cache** after a pooled/cloned area is destroyed
   (`area_save.nss` must clear the module's cache entry, not just
   `DestroyArea()`).
2. **Pooled-object reuse without resetting population state**
   (`PopStarted`/`VisDistSet` live on the physical object; every claim from
   `transitions2.nss`'s pool must call `AreaPopReset()`).
3. **Missing re-entry guard** causes duplicate content generation (every
   trigger in `area_recall.nss`'s dispatch needs an `iReady!=1`-shaped
   gate, or it re-fires on every `OnAreaEnter`, not just first population).
4. **Nested `ExecuteScript` sharing the caller's instruction budget** -
   heavy content generation (a domain's 10-slot loop, `dungeons.nss`'s
   castle population) silently truncates mid-run with no error if called
   as a bare nested `ExecuteScript()` instead of `DelayCommand(0.0,
   ExecuteScript(...))`. The diagnostic log line printed right before the
   generating code can still show correct values even when the tail end of
   the chain never ran - don't trust "the log looks right" as proof the
   `CreateObject` calls actually happened.

## Debugging technique

- `ObjectToString(object)` in diagnostic `WriteTimestampedLogEntry` calls to
  tell "the same physical object logged twice" apart from "two different
  objects."
- `docker logs uoa_nwserver_1 --since 1h | grep -E '\[transitions\]|\[area_interests\]|\[domains\]'`
  filtered to the coordinate/area in question.
- **Timezone**: container clock is UTC, host shell is PDT (UTC-7) - confirm
  the offset explicitly before reasoning about log-vs-deploy ordering.
- Deploy only via `/home/qlippoth/uoa/build_deploy.sh` - the repo's own
  `.build/modules/UOA.mod` is local staging only and never reaches players.
