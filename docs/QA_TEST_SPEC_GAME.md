# Game / NWScript QA Test Spec

Manual in-game test checklist covering feature work from the last year
(2025-08-20 – 2026-08-08, commits `be3a1c3`..`81968aa`). NWScript has no
unit-test framework in this project (see root `CLAUDE.md`) — everything
here is validated by compiling with `nwnsc` and exercising it in-game or
on a test server. Grouped by feature/theme, not by commit.

Each case lists: **Setup**, **Steps**, **Expected**, and the commits it covers.

---

## 1. Ship arrival / departure animation

Covers: `4b43a96`, `9bab964`, `b0358da`, `e6ee6e6`, `920fc1a`, `21cc80b`,
`6d0b387`, `81968aa` (TASK-15 / this session's follow-up).

### 1.1 Airship docks on schedule
- **Setup:** Stand in a city area at one of the configured airship arrival hours.
- **Steps:** Wait for the scheduled hour to tick over.
- **Expected:** The airship hull flies straight in along a single fixed axis
  (no diagonal cut-in from a corner), decelerating smoothly (`EASE_OUT`) as
  it settles into its dock over ~20s. It does not clip through scenery
  mid-approach.

### 1.2 Starship docks on schedule (planet `0_0` only)
- **Setup:** Stand in the `0_0` planet's designated area at a starship hour.
- **Steps:** Wait for the scheduled hour.
- **Expected:** Same fixed-axis, decelerating approach as 1.1, using the
  starship hull/blueprint instead of the airship's.

### 1.3 Mooring ropes and ladder appear after the hull lands, not mid-flight
- **Setup:** Continue from 1.1 or 1.2.
- **Steps:** Watch the dock for ~25s after the hull first becomes visible.
- **Expected:** The 4 mooring-rope pieces and the boarding ramp/ladder do
  not appear until the hull's ~20s arrival ease has finished (ropes ~20s
  in, ladder ~22s in) — they must not spawn while the hull is still
  visibly descending.

### 1.4 Ship departs with an outbound animation, not an instant pop
- **Setup:** Board (or simply observe) a docked ship, then wait past its
  scheduled departure hour.
- **Steps:** Watch the dock through the departure window.
- **Expected:** The hull eases away from its exact docked position (no
  jump/teleport first) along the same fixed axis, accelerating (`EASE_IN`)
  as it leaves, taking ~20s — the same duration as arrival, not faster or
  slower. Mooring ropes/ladder disappear immediately (no matching ease).

### 1.5 Transport self-destruct doesn't leave orphaned pieces
- **Setup:** Trigger a docking cycle (1.1 or 1.2), let it complete.
- **Steps:** Wait through a full dock → depart cycle.
- **Expected:** No leftover `transport1`/`transport2`-tagged hull, rope, or
  ladder placeables remain in the area after departure completes.

### 1.6 One-off arrival flourish (direct-teleport arrival) still resolves cleanly
- **Setup:** Use the transport system to teleport a PC directly to a
  `TransArrivalLoc` (rather than waiting at a scheduled dock).
- **Steps:** Observe the area immediately after arrival for ~30s.
- **Expected:** A one-off ship hull eases in, ropes/ladder appear ~20-22s
  in, and the whole flourish (hull + ropes + ladder) is gone by ~30-32s
  with no instant pop or leftover pieces.

---

## 2. Party co-flight cabin system

Covers: `52167d1`, `739e122`, `4f81b4a`, `dee82c0`.

### 2.1 Nearby party members are brought along automatically
- **Setup:** Form a party with 2+ PCs standing near the pilot when a
  transport departs.
- **Steps:** Have the pilot board/trigger departure.
- **Expected:** All nearby party PCs (not just the pilot) are cloned into
  the flight cabin area, not left behind in the origin area.

### 2.2 Solo PC still boards normally
- **Setup:** A lone PC (no party) boards a transport.
- **Steps:** Trigger departure.
- **Expected:** Solo boarding still works exactly as before — no cabin
  clone errors or empty-party edge-case failures.

### 2.3 Cabin hatch offers join-pilot or disembark
- **Setup:** A PC is inside the flight cabin mid-flight.
- **Steps:** Use the cabin hatch.
- **Expected:** Menu offers both "join the pilot" and "disembark", per
  TASK-24.

### 2.4 Mid-flight disembark lands at the boarding spot, not mid-air
- **Setup:** PC in the cabin mid-flight (ship not yet docked).
- **Steps:** Choose disembark from the hatch menu.
- **Expected:** PC is placed at the ship's boarding spot, not floating in
  the transport's cabin-instance void or an unreachable location.

