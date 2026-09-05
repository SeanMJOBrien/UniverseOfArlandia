# Game / NWScript QA Test Spec — 2026-09 session

Manual in-game test checklist for the work in commits `db5fc9a`..`e1ff820`
(2026-09-04/05), deployed as build `e1ff820`. NWScript has no unit-test
framework in this project (see root `CLAUDE.md`) — everything here is
validated by compiling with `nwnsc` and exercising it in-game.

Each case lists **Setup**, **Steps**, **Expected**, and the TASK it covers.

**Ordered by risk, not by feature.** Sections 1–3 touch live player data or
hot paths that run for every player on every area change; run those first. A
failure there is worse than any missing feature further down.

Two commits in the range are NOT covered here: `d7401c7` (henchman gear, gold
auto-loot, wear rebalance, per-player web map) and `80619ad`/`920bcb9`
(tooling, tests, mockups). Those are the repo owner's own prior work,
committed as-is without review — they need their author's test plan, not
mine.

---

## 1. Player chest storage — HIGHEST RISK

Covers TASK-37. `chestplay_used.nss` was rewritten and the chests now hold
real player property through a new persistence path. A failure here loses
items.

**Before testing:** take a copy of `~/uoa/server/database/` — this is where
storage now lives, and it is NOT in a MySQL dump.

### 1.1 Items survive a server restart (the whole point)
- **Setup:** A character with a rented house at level 1 or above.
- **Steps:** Open chest 1, put in several distinguishable items (note names,
  stack sizes, any enchantments). Close it. Restart the server. Return and
  open chest 1.
- **Expected:** Every item is present, with the same stack sizes, names and
  properties. This is the bug being fixed — previously all of it vanished on
  reboot.

### 1.2 Old contents migrate rather than disappearing
- **Setup:** A chest that had items in it BEFORE build `dacc532` was
  deployed, with no reboot since.
- **Steps:** Open it as its owner.
- **Expected:** Message "Moved N item(s) into your storage." and the items
  appear in the storage window.
- **Note:** If a reboot has already happened, those contents were lost to the
  old module-local bug and this case is unobservable — not a regression.

### 1.3 Storage is per ACCOUNT, not per character
- **Setup:** Two characters on the same CD key, both with house access.
- **Steps:** Store an item as character A. Log in as character B and open the
  same chest slot.
- **Expected:** B sees A's item. **This is intended** (CD-key scoping, matching
  TFN) but is a real design consequence — confirm it is what you want before
  players rely on it.

### 1.4 Storage does NOT leak between accounts
- **Setup:** Two characters on DIFFERENT CD keys.
- **Steps:** Store an item as one; open the same chest slot as the other.
- **Expected:** The second sees an empty (or their own) chest. No cross-account
  visibility under any circumstances.

### 1.5 Storage follows the player to a new house
- **Setup:** A character with items in storage.
- **Steps:** Leave the house ("Leave the house"), rent a different one
  elsewhere, open its chest 1.
- **Expected:** The same items are there. Storage belongs to the account, not
  the building — this is what removes the need for eviction escrow.

### 1.6 The 40-item cap holds and hands the item back
- **Setup:** A chest with 40 item stacks in it.
- **Steps:** Try to add a 41st.
- **Expected:** Message "That chest is full (40 items)." and the item returns
  to your inventory — not destroyed, not silently swallowed. Confirm your
  inventory actually has it afterwards.

### 1.7 The cap counts stacks, not units
- **Steps:** Put a stack of 99 arrows into an otherwise empty chest.
- **Expected:** Counts as 1 of 40, not 99.

### 1.8 Chest level gating is unchanged
- **Setup:** Houses at levels 1, 4 and 5.
- **Steps:** Try each of chests 1–4 at each level.
- **Expected:** Chest 1 from level 1, chest 2 from level 4, chests 3 and 4
  from level 5. Locked chests do nothing when used.

### 1.9 Only the house's Master can open the chests
- **Steps:** As a character who is not the house's renter, use a chest.
- **Expected:** Nothing happens — no window, no message leaking whose it is.

