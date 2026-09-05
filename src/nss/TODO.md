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
- **status**: done — option 2 chosen (rotate an already-built structure, not during the build step). `_string_utils.nss` (`RotateOffset90`/`RotateFacing90`), `domains.nss` (`DomainLoc()` wrapper + `iRot` read per slot + mechanical rewrite of all 358 matching `Location()` call sites). Compiled and deployed. Not yet confirmed in-game.
- **UX follow-up (this session)**: replaced the original single "Rotate this structure 90 degrees." reply (`domain_rotate.nss`, incremented from whatever the current rotation was) with a proper submenu per user request - `structureflag`'s "Structure menu :" now has one new reply, **"Structure Options :"**, leading to a submenu with **"Structure information."** (reuses the existing info-display entry, previously a flat top-level reply) and **"Rotation options."** (leads to a further submenu with direct **North/South/East/West** replies that set an *absolute* facing instead of cycling). `domain_rotate.nss` deleted (fully unreferenced after removing its dialog link - the orphaned reply struct itself was left in place rather than renumbering the dialog's struct array, which the `nwn-area-builder` skill's append-only invariant doesn't cover removal of). Replaced by four tiny scripts (`domain_rot_n/s/e/w.nss`) calling a new shared `DomainSetRotation(oFlag,oPC,iRot)` in `_string_utils.nss` (extracted from the old script's body, parameterized on absolute `iRot` instead of `(current+1)%4`).
  - **Compass-to-`iRot` mapping** (verify this empirically before trusting it further - derived, not confirmed in-game): domain structures default to facing South at `iRot=0`. `RotateFacing90` *adds* `iRot*90°` to a piece's facing, and the engine's own `DIRECTION_*` constants confirm facing increases counterclockwise with East=0° (`DIRECTION_EAST=0, DIRECTION_NORTH=90, DIRECTION_WEST=180, DIRECTION_SOUTH=270`, from `nwscript.nss`). Since South=270°, adding 90°/180°/270° cycles 270→0(East)→90(North)→180(West). So: **South=0, East=1, North=2, West=3** - this is what `domain_rot_n/s/e/w.nss` hardcode. `RotateOffset90`'s position-vector math (`(x,y)→(-y,x)` for `iRot=1`, a standard CCW rotation given NWN's X=East/Y=North area-coordinate convention) independently confirms the same rotational direction, so position and facing stay consistent as a structure rotates.
  - All 6 changed/new files (`_string_utils.nss`, `domain_rot_n.nss`, `domain_rot_s.nss`, `domain_rot_e.nss`, `domain_rot_w.nss`, `domain.dlg.json`) compile clean and the dialog round-trips through `nwn_gff` byte-identical.
- **client refresh follow-up (this session)**: reported that a rotated structure's new pieces keep showing their old orientation to a player already standing nearby (not freshly arriving) until they leave and re-enter the area - the client doesn't reliably redraw objects marked static (`area_pop_inc.nss`'s `NWNX_Object_SetPlaceableIsStatic`, see TASK-18's own finding on that flag) after an ad-hoc runtime destroy+recreate cycle like `DomainSetRotation`'s. Added `ForceAreaRefresh(oPC)` in `_string_utils.nss`, called automatically at the end of `DomainSetRotation` (0.5s after triggering the rebuild) - jumps the PC out to `_construction` (a permanent, always-empty utility area, confirmed via grep to have no special-case handling anywhere unlike e.g. `"initialisation"`, which is wired into `area_enter.nss`'s login-redirect logic and would misfire if reused for this) and straight back, forcing a genuine area-exit/re-enter client-side reload. Scoped to just the acting PC, matching what was asked - if other PCs standing nearby also need the same fix, extend `DomainSetRotation` to loop over `GetFirstObjectInArea`/PCs in range rather than just `oPC`.
- **found a real pre-existing bug while chasing "PC not moved at all"**: `[domain_rot]` diagnostic logging showed `DomainSetRotation` starting and completing `SetPersistentInt` for the `Rot` key, but *nothing* after that - no `[domains]` rebuild log, no `[force_refresh]` log, nothing, confirmed via the container's own `nwserverError1.txt` staying completely empty (not a runtime error/crash either). Root cause: the destroy-this-slot's-pieces loop matched on `Slot`+`Master`, which the structure's own flag placeable (`oFlag`) also carries - and `oFlag` **is** `OBJECT_SELF` for this whole script (it's the flag's own dialog action). Destroying `OBJECT_SELF` mid-script silently terminated the rest of the function's execution, including every `DelayCommand` scheduled after that point. This was likely a **pre-existing bug in the original `domain_rotate.nss` too** (same destroy-loop shape, same self-destruction), never caught because that feature's own TODO entry still said "not yet confirmed in-game" - this session's compass-submenu testing was probably the first time anyone actually clicked through the destroy+rebuild path.
  - **First fix attempt (didn't work)**: skip `oFlag` in the destroy loop and destroy it separately via its own `DelayCommand(0.0,...)` scheduled after everything else. Redeployed, re-tested - still nothing after the `SetPersistentInt`. NWN appears to tie *every* `DelayCommand` from one script instance to that instance's originating object (`OBJECT_SELF` at schedule time), and destroying that object cancels its siblings regardless of what those siblings' own explicit target objects are - so deferring the self-destruction by one tick didn't help, since it still fires (via its own `DelayCommand(0.0,...)`) before the `DelayCommand(0.1,...)` rebuild does.
  - **Second fix (fixed the stall, but exposed a third, related bug)**: `DomainSetRotation` now only does the minimum synchronous work itself (persist `Rot`, stash `iSlot`/`iStructure`/`sMaster`/`oPC` as locals on `oArea`) then hands off via `DelayCommand(0.0,ExecuteScript("domain_rot_apply",oArea))` - a new script that runs with `OBJECT_SELF=oArea` instead of the flag. The destroy loop (now matching the flag too, no more special-casing) lives there; since `oArea` itself is never one of the destroyed objects (only things *inside* it are), its own `DelayCommand`s for the rebuild and the client refresh both fired correctly this time (confirmed via logs: `[domains]` rebuild ran, `[force_refresh]` fired with valid pc/void). But the player got stranded in `_construction` after the jump-out - the jump-back never happened.
  - **Third bug found**: `area_exit.nss` schedules `area_save.nss` (which destroys per-coordinate clones, per TASK-22) 0.3s after the *last* player leaves an area. The test domain's area is exactly such a clone, and the player was alone in it - so the moment `ForceAreaRefresh`'s jump-out emptied it, `oArea` became scheduled for destruction ~0.3s later. `ForceAreaRefresh` itself runs from a `DelayCommand` originating in `domain_rot_apply.nss` (`OBJECT_SELF=oArea`), so its *own* `DelayCommand`s for the jump-back (0.5s) and confirmation log (0.7s) were still tied to `oArea`'s context - both past the 0.3s destroy point, both cancelled once `oArea` died, same bug class as the second fix above just one level deeper. A 0.2s diagnostic log (before the 0.3s destroy point) fired fine, which is what confirmed the exact timing.
  - **That fix stopped the cancellation, but not the stranding**: re-tested, `[force_refresh] 0.7s after jump-back` now fires (no longer cancelled), but `pc area=` is still empty - the jump-back *command* runs, but its *target location* is itself invalid by then, because the area it points back into is the same one `area_save.nss` already destroyed. No scheduling trick can fix this: once the source area is gone, "jump back to where you were" has nowhere to go, full stop.
  - **Conclusion on the area-transition trick**: dropped entirely. A domain's area is fundamentally a per-coordinate clone (TASK-22) that gets destroyed 0.3s after its last occupant leaves (`area_exit.nss`) - a player rotating a solo structure is typically that last occupant, so *any* jump-out-and-back trick against the SAME location reference is a dead end, not just a timing bug.
  - **Next report from the user**: rotation itself now works, but *multiple* buildings were overlaying each other - confirms the rebuild bug above is genuinely fixed (it was silently blocked entirely by self-destruction in every earlier attempt, so the original "stays showing the old orientation" symptom was very likely just that bug, not a real client rendering quirk after all), but also confirms `domain_rot_apply.nss`'s in-place single-slot destroy+rebuild wasn't reliably cleaning up prior attempts' pieces (rapid repeat clicks likely raced its own destroy-then-0.1s-rebuild window - see the corollary in the `area-population-bug-reference` project memory about deferred calls changing a caller's timing assumptions).
  - **Final design (this session) - reuse the real travel system instead of any custom destroy/rebuild or area-jump logic**: `domain_rot_apply.nss` deleted entirely. `DomainSetRotation` now only persists the `Rot` value, then calls new `DomainTravelRefresh(oPC,sPlanet,sArea)` (`_string_utils.nss`): sends the player away and straight back via `transitions.nss`'s normal `PlanetDest`/`AreaDest`/`fX`/`fY`/`fFacing` contract - the SAME mechanism ordinary map travel already uses. Since `transitions.nss` resolves its destination from the coordinate STRINGS every time (not a captured object/location reference), it doesn't matter that the original clone is destroyed by the time the return trip runs - a genuinely fresh clone gets `CopyArea()`'d and fully repopulated by `area_recall.nss`/`domains.nss` from whatever's currently persisted, which cleans up *everything* stale on that coordinate at once (not just the one slot that changed) using already-proven infrastructure instead of hand-rolled destroy loops. The return trip is scheduled via `AssignCommand(oPC,DelayCommand(1.0,DomainReturnTrip(...)))` (split into its own function, `DomainReturnTrip`) - re-anchored to `oPC`'s own lifetime for the same reason established earlier in this saga. **Confirmed working in-game** - round trip lands the player back at the same spot with a single, correctly-rotated, non-duplicated structure.
  - **Away destination changed from "one tile over" to a fixed safe coordinate**: the first version computed a neighbor tile (`ParseAreaCoord`/`FormatAreaCoord`, `(X+1,Y)`) as the away-trip target - user hit a monster camp there (`area_creatures.nss` populates exterior tiles with hostile camps fairly often, see the `uoa-world-generation` skill, and there's no way to know a neighbor's roll without having already visited it). Replaced with a fixed, user-confirmed-safe coordinate instead: planet `"Sand"`, area `"0_0"` (`DOMAIN_REFRESH_AWAY_PLANET`/`DOMAIN_REFRESH_AWAY_AREA` constants in `_string_utils.nss`). `ParseAreaCoord`/`FormatAreaCoord` are no longer used by this feature but are pre-existing general-purpose helpers (added for TASK-14), left untouched.
  - All diagnostic `[domain_rot]`/`[force_refresh]` logging from this saga has been removed along with the code it was diagnosing.
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
  - **Tested and ruled out (2nd attempt)**: layering `x3_plc_inviswal` at the house's center offset (commit `596b361`) — **reverted**, it made things worse, not better. `placeables.2da` row 818 (`resolve_2da table=placeables row=818`) labels it `"Wall: Invisible (deactivate to hide)"`, `ModelName=pwc_block_01` — it is a **visible solid block by default**; whatever BioWare campaign script normally makes it invisible (a scripted "deactivate" step, not an engine property) was never called here. Spawning it bare via `CreateObject()` at the exact same coordinates as `nwn2house003` left a plain grey box sitting on/around the School, which read in-game as "the building isn't there" - a regression, not a fix. Any future attempt at this "invisible collision blocker" direction must find and call whatever makes this placeable's model actually disappear (or pick a blueprint that's genuinely invisible with no extra scripting) before judging it — don't assume the label's "Invisible" means invisible-by-default.
