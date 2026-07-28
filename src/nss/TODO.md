---
project: Universe of Arlandia — src/nss
updated: 2026-06-09
completed_tasks:
  - Fixed bitwise & → && logic bug in lamp.nss:101
  - Created _constants.nss (delimiter constants FIELD_1..30, FIELD_A..L, OBJ_A..Z, IDX_01..11)
  - Created _string_utils.nss (Between, EncodedField, LetterField helpers)
  - TASK-14: guaranteed nearby camp + plot-giver clear-it-out mission per city/town
  - TASK-15: smooth sky-descent arrival for airship/spaceship placeables
validate_with: compile via nwnsc; test in-game or on test server (no unit test framework)
---

# NWScript TODO — Universe of Arlandia

Each task below is self-contained. Fields:
- **action**: what to do
- **files**: where to do it (path:line where known)
- **pattern**: before → after transformation (for mechanical tasks)
- **constraint**: blockers or caveats
- **verify**: how to confirm the task is complete

---

## HIGH

---

### TASK-01: Migrate raw string parsing to Between() / EncodedField()
- **status**: todo
- **action**: Replace all nested GetStringLeft/GetStringRight/FindSubString chains with calls to `Between()`, `EncodedField()`, or `LetterField()` from `_string_utils.nss`. Add `#include "_string_utils"` to each file changed.
- **files** (highest density first):
  - `src/nss/transitions.nss`
  - `src/nss/area_ambiances.nss`
  - `src/nss/area_creatures.nss`
  - `src/nss/area_recall.nss`
  - `src/nss/planet_take_off.nss`
  - `src/nss/enigms.nss`
  - `src/nss/conv_enigm002.nss`
  - `src/nss/domains.nss`
  - `src/nss/interests.nss`
  - `src/nss/stores.nss`
- **pattern**:
  ```
  BEFORE:
    GetStringRight(GetStringLeft(s, FindSubString(s,"&002&")),
      GetStringLength(GetStringLeft(s, FindSubString(s,"&002&")))
      - FindSubString(s,"&001&") - 5)

  AFTER:
    Between(s, FIELD_1, FIELD_2)
  ```
  ```
  BEFORE:
    GetStringLeft(s, FindSubString(s,"&001&"))

  AFTER:
    Between(s, "", FIELD_1)
  ```
  ```
  BEFORE:
    GetStringRight(s, GetStringLength(s) - FindSubString(s,"&001&") - 5)

  AFTER:
    Between(s, FIELD_1, "")
  ```
- **constraint**: Delimiter lengths are 5 chars for `&001&` style, 3 for `&A&` style, 3 for `_A_` style. The legacy arithmetic subtracts the delimiter length — Between() handles this automatically so the subtracted constant must be removed, not kept.
- **verify**: `grep -c "FindSubString" <file>` should drop to 0 or near-0 in converted files. Compile with nwnsc after each file.

---

### TASK-02: Add missing object validity checks
- **status**: todo
- **action**: Before any call to `DestroyObject()`, `ChangeToStandardFaction()`, or `ApplyEffectToObject()`, add a `GetIsObjectValid()` guard if one is not already present.
- **files**:
  - `src/nss/mod_resting.nss` — `DestroyObject(oFood)` with no prior validity check
  - `src/nss/area_recall.nss:71` — faction change without object validation
  - `src/nss/henchs.nss` — multiple unguarded object operations
- **pattern**:
  ```
  BEFORE:
    DestroyObject(oFood);

  AFTER:
    if (GetIsObjectValid(oFood)) DestroyObject(oFood);
  ```
- **constraint**: Do not add validity checks inside loops that already break on `!GetIsObjectValid()` — that would be redundant. Only add at call sites that have no guard anywhere in their control flow path.
- **verify**: `grep -n "DestroyObject\|ChangeToStandardFaction\|ApplyEffectToObject" <file>` — manually confirm each call has an enclosing validity check.

---

### TASK-03: Break up monolithic files
- **status**: todo
- **action**: Extract logical sections of each large file into focused helper include files. No function should exceed ~80 lines. Each extracted file should have a single clear responsibility.
- **files**:
  - `src/nss/dmfi_execute.nss` — 3,940 lines (check if third-party DMFI before editing)
  - `src/nss/dmfi_voice_exe.nss` — 3,391 lines (same caution)
  - `src/nss/dungeons.nss` — 1,509 lines
  - `src/nss/domains.nss` — 1,685 lines
  - `src/nss/nwnx_redis.nss` — 5,906 lines (likely third-party NWNX — do not edit)