### 1.10 Desks still behave as before (regression)
- **Setup:** A house containing a `deskplayer` placeable.
- **Steps:** Open a desk, add and remove items, close it, re-open.
- **Expected:** Unchanged from before this session. Desks deliberately still
  use the OLD module-local path (`chestplay_open/close.nss`), so their
  contents still vanish on reboot — that is a known, separate bug, not a
  regression from this work. Confirm only that desks are no worse.

---

## 2. Area entry and item activation hot paths — HIGH RISK

Covers TASK-34. `area_enter.nss` runs for every player on every area change,
and `mod_activate.nss` handles every item activation in the game. Both were
touched.

### 2.1 Area transitions are completely unaffected
- **Steps:** Move through at least a dozen areas of mixed type — city,
  exterior tile, dungeon interior, ocean, clouds, space, an airship/starship
  interior.
- **Expected:** No lag, no errors, no change in appearance swapping. Confirm
  `nwserverError1.txt` stays empty throughout. The ship-rename hook is gated
  OFF (`iShipNameRename` = 0), so it must be invisible.

### 2.2 Your character name never changes
- **Steps:** Enter ocean, clouds and space areas.
- **Expected:** Your name is unchanged everywhere. The rename half is
  deliberately disabled pending TASK-33 — if a name DOES change, stop and
  report it, because 96 database lookups key on `GetName(oPC)`.

### 2.3 Existing ship flight still works from its own element
- **Setup:** A character owning `tool_ship` / `tool_airship` / `tool_starship`.
- **Steps:** Use each tool while standing in its matching area type (ocean /
  clouds / space).
- **Expected:** The normal flight dialog opens exactly as before. This path
  must be unchanged.

### 2.4 Using a ship tool outside its element opens the rename window
- **Steps:** Use a ship tool on land.
- **Expected:** A NUI window titled "Ship - <kind>" opens, showing the current
  name (or "(unnamed)") and a text field.

### 2.5 Naming a ship persists
- **Steps:** Type a name, press Save name. Close. Re-open the window. Log out
  and back in, re-open.
- **Expected:** The name shows each time. It is stored on the tool item, so it
  travels with the character file.

### 2.6 Clearing a name works
- **Steps:** With a named ship, press Clear name.
- **Expected:** Confirmation message, field empties, and re-opening shows
  "(unnamed)".

---

## 3. Domain rent and access — LIVE BEHAVIOUR CHANGE

Covers TASK-35 and TASK-36. Renting used to be open to every player on the
server; it is now gated. Expect player reports.

### 3.1 A non-approved character can no longer rent
- **Setup:** A domain with an unrented House slot, and a character who is
  neither its owner nor granted.
- **Steps:** Use the House structure flag.
- **Expected:** The rent menu does not appear. **This is the intended change** —
  previously anyone could rent any house in anyone's domain.

### 3.2 The owner is unaffected
- **Steps:** As the domain owner, use the House structure flag.
- **Expected:** The build/destroy menu as always — owners reach
  `cond_domain005` first and never see the rent menu.

### 3.3 A sitting tenant is never locked out
- **Setup:** A character already renting a house from before this change,
  with no grant.
- **Steps:** Use the structure flag.
- **Expected:** They can still pay rent, enter, and leave the house. Losing
  access to a home you already rent would be the worst failure mode here.

### 3.4 One rental per character
- **Setup:** A character already renting a house.
- **Steps:** Find another unrented House slot they could otherwise rent and
  try.
- **Expected:** The "Rent the house." reply is absent. Governed by
  `iDomainOneRental`.

### 3.5 Moving out frees the cap
- **Steps:** From 3.4, choose "Leave the house", then try renting elsewhere.
- **Expected:** Renting is now offered again.

### 3.6 A demolished house does not strand its tenant
- **Setup:** A character renting a house.
- **Steps:** As the owner, destroy that slot. As the tenant, try to rent
  somewhere else.
- **Expected:** Renting is offered — the stale back-pointer self-heals rather
  than blocking them forever. This is the failure mode the self-check exists
  to prevent.