### 2.5 No residual action queue after cabin/placeable transitions
- **Setup:** Queue an attack or movement action, then immediately use a
  placeable that transitions the PC (cabin hatch, ship boarding, etc.).
- **Steps:** Complete the transition.
- **Expected:** The PC's action queue is cleared by the transition — no
  leftover queued attack/move fires after arriving in the new location.

---

## 3. Dynamic area pooling (CopyArea system)

Covers: `732e932`, `c981b9e`, `2df5ed1`, `a1e4659`, `7301c6f`, `9a530af`,
`b3bdc31`, `ca85585`, `18022ec`, `ddffa62`.

### 3.1 On-demand area clones replace the old floating pool
- **Setup:** Enter a terrain type that used to draw from a pre-spawned
  floating area pool (e.g. a dungeon or interior).
- **Steps:** Enter the area.
- **Expected:** A `CopyArea` clone is created on demand from a
  `000`-tagged template, not pulled from a pre-existing floating pool.

### 3.2 Area transitions work correctly across cloned areas
- **Setup:** Enter a cloned area, then use a transition (door/trigger) to
  another area.
- **Steps:** Walk through the transition.
- **Expected:** PC lands in the correct destination; no "area no longer
  exists" or wrong-coordinate failures.

### 3.3 Coordinate→area cache doesn't go stale after a clone is destroyed
- **Setup:** Visit a cloned area, leave it so it's destroyed/vacated, then
  trigger something that looks up that same coordinate again (e.g. a
  return trip or map click).
- **Steps:** Re-trigger the coordinate lookup.
- **Expected:** The lookup resolves to a fresh clone or correct state, not
  a stale reference to the destroyed area.

### 3.4 Pooled interior areas repopulate after their first claim
- **Setup:** Claim a pooled interior area (first-ever use), vacate it, then
  claim it again later.
- **Steps:** Re-enter after vacating.
- **Expected:** The interior repopulates (spawns, decor) rather than
  coming up empty on the second claim.

### 3.5 Static/pooled areas aren't destroyed prematurely (tavern exit regression)
- **Setup:** Enter a tavern or similar static/pooled area, then exit via
  its normal exit.
- **Steps:** Exit and re-enter multiple times in a row.
- **Expected:** The exit works every time — this was a prior regression
  where static/pooled areas got destroyed on vacate, breaking the tavern
  exit specifically.

### 3.6 Pilot dialog keeps its destination list across an area-save race
- **Setup:** Open a pilot/transport dialog around the same time an
  area-save/occupancy check would run (e.g. shortly after server activity
  in that area).
- **Steps:** Open the dialog and check available destinations.
- **Expected:** Destinations are present and correct — not silently lost
  to the area-save occupancy race.

### 3.7 `DestroyArea()` only fires on actual copies
- **Setup:** Trigger cleanup on both a `CopyArea` clone and a genuine
  static/template area.
- **Steps:** Vacate both.
- **Expected:** Only the clone (`IsCopy`) is destroyed; the static/template
  area is never destroyed via this path.

---

## 4. Henchman AI & following

Covers: `9ae75f9`, `6d28cad`, `f8c35e2`, `ddffa62`.

### 4.1 Hench follows into and out of dungeons and domain interiors
- **Setup:** Recruit a henchman, stand near a dungeon or domain interior
  entrance.
- **Steps:** Enter, then exit.
- **Expected:** The hench follows both directions — no getting stuck
  outside or left behind inside.

### 4.2 Hench exit detection uses the area-exit flag, not `IsInterior`
- **Setup:** Exit a domain interior that is flagged as an interior but
  reachable via a non-standard transition.
- **Steps:** Exit.
- **Expected:** Hench correctly follows out — detection no longer
  misfires based on `IsInterior` alone.

### 4.3 Hench jump isn't dropped by follow-AI queue contention
- **Setup:** Move quickly through several transitions in succession with a
  hench following.
- **Steps:** Chain 2-3 transitions rapidly.
- **Expected:** The hench's jump command isn't silently dropped by a
  competing follow-AI action; it consistently arrives with the PC.

### 4.4 Hench jumps on all terrain transitions, not just interior exits
- **Setup:** Cross a terrain-to-terrain transition that is not an interior
  exit (e.g. outdoor area to outdoor area).
- **Steps:** Cross the transition with a hench following.
- **Expected:** Hench jumps along on this transition type too, not only on
  interior exits.

### 4.5 Direct area-exit jump fallback recovers a stuck hench
- **Setup:** Get into a state where the primary follow-jump would fail
  (e.g. contention from 4.3 reproduced deliberately).
- **Steps:** Continue moving away from the hench.
- **Expected:** The fallback direct area-exit jump eventually brings the
  hench along instead of leaving it stranded permanently.