- **constraint**: `dmfi_execute.nss`, `dmfi_voice_exe.nss`, and `nwnx_redis.nss` may be upstream third-party files (DMFI / NWNX projects). Confirm provenance via git log or file headers before refactoring — upstream patches would overwrite local changes. Skip if third-party.
- **verify**: All functions in refactored files are ≤80 lines. nwnsc compiles cleanly. In-game functionality unchanged.

---

## MEDIUM

---

### TASK-04: Remove redundant boolean comparisons
- **status**: todo
- **action**: Replace explicit `== TRUE` and `== FALSE` comparisons in conditionals with direct boolean expressions.
- **files**:
  - `src/nss/nw_c2_default4.nss:43` — `if (GetHasEffect(...) == TRUE)`
  - `src/nss/lamp.nss` — `if((GetIsNight() == 0) & ...)`
  - `src/nss/conv_*.nss` — scattered instances
- **pattern**:
  ```
  BEFORE:  if (GetHasEffect(EFFECT_TYPE_SLEEP, oPC) == TRUE)
  AFTER:   if (GetHasEffect(EFFECT_TYPE_SLEEP, oPC))

  BEFORE:  if (GetCommandable(oSelf) == FALSE)
  AFTER:   if (!GetCommandable(oSelf))

  BEFORE:  if (GetIsObjectValid(oEnemy) == TRUE)
  AFTER:   if (GetIsObjectValid(oEnemy))
  ```
- **constraint**: In NWScript, integers are used as booleans (0=false, non-zero=true). `== TRUE` compares to the integer 1 specifically, which is safe to remove only when the function is documented to return exactly TRUE(1) or FALSE(0) — all NWN engine functions do. Custom functions returning other non-zero integers should be checked first.
- **verify**: `grep -rn "== TRUE\|== FALSE" src/nss/` returns 0 results.

---

### TASK-05: Add named constants for magic numbers in _module.nss
- **status**: todo
- **action**: Identify unexplained numeric literals in game-logic scripts and add named constants for them in `_module.nss` (which already holds game balance values).
- **files**:
  - `src/nss/mod_heartbeat.nss:95` — `>= 12` (wait threshold in ticks — what interval?)
  - `src/nss/rustmonster_dmg.nss` — `+ 288` (weapon wear increment per hit)
  - `src/nss/mod_resting.nss` — `<= 50.0` (guild proximity distance in metres)
  - `src/nss/_module.nss` — add constants here
- **pattern**:
  ```
  BEFORE:  if(GetLocalInt(oPC,"Wait") >= 12)
  AFTER:   if(GetLocalInt(oPC,"Wait") >= WAIT_TICKS_THRESHOLD)
  ```
- **constraint**: Confirm the meaning of each magic number before naming it — check surrounding code comments and in-game behaviour. Do not guess names.
- **verify**: `grep -n "288\|<= 50\.0" src/nss/` finds only the constant definition, not raw literals.

---

### TASK-06: Cache parsed data on heartbeat/area-enter scripts
- **status**: todo
- **action**: Store parsed planet/area values as local variables on the module or area object on first parse; read from cache on subsequent calls instead of re-parsing the raw string.
- **files**:
  - `src/nss/mod_heartbeat.nss`
  - `src/nss/area_recall.nss`
  - `src/nss/area_ambiances.nss`
- **pattern**:
  ```
  BEFORE (runs on every heartbeat):
    string sPlace = Between(sPlanetData, FIELD_1, FIELD_2);

  AFTER:
    string sPlace = GetLocalString(GetModule(), "CACHE_planet_place");
    if (sPlace == "") {
        sPlace = Between(sPlanetData, FIELD_1, FIELD_2);
        SetLocalString(GetModule(), "CACHE_planet_place", sPlace);
    }
  ```
- **constraint**: Cache must be invalidated if the underlying pwdata record changes. Add a `ClearPlanetCache()` call wherever the planet record is written.
- **verify**: Add a debug `SendMessageToPC` counter and confirm parse runs once per cache lifetime, not every tick.

---

### TASK-07: Fix uninitialized variables
- **status**: todo
- **action**: Initialise all variables to a safe default at the point of declaration.
- **files**:
  - `src/nss/mod_resting.nss:110` — `int b;` used in `while(b < iUOAreferences)`
  - `src/nss/wear.nss:50` — same pattern `int b;`