### 3.7 Rent days survive a restart
- **Setup:** A rented house; note the days remaining shown in the structure
  menu.
- **Steps:** Restart the server. Check again.
- **Expected:** The same figure (or one lower if a game day passed). Rent
  previously stretched at every reboot because it counted a module-local
  heartbeat.

### 3.8 Legacy tenancies are not instantly expired
- **Setup:** A tenancy that predates build `7e4d451`.
- **Steps:** Open the structure menu.
- **Expected:** A full term is shown, not 0 or a negative number.

### 3.9 Paying rent extends rather than resets
- **Steps:** With days remaining, pay a month.
- **Expected:** Remaining days go UP by the term, not back to exactly one term.

### 3.10 The door respects the shared clock
- **Steps:** With rent remaining, lock/unlock the door. Then with an expired
  tenancy (set the expiry back in the database, or wait), try again.
- **Expected:** Unlocks while paid; "No more rent" once expired.

### 3.11 Slot grants reset when the slot changes
- **Setup:** A domain slot with a grant recorded against it (set directly in
  `pwdata` — there is no UI yet, see TASK-35).
- **Steps:** Destroy that slot, or build something different into it.
- **Expected:** The grant row is gone. A grant is permission to use one
  specific structure and must not carry over.

### 3.12 Destroying a domain clears every grant
- **Steps:** Destroy a whole domain that had grants on several slots plus a
  domain-wide (slot 0) grant.
- **Expected:** All of them are gone, slot 0 included.

---

## 4. Ship arrival animation — REGRESSION ONLY

Covers TASK-26. `inc_shiparrive.nss` was rewritten around a new primitive.
The scheduled arrivals must look **identical** to before; the new
random-edge functions have no caller yet.

### 4.1 Scheduled airship arrival is unchanged
- **Setup:** A city area at a configured airship hour.
- **Expected:** Hull flies straight in along one fixed axis, decelerating over
  ~20s, then ropes (~20s) and ramp (~22s). Byte-for-byte the same experience
  as before this session — see §1 of `QA_TEST_SPEC_GAME.md`.

### 4.2 Scheduled starship arrival is unchanged
- **Expected:** As 4.1 with the starship hull.

### 4.3 Departures still animate
- **Expected:** Hull accelerates away rather than popping out.

### 4.4 Ships are no longer marked static mid-flight
- **Steps:** Watch a scheduled arrival closely, particularly the temporary
  flourish ship that self-destructs.
- **Expected:** The hull animates smoothly for its whole descent. Ships now
  carry `NoStatic`, exempting them from `area_pop_inc.nss`'s static marking,
  which would otherwise freeze an animating placeable.

### 4.5 Other placeables are STILL marked static (regression)
- **Steps:** Enter a populated exterior area and check performance and
  interactivity of ordinary scenery.
- **Expected:** Unchanged. Only objects carrying `NoStatic` are exempt.

---

## 5. Space asteroids

Covers TASK-27.

### 5.1 Asteroids sit at varied heights
- **Steps:** Enter a `space0*` area and look at the asteroid field.
- **Expected:** Decorative asteroids are spread over roughly ±3m vertically
  rather than one flat plane.

### 5.2 Heights are stable within a session
- **Steps:** Leave the area and return.
- **Expected:** The same asteroids at the same heights.

### 5.3 Heights re-roll on restart
- **Steps:** Restart the server, return to the same coordinate.
- **Expected:** A different arrangement.

### 5.4 Mineable asteroids are not floating
- **Steps:** Find a `pla_asteroid` (the mineable one) and mine it.
- **Expected:** It sits on the plane like before and is clickable normally.
  Only `asteroid001`–`003` are jittered, precisely so the click hull stays on
  the model.

### 5.5 Watch for asteroids sunk below the plane
- **Expected:** Note whether the −3m end looks wrong in your space tileset. If
  it does, bias the range upward — `iAsteroidJitterZ` in `_module.nss`.

---

## 6. Spawn-group DM tools

Covers TASK-28. These items existed in script but had no blueprint until now,
so this is a first-ever test of the engine behind them.