---

## 5. Domain structures: build, production, rotation, collision

Covers: `7b7698c`, `59b6beb`, `6e83702`, `0bea260`, `e3a01d2`, `c35ce29`,
`1aee980`, `ef4952c`, `6424004`, `3074b74`, `8d246a1`, `2594cfb`,
`f44c7b7`, `daaaf33`, `6dfc7c4`, `80b4947`, `7bd90f9`, `596b361`,
`07e0965`, `908d3ad`. See also the `uoa-world-generation` skill.

### 5.1 Level 5+ structure production-time halving actually applies
- **Setup:** Own a domain structure at level 5 or higher with a build-time
  reduction perk.
- **Steps:** Queue production and time it.
- **Expected:** Production time is actually halved, not a no-op (prior
  bug: `iDays` halving silently did nothing).

### 5.2 Production doesn't freeze or waste cycles on counter reset
- **Setup:** Let a structure's production counter reach a reset point
  (cycle rollover).
- **Steps:** Observe production continuing across the reset.
- **Expected:** Production continues smoothly — no freeze, no wasted/lost
  cycle at the reset boundary.

### 5.3 Domain placeables get static-marked without a timing race
- **Setup:** Build or load into an area with newly-placed domain
  placeables.
- **Steps:** Enter the area immediately after placement/load.
- **Expected:** All domain placeables end up correctly static-marked; none
  are missed due to the placement/marking race.

### 5.4 `area_interests.nss` doesn't re-run redundantly on re-entry
- **Setup:** Enter an area, leave, then re-enter the same area shortly
  after.
- **Steps:** Re-enter 2-3 times.
- **Expected:** Interest-related setup logic runs once per genuine
  population, not every single re-entry.

### 5.5 Structure rotation: compass-direction submenu, 90° increments
- **Setup:** Own a built domain structure.
- **Steps:** Open the rotate menu.
- **Expected:** A compass-direction submenu (N/E/S/W or similar) rotates
  the structure in clean 90° increments.

### 5.6 Rotation persists across relog and doesn't self-terminate
- **Setup:** Rotate a structure, then log out and back in.
- **Expected:** The structure keeps its rotated orientation; the
  rotation-handling flag/process doesn't self-terminate on destroy
  (prior bug in `DomainSetRotation`).

### 5.7 Rotation's client-side refresh doesn't strand or duplicate the PC
- **Setup:** Rotate a structure while standing nearby.
- **Steps:** Watch the PC through the refresh (this went through several
  iterations — area-transition trick, fixed safe coordinate, etc. — verify
  the current approach).
- **Expected:** The client visually refreshes to show the new orientation
  without the PC's trip getting cancelled, jumping back unexpectedly, or
  landing anywhere but the intended spot.

### 5.8 Domain content doesn't duplicate onto an unrelated coordinate
- **Setup:** Build/rotate domain content in one location.
- **Steps:** Check other coordinates/areas the domain system touches.
- **Expected:** No duplicate copies of domain content appear at unrelated
  coordinates (prior TASK-22 bug).

### 5.9 Domain buildings survive a relog
- **Setup:** Build a domain structure, log out, log back in.
- **Expected:** The building is still present and correctly placed — does
  not vanish on relogin.

### 5.10 Structure collision — known limitation, verify current state
- **Setup:** Walk into a built domain structure's walls.
- **Steps:** Attempt to walk through where a wall should be.
- **Expected:** ⚠️ As of the last recorded attempt (`x3_plc_inviswal`
  reverted in `07e0965`), domain structure houses are still walk-through —
  this is a known, currently-unresolved limitation (TASK-18), not a
  regression to chase in this pass. Confirm it's still documented as such
  rather than silently "fixed" by something else.

### 5.11 Ranger cartography talent also works for druids
- **Setup:** Play (or spawn a test hench as) a druid.
- **Steps:** Use the cartography talent.
- **Expected:** Works the same as it does for rangers (TASK-19 extended
  it to druids).

---

## 6. Area population & spawning

Covers: `9d76b82`, `f04f7fb`, `7fccbd5`, `71c54d1`, `4fe97a1`.

### 6.1 Areas are populated before the player arrives
- **Setup:** Travel to an area that requires population (spawns, decor).
- **Steps:** Arrive and immediately look around.
- **Expected:** Spawns/decor are already present on arrival — no visible
  pop-in after the fact.

### 6.2 Tavern adventurers reroll
- **Setup:** Visit a tavern, note the adventurers present, leave and
  return later (or across a reset boundary).
- **Expected:** The adventurer roster rerolls rather than staying static
  forever.