- **pattern**:
  ```
  BEFORE:  int a = 16; int b;
  AFTER:   int a = 16; int b = 0;
  ```
- **constraint**: Confirm that 0 is the correct initial value by reading the loop that uses the variable. In both known cases the loop increments b from 0, so 0 is correct.
- **verify**: `grep -n "int [a-z];$" src/nss/*.nss` returns no results.

---

### TASK-08: Simplify complex conditional expressions
- **status**: todo
- **action**: Extract multi-clause conditionals into named boolean variables declared immediately before the `if`.
- **files**:
  - `src/nss/area_recall.nss:279` — 10+ AND/OR sub-expressions on one line
  - `src/nss/area_recall.nss:29` — 8+ validity conditions chained
- **pattern**:
  ```
  BEFORE:
    if((GetStringLeft(GetTag(OBJECT_SELF),4)=="city") &&
       (GetIsDay()) &&
       ((GetStringRight(GetStringLeft(GetTag(OBJECT_SELF),5),1)=="a") || ...))

  AFTER:
    string sTag       = GetTag(OBJECT_SELF);
    int bIsCity       = GetStringLeft(sTag, 4) == "city";
    int bIsDaytime    = GetIsDay();
    string sFifthChar = GetStringRight(GetStringLeft(sTag, 5), 1);
    int bValidZone    = sFifthChar=="a" || sFifthChar=="b" || ...;
    if (bIsCity && bIsDaytime && bValidZone)
  ```
- **constraint**: Preserve exact logical equivalence. Test the refactored condition against the same input cases as the original.
- **verify**: nwnsc compiles cleanly; behaviour in-game is identical.

---

## LOW

---

### TASK-09: Rename single-letter variables
- **status**: todo
- **action**: Replace single-letter variable names (`i`, `j`, `k`, `n`, `s`, `l`) with descriptive names scoped to their purpose.
- **files** (worst offenders):
  - `src/nss/cond_hench001.nss` — `int i`, `int j`, `int k`
  - `src/nss/conv_null001.nss` — `int i`, `int j`, `int k`
- **pattern**:
  ```
  BEFORE:  int i=1; int j; object oHenchs; int k=1;
  AFTER:   int iHenchSlot=1; int iHenchCount; object oHenchs; int iLoopIndex=1;
  ```
- **constraint**: Rename only within files being otherwise refactored to avoid churn-only commits. Loop counters in very tight, obvious loops (`for(int i=0; i<3; i++)`) may be left as-is.
- **verify**: `grep -n "\bint [ijkns]\b" <file>` returns 0.

---

### TASK-10: Remove commented-out code
- **status**: todo
- **action**: Delete dead code blocks that have been commented out. Git history preserves them if needed.
- **files**:
  - `src/nss/mod_resting.nss:105–107` — commented spell decrement block
  - `src/nss/nw_c2_omnivore.nss` — `//WalkWayPoints();`
  - `src/nss/stores.nss` — several commented variable definitions
- **constraint**: Read the surrounding context before deleting — confirm the comment is dead code, not a temporarily disabled feature with a known re-enable condition.
- **verify**: `grep -n "^[[:space:]]*//" <file>` returns only explanatory comments, not code.

---

### TASK-11: Standardise comment style
- **status**: todo
- **action**: Replace `//::`, `/* */`, and decorative `////...` dividers with plain `//` comments and `// ---` section dividers throughout.
- **files**: All files touched during other refactor tasks (do not make comment-only commits).
- **constraint**: Apply opportunistically during other tasks, not as a standalone pass. Do not change comments inside third-party files (`dmfi_*`, `nwnx_*`, `nw_*`, `x0_*`, `x2_*`).
- **verify**: `grep -rn "//:" src/nss/` matches only project-owned files, not third-party.

---

### TASK-12: Audit small stub files
- **status**: todo
- **action**: Review all .nss files under 15 lines and determine if each is intentional (NWN conversation node requirement) or could be merged.
- **files**: Run `wc -l src/nss/*.nss | awk '$1 < 15' | sort -n` to get the list.
- **known examples**: `cond_shop005.nss` (6 lines), `cond_choice1.nss` (8 lines), `ooze_attacked.nss` (5 lines)
- **constraint**: NWN's conversation system requires one script file per dialogue node. Most sub-15-line files are legitimately sized. Only merge if two files are functionally identical.
- **verify**: Merged files removed; remaining small files each have a documented reason for their size.