### 6.1 Capture a staging area
- **Setup:** A DM with a `spawngrab` item; set its `GrpName` (and optionally
  `GrpLevel`) with the DM variable editor. Decorate an area with creatures and
  placeables.
- **Steps:** Activate the item.
- **Expected:** Message "Spawn group '<name>' saved: N object(s), min level M."

### 6.2 Stamp it back
- **Setup:** A DM with a `spawnstamp` item, in an empty area.
- **Steps:** Activate it.
- **Expected:** The captured layout rebuilds at the **area centre** (not where
  the DM stands — a known limitation).

### 6.3 Captured equipment survives
- **Expected:** Stamped creatures keep the gear and locals they had when
  captured.

---

## 7. Conflict battle instances

Covers TASK-30. Plumbing only — `conflict_pop.nss` is an empty hook, and
**nothing places a conflict shaft yet**, so a DM must create one manually
(`pla_conflict`, tag `conflict`) to test at all.

### 7.1 Clicking the shaft clones the right terrain
- **Setup:** DM-place a `pla_conflict` in a space, clouds or ocean tile.
- **Steps:** Click it.
- **Expected:** You arrive in a blank area of the SAME terrain type (space →
  blank space, clouds → blank sky, ocean → blank sea), empty of creatures.

### 7.2 The instance is shared
- **Steps:** Have a second player click the same shaft.
- **Expected:** They arrive in the same area instance, not a fresh one.

### 7.3 The exit returns you to the shaft
- **Steps:** Use the green exit shaft in the battle area.
- **Expected:** You return to the origin tile at the conflict shaft's position.

### 7.4 The return works even when the origin tile was destroyed
- **Steps:** Enter as the only player on that tile (so it empties and is torn
  down behind you), wait, then exit.
- **Expected:** You still get back — the exit falls back to `transitions.nss`
  and rebuilds the coordinate. This is the main thing worth proving.

### 7.5 The instance survives being empty
- **Steps:** Everyone leaves, then someone re-enters.
- **Expected:** The same instance, not a rebuilt one.

### 7.6 Cabin passengers come along
- **Setup:** A pilot flying their own ship with party members in the cabin.
- **Steps:** The pilot clicks a conflict shaft.
- **Expected:** Cabin passengers arrive too, and the cabin clone is destroyed
  behind them.

### 7.7 The cabin hatch refuses mid-conflict
- **Steps:** While the pilot is inside a conflict, a follower uses the cabin
  hatch's "climb up to the pilot".
- **Expected:** "The pilot is under attack - you cannot climb up right now."

---

## 8. Known-unreachable — do NOT raise as bugs

These are deliberately unbuilt or gated off this session:

- **Ship rename onto the pilot** — gated behind `iShipNameRename` = 0 pending
  the TASK-33 `GetName` audit.
- **Conflict creatures** — `conflict_pop.nss` is an empty hook (TASK-32).
- **Conflict shaft placement** — no random roll and no DM item; manual only.
- **Domain grant UI** — `_domainuser.nss` has the storage and rules, but no
  dialog exposes granting yet (TASK-35). Grants must be set directly in
  `pwdata` to test §3.11/3.12.
- **Rent auto-release on expiry** — expiry is detectable now but nothing acts
  on it (TASK-36).
- **Random-edge ship flight** — `ShipArriveFromEdge`/`ShipDepartToEdge` exist
  but nothing calls them (TASK-26).
- **`pla_spacedung001/002` never spawning** — a pre-existing bug, deliberately
  not fixed because it shifts spawn rates (TASK-29).

---

## 9. Post-test housekeeping

### 9.1 Server log stays clean
- **Expected:** `~/uoa/logs/nwserverError1.txt` is 0 bytes after all of the
  above. Any content is a real fault worth chasing.

### 9.2 Storage database is being written
- **Steps:** After §1, check `~/uoa/server/database/`.
- **Expected:** A `pcstorage.sqlite3` exists and grows. Confirm it is included
  in whatever backup you run — a `mysqldump` does NOT cover it.