### 6.3 Scenery placeables are correctly static-marked
- **Setup:** Enter a freshly-populated area.
- **Steps:** Inspect scenery placeables (non-interactive decor).
- **Expected:** They're marked static as expected (performance/behavior
  check, not meant to be interactive).

### 6.4 Creature visual appearance matches its randomised mechanical race
- **Setup:** Encounter a creature that went through
  `RandomiseCreatureRacialType`.
- **Steps:** Compare its visible model to its actual racial type (e.g. via
  examine or combat log).
- **Expected:** The visual model matches the mechanical race — no
  human-looking creature with orc stats, etc.

### 6.5 Planetary spawn waves have level variance
- **Setup:** Trigger a planetary spawn wave (repeat several times if
  needed to sample).
- **Expected:** Spawned creature levels vary within the wave rather than
  all being identical.

### 6.6 Commoner appearance is randomised
- **Setup:** Observe several commoner NPCs.
- **Expected:** Head/skin/hair vary across commoners rather than all
  looking identical.

### 6.7 Paid hench level-up and hire greeting
- **Setup:** Hire a paid henchman.
- **Steps:** Pay to level them up; also check the initial hire greeting.
- **Expected:** Level-up works correctly, and the hire greeting includes a
  class-breakdown as described.

---

## 7. Monster camps & plot-giver missions

Covers: `5c235a4`, `bb4fdb7`, `dc7c872`, `095b116`, `3ce0d8a`, `ae37c62`.

### 7.1 Every city/town has a nearby monster camp with a plot-giver mission
- **Setup:** Visit several different cities/towns.
- **Steps:** Look for a nearby monster camp and its plot-giver.
- **Expected:** Every city/town has one guaranteed nearby camp with an
  available plot-giver mission — none are missing.

### 7.2 Camp-clear reward requires a verified kill, not a live-area scan
- **Setup:** Accept a camp-clear mission.
- **Steps:** Try to claim the reward (a) after actually clearing the camp,
  and (b) by leaving and re-entering the area without clearing it (to
  probe for a live-scan false-positive/negative).
- **Expected:** Reward is granted only when the persisted "cleared" flag
  is set from an actual kill — not derived from whatever happens to be
  alive in the area at claim time.

### 7.3 Camp-clear mission spawns a tier the planet can actually build
- **Setup:** Accept a camp-clear mission on a planet with a given
  structure/tech tier.
- **Expected:** The spawned camp tier matches what that planet can build —
  not an impossible or mismatched tier.

### 7.4 Cleared camp stays cleared
- **Setup:** Clear a camp, wait, revisit.
- **Expected:** The camp does not silently respawn back to full strength
  right away — it stays cleared per the mission's design.

### 7.5 Mercenary ranger henchman (hench020) doesn't duplicate equipment
- **Setup:** Hire/interact with the mercenary ranger henchman (hench020)
  repeatedly (relog, hire/dismiss cycles, etc.).
- **Steps:** Check its inventory/equipped items after each cycle.
- **Expected:** No duplicate copies of its equipment appear (prior
  TODO-16 / TASK-16 bug).

---

## 8. Dungeon enigmas & menu ordering

Covers: `89be7a1`, `29bcfed`.

### 8.1 Dungeon enigmas use monster/skill challenges, not math/logic puzzles
- **Setup:** Reach a dungeon enigma encounter.
- **Expected:** The challenge is a monster or skill-check challenge, not a
  math/logic puzzle (prior design used logic puzzles; this was
  deliberately removed).

### 8.2 Plot-giver and henchman menus are correctly ordered
- **Setup:** Open a plot-giver dialog and a henchman management dialog.
- **Expected:** Menu order matches the intended reordering, and the
  option previously called "Abort" now reads "Leave" and appears last in
  the list.

---

## 9. Build tooling sanity (not in-game, but blocks everything above)

Covers: `4bcd46f`, `37f41cf`.

### 9.1 `build.sh` fails loudly on a partial compile instead of deploying it
- **Setup:** Deliberately introduce a script compile error (e.g. a typo in
  a `.nss` file) on a branch, then run `./build.sh`.
- **Steps:** Run the build.
- **Expected:** The build exits non-zero and does **not** deploy — it must
  not silently pack a `.mod` that's missing `.ncs` files for the broken
  script.
- **Cleanup:** Revert the deliberate error before merging/deploying for
  real.

### 9.2 Include paths resolve correctly regardless of caller's cwd
- **Setup:** Run `./build.sh` from the repo root (its normal invocation).
- **Expected:** All `-i` include paths resolve (base scripts, ZEP
  includes, project `src/nss`) — no `NSC1085` unresolved-include errors
  from scripts that only reach a base-game include via the case-shim dir.