---

### TASK-13: Map include file dependencies
- **status**: todo
- **action**: Generate a dependency graph of all `#include` relationships to identify circular risks before splitting large files.
- **files**: All `src/nss/*.nss`
- **known stats**: `aps_include` included 83 times, `_module` 76 times, `nwnx` 36 times
- **pattern**:
  ```bash
  grep -rh "#include" src/nss/ | sort | uniq -c | sort -rn
  ```
- **constraint**: NWN's compiler does not support circular includes. Any refactor that adds new includes must not create a cycle.
- **verify**: Dependency graph has no cycles. Document result in a `INCLUDES.md` next to this file.

---

## FEATURES

---

### TASK-14: Plot-giver missions for nearby monster camps
- **status**: done — implemented as a guaranteed (not random-only) camp per
  city/town + standalone plot-giver dialog branch. `missions.nss` now
  permanently assigns one valid neighbor tile within Chebyshev distance 2
  per town (`CampMissionSite`/`ForcedCamp` persistent keys), `area_creatures.nss`
  honors that assignment over the `Random(45)` roll, and `cond_campmission.nss`
  / `conv_campoffer.nss` / `conv_campcheck.nss` wire a new
  "Tell me about the camp..." branch into `mission.dlg.json`'s existing hub
  (`EntryList[0]`, `Script=missions`). Reward is 100gp × camp tier
  (Little=100/Big=200/Fort=300), paid per-player via the goldbag once the
  camp's `Camp`-tagged creatures are all dead.
- **action**: Generate a "clear the camp" mission (plot giver, `pin_plotgiver.utw`) for any placed monster camp within 2 areas of a city or town, pointing the PC at that specific camp instead of an abstract "kill a random monster" quest. "Within 2 areas" means planet area (tile) coordinates — Chebyshev distance ≤2 on the same planet's `X_Y` grid, not a walkable-area-transition hop count.
- **files**:
  - `src/nss/missions.nss` — the mission generator/storage; already has a "Kill monster" type (`MissionType4+1..MissionType5`, ~line 350) that rolls a flavor-only kill target with no real location tie-in — the new mission type should follow the same encoded-string storage pattern (`oModule, sPlanet+sArea+"Mission"+IntToString(iNum)`, `&NNN&`-delimited fields) but reference an actual camp instead.
  - `src/nss/area_creatures.nss:849` — where camp presence is actually decided: `iRandom1 = Random(45)+1` is a **fresh, unrecorded coin-flip every time the area populates** (1-5 → Little camp, 6-8 → Big camp, 9 with `iLevel>=3` → Fort, else no camp), unless overridden by the `NoCamp`/`CampSize` area locals (`NoCamp` forced by `area_interests.nss:715` when a real Interest already occupies the area, or self-latched by `encounters.nss:100` for well-areas; `CampSize` only ever set by the DM tool `conv_dm020.nss:169`). The chosen tier's placeables get created here (tagged `SetLocalInt(oNew,"Camp",1)`) and only then does it call `dungeons.nss` (via `SetLocalInt(OBJECT_SELF,"DungeonRespawn",2/3/4)`) to populate the guarding creatures. Runs via `area_recall.nss:311`'s `iReady` gate (a volatile module local wiped every server restart), so this roll happens once per area per server boot — proactively, as soon as a player's travel approaches the area, per the "populate before the player arrives" pipeline (commit `9d76b82`).
  - `src/nss/conv_mission001.nss` / `conv_mission002.nss` — plot giver dialog scripts that read/display mission records; a new mission type needs display text handling here too (see how `MissionType4`/kill-monster is threaded through).
