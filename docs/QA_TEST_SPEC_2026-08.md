# Game / NWScript QA Test Spec — 2026-08-09 to 2026-08-23

Manual test checklist for the commit range `6b7f596`..`dd56e5c`, plus the
feature work that sat uncommitted until `d7401c7` landed it on 2026-09-05.

This range is the gap between the two existing specs: `TEST_PLAN.md` and
`QA_TEST_SPEC_GAME.md` stop at `81968aa` (2026-08-08), and
`QA_TEST_SPEC_2026-09.md` starts at `db5fc9a` (2026-09-05). See
`TEST_PLAN.md` for the full-year index.

NWScript has no unit-test framework in this project (root `CLAUDE.md`) —
these are validated by compiling with `nwnsc` and exercising in-game. The
`www/` cases have Playwright/PHPUnit coverage as well; see
`www/tests/TEST_SPEC.md`.

Each case lists **Setup**, **Steps** and **Expected**.

---

## 1. Per-player map memory and pins

Covers `6b7f596`, `76928a1`. Fog-of-war memory (`inc_persist.nss`),
persistent map pins (`inc_mappin.nss`), and a DM reveal tool
(`dev_revealmap.nss`), ported from tfn-map-memory.

Both tables are keyed by the **Planet + Area coordinate pair**, not by area
resref or tag. That choice matters: `CopyArea()` gives clones an
auto-generated resref that is freed and reused when the clone is torn down,
and clones keep their template's tag forever (TASK-22). Either would corrupt
across players.

### 1.1 Explored map survives leaving and returning
- **Steps:** Explore part of an exterior area. Leave. Return.
- **Expected:** The explored portion is still revealed. Before this change,
  `area_enter.nss` called `ExploreAreaForPlayer(..., FALSE)` unconditionally
  and wiped it on every entry.

### 1.2 Explored map survives a server restart
- **Steps:** Explore an area, restart the server, return.
- **Expected:** Still revealed.

### 1.3 Map memory does not leak between players
- **Setup:** Two characters, ideally on different accounts.
- **Steps:** Have one explore an area the other has never visited. Bring the
  second there.
- **Expected:** The second sees unexplored fog. A leak here would mean the
  coordinate key is being shared rather than scoped per player.

### 1.4 Map memory follows the coordinate, not the clone
- **Steps:** Explore an exterior tile, leave until the clone is destroyed
  (be the last player out), then return so a fresh clone is built.
- **Expected:** The exploration is still there. This is the case the
  coordinate-keying exists for.

### 1.5 Cities and town halls still always reveal
- **Steps:** Enter a `city*` or `townhall*` area for the first time.
- **Expected:** Fully revealed immediately, as before — this behaviour was
  deliberately left unchanged.

### 1.6 Map pins persist
- **Steps:** Place map pins, leave the area, restart the server, return.
- **Expected:** Pins are still there, at the same positions.

### 1.7 Minimap saves to the right area on transition
- **Steps:** Explore area A, walk directly to area B, then return to A.
- **Expected:** A's exploration is intact and B's is separate. `76928a1`
  fixed `ExportMinimap` writing to the wrong area during a transition — test
  this by moving between areas quickly and repeatedly.

### 1.8 Map state saves on logout, not just on area change
- **Steps:** Explore an area and log out from inside it. Log back in.
- **Expected:** Exploration preserved. Export is spliced into `mod_exit.nss`
  as well as `area_exit.nss` for exactly this.

### 1.9 DM reveal tool
- **Steps:** As a DM, use `dev_revealmap`.
- **Expected:** The area reveals. Confirm it does not corrupt the player's
  own stored memory for that coordinate.

---

## 2. Camp-clear missions — refinements

Covers `2749699`, `dc2a6cb`, `2790e2b`, `22f22ee`, `15d41f8`. The base
feature is tested in `QA_TEST_SPEC_GAME.md` §7; these are the later fixes.

### 2.1 The dialog names the camp's exact coordinate
- **Steps:** Take a camp-clear mission from a plot giver.
- **Expected:** The dialog states the camp's actual area coordinate, not a
  vague direction.

### 2.2 The camp location re-rolls once per boot, not endlessly
- **Steps:** Take a mission, note the coordinate, travel around without
  completing it, and re-open the dialog several times.
- **Expected:** The same coordinate throughout the session. After a restart
  it may differ. Before `dc2a6cb` it could change repeatedly.

### 2.3 Completion is keyed to the site, not the town
- **Setup:** Two towns whose missions point at camps.
- **Steps:** Clear the camp for town A's mission, then check town B's.
- **Expected:** B's mission is still outstanding. Completion attaches to the
  camp site, so clearing one does not silently complete another.

### 2.4 Reward splits across the party
- **Setup:** A party of three.
- **Steps:** Clear the camp together, then turn in.
- **Expected:** The reward is divided among the party, not paid in full to
  the person who talks to the plot giver.

