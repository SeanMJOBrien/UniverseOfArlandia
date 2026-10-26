# Ship combat prototype

`export/uoa_ship_test.mod` is a single-player test module for round-based ship combat. It needs the base game only (Neverwinter Nights: Enhanced Edition, no haks, no NWNX). It is built by `tools/build_ship_module.py` from the scripts in `tools/ship_test`. It has been compiled and checked with the nwn-mcp validators. It has not been played, so every in-game behavior below is untested.

## Install

Copy `uoa_ship_test.mod` to the `modules` folder of the Neverwinter Nights user directory and start it from Other Modules. Any level 1 character works.

## The area

One area, "Test Bay": Rural tileset, 10 x 10 tiles. A strip of land runs along the south edge. The rest is open water, 20 x 20 squares of 5 metres, of which the northern 16 rows are sea.

| Object | Position | Purpose |
|---|---|---|
| Start point | south shore, centre | The player and any henchman walk the shore freely. |
| Battle Gong | south shore, west of the start | Using it starts the battle. |
| Garrick the Pilot | south shore, east of the start | Henchman. "Join me" adds him to the party. |
| Gull | sea, near the shore | The player's schooner. |
| Skiff, Reaver | sea, north-west and north-east | Hostile ships: a fast sailboat and a heavy galley. |

The ships are the base game's "Ship - Tiny" placeables. Everyone stands on the shore during the battle; the ships are shown as markers on the water and in the window's map.

## Playing

1. Walk the shore. Optionally talk to Garrick and choose "Join me."
2. Use the gong. The Ship Orders window opens and round 1 starts.
3. Each round has a 30 second plotting phase. Set the orders, then press Ready. Pressing Ready ends the phase early; the timer ends it otherwise.
4. All ships then move together, one square at a time, and fire together. Results are in the window's log and as messages.
5. The battle ends when the Gull sinks (defeat) or both hostile ships sink (victory). End battle in the window stops it at any time. After a few seconds the ships return to their starting squares and the gong can be used again.

### Orders

| Control | Effect |
|---|---|
| Pilot | Who steers. The player, or any henchman in the party. A henchman pilot plots the movement by itself every round (head for the nearest foe, then come alongside); Move and Turn are then set by the pilot. Gunnery stays with the player. |
| Move | Squares to advance this round, up to the ship's speed. |
| Turn | Turn applied before moving, up to the ship's turn rate, in 45 degree steps. |
| Target | The ship the guns aim at. |
| Fire port / starboard guns | Fire that broadside if the target is in its arc and range. |
| Ready | Ends the plotting phase now. |
| Follow ship | Attaches the camera to the Gull (done automatically when the battle starts). |
| Return to shore | Returns the camera to the player and moves the player to the shore start point. |

### Rules

| Item | Gull | Skiff | Reaver |
|---|---|---|---|
| Hull points | 40 | 25 | 45 |
| Squares per round | 3 | 4 | 2 |
| Turn per round | 90 degrees | 90 degrees | 45 degrees |
| Guns per broadside | 2 | 1 | 3 |
| Range (squares) | 6 | 5 | 6 |
| Armor rating | 12 | 13 | 11 |
| Attack bonus | +4 | +3 | +3 |

- **Order of events:** turn, then move one square at a time with all ships moving together, then fire together.
- **Moving:** a ship that would enter an occupied square stops, and both ships take a d6 ram hit. A ship stops at the edge of the bay and at the shore line.
- **Firing:** each broadside covers 90 degrees abeam (45 to 135 degrees from the bow, port or starboard). Each gun rolls d20 plus the attack bonus against the target's armor rating. A natural 1 misses and a natural 20 hits for double damage. A hit does d6+2.
- **Reloading:** a broadside that fires cannot fire again the next round.
- **Hostile ships:** they plot like a henchman pilot and fire both broadsides at the nearest foe each round.

## Tuning

Two module variables (Module Properties, Variables in the toolset) can be changed without rebuilding:

| Variable | Default | Meaning |
|---|---|---|
| `ship_scale_pct` | 300 | Size of the ship models, in percent. The models are small; raise or lower this until a ship fills about one square. |
| `ship_yaw_offset` | 0 | Degrees added to a ship's heading. Use 90, 180 or 270 if the model points the wrong way. |

The statistics, timer and grid constants are at the top of `tools/ship_test/sc_inc.nss`; the stat table is in `ScInitShip`.

## What to check first

These are the points most likely to need a fix, since none of the code has run in the client:

1. The shore tiles: row 1 uses tile 7 (water on the north edge, grass on the south). If the shore looks wrong, the tile or its orientation needs changing in `shiptest.are`.
2. Ship movement: the ships glide square to square with `SetObjectVisualTransform` translation (the technique `inc_shiparrive.nss` already uses). Turns are instant 45 degree snaps with `SetFacing`.
3. Ship height: ships are at z 0.0. If they float above or sink into the water, set the translate Z in `ScShowAt`.
4. The Ship Orders window: layout, the map (drawn with NUI draw-list items), and the combo boxes. The draw list cannot be bound as a whole, so the map is a fixed list of items (sea, shore, grid, and an outline, label and target line per ship) whose points, colours and text are bound and pushed every second and after each change.
5. Whether changing a combo or box fires a `watch` event. The handler writes the orders then and only pushes a redraw when a value changed, so a repeated event does nothing.
6. Henchman pilot: confirm Garrick appears in the Pilot box after he joins. The box lists the party when the window opens, so join him before using the gong.
7. Camera follow: `AttachCamera` follows the ship object, which never moves (only its drawn position does), so the camera may stay at the mooring instead of gliding with the ship.
8. Visual effects on hits use `VFX_IMP_FLAME_M` and `VFX_FNF_SMOKE_PUFF` at the squares' world positions.

## Not built yet

- Spell casting. The plan is a list of memorized spells in the window, spent at plotting time, each mapped to a ship-scale effect and resolved after movement with the guns.
- Station assignment other than the pilot (gunner, caster), and player-versus-player.
- Boarding, wind, and ship damage beyond hull points.
- Use in the live module. The code is kept in `tools/ship_test` and is not part of the server build.

## Files

| File | Purpose |
|---|---|
| `tools/ship_test/sc_inc.nss` | Grid, ship state, orders, round resolution, computer plotting. |
| `tools/ship_test/sc_nui.nss` | The Ship Orders window and its map. |
| `tools/ship_test/sc_nui_event.nss` | Window events. |
| `tools/ship_test/sc_ui_open.nss`, `sc_ui_refresh.nss` | Run on the player to open and redraw the window. |
| `tools/ship_test/sc_bell_use.nss` | Gong: starts the battle. |
| `tools/ship_test/sc_on_enter.nss` | Module entry: sets the ships out. |
| `tools/ship_test/act_ship_hire.nss`, `act_ship_dismiss.nss` | Garrick's dialog actions. |
| `tools/build_ship_module.py` | Builds the module. |