- **constraint**: There's no existing area-adjacency/distance helper (`grep` confirms no `AreaDistance`/`GetNearbyAreas`-style function) — will need new grid-coordinate distance logic against the planet's `AreasX<XX>` tile columns (see `www/CLAUDE.md` for the `pwdata` tile-key format towns/camps live in). Also, critically, **nothing persists "this area got a camp" anywhere** — it's a live-only `Random(45)` outcome with no `pwdata` row or module-local list recording it, only visible after the fact by scanning the area's live placeables for `GetLocalInt(oPla,"Camp")==1`. The mission generator needs that recorded at roll time — add a `pwdata`-style write (e.g. `sPlanet+sArea+"Camp"`, or append to a per-planet list) right where `area_creatures.nss:849`'s roll lands on a camp, so it survives area resets/pooling and doesn't require re-scanning live objects (which may not even be loaded if the area hasn't been visited yet this boot).
- **verify**: Not yet planned — fill in once a design is worked out (e.g., a plot giver in a town with a camp within 2 area-coordinates should offer a mission referencing that camp; talking to the plot giver of a town with no nearby camps should not offer this mission type).

---

### TASK-15: Smooth sky-descent arrival library for airship/spaceship placeables
- **status**: done — `src/nss/inc_shiparrive.nss` (`EaseShipHullIn`/
  `SpawnShipRopes`/`SpawnShipLadder`), wired into all three ship-spawn
  branches in `transports.nss`. Per follow-up clarification, view
  distance is 200m (not 400m as originally written below) matching
  `area_pop_inc.nss`'s existing static-scenery value, and only the hull
  animates the descent — ropes appear once it settles, ladder/ramp 2s
  after that, rather than all pieces descending together.
- **action** (original spec, kept for history): Build a reusable library function that eases an airship/spaceship placeable in from 20 meters above its normal resting Z, smoothly translating down to settle at the position it appears at today — instead of just popping into existence there. Also raise these placeables' view distance to 400 meters (currently unset, so they use the engine default).
- **files**:
  - `src/nss/transports.nss` — the only place airship/spaceship placeables are actually created: `zep_ship001`/`"transport1"`/"Airship" (line 158) and `zep_ship002`/`"transport2"`/"Starship" (line 174), both via `CreateObject(OBJECT_TYPE_PLACEABLE,sBP,lLoc,...)` at their final `Location(oArea,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF)` with no arrival animation. There's also a third, temporary variant at line 203 (`zep_ship00"+IntToString(iArrival)`, `DestroyObject(oPla,10.0)` — appears briefly then despawns) that's already doing some kind of arrival flourish for a different context and may be worth a look for prior art/reuse.
  - New library file (name TBD, e.g. `inc_ship_arrival.nss`) — should take the placeable, its final location, and expose one function other callers can use.
- **pattern**: The native primitive for this is `SetObjectVisualTransform(oObject, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, fValue, nLerpType, fLerpDuration, ...)` (`nwscript.nss:12012`) — a client-side visual lerp, no server-side movement/pathfinding needed (placeables can't use creature movement actions anyway). Rough shape:
  ```
  // Spawn 20m above the final resting spot, then lerp Z back down to 0 offset
  object oShip = CreateObject(OBJECT_TYPE_PLACEABLE, sBP, Location(oArea, Vector(fPX+fX, fPY+fY, fPZ+fZ+20.0), fF), ...);
  SetObjectVisualTransform(oShip, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z, -20.0, OBJECT_VISUAL_TRANSFORM_LERP_?, fDurationSeconds);
  SetObjectVisibleDistance(oShip, 400.0);
  ```
  Confirm the correct `nLerpType` constant (ease-in/ease-out/linear) against `nwscript.nss`'s `OBJECT_VISUAL_TRANSFORM_LERP_*` list, and pick a duration that reads as "descending," not teleporting.
  For visibility distance, `area_pop_inc.nss:46` already does exactly this pattern elsewhere: `SetObjectVisibleDistance(oPlaceable,200.0)` (part of last session's "200m placeable view distance" change) — same call, just `400.0` and scoped to these ship placeables specifically rather than all static scenery.
- **constraint**: Confirm `SetObjectVisualTransform`'s Z-translate is relative to the placeable's spawn transform (not absolute world Z) before wiring the lerp direction — get this backwards and the ship animates *up* out of the ground instead of down from the sky. Also confirm this transform is purely visual/client-side and doesn't affect the placeable's actual walkmesh/use-range collision during the animation (a player interacting with the ramp/rope sub-placeables mid-descent could be a problem if collision doesn't match the visual lerp).
- **verify**: Not yet planned — fill in once a design is worked out (e.g., trigger a ship arrival and confirm it visibly descends from above rather than appearing instantly; confirm it's visible from 400m away and not before).

---

### TASK-16: Mercenary ranger henchman duplicates its own equipment onto the PC
- **status**: fix deployed, not yet confirmed in-game
- **confirmed**: "mercenary ranger" is `hench020` (`src/utc/hench020.utc.json`'s `FirstName` is literally `"Mercenary Ranger (hench)"`) — one of the four static named companions (hench000/001/010/020), not a random tavern-hired "adventurer". Resolves the caveat below in favor of the `henchs.nss` action-14 lead.
- **root cause found**: two related gaps in `henchs.nss`, same bug *class* as `area_recall.nss`'s missing `iReady!=1` guard fixed earlier this session (a content-recreation script with no re-entry guard):
  1. Action 5 ("Henchs area recall" — re-entering an area where a "stay here" hench was left waiting, `henchs.nss:258`) creates a brand new hench via `CreateObject` on **every** re-entry (`SetLocalObject(oPC,"HenchObject"+IntToString(iHenchs),oHench)` at the end) but never once *read* that same local back to check for/destroy a stale instance from a previous visit first — confirmed via grep, that local was write-only. Repeatedly walking in and out of the same area left duplicate hench NPCs behind, each getting its own full equipment set from action 14 below.
  2. Action 14 itself ("Full equipment recall", `henchs.nss:652`) unconditionally `CreateItemOnObject`'d + equipped all 18 saved slots with no check the hench already had something equipped there — harmless the first time on a freshly-created, empty-inventory hench (the normal case), but would stack a full duplicate gear set on top if ever triggered twice on the same object.
- **fix**: `henchs.nss` — action 5 now destroys any existing `GetLocalObject(oPC,"HenchObject"+IntToString(iHenchs))` before creating a new one. Action 14's per-slot loop now computes the target `iSlot` first and skips the whole create+equip block if `GetItemInSlot(iSlot,oHench)` is already valid, as defense-in-depth regardless of which path triggered it. Compiled (565 scripts) and deployed.
- **verify**: Hire/leave "stay here" the mercenary ranger, walk in and out of the same area several times, confirm only one hench020 NPC is ever present and no duplicate/extra items appear in the PC's inventory afterward.

---

### TASK-17: Rotate a domain structure in 90° increments (including sign facing)
- **status**: done — option 2 chosen (rotate an already-built structure, not during the build step). `_string_utils.nss` (`RotateOffset90`/`RotateFacing90`), `domains.nss` (`DomainLoc()` wrapper + `iRot` read per slot + mechanical rewrite of all 358 matching `Location()` call sites), `domain_rotate.nss` (new action script: bumps the persisted `Rot` key, destroys the slot's existing pieces, rebuilds via the single-slot loop with `Domain_Ini=1` so no gold/resources are re-charged), `src/dlg/domain.dlg.json` (new "Rotate this structure 90 degrees." reply appended to the structure-flag's own "Structure menu:" entry, no slot-picker needed since the player is already standing at the structure). Compiled (565 scripts) and deployed. Not yet confirmed in-game.
- **action** (original spec, kept for history): Let the player choose a 0/90/180/270 rotation for a domain structure while picking what to build into a slot, so a structure's footprint/door-side/sign-facing can be turned to fit the surrounding terrain instead of always spawning in its one hardcoded orientation. The sign must rotate with the rest of the structure (it's just another piece in the same block, so this falls out of the general fix rather than needing special-casing).
- **files**:
  - `src/nss/domains.nss` — every structure block (`if(iChoice3==N){...}`, ~20 of them, lines 113-1900+) builds each piece's placement the same way: local offsets `fX/fY/fZ` + facing `fF` relative to the slot's pivot (`fPX,fPY,fPZ`), then `lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);`. Confirmed via grep that **358 of the file's ~1900 lines use that exact literal pattern**, with zero exceptions found (`grep -n 'lLoc = Location(OBJECT_SELF,Vector(' src/nss/domains.nss | grep -v 'fPX+fX,fPY+fY,fPZ+fZ),fF)'` returns nothing) — so this is a single mechanical find/replace across the whole file, not ~20 separate hand-edits, and the per-piece `fX/fY/fZ/fF` literals (e.g. the School block's sign at `fX=-1.8;fY=-6.1;fF=180.0`, `src/nss/domains.nss:1327`) stay untouched, authored in the structure's own local unrotated frame.
  - `src/nss/_string_utils.nss` — add the rotation math as two small helpers, same file the project already centralizes string/geometry-adjacent helpers in (`Between`/`EncodedField`/etc, plus the `AreaCoord` struct added for TASK-14):
    ```nss
    // Rotates a 2D offset by iRotation90*90 degrees (0-3), around the origin.
    // Exact axis-swap + sign-flip, no trig needed since it's always a multiple of 90.
    vector RotateOffset90(float fX, float fY, int iRotation90)
    {
        iRotation90 = ((iRotation90 % 4) + 4) % 4;
        if (iRotation90 == 1) { return Vector(-fY, fX, 0.0); }
        if (iRotation90 == 2) { return Vector(-fX, -fY, 0.0); }
        if (iRotation90 == 3) { return Vector(fY, -fX, 0.0); }
        return Vector(fX, fY, 0.0);
    }

    // Rotates a facing angle (degrees) by iRotation90*90 degrees, wrapped to [0,360).
    float RotateFacing90(float fF, int iRotation90)
    {
        float fResult = fF + IntToFloat(((iRotation90 % 4) + 4) % 4) * 90.0;
        while (fResult >= 360.0) { fResult -= 360.0; }
        while (fResult < 0.0) { fResult += 360.0; }
        return fResult;
    }
    ```
  - `src/nss/domains.nss` — add one wrapper that every structure block routes through instead of calling `Location()` directly:
    ```nss
    location DomainLoc(object oArea, float fPX, float fPY, float fPZ, float fX, float fY, float fZ, float fF, int iRot)
    {
        vector vOff = RotateOffset90(fX, fY, iRot);
        return Location(oArea, Vector(fPX+vOff.x, fPY+vOff.y, fPZ+fZ), RotateFacing90(fF, iRot));
    }
    ```
    then mechanically replace every `lLoc = Location(OBJECT_SELF,Vector(fPX+fX,fPY+fY,fPZ+fZ),fF);` with `lLoc = DomainLoc(OBJECT_SELF,fPX,fPY,fPZ,fX,fY,fZ,fF,iRot);` (`iRot` computed once per slot near the top of the `while(iSlot<iTot)` loop, alongside the existing `fPX/fPY` slot-pivot assignment at lines 92-101).
  - `src/nss/conv_domain003.nss` — the "Build domain" branch (`iChoice1==1`, line 43-48) currently commits immediately: sets `Domain_Build` from `iChoice2` (slot) + `iChoice3` (structure type) and runs `domains.nss` with no preview/confirm step at all. This is where a rotation choice needs to land before commit — needs a small UI decision (see constraint below) plus reading back whatever rotation the player picked into a new persisted key before `ExecuteScript("domains",oArea)` runs.
- **pattern**: **Persistence** — don't touch the existing `Domain_Build`/`Interests` encoded-string format (`sVarN` = `"type%level"`, parsed via 10x copy-pasted `GetStringLeft/Right/FindSubString` chains in `domains.nss:22-43` — fragile, and TASK-01 already flags it for a separate migration to `Between()`/`EncodedField()`). Add rotation as a parallel, independent persistent int instead: `SetPersistentInt(oModule,sPlanet+"&"+sArea+"&Rot&"+IntToString(iSlot),iRotation90)`, read back in `domains.nss` as `int iRot = GetPersistentInt(oModule,sPlanet+"&"+sArea+"&Rot&"+IntToString(iSlot));` right where `fPX/fPY` get set per slot. Absent key defaults to `0` (`GetPersistentInt`'s natural default) so every already-built domain keeps its current (unrotated) orientation with no migration needed.
- **constraint**: Needs one UX decision before implementing — how does the player actually pick the rotation? Two options, both compatible with the persistence/math design above (same `Rot` key either way):
  1. **Pick during build** (matches "the building being built" most literally): before `conv_domain003.nss`'s `iChoice1==1` branch commits, add a rotate-preview step — a dialog node that shows the pending structure choice with a "Rotate ->" option cycling `0→90→180→270→0` (write to the `Rot` key each press) and a ghost/flag preview placeable at the current rotation, then a separate "Confirm" option that actually calls `domains.nss`. Bigger scope: new dialog node(s) in whichever `.dlg` drives this menu.
  2. **Rotate after the fact** via the existing "Manage domain" branch (`iChoice1==2`, line 51+) — add a sub-option next to "Change domain description"/"Destroy Domain" that bumps a built slot's `Rot` key and re-triggers that slot's structure block. This needs `domains.nss` to support "destroy this slot's placeables and rebuild them at the current level" (it doesn't today — once built, re-running only ever adds level-up visual effects, never recreates geometry) but every piece already carries `SetLocalInt(oPla,"Slot",iSlot)` and `SetLocalInt(oPla,"Structure",iChoice3)` locals (set on every `CreateObject` call), so a destroy-then-rebuild-this-slot loop is a straightforward iterate-and-match over `GetFirstObjectInArea`/`GetNextObjectInArea` — same shape as `conv_domain003.nss`'s existing "Destroy Domain" iterate-and-destroy block (line 66-70), just filtered by `Slot`+`Structure` instead of `Master`.
  Option 2 is more useful long-term (lets a player fix a mis-rotated building without demolishing and rebuilding the whole structure) but option 1 is smaller in scope and closer to a literal reading of the request. Confirm which (or both) before implementing.
- **verify**: Not yet planned — fill in once the UX decision above is made (e.g. build/rotate a School into a slot at each of the 4 rotations and confirm the house, both doors, and the sign all rotate together and stay geometrically consistent — doors still open into the house, sign still reads facing outward — rather than just the flag/house rotating while the sign stays fixed).

---

### TASK-18: Domain structure "house" placeables are walk-through (no runtime collision)
- **status**: todo — root cause found, fix not yet chosen (deliberately logged and deferred rather than guessed at further)
- **action**: Fix (or work around) domain structures' main building placeable having no collision - a player can walk straight through Findell's School's house model at m2_0 (structureflag and both doorhouse001 doors are fine; only the main house shell lacks collision).
- **root cause, confirmed empirically this session**:
  - `NWNX_Object_SetPlaceableIsStatic` (`area_pop_inc.nss:56`, called via the population pipeline documented in the `uoa-world-generation` skill) is a **network-optimization flag only** (fewer per-client position updates) - it does **not** grant or affect walkmesh/collision. Confirmed via new `[area_pop_setup]` diagnostic logging (`area_pop_inc.nss`): the call fired correctly 8 separate times on the live house object (`useable=0`, `willMarkStatic=1` every time), yet the house remained walk-through-able throughout.
  - `nwn2house003` (the School's house blueprint, extracted from `cep2_build.hak` for inspection) ships with **no `.pwk`** (placeable-walkmesh) file, only a visual `.mdl` + `.utp` - it was authored to have its collision baked in at toolset **area-compile time**, which a runtime `CreateObject()` call never goes through.
  - **Tested and ruled out**: swapping to `ccp_house6` (which *does* ship a `.pwk`, from `"the ccp 2.2.hak"`) made no difference - still walk-through-able. `ccp_house6` is also already used elsewhere in `domains.nss` (line ~846, a different structure type) with no prior collision reports there either. This means `.pwk` presence isn't the deciding factor, and the issue is most likely a **general limitation of placeables spawned via `CreateObject()` at runtime** in this engine/HAK setup, not a specific-blueprint defect - so further blueprint-swapping alone is unlikely to fix it.
- **candidate fix directions, not yet attempted**:
  1. **Invisible collision blocker**: layer a separate placeable of a type *confirmed* to get real runtime collision (not yet verified that any placeable does - test this first, e.g. with a standard toolset object like a chest or barrel blueprint at the same footprint) underneath/around the decorative house model, sized to its footprint. Stays within the current CreateObject()-based architecture.
  2. **Tile-level stamping instead of a placeable**: this codebase already has proven runtime-walkable tile-stamping infrastructure for exactly this kind of "put a building in the world with real collision" need - see the DM area-builder feature (`dmb_inc.nss`, cluster tile data model) and the `settileLibrary`/`nwn-tile-editing` tooling referenced in project memory (`~/git/settileLibrary`). Bigger redesign: would change how domain structures are built generally, not just this one piece - worth deciding whether that's worth it before committing.
- **files**: `src/nss/domains.nss` (School's house piece, `sBP = "nwn2house003"`, in the `iChoice3==15` block), `src/nss/area_pop_inc.nss` (`AreaPopSetupPlaceables` - has diagnostic `[area_pop_setup]` logging left in for `nwn2house003` specifically, harmless to leave or remove).
- **constraint**: Whatever fix is chosen, verify it doesn't just apply to School - if it's a general CreateObject()-placeable limitation, every other domain structure type's "house"-equivalent piece almost certainly has the same problem and should get the same fix, not just this one reported case.
- **verify**: Build/rotate a School (or any domain structure) into a slot, walk directly at the house model from multiple angles, confirm it blocks movement rather than letting the PC walk through.
