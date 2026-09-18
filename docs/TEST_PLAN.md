# Test Plan — 2026 Work (full year index)

## Scope

- **Date range:** 2026-05-31 – 2026-09-05 (`d09e79a` .. `85f5156`). These are
  every commit in this repo dated on/after 2026-01-01 — despite the
  "since 2026-01-01" cutoff, the repo's first 2026 commit didn't land until
  late May.
- **Commit count:** 141 commits (`git log --since=2026-01-01 --oneline | wc -l`).
- **This document is the master index for the whole year.** The detailed,
  step-by-step cases live in the four specs listed below; the test cases in
  this file cover 2026-05-31 – 2026-08-08 in depth and cross-reference the
  rest rather than duplicating it.
- **Grouping method:** commits were read via `git log --since=2026-01-01
  --stat` and grouped by touched files / commit-message task tags
  (`TASK-NN`/`TODO-NN` references in `src/nss/TODO.md`) into feature/fix
  clusters, rather than one test case per commit. Pure documentation
  commits (adding/updating `TODO.md` entries or the `uoa-world-generation`
  skill), merge commits, and diagnostic-logging-only commits are folded
  into the test case for the feature they document/instrument/land, and
  are called out individually only where they represent a distinct
  no-test-needed change.
- **Two existing, more granular specs already cover most of this range in
  depth** and are treated as the source of truth for step-by-step detail;
  this document is the master index + top-level spec, cross-referencing
  them rather than duplicating every sub-case:
  - `docs/QA_TEST_SPEC_GAME.md` — NWScript/in-game manual QA, sections 1-9
    (covers `be3a1c3`..`81968aa`, a superset of this range).
  - `www/tests/TEST_SPEC.md` — `www/` PHP dashboard spec, sections 1-9+
    (covers `be3a1c3`..`6752100`, a superset of this range's web commits).
  - `docs/QA_TEST_SPEC_2026-08.md` — 2026-08-09 – 2026-08-23 (`6b7f596`..
    `dd56e5c`), plus the feature work that sat uncommitted until `d7401c7`
    landed it. Map memory and pins, camp-mission refinements, DM cluster
    creature persistence, player self-service auth, henchman gear rules,
    gold auto-loot, item-wear rebalance.
  - `docs/QA_TEST_SPEC_2026-09.md` — 2026-09-05 (`db5fc9a`..`85f5156`).
    Ship flight paths, asteroid Z jitter, spawn-group DM items, conflict
    battle instances, player-named ships, domain access grants, rent expiry
    clock, per-account chest storage, space dungeon entrances.

### Year coverage map

| Range | Commits | Spec |
|---|---|---|
| 2026-05-31 – 2026-08-08 | 96 | this file + `QA_TEST_SPEC_GAME.md` + `www/tests/TEST_SPEC.md` |
| 2026-08-09 – 2026-08-23 | ~29 | `QA_TEST_SPEC_2026-08.md` |
| 2026-09-05 | ~16 | `QA_TEST_SPEC_2026-09.md` |

Run order across the year, highest risk first: §1 of `QA_TEST_SPEC_2026-09.md`
(player chest storage — it touches live player property), then §2-3 of the
same (hot paths and the domain rent behaviour change), then
`QA_TEST_SPEC_2026-08.md` §1 and §4 (map memory and player auth, both of
which alter what every player sees), then the rest in any order.

## Test Strategy

Three layers, run in this order — each gates the next:

1. **Compile check (NWScript).** `./build.sh` from the repo root. It now
   (as of `37f41cf`) resolves all `-i` include paths as absolute paths
   regardless of nasher's cache-copy cwd, and refuses to deploy
   `uoa/server/modules/UOA.mod` if any script fails to compile (previously
   it could silently pack a `.mod` missing `.ncs` files for a broken
   script). A clean `build.sh` run is a **precondition** for every in-game
   test case below — do not test against a module you aren't sure compiled
   cleanly.
2. **Automated web/PHP checks.**
   - `./run_tests.sh --php` — PHPUnit (`tests/*.php`) against the DB-access
     helpers and HTML structural assertions.
   - `./run_tests.sh --web` (or the full `./run_tests.sh`) — PHPUnit-driven
     web/HTML smoke tests.
   - `cd www && npx playwright test` — Playwright specs in `www/tests/*.spec.js`.
   - `cd www/selenium && pytest` — Selenium specs (`test_*.py`), HTML report
     at `www/selenium/report/report.html`.
   These are regression nets for the web dashboard; green here does not
   substitute for the manual game-side steps in section 3.
3. **Manual in-game / on-server verification.** No NWScript unit-test
   framework exists (per root `CLAUDE.md`). For every case below marked
   "in-game": start (or connect to) a running UOA server with the
   freshly-built module, log in with a test PC (or DM client where noted),
   perform the listed steps, and check both visible behavior and, where
   noted, the server log (`nwserverLog1.txt`/`nwserverError1.txt`) for the
   `[tag]`-prefixed diagnostic lines the commits added.

Test cases below are grouped by feature area. Each lists: **Title**,
**Commits**, **Preconditions**, **Steps**, **Expected**.

---

## Test Case Spec

### A. Build & deployment tooling

#### TC-001 — `build.sh` refuses to deploy a partial compile
- **Commits:** `37f41cf`, `4bcd46f`, `d6aa7b4` (build.sh path portion), `a1e4659` (build.sh portion)
- **Preconditions:** Working tree builds cleanly today.
- **Steps:**
  1. Introduce a deliberate syntax error into any `src/nss/*.nss` file on a
     scratch branch (e.g. a stray `}` in `henchs.nss`).
  2. Run `./build.sh` from the repo root.
  3. Revert the deliberate error.
- **Expected:** The build exits non-zero and does **not** overwrite
  `uoa/server/modules/UOA.mod` — no `.mod` missing `.ncs` files gets
  deployed. On a clean tree, `./build.sh` succeeds and all `-i` include
  paths (base scripts, ZEP includes, project `src/nss`, case-shim dir)
  resolve with no `NSC1085` errors regardless of the invoking shell's cwd.

#### TC-002 — Test/build infra additions (PHPUnit, Playwright, Selenium)
- **Commits:** `d09e79a`, `6ccd621`, `4e4a54c`, `aa43279`
- **Preconditions:** None.
- **Steps:** Run `./run_tests.sh` (full suite), `cd www && npx playwright
  test`, and `cd www/selenium && pytest`.
- **Expected:** All three suites execute and report pass/fail without
  harness errors (missing PHPUnit binary, missing `node_modules`, missing
  Python deps). `run_tests.sh` auto-downloads `phpunit.phar` if absent.
  This is itself the regression check for these commits — no separate
  manual step needed beyond confirming the suites run.

#### TC-003 — Dev/deploy hygiene: Docker Compose, non-root Claude Code user, `.dockerignore`, credential removal
- **Commits:** `2e8fb26`, `ca5ae0e`, `071c2b9`, `144722e`
- **Preconditions:** Docker available.
- **Steps:**
  1. `docker compose up` (or equivalent) using `docker-compose.yml`.
  2. Confirm the Claude Code container process runs as a non-root user and
     that account data persists across a container restart.
  3. Confirm `.git` history / working tree no longer contains the removed
     legacy credential file, and `node_modules` is untracked (`git status`
     shows it ignored, not staged).
- **Expected:** Compose stack comes up; container runs non-root with
  persistent account data; no credential file present; `node_modules` not
  tracked by git. **Note:** removing an already-committed credential file
  does not scrub it from prior git history — flag to the user separately
  if that file ever held a *live* secret (out of scope for this test
  pass to verify).

---

### B. PHP web dashboard (`www/`)

See `www/tests/TEST_SPEC.md` for the full per-page Playwright/Selenium
breakdown; the cases below are the top-level summary for this date range.

#### TC-004 — `galaxy.php` Space-view heading reflects current viewport
- **Commits:** `c969709`, `378a16f`, `aa43279`
- **Preconditions:** Web stack running, DB reachable.
- **Steps:** Open `galaxy.php?planet=Space`. Pan the view using the
  compass arrows (N/E/S/W) several sectors in each direction, including
  crossing into negative sector coordinates.
- **Expected:** The page heading text updates to reflect the sector/system
  currently in view (not a static "Space" label), including correctly
  labeling far-out sectors as generic "Space" once no named system is in
  range. `data-testid`/`data-*` attributes are present on the interactive
  elements the Selenium/Playwright specs target
  (`www/tests/galaxy.spec.js`, `www/selenium/test_galaxy.py`) — both suites
  pass.

#### TC-005 — `map-data.php` targeted queries hide undiscovered terrain
- **Commits:** `0b5ad59`
- **Preconditions:** A DB with at least one undiscovered map tile for the
  test character/party.
- **Steps:** Load a planet map for a character who hasn't explored the
  full grid. Inspect the returned tile data (network tab or page output).
- **Expected:** Only tiles the party has actually discovered return real
  terrain data; undiscovered tiles are hidden/blanked rather than leaking
  terrain type. Query is scoped/targeted (per-tile or per-viewport), not a
  full-table scan — verify via slow-query log or `EXPLAIN` if timing is in
  question.

#### TC-006 — Planet area storage helpers modernization / map display refactor
- **Commits:** `2df5ed1`
- **Preconditions:** None.
- **Steps:** Load several planet and space maps; compare rendered output
  to pre-change screenshots if available, or simply confirm no blank/error
  map renders.
- **Expected:** Map display is behaviorally unchanged from the user's
  perspective — this is an internal helper refactor. **No test needed
  beyond a smoke pass** for functional parity; not a new-behavior case.

#### TC-007 — PC location tracking + security/HTML refactor + config cleanup
- **Commits:** `b8bdf41`
- **Preconditions:** A PC logged into the game server.
- **Steps:** Move the PC between areas in-game, then load whatever
  dashboard page surfaces "current location" (per this commit's PC
  location tracking feature). Also spot-check pages touched by the
  security/HTML refactor for XSS-safe output (`htmlspecialchars()` on
  user-influenced fields) and confirm no hardcoded credentials remain in
  the moved config.
- **Expected:** Displayed PC location matches the PC's actual current
  in-game area, updating as the PC moves. Refactored pages render
  identically to before with no unescaped output. Config values load from
  the single dedicated config include, not scattered literals.

#### TC-008 — Dead file removal / `www/` restructure (public/, app/) — refactor only
- **Commits:** `6752100`, `34b6507`, `aed6884`
- **Preconditions:** None.
- **Expected:** **No test needed — refactor/cleanup only.** These commits
  delete dead files (`phpinfo.php`, `test.php`, `testmysql.php`, old
  crafting HTML duplicates) and move files between `www/`, `www/public/`,
  and `www/app/` without changing behavior. Verification is just: site
  still loads (covered by TC-004/TC-005/TC-007's smoke passes) and none of
  the removed files are reachable (`curl -I` on their old paths should
  404, not required to be a fatal error but should not still work).

---

### C. Dynamic area pooling (CopyArea system)

See `docs/QA_TEST_SPEC_GAME.md` §3 for the fully detailed sub-cases; this
plan folds them into three cases.

#### TC-009 — On-demand `CopyArea` clones replace the floating area pool
- **Commits:** `732e932`, `c981b9e`, `a1e4659` (transitions.nss portion)
- **Preconditions:** Server freshly booted (no pre-existing clones).
- **Steps:** Travel into a terrain area type that previously drew from
  the pre-spawned floating pool (e.g. a rural/dungeon tile never visited
  this boot).
- **Expected:** A fresh clone is created on demand from the matching
  `<type>000`-tagged template area, not pulled from a stale floating pool
  entry. Area transitions into and out of the clone resolve correctly
  (correct destination, no "area no longer exists").

#### TC-010 — Coordinate→area cache and template-clone resolution stay correct under concurrency
- **Commits:** `7301c6f`, `80b4947`, `7e0bea7`, `9a530af`
- **Preconditions:** Two test characters (or one + a DM client) able to
  visit adjacent, same-terrain-type tiles around the same time.
- **Steps:**
  1. Have PC A occupy a populated domain coordinate (a live, tagged
     `<type>000` clone).
  2. While PC A is still there, have PC B visit a different, never-before-
     visited adjacent tile of the *same* terrain type.
  3. Separately: claim a pooled interior area, fully vacate it (destroying
     the clone), then re-claim the same coordinate later.
  4. Separately: vacate a clone, then immediately trigger a coordinate
     lookup against that same coordinate (e.g. a return trip).
- **Expected:** (1-2) PC B's fresh tile comes up empty — it does **not**
  inherit PC A's domain content (prior bug: `GetObjectByTag("<type>000")`
  could resolve to the wrong live clone; fixed by `area_tmpl_boot.nss`
  caching each template's true reference at module load, before any player
  can log in). (3) The interior repopulates (spawns/decor present) on the
  second claim rather than coming up empty. (4) The lookup resolves to a
  fresh/correct clone, not a stale reference to the destroyed area.

#### TC-011 — Static/pooled areas aren't destroyed prematurely; pilot dialog keeps destinations
- **Commits:** `b3bdc31`, `18022ec`, `ca85585`, `ddffa62`, `d6e1ba4` (merge)
- **Preconditions:** A tavern or other static/pooled area with a normal
  exit, and a pilot/transport dialog.
- **Steps:**
  1. Enter and exit a tavern (or similar static/pooled area) via its
     normal exit, repeated 3-4 times in a row.
  2. Open a pilot/transport dialog shortly after other server activity in
     that area (to hit the area-save/occupancy check window).
  3. If step 1 or 2 leaves a PC stuck, use the direct area-exit jump
     fallback / web-triggered reset added in `ddffa62`.
- **Expected:** (1) The tavern exit works every time — no regression
  where `DestroyArea()` fires on a static/pooled area on vacate (it's now
  gated by `IsCopy`, matching `area_save.nss`'s existing gate). (2) The
  pilot dialog's destination list is present and correct, not silently
  emptied by the area-save occupancy race. (3) The fallback jump/reset
  recovers a stranded PC.

---

### D. Henchman AI, following, and equipment

#### TC-012 — Henchmen follow through all transition types without dropping
- **Commits:** `d6aa7b4` (transitions.nss portion), `9ae75f9`, `6d28cad`, `f8c35e2`, `3f4812b` (merge)
- **Preconditions:** A recruited, following henchman.
- **Steps:** Cross, in sequence: a dungeon/interior entrance, a domain
  interior door, an outdoor terrain-to-terrain transition (not an interior
  exit), and 2-3 transitions chained rapidly back-to-back.
- **Expected:** The hench follows on every transition type, both
  directions, including the plain outdoor-to-outdoor case (previously
  hench jumps only fired on interior exits) and under rapid chaining
  (previously drop-able due to follow-AI queue contention).

#### TC-013 — Mercenary ranger henchman (hench020) no longer duplicates equipment
- **Commits:** `ae37c62`, `3ce0d8a` (doc)
- **Preconditions:** Mercenary ranger henchman (`hench020`) available to
  hire.
- **Steps:** Hire the mercenary ranger, set it to "stay here," walk out of
  and back into the same area 3-4 times. Separately, dismiss and re-hire
  it, then relog.
- **Expected:** Only one `hench020` NPC is ever present after repeated
  re-entries (action 5 now destroys any stale prior instance before
  creating a new one). No duplicate/extra items appear in its inventory or
  the PC's inventory (action 14's per-slot equip now skips a slot that's
  already filled).

---

### E. Area population & spawning

See `docs/QA_TEST_SPEC_GAME.md` §6 for full sub-case detail.

#### TC-014 — Areas populate before arrival; tavern adventurers reroll; scenery is static-marked
- **Commits:** `9d76b82`, `f04f7fb`, `7fccbd5`, `71c54d1`, `4fe97a1`
- **Preconditions:** None.
- **Steps:**
  1. Travel to an area requiring population and look around immediately
     on arrival.
  2. Visit a tavern, note the adventurer roster, leave and return after a
     reset boundary.
  3. Encounter creatures spawned via `RandomiseCreatureRacialType` and
     compare visible model to mechanical race; trigger a planetary spawn
     wave several times and sample creature levels; observe several
     commoner NPCs' head/skin/hair.
  4. Hire a paid henchman: check the hire greeting includes a
     class-breakdown, then pay to level it up.
- **Expected:** (1) Spawns/decor are already present on arrival, no
  visible pop-in. (2) Adventurer roster rerolls rather than staying static
  forever. (3) Visual model matches the randomised mechanical race;
  spawn-wave levels vary within a wave; commoner appearance varies across
  NPCs. (4) Hire greeting shows a class breakdown; paid level-up succeeds.

#### TC-015 — Ranger cartography talent extended to druids
- **Commits:** `908d3ad`
- **Preconditions:** A druid PC or druid henchman, leveled.
- **Steps:** As a druid henchman, use the "tell me where we are" and
  "track nearest living creature" dialog options. As a druid PC, check the
  `Cartographer` goldbag flag is granted at the same level tiers a ranger
  gets, and that the coordinates item-use (`analyser.nss`) works at the
  matching area-type tier.
- **Expected:** Both hench dialog options work identically to a ranger of
  the same level; the PC-side tiering uses `max(rangerLevel, druidLevel)`
  so a ranger/druid multiclass doesn't stack tiers beyond the correct one.

---

### F. Monster camps & plot-giver missions

See `docs/QA_TEST_SPEC_GAME.md` §7 for full sub-case detail.

#### TC-016 — Every city/town has a guaranteed nearby camp with a plot-giver mission
- **Commits:** `5c235a4`, `bb4fdb7`, `e146429`, `1c6bd66`, `73aa900`, `f03888f`
- **Preconditions:** None.
- **Steps:** Visit several different cities/towns and talk to each one's
  plot giver.
- **Expected:** Each city/town has a guaranteed (not random-chance) nearby
  camp within Chebyshev distance 2, and the plot giver offers a "clear the
  camp" mission referencing that specific camp. Dialog scripts load
  correctly under their renamed (≤16-char resref) filenames
  (`conv_campcheck`/`conv_campoffer`) — a prior commit's rename fix wasn't
  actually committed until `e146429`, so specifically confirm the mission
  dialog branch isn't broken/missing.

#### TC-017 — Camp-clear reward requires a verified kill, and the assigned tier matches planet capability
- **Commits:** `dc7c872`, `095b116`
- **Preconditions:** An active camp-clear mission.
- **Steps:**
  1. Leave the camp area without killing anything, then return to the
     plot giver and try to claim the reward.
  2. Actually clear the camp (kill all `Camp`-tagged creatures), then
     claim the reward.
  3. Repeat on a lower-tier planet and confirm the spawned camp tier
     matches what that planet can build.
  4. After clearing, wait and revisit — confirm the camp doesn't
     immediately respawn to full strength.
- **Expected:** (1) No reward — claim requires the persisted "cleared"
  flag, not a live-area creature scan. (2) Reward granted (100gp × tier,
  paid per-player via goldbag). (3) Tier assigned matches the planet's
  buildable tier, not a mismatched/impossible one. (4) Camp stays cleared.

---

### G. Domain structures — build, production, rotation, collision

See `docs/QA_TEST_SPEC_GAME.md` §5 for full sub-case detail; TASK-17
through TASK-22 in `src/nss/TODO.md` document the multi-session debugging
history behind these commits.

#### TC-018 — Domain structure rotation: compass submenu, persists, survives relog
- **Commits:** `e3a01d2`, `c35ce29`, `1aee980`, `ef4952c`, `6424004`,
  `3074b74`, `8d246a1`, `2594cfb`, `f44c7b7`, `daaaf33`, `6dfc7c4`
- **Preconditions:** A built domain structure with a flag/menu.
- **Steps:**
  1. Open the structure's menu → "Structure Options" → "Rotation options"
     and pick each of North/South/East/West in turn.
  2. After each rotation, walk away and back (or relog) and confirm the
     new orientation persists and renders correctly without a stale
     old-orientation client-side artifact.
  3. Rotate the same structure rapidly several times in a row (repeat
     clicks).
- **Expected:** Each compass option sets an absolute facing (not a
  relative cycle); the structure's house, doors, and sign all rotate
  together and remain geometrically consistent (doors open outward, sign
  faces outward). The client-side refresh (via a real round-trip through
  `transitions.nss`'s normal travel system, landing the PC back at the
  same spot) shows the new orientation without stranding the PC in the
  `_construction` utility area or leaving duplicate/overlapping pieces
  behind, even under rapid repeat clicks.

#### TC-019 — Domain content doesn't bleed onto an unrelated coordinate; buildings survive relog
- **Commits:** `80b4947` (see also TC-010, same fix), `07e0965`
- **Preconditions:** A built domain and an adjacent, never-visited
  same-terrain tile.
- **Steps:** Build/rotate domain content in one location; visit the
  adjacent tile from a second session; log the domain owner out and back
  in.
- **Expected:** No duplicate domain content appears at the unrelated
  coordinate. The building is still present, in the correct spot, after a
  relog (prior bug: buildings could vanish on relogin).

#### TC-020 — Domain production: level 5+ time-halving works; no freeze/wasted cycles at counter reset
- **Commits:** `7b7698c`, `59b6beb`
- **Preconditions:** A domain structure at level 5+ with a build-time
  reduction perk, actively producing.
- **Steps:** Queue production and time it across at least one counter
  reset/rollover.
- **Expected:** Production time is actually halved (prior bug: `iDays`
  halving was a silent no-op). Production continues smoothly across the
  reset boundary — no freeze, no lost/wasted cycle.

#### TC-021 — Domain placeables are reliably static-marked; `area_interests` doesn't re-run redundantly
- **Commits:** `6e83702`, `0bea260`, `54ed73d`, `36995cd` (doc), `74f8997`
  (diagnostic), `2d42cdf` (diagnostic), `ec67a2c`
- **Preconditions:** A domain area with newly-placed structures.
- **Steps:** Enter the area immediately after placement/load, and re-enter
  the same area 2-3 times in a row.
- **Expected:** All domain placeables end up correctly static-marked (no
  timing-race misses between `area_pop_inc.nss` and `area_enter.nss`'s
  single-scan). Interest-related setup logic in `area_interests.nss` runs
  once per genuine population, not on every re-entry; `area_recall.nss`'s
  larger instruction budget for interests/dungeons doesn't itself change
  behavior (perf-only) — confirm no new script-timeout errors in the
  server log.

#### TC-022 — Domain structure collision — known limitation, confirm still documented as such
- **Commits:** `7bd90f9`, `596b361`, `30318d1`, `8fd201f`, `5c89eeb` (doc),
  `e169e58` (doc)
- **Preconditions:** A built School (or other) domain structure.
- **Steps:** Walk directly into the structure's main house model from
  multiple angles.
- **Expected:** ⚠️ Still walk-through as of the last recorded attempt — no
  fix has landed (both the `ccp_house6` blueprint swap and the
  `x3_plc_inviswal` invisible-collision-blocker attempts were tried and
  reverted). This is a known, currently-unresolved limitation (TASK-18) —
  confirm it remains documented in `src/nss/TODO.md` / the
  `uoa-world-generation` skill rather than silently "fixed" by an
  unrelated change, and confirm the *reverts* left `domains.nss` in its
  original pre-experiment state (no leftover invisible wall blocks or
  wrong blueprint references).

#### TC-023 — Domain construction cost UI
- **Commits:** `a1e4659` (colors_inc.nss / domains.html portion)
- **Preconditions:** A player able to open the domain build menu.
- **Steps:** Open the "Build domain" flow and view the construction cost
  display.
- **Expected:** Cost UI renders correctly (colors/formatting from the new
  `colors_inc.nss` helpers) and matches the actual resource cost charged
  on confirm.

---

### H. Ship arrival / departure animation

See `docs/QA_TEST_SPEC_GAME.md` §1 for full sub-case detail.

#### TC-024 — Ships ease in and out along a fixed axis instead of popping/teleporting
- **Commits:** `4b43a96`, `920fc1a`, `21cc80b`, `9bab964`, `b0358da`,
  `e6ee6e6`, `6d0b387` (doc), `81968aa`
- **Preconditions:** Stand at a city/planet with a scheduled
  airship/starship dock.
- **Steps:**
  1. Wait for a scheduled arrival hour and watch the dock for ~30s.
  2. Wait past the scheduled departure hour and watch the same dock.
- **Expected:** (1) The hull flies in along a single fixed axis
  (longitudinal, not diagonal), decelerating smoothly (`EASE_OUT`) over
  ~20s, settling into its dock without clipping scenery; mooring ropes
  appear only after the hull settles (~20s), the boarding
  ladder/ramp ~2s after that — none of the pieces appear while the hull is
  still visibly descending. (2) Departure is the symmetric reverse: the
  hull eases away (`EASE_IN`, accelerating) from its exact docked position
  over the same ~20s, ropes/ladder disappear immediately (no ease). No
  orphaned `transport1`/`transport2` pieces remain after a full cycle.

---

### I. Party co-flight cabin system

See `docs/QA_TEST_SPEC_GAME.md` §2 for full sub-case detail.

#### TC-025 — Nearby party members are cloned into flight cabin together; hatch offers join/disembark
- **Commits:** `52167d1`, `739e122` (doc), `4f81b4a`, `dee82c0`
- **Preconditions:** A 2+ PC party standing near a pilot at departure.
- **Steps:**
  1. Trigger departure with the party nearby; separately, trigger
     departure solo (no party) as a regression check.
  2. Mid-flight (ship not yet docked), use the cabin hatch and choose
     "drop back down to where you boarded."
  3. Use the hatch and choose "climb up to the pilot" instead.
  4. Queue a move/attack action immediately before using the cabin hatch
     or boarding a transport.
- **Expected:** (1) All nearby party PCs are cloned into the flight cabin,
  not just the pilot; solo boarding still works with no cabin-clone
  errors. (2) The disembarking PC lands at the ship's actual boarding
  spot, not mid-air or in the cabin void. (3) Join-pilot still works as
  before. (4) The PC's action queue is cleared by the transition — no
  leftover queued action fires after arrival.

---

### J. Dungeon enigmas & dialog menu ordering

#### TC-026 — Dungeon enigmas use monster/skill challenges, not math/logic puzzles
- **Commits:** `89be7a1`
- **Preconditions:** A dungeon with an enigma encounter.
- **Steps:** Reach and trigger a dungeon enigma.
- **Expected:** The challenge presented is a monster or skill-check
  challenge; math/logic puzzle enigmas no longer occur.

#### TC-027 — Plot-giver/henchman menu ordering; "Abort" renamed to "Leave"
- **Commits:** `29bcfed`
- **Preconditions:** A recruitable henchman and an active plot-giver
  mission dialog.
- **Steps:** Open the henchman management dialog and a plot-giver dialog;
  read through the option order.
- **Expected:** Menu options appear in the reordered sequence; the option
  previously labeled "Abort" now reads "Leave" and is last in the list in
  both dialogs.

---

### K. Large feature-landing commit

#### TC-028 — `ce82010`: item-wear display, 200m placeable view distance, adventurer/NUI systems
- **Commits:** `ce82010`
- **Preconditions:** This single commit landed a large batch of
  previously-uncommitted work (adventurer henchman system, NUI-based DM
  area builder, weapon/spell/feat randomization includes, item-wear
  display, static scenery view distance). Test each sub-feature
  independently:
- **Steps:**
  1. Equip a visibly worn/damaged item and check its display (wear
     indicator) on the PC/inventory UI.
  2. Stand near static scenery placeables and confirm they render/pop-in
     at 200m rather than the previous (shorter) default.
  3. Hire a random tavern adventurer and confirm it's built from the new
     blank-template + randomized appearance/feats/spells/equipment
     pipeline (`inc_adventurer.nss`, `inc_rand_appear.nss`,
     `inc_rand_feat.nss`, `inc_rand_spell.nss`, `inc_weaponpick.nss`)
     rather than a fixed blueprint.
  4. Open the DM area-builder NUI tool (`dmb_nui_event.nss`/`dmb_nui_inc.nss`)
     and place/inspect a cluster of tiles.
- **Expected:** (1) Wear display reflects the item's actual condition.
  (2) Static scenery is visible from 200m, matching
  `area_pop_inc.nss`'s `SetObjectVisibleDistance(oPlaceable,200.0)`. (3)
  Adventurer henches show varied appearance/feats/spells/equipment
  appropriate to their level, not a single reused template. (4) The NUI
  tool opens and places tiles without client errors.

---

## Summary Table

| # | Area | Commits | Status |
|---|------|---------|--------|
| TC-001..003 | Build/deploy tooling | 8 | Testable |
| TC-004..008 | PHP web dashboard | 11 | Testable (TC-006, TC-008 refactor-only) |
| TC-009..011 | Dynamic area pooling | 12 | Testable |
| TC-012..013 | Henchman AI/equipment | 6 | Testable |
| TC-014..015 | Area population/spawning | 6 | Testable |
| TC-016..017 | Camps & missions | 8 | Testable |
| TC-018..023 | Domain structures | 27 | Testable (TC-022 known limitation, not a regression to chase) |
| TC-024 | Ship arrival/departure | 8 | Testable |
| TC-025 | Party co-flight | 4 | Testable |
| TC-026..027 | Enigmas & menus | 2 | Testable |
| TC-028 | Large feature landing | 1 | Testable |

Commit counts above overlap slightly where a single commit touches two
concerns (e.g. `a1e4659` appears under both area pooling and domain UI) —
the total of 96 unique commits is preserved; this table is a coverage map,
not a partition.