### 2.5 Credit goes to who was present at the kill
- **Setup:** A party of three; one member leaves before the last camp
  creature dies.
- **Steps:** Kill the camp, then have the remaining members turn in.
- **Expected:** The split credits those present at the kill, not whoever is
  standing at the plot giver during turn-in (`15d41f8`).

### 2.6 A cleared camp stays cleared
- **Steps:** Clear a camp, leave the coordinate, return.
- **Expected:** It does not rebuild. Covered in depth by
  `QA_TEST_SPEC_GAME.md` §7 — re-run it here as a regression.

---

## 3. DM cluster creature persistence

Covers `59a2dff`.

Cluster member areas are never destroyed during a session, so they never
pass through `area_save.nss` — its `IsClusterMember` early return skips
them. Landed creatures therefore needed their own snapshot path.

### 3.1 A Persistent creature survives a restart
- **Setup:** A DM-built cluster area.
- **Steps:** Land a creature with the Creator tool's **Persistent** toggle
  ON. Restart the server. Return.
- **Expected:** The creature is back, at the position and HP it had.

### 3.2 A non-Persistent creature does not survive
- **Steps:** Land one with Persistent OFF. Restart. Return.
- **Expected:** Gone. Session-only, as everywhere else.

### 3.3 A creature survives an unscheduled restart
- **Steps:** Land a Persistent creature, then kill the server process
  without a clean shutdown. Restart.
- **Expected:** Still there — the snapshot is taken when the creature is
  landed, not only at shutdown.

### 3.4 Moved or damaged state is captured at a scheduled reboot
- **Steps:** Land a Persistent creature, move it and damage it, then let a
  scheduled reboot happen.
- **Expected:** It returns moved and damaged, not at its original spot and
  full HP.

### 3.5 Restore order holds
- **Expected:** Creatures appear in the correct member areas. The restore
  runs in `mod_load.nss` after `dmb_cluster_boot` stamps the member-area
  locals it depends on — a wrong order would put creatures nowhere or in
  the wrong area.

---

## 4. Player self-service auth and per-player map

Covers `dd56e5c`, `ea3b30c`, `36fa836`, `f43c281`, `133af5b`, `d648e7f`,
plus `_webmap.nss` from the `d7401c7` batch. Detailed web cases live in
`www/tests/TEST_SPEC.md`; these are the end-to-end ones that cross from
in-game to the site.

### 4.1 In-game code to website registration
- **Steps:** Type `.web` in game. Note the code. Go to `register.php` and
  register with your public CD key and that code.
- **Expected:** Registration succeeds and the account can log in.

### 4.2 A code cannot be reused
- **Steps:** Register with a code, then try to register again with the same
  one.
- **Expected:** Refused. Codes are one-time.

### 4.3 Login uses bcrypt, and DM login works
- **Steps:** Log in as a player, then as a DM.
- **Expected:** Both succeed. `ea3b30c` fixed a DM bcrypt hash mangled by
  nested `$$` escaping in Docker Compose — if DM login fails, check that
  first.

### 4.4 The map shows only what that player discovered
- **Steps:** Explore tiles as character A. Log into the site as A, then as
  a different player.
- **Expected:** Each sees only their own discovered tiles. Previously the
  map showed one server-wide discovery state, where the first player onto a
  tile revealed it for everyone.

### 4.5 Discovery is recorded on login, not only on travel
- **Steps:** Log out inside an area never visited before, then log back in
  and check the site.
- **Expected:** The tile is recorded. `area_enter.nss` catches the tile a
  player logs in on, which fires no transition.

### 4.6 Last-login time is shown
- **Steps:** Log in, then check the character on the site.
- **Expected:** A real-world last-login time appears and updates.

### 4.7 State-changing actions are DM-gated and CSRF-protected
- **Steps:** As a non-DM, attempt `playerInfo.php`'s `reset_player` action.
  Then, as a DM, submit a state-changing form with a missing or altered CSRF
  token.
- **Expected:** Both refused. Covers `f43c281` and `133af5b`.

### 4.8 No SQL or HTML injection through player-supplied values
- **Steps:** Register or set values containing quotes, `<script>` and `&`.
- **Expected:** Rendered escaped, stored intact, no query breakage.
  `133af5b` moved inline JS values to `json_encode` rather than
  `addslashes`.

---

## 5. Henchman work landed in `d7401c7`

Covers `_hench_gear.nss`, `cond_hench028.nss`, `conv_hench028.nss`,
`henchs_revive.nss`, `hench.dlg.json`, `mod_acquire.nss`, plus `c1d3c77`
and `c466cd9`.

**Note:** this batch was written before this session and committed as-is
without review. These cases are a starting point, not an author's plan.