- **candidate fix directions, not yet attempted**:
  1. **Invisible collision blocker**: layer a separate placeable of a type *confirmed* to get real runtime collision *and confirmed actually invisible with no extra scripting required* (verify both properties before testing in place — `x3_plc_inviswal` failed the second property, see above) underneath/around the decorative house model, sized to its footprint. Stays within the current CreateObject()-based architecture.
  2. **Tile-level stamping instead of a placeable**: this codebase already has proven runtime-walkable tile-stamping infrastructure for exactly this kind of "put a building in the world with real collision" need - see the DM area-builder feature (`dmb_inc.nss`, cluster tile data model) and the `settileLibrary`/`nwn-tile-editing` tooling referenced in project memory (`~/git/settileLibrary`). Bigger redesign: would change how domain structures are built generally, not just this one piece - worth deciding whether that's worth it before committing.
- **files**: `src/nss/domains.nss` (School's house piece, `sBP = "nwn2house003"`, in the `iChoice3==15` block), `src/nss/area_pop_inc.nss` (`AreaPopSetupPlaceables` - has diagnostic `[area_pop_setup]` logging left in for `nwn2house003` specifically, harmless to leave or remove).
- **constraint**: Whatever fix is chosen, verify it doesn't just apply to School - if it's a general CreateObject()-placeable limitation, every other domain structure type's "house"-equivalent piece almost certainly has the same problem and should get the same fix, not just this one reported case.
- **verify**: Build/rotate a School (or any domain structure) into a slot, walk directly at the house model from multiple angles, confirm it blocks movement rather than letting the PC walk through.

---

### TASK-19: Druids should have all of the dialog options Rangers have
- **status**: fix applied (not yet compiled into a full build/deployed) — scoped to the reported "cartography" skill (coordinates + tracking); no other Ranger-only dialog options were found
- **found**: the "cartography" skill is two Ranger-gated hench dialog options in `src/dlg/hench.dlg.json` (wording has no literal "ranger" text, gating is purely in the condition scripts) plus a parallel PC-side "Cartographer" talent, both keyed off `GetLevelByClass(CLASS_TYPE_RANGER,...)` only:
  - `cond_hench019` (reply "Tell me where we are." -> `conv_hench023`) and `cond_hench020` (reply "Track nearest living creature and take me to them." -> `conv_hench013`) — both required `GetLevelByClass(CLASS_TYPE_RANGER,OBJECT_SELF)>0`.
  - `conv_hench023.nss` itself re-derives a 5-tier `iCartographer` level (gating which area *types* the coordinates command works in, e.g. interior/city tier 1 up through gaz-tier 5) from the henchman's own ranger level.
  - `mod_levelup.nss` (grants the PC's own "Cartographer" goldbag flag on level-up, same 5-tier thresholds) and `mod_enter.nss:120` (grants tier 1 on login if not already set) both also gated on Ranger level only — this is what backs the player's own `analyser.nss` "tell me our coordinates" item use, a separate but parallel mechanism from the hench dialog.
- **fix**: added `||(GetLevelByClass(CLASS_TYPE_DRUID,...)>0)` to the two `cond_hench01[9,0]` gates and to the `mod_levelup.nss`/`mod_enter.nss` grant conditions; `conv_hench023.nss` and `mod_levelup.nss`'s tiering now use `max(rangerLevel, druidLevel)` instead of ranger level alone, so multiclassing between the two doesn't stack tiers. All 5 changed scripts (`cond_hench019.nss`, `cond_hench020.nss`, `conv_hench023.nss`, `mod_levelup.nss`, `mod_enter.nss`) compile clean.
- **deliberately left alone**: `mod_enter.nss:121`'s "Leader" talent (also Ranger-only) — not part of what was reported, out of scope.
- **verify**: hire/level a Druid henchman to ranger-equivalent tiers and confirm both dialog replies appear and work the same as for a Ranger hench; log in as a fresh Druid PC and confirm the goldbag `Cartographer` flag is granted and the coordinates item-use works at the same area-type tiers a Ranger of the same level gets.

---

### TASK-20: List what interests are built inside a domain
- **status**: todo — not yet investigated
- **action**: Add a way to list/display which interests (structures) are currently built in a domain, and at what slot/level. Not yet decided whether this is a dialog option (e.g. on `domaincontrol`), a DM tool report, or both.
- **files**: likely `src/nss/domains.nss` (the persisted `Interests` string parsing at the top of the file is the source of truth for slot/type/level - see the `sVar1..sVar10`/`sVar1L..sVar10R` decode block) and `src/dlg/domain.dlg.json` for a new dialog entry if that's the chosen surface.
- **verify**: not yet planned.

### TASK-21: Show terrain type on mouse-hover over an area tile
- **status**: todo — not yet investigated
- **action**: Display the terrain type of an area tile when the mouse hovers over it. Not yet confirmed whether this means the NWN:EE toolset/client (out of this codebase's control), an in-game UI (minimap/world map), or the DM area-builder / web-editor tooling in this repo.
- **files**: unconfirmed - check the DM area-builder feature (`dmb_inc.nss`, cluster tile data model - see the `uoa-world-generation` skill) and `scripts/nwn_web_editor.py` (`nwn-web-editor` skill) as the two most likely places a custom hover UI could live, if this isn't actually a base NWN:EE client feature request.
- **verify**: not yet planned.

---

### TASK-22: A world tile's clone-source template can resolve to the wrong live object, duplicating a domain's content onto an unrelated coordinate
- **status**: fix applied, not yet deployed
- **symptom**: Findell's domain (School etc.) appeared duplicated at `m1_0`, an adjacent tile with zero persisted domain data of its own (`SELECT ... FROM pwdata WHERE name LIKE '%m1_0%'` returns nothing) - confirmed not a data problem. Clicking the duplicated School's door gave "no area available" (the interior pool claim doesn't recognize a domain instance under the wrong coordinate).
- **root cause**: `transitions.nss` resolves a fresh tile's clone source via `GetObjectByTag(sNewArea+"000")` (e.g. `"rural000"`) on every single visit. `CopyArea()` clones keep their source's exact Tag forever - confirmed via the `[transitions]` log line, every rural-tile clone anywhere in the game reports `tag=rural000`, identical to the master template's own tag, with nothing ever renaming it. The moment a clone of that same tile type is alive (e.g. a domain's coordinate, actively occupied) at the instant a *different* coordinate's `CopyArea()` request comes in, `GetObjectByTag("rural000")` can resolve to that live, already-populated clone instead of the true empty master - so the new clone silently inherits a full copy of whatever the wrong "template" already contained. Timeline evidence: this was very likely triggered by TASK-18's verification testing, which kept repeatedly recreating a fully-built `rural000`-tagged `m2_0` clone right as the player walked to the adjacent `m1_0` tile ~2 minutes later.
- **fix**: new `area_tmpl_boot.nss`, run once from `mod_load.nss` before any player can log in (so no clone can possibly exist yet) - walks `GetFirstArea()`/`GetNextArea()` and caches every `"<type>000"`-tagged area's object reference as `GetLocalObject(oModule,"AreaTemplate_"+tag)`. `transitions.nss` now reads that cache first and only falls back to a live `GetObjectByTag()` if a template wasn't cached at boot. All 3 files (`area_tmpl_boot.nss`, `mod_load.nss`, `transitions.nss`) compile clean.
- **not yet done**: this only prevents *future* mis-clones - it doesn't retroactively clean up `m1_0`'s already-duplicated live clone. That clone should self-heal once vacated (`area_save.nss`'s `IsCopy==1` destroy path), same as any other per-coordinate clone; no manual DB cleanup needed since `m1_0` never had any persisted data to begin with.
- **verify**: after deploying, have a player linger in a populated domain coordinate (occupying its clone) while a second player/DM visits a fresh, never-before-visited adjacent tile of the same terrain type at the same moment - confirm the new tile comes up empty rather than duplicating the domain's structures. Also confirm `m1_0` comes up clean once its current stray clone is naturally destroyed and recreated.

---

### TASK-23: Caserne troops should be created the same way as random adventurers
- **status**: todo — not yet investigated
- **action**: Casern (`domains.nss` `iChoice3==3`) troop hiring currently creates each troop as a fixed `hench000` blueprint (`conv_domain008.nss:43`, `CreateObject(OBJECT_TYPE_CREATURE,"hench000",...)`) with Race/Class/Level set as locals and handed to `henchs.nss`. Should instead use the same blank-template + level-up approach the random-adventurer tavern-hire feature uses (`area_tavernspawn.nss`, `inc_rand_appear.nss`, and whatever feat/spell/equipment selection those lean on - see the `random-adventurer-henchman-feature` project memory for that feature's history), so a Caserne troop of the player's selected class gets properly built up (feats/spells/equipment appropriate to its level) instead of just re-skinning one fixed blueprint.
- **files**: `src/nss/conv_domain008.nss` (Casern hiring block, ~line 40-86), `src/nss/area_tavernspawn.nss`, `src/nss/inc_rand_appear.nss`, `src/nss/henchs.nss` - not yet confirmed which of these actually does the "blank template, then level it up" build vs which are appearance-only.
- **verify**: not yet planned.

---

### TASK-24: Party co-flight cabin hatch should let a follower disembark to their boarding location mid-flight
- **status**: done — implemented on branch `feature/party-coflight`
- **action**: The cabin hatch now opens a menu (self/placeable conversation `cabin_hatch.dlg`, started from `cabin_hatch.nss` OnUsed) with two options: "Climb up to the pilot" (`cabin_join.nss` -> `FlightHatchJoinOwner`, current-owner-location, logout-fallback to boarding spot) and "Drop back down to where you boarded" (`cabin_disemb.nss` -> `FlightHatchToBoarding`, always the boarding spot even while the owner is still piloting), plus "Stay aboard". `inc_flight.nss`'s old `FlightHatchToOwner` was split into `FlightExitTo` (shared jump + local-clear + empty-cabin self-destroy) and the two option functions. No cabin-area change was needed — the placeable's `OnUsed=cabin_hatch` is unchanged; only what that script does changed.
- **files**: `src/nss/inc_flight.nss`, `src/nss/cabin_hatch.nss`, `src/nss/cabin_join.nss` (new), `src/nss/cabin_disemb.nss` (new), `src/dlg/cabin_hatch.dlg.json` (new).

---

### TASK-25: tile_util.nss has no caller yet
- **status**: todo — library exists, unwired
- **action**: `tile_util.nss` was written (alongside the spawn-group-capture feature) as a self-contained, engine-only tile-editing library — grid↔world conversion, bounds-checked single-tile read/write, rotatable multi-tile "footprint" builder/apply, and snapshot/restore for undoing a stamp. It's fully documented and compiles clean, but `grep`ing the codebase turns up zero `#include "tile_util"` anywhere — nothing calls it. Original intent isn't recorded; likely candidates are letting a spawn-group capture/restamp its terrain footprint alongside its creatures/placeables (`spawngrp_save.nss`/`spawngrp_load.nss`), or a `.w`-command DM tool for reshaping terrain the same way `.warea` reshapes a whole tile. Needs a decision on which feature actually wants it before wiring it in - don't guess and bolt it onto the first plausible caller.
- **files**: `src/nss/tile_util.nss` (existing), likely `src/nss/spawngrp_save.nss`/`spawngrp_load.nss` or a new `dmb_*`/`mod_chat.nss` DM command if/when a consumer is chosen.
- **verify**: not yet planned - depends on which consumer is picked.
- **verify**: board a follower, take off; while the pilot is still aloft, use the hatch and choose "drop back to where you boarded" — confirm the follower lands back where they boarded (not at the pilot), and "climb up to the pilot" still works. Confirm the cabin clone is destroyed once empty via either path.

---

### TASK-26: Free-form ship flight paths (random entry/exit, PC-designated landing)
- **status**: done — code written and compiles clean (586 scripts, zero errors); NOT yet confirmed in-game.
- **action**: Generalise TASK-15's fixed-longitude arrival into a reusable flight-path library, so a ship can enter from any of the four area edges, land at an arbitrary point (e.g. wherever a PC used a hailing item), and depart over a different edge.
- **files**:
  - `src/nss/inc_shiparrive.nss` — rewritten around one primitive, `ShipFlyLeg(oShip, vLand, vFrom, vTo, fDuration, nLerp, fRotFrom, fRotTo)`. Everything is a client-side visual offset from the hull's real position (its landing spot); nothing moves server-side. New helpers: `ShipEdgePoint` (a point beyond a given edge, axis-aligned with the landing spot), `ShipEdgeApproachFacing`, `ShipPickEdge` (random edge, optionally excluding the arrival edge), `ShipArriveFromEdge` / `ShipDepartToEdge` (EASE_OUT in / EASE_IN out), `ShipDockRotationToward` (which 90° dock rotation puts the boarding ramp on the PC's side), and `ShipPieceAt` (one rope/ramp piece, offset+facing rotated together). `EaseShipHullIn`/`EaseShipHullOut` are kept as the fixed-longitude entry points transports.nss's scheduled arrivals still use, now implemented on top of `ShipFlyLeg`.
  - `src/nss/inc_shiparrive.nss` — `SpawnShipRopes`/`SpawnShipLadder` take a new trailing `iRotation90` (default 0 = original hardcoded layout), routing every offset through `_string_utils.nss`'s `RotateOffset90`/`RotateFacing90`. Without this, a ship landing at a PC-chosen facing puts its boarding ramp on the wrong side — the offsets are authored in world axes for a hull docked at facing 180.
  - `src/nss/area_pop_inc.nss:57` — added a `GetLocalInt(oPlaceable,"NoStatic")!=1` term to the static-marking condition. `NWNX_Object_SetPlaceableIsStatic` bakes a placeable into client-side area geometry, where it won't follow a visual transform; that function marks *every* non-useable placeable and re-scans on every poll tick, so an animating hull needs a permanent opt-out rather than a one-time undo.
  - `src/nss/transports.nss:159,171,200` — `SetLocalInt(oPla,"NoStatic",1)` alongside the existing `DontSave` on all three ship-spawn branches. Line 200's flourish ship explicitly calls `SetUseableFlag(oPla,FALSE)`, so it was definitely being marked static mid-flight.
- **constraint**: Flights are single-axis by design (a leg shares one coordinate between start and end). `ShipEdgePoint` preserves that for all four edges rather than allowing true point-to-point diagonals — a diagonal cuts across the middle of the area and is far more likely to clip through scenery, which is why TASK-15 chose a fixed longitude in the first place. Randomising the *edge* rather than the *point* keeps the guarantee.
- **unverified**: (a) `OBJECT_VISUAL_TRANSFORM_ROTATE_Z` is assumed to take degrees, not radians — the translation half is proven by TASK-15, the rotation half is new; check before trusting a non-zero rotation. (b) `ShipDockRotationToward`'s index→compass mapping is derived from the rope/ramp offsets, not confirmed in-game (same caveat TASK-17 carried for domain rotation). (c) What a player entering an area mid-flight sees — `nwscript.nss:12027` doesn't say whether an in-progress lerp is replayed on object load for a late joiner.
- **not built**: the hailing item itself. The library supports it (`ShipPickEdge` → `ShipArriveFromEdge` → hold → `ShipDepartToEdge` over a different edge, landing at `GetItemActivatedTargetLocation()`), but no `.uti` or `mod_activate.nss` branch exists yet.
- **verify**: trigger a scheduled airship/starship arrival and confirm the descent still looks exactly as it did before this refactor (the `EaseShipHullIn` path must be behaviour-identical). Then, with a test caller, confirm a ship arrives from a random edge, its ropes/ramp land on the correct side for a non-zero `iRotation90`, and it departs over a different edge than it arrived from.

---

### TASK-27: Space asteroid Z jitter
- **status**: done — compiles clean; NOT yet confirmed in-game.
- **action**: Decorative space asteroids sat on one flat Z plane. They now get a random ±3.0m Z offset so a field reads as layered depth.
- **files**: `src/nss/area_resources.nss:69` (jitter applied to the `CreateObject` vector), `src/nss/_module.nss` (`iAsteroidJitterZ = 30`, decimetres).
- **pattern**: real Z at creation, not a visual transform — so the click hull follows the model and the offset round-trips through `area_save.nss:50` / `area_recall.nss:61` for free. Scoped to `asteroid001-003` only: `pla_asteroid` is a mineable resource whose click hull must stay on the model, and `pla_spacedung001/002` are dungeon entrances needing a predictable height.
- **constraint**: `area_resources.nss` runs under `area_recall.nss`'s `iReady!=1` gate — once per coordinate per server boot. Module locals hold the exact float Z within a session, and die on restart, so heights are stable while the server is up and re-roll on each restart. That was the requirement; no persistence work needed.
- **verify**: enter a `space0*` area and confirm asteroids sit at visibly varied heights; leave and re-enter and confirm the heights do NOT change; restart the server and confirm they do. Watch specifically for the −3.0 end putting asteroids below the walkable plane in a way that reads badly — if so, bias the range upward (`Random(41)/10.0` for 0…+4) rather than adding clamping.

---

### TASK-28: Spawn-group DM tool items had no blueprints
- **status**: done — blueprints created and round-trip through `nwn_gff`; NOT yet tested in-game.
- **action**: `spawngrp_save.nss`/`spawngrp_load.nss` and their `mod_activate.nss:54-55` dispatch branches were written and deployed, but no `spawngrab` or `spawnstamp` item existed anywhere — not in `src/uti/`, not in the live `UOA.mod`. The engine was unreachable. Both blueprints now exist, cloned from `dmtool.uti.json` (same Unique Power activation property).
- **files**: `src/uti/spawngrab.uti.json`, `src/uti/spawnstamp.uti.json` (new).
- **constraint**: the group name and level still come from `GrpName`/`GrpLevel` *locals on the item itself* (`mod_activate.nss:54`), which a DM has to set with the variable editor — there is no UI for it. Worth a `.w` chat command or a NUI panel later if this sees real use.
- **known limits of the engine these items drive**: (a) `spawngrp_load.nss:55-56` always stamps at the **area centre**, not where the DM stands. (b) `spawngrp_load.nss:68` flags every stamped object `Camp`=1, hooking it into camp despawn/clear — wrong for a permanent station, right for a clearable mission target. (c) `spawngrp_save.nss:65` stores only `dX/dY/facing/type`, no Z, and `spawngrp_load.nss:57` recomputes Z from the area tag prefix (0.0 for space) — fine for default-Z layouts, but a group whose design depends on stacked heights will flatten. (d) Auto-stamping via the camp roll never fires in space: `area_creatures.nss:887` excludes the `space` tag prefix. Manual stamping is unaffected by (d).
- **verify**: give a DM both items, set `GrpName` on `spawngrab`, decorate a staging area, activate it and confirm the "Spawn group '<name>' saved: N object(s)" message. Then activate `spawnstamp` in an empty area and confirm the layout rebuilds at the area centre.

---

### TASK-29: Space dungeon entrances could never spawn
- **status**: fixed and deployed. Not yet confirmed in-game.
- **the bug**: `area_resources.nss`'s space loop assigned `pla_spacedung001` on a roll of 1 and `pla_spacedung002` on a roll of 2, then ran a SEPARATE `if(iRandom<12){sBP="pla_asteroid";}` that overwrote both, because 1 and 2 are below 12. Neither entrance ever reached `CreateObject`, so the `d_towerb1_` and `d_spaceship1_` dungeons behind them — which exist in `src/are/` with working transition code in `transitions2.nss:122-123` — were unreachable in the entire game.
- **second bug, found while fixing the first**: spawning them would not have been enough. Both blueprints had `Useable=0` and `Static=1`, and NOTHING in a space area is wired to `transitions2` — a check of every `.utp` shows only `entry`-tagged placeables, doors and the new conflict shafts route to it. So the entrances would have appeared as unclickable scenery. `transitions2.nss`'s `sSpaceDung` branch was dead code alongside them.
- **fix**: the roll is now one `else if` chain, so an earlier match survives. The entrances are `Useable=1`, `Static=0`, `OnClick=transitions2` (useable also keeps `area_pop_inc.nss:57` from marking them static). `transitions2.nss` now checks the clicked object's OWN tag for a `pla_spacedung` prefix before falling back to the original nearest-placeable check — `GetNearestObject` excludes `OBJECT_SELF`, so an entrance could never have found itself.
- **rates**: dungeon entrances take 1% each (`iSpaceDungeonPct`), mineable asteroids keep exactly 11% (`iSpaceMineablePct`), decorative absorbs the difference and drops from 89% to 87%. Mineable density is unchanged by design. With 20-59 objects per tile, expect ~0.79 entrances per space tile, and roughly 54% of tiles holding at least one.
- **persistence: deliberately none**. Placement is re-rolled once per coordinate per server boot, like the rest of `area_resources.nss`, so entrances move between restarts. This differs from planet interests, which `_galaxy.nss:1243` writes to `pwdata` once and keeps forever. Chosen knowingly — a space dungeon found today may be gone after the next reboot.
- **verify**: see §5.6-5.8 of `docs/QA_TEST_SPEC_2026-09.md`.

---

### TASK-30: "Join the conflict" placeable — click to pull the party into a cloned battle area
- **status**: plumbing implemented and compiling clean; NOT tested in-game. Composition deliberately unbuilt (see TASK-32).
- **action**: A red light-shaft placeable standing in a ship-travel area (space / clouds / ocean). Clicking it drops the pilot into a battle area cloned from that tile's own terrain, bringing their flight-cabin passengers along. Ground areas are explicitly OUT of scope — ordinary ground battles keep working exactly as they do today, since players can already walk into and out of them.

#### The one rule that made this small
`transitions.nss:143-147` builds every exterior tile as `CopyArea()` of a `<type>000` template, and a clone keeps its source's tag forever — so from inside a live tile, `GetTag(oArea)` **is** its own template tag. One lookup therefore yields blank space in `space000`, blank sky in `clouds000` and blank sea in `ocean000`, with no per-environment branching. It must read the `AreaTemplate_` cache rather than `GetObjectByTag`, or a live clone can be copied instead of the master (the TASK-22 bug that `area_tmpl_boot.nss` exists to prevent).

#### Hybrid model (agreed)
The cabin (`inc_flight.nss`) still carries followers for ordinary travel — the pilot hops between tiles constantly, and a detached clone is the only thing that survives that cheaply. Only a conflict moves them out of it, which is one bounded transition instead of dragging passengers through every hop.

#### Files (all new/changed this session)
- `src/nss/inc_conflict.nss` (new) — `ConflictTemplateFor`, `ConflictCloneFor`, `ConflictArrivalPoint`, `ConflictSpawnExit`, `ConflictSetReturn`, `ConflictJump`, `ConflictBoardCabinParty`.
- `src/nss/conflict_pop.nss` (new) — composition hook. Runs on the fresh clone, reads `ConflictTier`, and deliberately spawns nothing yet; its header carries the agreed faction rules for whoever fills it in.
- `src/nss/transitions2.nss` — new `sTag=="conflict"` branch, and a `ConflictActive` clear in the existing `exit` branch. Instance is shared, keyed `<planet>_<area>&<x><y>&Conflict` on the module, matching the tent/dungeon key shape directly above it.
- `src/utp/pla_conflict.utp.json` (new) — tag `conflict`, appearance 826 (Lightshaft Red), `OnClick=transitions2`, Useable=1/Static=0 (a static placeable cannot be clicked at all — `area_pop_inc.nss:57`).
- `src/utp/conflict_exit.utp.json` (new) — tag `exit`, appearance 828 (Lightshaft Green). Tagged `exit` on purpose so `transitions2.nss`'s existing exit branch handles the return verbatim, including its fallback to `transitions.nss` when the origin tile was destroyed while we were inside — the normal case for a lone pilot, whose tile empties the moment they leave.
- `src/nss/inc_flight.nss` — `FlightHatchJoinOwner` now refuses while the owner has `ConflictActive`, so a lone follower can't side-door into a live fight.
- `src/nss/area_save.nss:11` — conflict clones exempted from the destroy-when-empty pass, beside the existing `IsClusterMember` exemption, so a retreating party finds the same fight on return.

#### Settled decisions
- Entry is **clicker-only** everywhere; the cabin party is the one exception, and they come as a group.
- Victory = every creature hostile to the PC dead. Surviving Defenders don't block it.
- Players leave via the exit shaft when ready, not on an auto-return.
- Factions are stock **Hostile vs Defender** — two Hostile groups would be allies and just stand there, and `src/fac/repute.fac.json` has only the 5 stock factions. Consequence: the party always has an ally side. `SetIsTemporaryEnemy(oPC, oCreature)` is the per-PC escape hatch when a Defender group needs to be hostile too.

#### Still to do
- **Composition** (TASK-32) — `conflict_pop.nss` is an empty hook today.
- **Placement** — nothing creates a conflict placeable yet. Needs the random roll (beside `area_creatures.nss`'s camp roll, with a persistent record written at roll time — `area_creatures.nss` records nothing about camps today, the gap TASK-14 found) and a DM placement branch in `mod_activate.nss`.
- **Resolution** — nothing yet detects "all hostiles dead", marks the record resolved, or tears the instance down.
- **verify**: place a `conflict` shaft in a space tile, click it as a pilot with a party aboard the cabin, confirm everyone lands in a blank clone of the same terrain type, confirm the cabin self-destroys, confirm the exit shaft returns everyone to the shaft's position even after the origin tile was torn down, and confirm the cabin hatch refuses while the pilot is inside.

---

### TASK-31: Ship decks, ghost-follow passengers, and pilot death
- **status**: designed, not implemented. This is the full model TASK-30's hybrid is a stepping stone toward; both are wanted.
- **action**: Give a ship owner's flight a real interior and a real answer to the pilot dying.

#### Design
- The ship owner is currently the only permitted pilot. Every other party member is moved to a **cloned ship deck**, mirroring the ticketed transport areas (`airship001/002`, `starship001/002`).
- The deck has a **doorway to a ship interior**, so passengers can be above on deck or below in the cabin — again as ticketed transport does.
- While in a ship-travel area (clouds / space / sea), non-pilot party members are **invisible, cutscene-ghosted, and cutscene-forced to follow the pilot**.
- Passengers can **toggle** between that follow-the-pilot observer mode and being back on the deck, so watching the flight is a choice rather than a state they're stuck in.
- **If the pilot dies**, move them — bleeding, not dead — aboard the ship deck so the party can stabilise them. Afterwards the pilot can either return to the same space location and fly on, or use a **ship control** to fly to a chosen destination like ticketed travel, with the same interruptible flight delay.
- Safe fallback destination is **Arland `0_0`** — the `citya` start tile named "Arlandia" (`_galaxy.nss:1221`). Parallels the existing `DOMAIN_REFRESH_AWAY_PLANET`/`_AREA` constants in `_string_utils.nss`.

#### Engine facts established while designing this (do not re-derive)
- **There is no cutscene invisibility.** NWScript offers `EffectCutsceneGhost` (creature-collision passthrough only — not invisibility, and not through walls), `EffectCutsceneParalyze`, `EffectCutsceneImmobilize`, `EffectCutsceneDominated`. For hiding there is only `EffectInvisibility(INVISIBILITY_TYPE_NORMAL|DARKNESS|IMPROVED)`, which is real spell invisibility: concealment, breaks on attack, defeated by See Invisibility / True Seeing.
- **The clean hiding tool is `NWNX_Visibility_SetVisibilityOverride`** (per-observer, no spell mechanics). `src/nss/nwnx_visibility.nss` is present but **the plugin is not loaded**: `~/uoa/config/nwserver.env` sets `NWNX_CORE_SKIP_ALL=yes` and has no `NWNX_VISIBILITY_SKIP=no` line. One line plus a container restart.
- **`SetCutsceneMode(oPC, TRUE)` also makes the player plot/unkillable**, restoring the prior plot flag on exit (`nwscript.nss:10754`). Useful for passengers; must be off before they can fight.
- **`ActionForceFollowObject` on a PC breaks the moment the player touches a movement key** — input clears the action queue. Follow is not actually forced without cutscene mode.
- **Force-follow does not survive an area transition.** `transitions.nss` moves ONE PC via `PlanetDest`/`AreaDest` locals; a following passenger is left in the old tile, which `area_exit.nss` then destroys 0.3s later. Since a flight is a chain of tile hops, ghost-follow needs explicit party movement on every hop — precisely the cost the detached cabin avoids. Budget for this; it is the main work in this task.
- **`area_enter.nss:151` swaps appearance to 338 for ANY PC entering a space area** (clouds→342, ocean→339), stashing the real one in `OrigApp` on the goldbag. So passengers standing in the pilot's area become ships too; invisibility is what hides that.
- **Two pre-existing bugs this task should fix**: `FlightHatchJoinOwner` checks only `GetIsObjectValid(oOwner)`, which is TRUE for a corpse — so a follower using the hatch after the pilot dies is teleported onto the body, in space. And once the pilot presses respawn, `mod_respawn.nss` jumps them to `WP_Death`, so the hatch dumps followers onto the Death plane. Both disappear once death moves the pilot to the deck instead.
- The current cabin is a **single** area (`cabin_air000` / `cabin_star000`); the deck/interior split does not exist yet and has to be built.

#### Files (anticipated)
- `src/nss/inc_flight.nss` — deck/interior split, ghost-follow mode and its toggle, per-hop passenger movement, pilot-death handling.
- New deck + interior area templates, modelled on `airship001`/`starship001`.
- New ship-control placeable and its destination dialog, modelled on the ticketed-travel conversation (`conv_trans006.nss` and friends).
- `~/uoa/config/nwserver.env` — `NWNX_VISIBILITY_SKIP=no` (outside the repo).
- **verify**: not yet planned.

---

### TASK-32: Conflict composition and tiers
- **status**: deferred by design; TASK-30 ships an empty `conflict_pop.nss` hook waiting on this.
- **action**: Decide what actually spawns in a conflict, per tier and per environment. Space "requires more systems" and is expected to differ substantially from clouds/sea.
- **constraint**: stock Hostile vs Defender only (see TASK-30) unless custom factions are added to `src/fac/repute.fac.json`, which is a build-time change — NWScript cannot create a faction at runtime.
- **verify**: not yet planned.

---

### TASK-33: GetName(oPC) is used as a database key in 96 places
- **status**: found while building ship naming (TASK-34); blocks that feature's rename half. Not started.
- **action**: Convert every `GetName(oPC)` that is used as a KEY (not as display text) to `GetName(oPC, TRUE)`, which returns the character's true name regardless of any active rename override. The two calls are identical while no override exists, so the conversion is safe to land ahead of the feature that needs it.
- **why it matters**: nothing can ever rename a PC until this is done. Renaming changes what `GetName(oPC)` returns — this is true of base `SetName()` AND of `NWNX_Rename_SetPCNameOverride`, whose own header directs you to `GetName(oPC, TRUE)` for the true name. Any renamed player silently starts reading and writing different rows.
- **worst offenders found so far**:
  - `area_exit.nss:19` — gates the whole area-save path on `GetLocalInt(oModule, GetName(oPC))`. A renamed player's areas stop saving, with no error.
  - `area_exit.nss:28` / `transitions2.nss` — the `GetName(oPC)+"Loc"` pending-arrival location, written on transition and read on exit. Rename between the two and it resolves to nothing.
  - `cond_domain004/005/018/019.nss` — domain ownership is a string compare of `GetName(oPC)` against the domain's `Master`. A renamed owner stops owning their domain.
  - `challenges.nss` (4 sites), `cond_challeng002/007.nss`, `conv_challeng001.nss` — per-player challenge progress keys.
  - `clones.nss:54`, `cond_hench008.nss` — henchman `Master` strings.
- **constraint**: display uses (`FloatingTextStringOnCreature`, `SendMessageToPC`, `SetCustomToken`, `SpeakString`, log lines) must be left alone — those SHOULD show the override once one exists. Only key uses convert.
- **verify**: with `iShipNameRename` still 0, confirm no behaviour changes at all (the two calls are equivalent). Then flip it to 1, fly a named ship, and confirm area saves, domain ownership and challenge progress all still work for the renamed pilot.

---

### TASK-34: Player-named ships
- **status**: naming, storage and the rename window are implemented and compile clean; the rename-the-pilot half is gated OFF behind `iShipNameRename` pending TASK-33. Not tested in-game.
- **action**: Let a player name each ship they own, and have that name stand in for the pilot's own while they are wearing the ship model.
- **files**:
  - `src/nss/_shipname.nss` (new) — area↔tool mapping, name storage, the NUI page/open/commit, and `ShipApplyNameForArea`.
  - `src/nss/shipname_event.nss` (new) — the window's event handler.
  - `src/nss/mod_activate.nss` — a ship tool used in its own element still opens the flight dialog exactly as before; used anywhere else it opens the rename window instead. That split is deliberate: `cond_ship001.nss` and friends gate every flight reply on the matching area, so outside it the dialog had nothing to offer, and renaming a ship is not something to do while steering it.
  - `src/nss/area_enter.nss` — `ShipApplyNameForArea` called beside the appearance swap, keyed off the area tag rather than the swap's own `iCheck` (that flag is also set for underwater and for airship/starship interiors, none of which put the PC in a ship model).
  - `src/nss/_module.nss` — `iShipNameRename` (default 0).
- **pattern**: the name lives as a local string on the tool item itself, so it travels with the character file and needs no pwdata row. `SetName(oObject,"")` reverts to the original name, so the real character name never has to be stashed.
- **verify**: use a ship tool on land — the window should open, prefilled with any existing name, and Save/Clear should both report back. Use the same tool at sea/in the sky/in space and the flight dialog should appear exactly as it does today. After TASK-33, flip `iShipNameRename` and confirm the name swaps in and out with the ship model.

---

### TASK-35: Shared domains — per-structure access grants from the domain sign
- **status**: storage, semantics and lifecycle implemented and wired; the dialog that exposes it is specified below but NOT built. Asks (2) and (3) still open.
- **action**: A domain owner grants another character the use of individual structures in their domain, managed from **the domain's own sign** — not a bank NPC. Both characters are naturally present, since granting happens at the sign.

#### Permission model
- Granularity is **per slot** (a domain has 10, `domains.nss:99`). Slot 0 is the domain-wide grant: one write instead of ten.
- A grant confers USE — collect an extractor's output, hire at a caserne, rent and decorate a house. It **never** confers building or destroying, in this or any domain.
- Grants **reset when the slot changes**. A grant is permission to use one specific structure, so it must not survive that structure being replaced. Wired at all three lifecycle points: build (`conv_domain003.nss`, `iChoice1==1`), destroy-slot (`conv_domain005.nss`), destroy-domain (`conv_domain003.nss`, `iChoice2==2`, which clears slot 0 as well). Rebuilding a slot as a different structure therefore starts with a clean list.
- Any two characters on the same **account** short-circuit the two-party requirement — `DomainSameAccount` compares public CD keys, so a player can approve their own alt alone.

#### What is built
`src/nss/_domainuser.nss` — `DomainAddUser` / `DomainRemoveUser` / `DomainRemoveUserAll` / `DomainIsGrantedSlot` / `DomainIsApprovedName` (slot grant OR domain-wide), `DomainClearSlot` and `DomainClearAllGrants` for the lifecycle resets, `DomainCanUse` and the one-call `DomainCanUseHere` (reads planet/area/slot/master straight off a sign or structure flag), `DomainCanBuild` (owner or DM only, kept a separate function so no call site can blur the split), `DomainSameAccount`, and `DomainAreaOf`. Storage is one pwdata row per (domain, slot): `<planet>&<area>&DomainUsers&<slot>`, holding an &-wrapped name list so `Al` never matches `Alice`.

#### What remains: the dialog work
The signs already carry everything needed — `domains.nss` gives each structure a `zep_sign0XX` placeable with `Master`, `Slot` and `Structure` locals and a readable name ("Airship", "Casern"), and `domaincontrol` / `structureflag` both open the `domain` conversation (`OnUsed = domain_used`).

1. **Granting UI** on the domain sign, behind the owner-only `cond_domain004`: list the PCs in the area (the module's usual fixed-replies-plus-`SetCustomToken` pattern, as `cond_choice0..26` do), then list the domain's built slots to pick which structure to grant, plus a domain-wide option and a revoke path (`DomainRemoveUser` / `DomainRemoveUserAll` exist for it).
2. **Per-reply conditions** in `src/dlg/domain.dlg.json`. `cond_domain005.nss` currently gates the ENTIRE structureflag menu on `Master == GetName(oPC)` — build, destroy, rotate, rent, production and caserne all sit behind that one condition, so it cannot simply be relaxed. Replies must be split:
   - **Stay on `cond_domain005`** (owner only): build, destroy, and the TASK-17 rotation submenu.
   - **Move to a new `cond_domainuser.nss` calling `DomainCanUseHere`**:
     - Production collection — the six structures `conv_domain006.nss:77` routes to `domain_content.nss`: Extractor (5), Factory (6), Farm (7), Field (8), House (11), Sawmill (21).
     - Caserne soldier hiring (3) — `conv_domain007.nss:26` lists tiers and prices, `conv_domain008.nss:41` creates the `hench000` soldier.
     - Rent — the replies gated today by `cond_domain018` (slot unrented) / `cond_domain019` (caller is the renter).
   Dialog edits must round-trip through `nwn_gff` before being trusted, and the struct array is append-only — add replies rather than renumbering.

#### Ask (2) — DONE, and it needed gating rather than opening
Claim-a-room-and-furnish-it turned out to be fully built already, and completely ungated. The rent menu (`domain.dlg.json` `EntryList[0]`, "Structure menu :") is its OWN root entry reached from `StartingList[6]` via `cond_domain020` — NOT nested under the `cond_domain005` structureflag menu — and `cond_domain020` used to return TRUE for any player at any House flag in any domain. So every player on the server could already rent any house anywhere.

The chain that already works: rent (`conv_domain008.nss:480` writes the renter's name to `<planet>&<area>&Domain&<slot>`) → enter (`transitions2.nss` Structure 11 sets the claimed interior's `Master` to the RENTER) → furnish (`mod_unacquire.nss:36` accepts an `ofurniture*` item in an area named "Home"/"House" when `GetName(oPC)` matches that `Master`; `h_house_001` is indeed named "House").

`cond_domain020.nss` now requires `DomainCanUseHere` — so granting a character the House slot IS designating that house for them — with the sitting tenant always let through, whether or not they hold a grant, so revoking a grant (or this change landing on a live server) never strands someone with no way to pay rent or move out. Because the rent menu is its own root entry, this needed no dialog edit at all.

**Behaviour change on a live server**: players who could previously rent any house anywhere now need a grant. Existing tenants are unaffected.

**Gap found**: furniture does NOT survive a server restart. `conv_furnitur003.nss` creates the placeable with no `Persistent` flag, so `area_save.nss:48` routes it to the module-local path — it survives the interior emptying and refilling within a session, and is lost on reboot. Setting `Persistent`=1 on placed furniture (and confirming the DB path's float truncation at `area_save.nss:65` doesn't matter at furniture scale) would fix it. This matters for ask (3), which asks for ship quarters "furnished and saved the same way".

#### Constraints and open questions
- Names as identifiers inherit TASK-33's fragility. If domain ownership moves to a stable id, these lists must move in the same change.
- Ship decks do not exist yet (TASK-31), so ask (3) stays blocked.
- **open**: which structure groups beyond production/caserne/rent an approved user should reach — Services (Guild, Hall, Inn, Mission Office, School, Shop, Tavern, Temple), Transport (Airship, Starship) and Adventure (Amusement Place, Dungeon, Tower) are all undecided. Also whether a grant holder may rent more than one property, and how many grants a domain may issue.
- **verify**: with two characters in one area, grant one the use of a single Extractor slot from the domain sign; confirm they can collect its output, cannot collect from an ungranted slot, and never see build or destroy. Rebuild that slot as something else and confirm the grant is gone. Repeat with two characters on one account, alone.

---

### TASK-36: Rent expiry — clock and auto-release done
- **status**: implemented and deployed. Not yet confirmed in-game.

#### Done: a shared, restart-proof expiry clock
Rent used to live ONLY on the tenant's goldbag, as a tick count decremented against `GetLocalInt(oModule,"Counter")`. Two problems: nobody but the tenant could read it — not the owner, not a would-be renter, not the door — and that heartbeat counter is a module local reset on every reboot, which `mod_heartbeat.nss:30` schedules routinely, so rent silently stretched at every restart.

Tenancies now carry an absolute expiry DAY in pwdata (`<planet>&<area>&Domain&<slot>Until`), read off the game calendar, which `mod_heartbeat.nss:30` saves and `mod_load.nss:37-42` restores. `DomainGameDay`, `DomainRentUntil`, `DomainRentExtend`, `DomainRentClear`, `DomainRentDaysLeft`, `DomainRentExpired` in `_domainuser.nss`; term length `iDomainRentDays` (30). Tenancies predating the clock are seeded with a full term on first read rather than treated as instantly overdue.

#### Done: auto-release on expiry
`DomainReleaseIfExpired` clears an overdue tenancy and its expiry, returning the slot to the market. Called from `cond_domain020.nss` (the rent-menu gate, so an expired slot presents itself as vacant) and `cond_domain018.nss` (the rent reply itself). Evaluated wherever a slot is looked at rather than on a timer: a tenant who stops paying may never return, so expiry cannot be detected from their own actions, and there is no index of rented slots to sweep. The owner and would-be renters are exactly the people who care whether a slot has come free.

**The escrow that once blocked this is no longer needed.** TASK-37 moved player storage out of houses and onto the account, so releasing a tenancy cannot cost anyone their belongings. The tenant's own back-pointer is not cleared at release — their goldbag is unreachable from these scripts — but `DomainHasRental` verifies against the record and heals itself, so their one-home slot frees the next time they try to rent.

#### Known limits
- A tenant gets no warning before losing a house.
- Release only happens when someone looks at the slot; a domain nobody visits keeps its expired tenants until it is next visited.
- Placed furniture in a domain house still does not survive a restart (module-local save path). Rental units solved this with their own snapshot (TASK-38); domain houses could use the same treatment.
- **verify**: rent a house, set its `Until` back in the database, then have another character open the House flag — the slot should show as available to rent. Confirm the previous tenant can then rent elsewhere.

---

### TASK-36b: House contents do not survive a restart (superseded in part)
#### Blocker: house contents already do not survive a restart
Escrowing a tenant's belongings assumes those belongings persist in the first place. They do not:
- `chestplay_close.nss` saves player-chest contents with `SetLocalString(oModule,...)` and has **zero** persistent writes — module locals, wiped on reboot.
- Placed furniture (`conv_furnitur003.nss`) is created with no `Persistent` flag, so `area_save.nss:48` routes it to the same module-local path.
- House interiors are pooled static areas claimed through `transitions2.nss`; the claim mapping is a module local too.

So on every scheduled reboot, everything inside every rented house already vanishes. Auto-release with escrow would frequently capture nothing, and — worse — releasing a tenancy WITHOUT working escrow lets the next tenant walk into whatever the previous one left. Auto-release is therefore strictly worse than the status quo until this is fixed, which is why only the clock shipped.

#### Order of work
1. **Make house contents persistent.** Player chests and placed furniture need the pwdata/campaign path rather than module locals. `StoreCampaignObject` is the module's existing tool for whole objects with gear intact (`area_save.nss:68`, `spawngrp_save.nss:64`); note `mod_load.nss:59` wipes the `AdvAreaSnap` namespace at boot, so escrow must use a different one. Decide on a per-house item cap first — `iDomainContainer` (10) is the existing precedent for container limits.
2. **Auto-release on expiry.** Evaluate `DomainRentExpired` wherever the slot is looked at — `domain_content.nss`, `cond_domain018`, `cond_domain020`, `conv_domain014` — since the tenant may never return. Release clears the tenancy, the expiry and the tenant's back-pointer (`DomainClearRented`; the marker already self-heals).
3. **Escrow on release.** Sweep the interior: loose items, container contents, and furniture converted back to its `o`-prefixed item form the way `conv_furnitur002.nss` already packs it. Key by character name, sanitised as `spawngrp_save.nss`'s `SG_Clean` does.
4. **Retrieval.** At a bank (a branch in `shop.dlg.json`, which already hosts the bank), and on renting a new house — dumped into chests there.
- **open**: per-house item cap; what happens to escrow if the character is deleted; whether the owner should be able to evict before expiry (`DomainCanBuild` would gate it).
- **verify**: rent a house, let the term lapse across a reboot, and confirm the day count shown is unchanged by the restart. Then, once escrow exists, confirm the house frees up, the belongings survive, and both retrieval paths return them.

---

### TASK-37: Player chest storage made persistent and per-account
- **status**: implemented and deployed. Not yet tested in-game.
- **problem**: UOA's four house chests (`chestplayer1-4`) wrote their contents to MODULE LOCALS (`chestplay_open/close.nss`, zero persistent writes), and `mod_heartbeat.nss:30` reboots the server on a timer — so players were silently losing everything they stored, every reboot.
- **model**, taken from The Frozen North (`~/tfndev`, `pc_storage_distu.nss` / `storage_onuse.nss`): storage belongs to the ACCOUNT (public CD key), not to a house. The chest in the world is only a portal — using it opens the player's own storage object via `NWNX_Player_ForcePlaceableInventoryWindow` (plugin confirmed enabled). The whole object is saved as ONE campaign entry per (account, slot) on `OnInvDisturbed`, contents intact.
- **why per-account rather than per-house**: it dissolves the escrow problem in TASK-36 entirely. Losing a house — evicted, demolished, rent lapsed — can no longer cost anyone their belongings, and renting somewhere new means the chests are already stocked, which is exactly what the "dump it into chests at the new lodgings" requirement asked for.
- **no item cap, deliberately**: TFN imposes none, and none is needed. Because one campaign entry holds a whole chest, row count is bounded by players x slots regardless of how many items are inside — unlike a per-item scheme, which is what made a cap look necessary earlier.
- **files**: `src/nss/_pcstorage.nss` (new), `src/nss/pcstore_distu.nss` (new), `src/nss/chestplay_used.nss` (rewritten as a portal), `src/utp/chestplayer.utp.json` (`OnInvDisturbed` = `pcstore_distu`), `src/nss/_module.nss` (`iPCStorageChests` = 4).
- **unchanged**: the four slots and their house-level gating (1 at level 1, 2 at level 4, 3 and 4 at level 5) and the Master check, which for a rented house is the RENTER.
- **migration**: the first time an owner opens a chest, anything still in the old per-house container is moved into their account store and saved. Those contents were doomed at the next reboot anyway; this just avoids losing them sooner.
- **campaign namespace** is `PCStorage`, deliberately NOT `AdvAreaSnap` — `mod_load.nss:59` destroys that one at every boot.
- **do NOT delete `chestplay_open.nss` / `chestplay_close.nss`** — checked, and they are not dead weight. A second blueprint, `deskplayer.utp.json` (tag `deskplayer0`), shares their `OnOpen`/`OnClosed` but has NO `OnUsed`, so desks never pass through the new portal and still depend entirely on the old module-local path. That is what the `sTag=="3"||sTag=="4"` branch is for: desk instances, saved lossily (resref + stack size only, items destroyed) versus the full `_A_`…`_M_` record every other tag gets. Desks therefore still lose their contents on reboot — a separate fix, same shape as this one.
- **item cap**: `iPCStorageMaxItems` (40) is enforced in `pcstore_distu.nss`, counting item STACKS not units. NWN has no per-container cap of its own — capacity is a slot grid and `baseitems.2da` gives each item type an `InvSlotWidth`/`Height` footprint — so a definite limit has to be imposed in script. It also bounds the save cost: every add or removal re-serialises the entire chest.
- **storage location**: `StoreCampaignObject` does NOT write to MySQL. It writes a local SQLite file under `~/uoa/server/database/` (`pcstorage.sqlite3`, alongside the existing `advareasnap.sqlite3`). Only `aps_include`'s pwdata/pwobjdata go to MySQL via NWNX_SQL. So chest contents are invisible to the website and are NOT covered by a MySQL dump — they need the `database/` directory backed up separately.
- **verify**: store items in a house chest, reboot the server, and confirm they are still there. Confirm a second character on the SAME account sees the same contents, and one on a different account does not. Rent a different house and confirm the chests carry over. Confirm chests 2-4 stay locked below the required house level.

---

### TASK-38: Multi-unit rental doors (apartment buildings)
- **status**: home area templates ported, cleaned and committed. The feature itself is NOT built, and deploying the templates is blocked — see below.
- **action**: Mark a door as a multi-unit rental. Using it opens a dialog listing every unit: the character renting it, or `VACANT: <size>`. Selecting a vacant unit offers to rent it. Example:
  ```
  1. Bruno Beltrix
  2. Vadil Tourn
  3. Amber Rose
  4. Gradle
  5. VACANT: Large unit
  6. VACANT: Small unit
  ```

#### Agreed design
- Doors live in **hand-built areas**, configured by a DM with **variables on the door placeable** (the pattern `spawngrab`'s `GrpName` already uses).
- **Size changes both price and interior.** Three tiers ported from tfndev: `slum` (small), `norm` (medium), `rich` (large).
- The **one-home-per-character cap applies**, shared with domain house rentals — `iDomainOneRental` and the existing `DomainMayRent` self-healing back-pointer carry over unchanged.

#### Done: home area templates ported from tfndev
12 templates — 3 tiers x 4 door facings — converted from `~/tfndev` binary GFF into `src/are`, `src/git`, `src/gic`. TFN names them `_home<tier>_<facing>` and instantiates them with `CreateArea()`, one real area per home, which sidesteps UOA's pooled-interior limit entirely (only 2 instances each of `h_house_`/`h_home1-3_` exist, so pooling caps concurrent house occupancy at 2 server-wide).

Sizes: slum 2x2, norm 4x2, rich 3x5 with three floors and internal level-to-level doors.

Cleanup applied on the way in:
- Tilesets `tni01`/`tni02` verified present in UOA (4 and 14 existing areas use them), so the templates will load.
- TFN's `storage1-6` / `gold_storage1-3` placeables replaced with UOA's `chestplayer`, tagged `chestplayer1..N` and capped at the 4 slots `chestplay_used.nss` supports; surplus containers dropped rather than left pointing at absent blueprints.
- `door_wood003` and `x3_door_wood001` (used by no UOA area) swapped for `x3_door_wood003`, which 8 UOA areas already use. `nw_door_fancy` (173 uses) and `nw_door_jeweled` (130) were left alone.
- A `Level` variable baked into each template's VarTable — slum 1, norm 4, rich 5 — so `chestplay_used.nss`'s existing level gating opens the right number of chests with no extra code.
- All 36 files round-trip through `nwn_gff`; no TFN-only blueprint references remain.

#### BLOCKER: the deploy script will not ship new areas
`~/uoa/build_deploy.sh` sets `SKIP_GFF_DIRS="ifo are git gic"` and never overlays those from `src/`. Its own header explains why: those GFFs drift between the repo and the live `.mod`, and a blanket overlay would silently revert live-only area state. The sanctioned procedure it names for such changes is to extract the live GFF, patch the single field, and convert back.

Two things are needed and both fall inside that skip:
1. The 36 new `.are`/`.git`/`.gic` resources have to reach the `.mod`. Confirmed absent after a normal deploy (`nwn_erf -t` finds zero `_home*` resources).
2. Each template needs an entry in the live `module.ifo`'s `Mod_Area_list`. TFN lists all 12 of its own, so `CreateArea()` requires it.

**Adding is safe in a way overwriting is not** — a resource that does not yet exist in the `.mod` cannot revert anything. So the options are to relax the guard to permit new-only additions, or do a one-off manual extract/patch/repack. Either is a deliberate change to live-server deployment and wants an explicit decision, not a silent workaround.

#### Built
- `src/nss/_unitrent.nss` — data model and window. Per-unit tenancy keyed on the AREA TAG plus the door's integer position (`<areaTag>&Unit&<x>_<y>&<n>`), NOT on Planet/Area: those belong to the coordinate travel system and are empty in the hand-built areas these doors are for. Rent runs on the same absolute game-day clock as domain houses.
- `src/nss/unitrent_event.nss`, `src/nss/unit_used.nss`, `src/utp/pla_unitdoor.utp.json` (tag `unitdoor`).
- `_module.nss` — `iUnitRentSmall` 250 / `iUnitRentMedium` 500 / `iUnitRentLarge` 1000 per term.
- `_domainuser.nss` — the one-home cap now covers both kinds. A `RentedKind` flag on the goldbag says whether the back-pointer describes a domain slot or a rental unit; units store their whole pwdata key, so verification needs no knowledge of `_unitrent.nss` and the include stays one-directional. Both self-heal.

**Built as NUI, not a dialog.** NWN dialog replies are fixed, so a dialog would have capped the unit count at however many reply slots were pre-made and needed `SetCustomToken` juggling per row. The window has no such limit (`UNITRENT_MAX` 12 is only a sanity bound) and reuses the pattern already proven by the ship-rename window.

**DM setup:** place `pla_unitdoor`, set `Units` = count, and `Unit<n>` = 1 small / 2 medium / 3 large. Anything unset reads as small, so a door with only `Units` set works rather than breaking.

**Interiors** are instanced per unit with `CreateArea()` under a deterministic tag, so the same unit resolves to the same tag after a reboot. `CreateArea` areas do not survive a restart — the shell is recreated on next entry, its loose contents are not. Player storage is account-scoped (TASK-37) and unaffected; furniture is not, the same known gap as everywhere else.

#### Interior wiring, and the way out
`UnitWireInterior` runs on a freshly instanced interior and does two things:
- Links the internal staircase doors to each other with `SetTransitionTarget` (`level1_to_level2` <-> `level2_to_level1`, and the same for 2<->3). Norm has two floors and rich three; unlinked, their upper floors are unreachable.
- Turns the front door into the way out, by retagging `interior_door` to `door_exit` and pointing its `OnClick` at `transitions2`. That script's existing exit branch then reads the `AreaExit`/`AreaExitObj`/`fXExit`/`fYExit` locals the instancer set, so no new exit code was needed and no floating exit marker had to be planted indoors.

A local `GetObjectInAreaByTag` was needed for this: NWScript has no "find by tag inside THIS area" call, and module-wide `GetObjectByTag` would return whichever instance it saw first — fatal here, because every unit interior carries the same internal door tags.

#### Tenant actions
A tenant's own row now shows days remaining and carries **Enter / Pay / Leave**. Paying extends from the later of today and the current expiry, so paying early adds a term instead of discarding the remainder. Leaving clears the tenancy and the one-home back-pointer, freeing both the unit and the character's home slot.

#### Expiry, re-letting, and furniture
- **Expiry sweep.** `UnitSweepExpired` releases every overdue unit at a door, and runs whenever the list is opened. A tenant who stops paying may simply never return, so expiry cannot be detected from the tenant's own actions — and whoever opens the door is exactly the person who cares whether something has come free.
- **Re-letting keeps the right furniture.** The interior shell and its furniture record survive a release, so a tenant who re-rents their own unit finds it as they left it. `UnitRentTake` wipes the record only when the unit actually changes hands, comparing against a `Last` tenant name, so an incoming tenant never inherits someone else's decorating.
- **Furniture now persists.** A unit interior is a `CreateArea()` instance and does not survive a restart, and `area_save.nss` cannot help because it keys on the Planet/Area coordinate locals these interiors deliberately do not carry. So `conv_furnitur003.nss` marks every placed piece `Furniture`=1, `area_exit.nss` snapshots a unit interior's pieces to pwdata when its last occupant leaves, and the instancer rebuilds them on next entry.
- **Containers needed no work.** The chests in these templates are `chestplayer` portals to account storage (TASK-37) and hold nothing locally, so they come back full regardless of the interior being rebuilt.

#### DM configuration: `.wunits`
`.wunits <count> [sizes]` configures the nearest `unitdoor` within 10m. Sizes is a comma list, one entry per unit — 1 small, 2 medium, 3 large — padded out to the count so every unit gets an explicit entry:
```
.wunits 6 1,1,1,1,3,1     six units, the fifth large
.wunits 4                 four small units
.wunits 0                 clear the door
```
**Saved to the database, not to the door.** A local variable set in-game does not survive a restart, so pwdata is the authority (`<areaTag>&Unit&<x>_<y>&Cfg`, stored `"<count>&<size1>,<size2>,..."`). A door configured in the toolset still works: its own `Units`/`Unit<n>` locals are the fallback whenever no database row exists.

#### Still to build
- **No expiry warning.** A tenant gets no notice before losing a unit; the sweep simply releases it. A message on entry when the term is nearly up would be kinder.
- **The sweep only covers doors someone opens.** A building nobody visits keeps its expired tenants until it is next looked at. That is deliberate — there is no index of doors to walk — but it means "released" really means "released the next time anyone looks".
- **Domain houses still have no expiry action** (TASK-36). Units now do; the two should probably behave the same way.
- **verify**: not yet planned.