### 5.1 Armor is capped by henchman level
- **Setup:** Henchmen at levels 1-3, around 4-12, and 13+.
- **Steps:** Try to equip progressively heavier armor on each.
- **Expected:** Level 1-3 capped at AC 4 (scale mail / chain shirt), rising
  by 1 per 3 hit dice, up to AC 8 (full plate) at level 13. Governed by
  `iHenchArmorACBase` / `iHenchArmorACLevels` / `iHenchArmorACMax`.

### 5.2 Armor cannot be lifted out of a henchman's inventory
- **Steps:** Open a henchman's inventory panel and try to drag its armor
  out.
- **Expected:** Refused. `SetDroppableFlag` only governs death drops, which
  is why `mod_acquire.nss` had to intervene.

### 5.3 Soldier paid level-up
- **Setup:** A posted Soldier at a caserne, and enough gold.
- **Steps:** Use the "Level up" dialog option.
- **Expected:** One real class level gained, `iSoldierLevelUpCost` gold per
  level taken, and the option refused without funds.

### 5.4 Paid levels survive a restart
- **Steps:** Level a Soldier twice, restart, and re-check.
- **Expected:** The levels persist, recorded in `PaidLevels`, and stack on
  top of the tier-based rebuild rather than replacing it.

### 5.5 A henchman revives its dead master
- **Setup:** A PC with a henchman, in combat.
- **Steps:** Let the PC die, then let the henchman finish the fight.
- **Expected:** Once combat ends, the henchman revives the master. Note UOA
  dismisses henchmen the moment a PC dies, so the `GetMaster()` link is
  gone — if revive never fires, that is where to look.

### 5.6 Random henchman greeting and mix
- **Steps:** Hire several tavern adventurers in a row.
- **Expected:** The greeting names the correct class breakdown each time
  (no stale token from the previous hire), and race/alignment mix looks
  reasonable (`c1d3c77`).

### 5.7 Horse mounts
- **Steps:** As a paladin of level 5+, and then as a non-paladin, use
  `mountitem`.
- **Expected:** Correct pony phenotype for small races; the non-paladin case
  no longer silently does nothing (`c466cd9`).

---

## 6. Gold auto-loot

Covers `_loot.nss`, `loot_gold.nss`, `treasures.nss`, `creatures_death.nss`
from `d7401c7`. Governed by `iAutoLootGold` and `iAutoLootGoldClose`.

### 6.1 Corpse gold goes straight to the purse
- **Steps:** Kill a creature carrying gold and click the corpse.
- **Expected:** Gold is added directly; no dragging a `nw_it_gold001` stack
  out of the loot window.

### 6.2 A gold-only corpse does not open a window
- **Steps:** Click a corpse whose only contents are gold.
- **Expected:** With `iAutoLootGoldClose` on, no loot window opens at all.

### 6.3 A corpse with other loot still opens
- **Steps:** Click a corpse holding gold and an item.
- **Expected:** Gold is taken automatically, the window opens for the rest.

### 6.4 Chests and crates behave the same
- **Steps:** Open a treasure chest and a crate containing gold.
- **Expected:** Same automatic pickup.

### 6.5 Turn the debug logging off
- **Steps:** Check the server log after looting.
- **Expected:** `[loot]` lines appear while `iAutoLootGoldDebug` is 1. Set
  it to 0 once the feature is confirmed — it logs every sweep.

---

## 7. Item wear rebalance

Covers `wear.nss`, `conv_repair001.nss`, `mod_heartbeat.nss` from
`d7401c7`.

### 7.1 Items break at the intended threshold
- **Steps:** Wear an item down and watch when it breaks.
- **Expected:** It breaks at `iWearBreakThreshold` (20%) remaining, for
  every category. The old formula broke items at roughly
  14/24/39/56/72% remaining for categories A-E, so high-value items broke
  with *more* life left — backwards from the intent.

### 7.2 High-value items no longer break early
- **Steps:** Take a category D or E item to around 75-80% remaining.
- **Expected:** It does not break. This was the reported symptom.

### 7.3 Only worn armor wears out of combat
- **Steps:** Stand out of combat wearing armor and carrying weapons.
- **Expected:** Over `iWearIdleArmorMinutes` (10 real minutes) the chest
  slot loses condition; weapons and everything else lose none.

### 7.4 Repair costs match the category
- **Steps:** Repair items from each value category.
- **Expected:** Cost follows `iFixA`..`iFixE` as a percentage of item value.

---

## 8. Cross-cutting regression

### 8.1 Coordinate wrap at planet edges
- Covers `b3fd782` (`AdvanceCoordAxis` dedup).
- **Steps:** Travel across a planet's coordinate wrap boundary in all four
  directions.
- **Expected:** You arrive at the correct opposite-edge tile. This was a
  refactor with no intended behaviour change, so any difference is a bug.

### 8.2 Server log stays clean
- **Expected:** `~/uoa/logs/nwserverError1.txt` is 0 bytes after a full
  pass.
