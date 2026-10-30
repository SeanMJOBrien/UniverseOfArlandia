# Ship combat systems for Universe of Arlandia

Date: 2026-10-25. Scope: sea and air ship combat, turn based or real time, judged by how well each system fits NWScript and a multiplayer persistent world.

## 1. What was examined

| Source | How it was examined |
|---|---|
| Turn Based Spelljammer (TBSJ), Nightbringer, 2003 | The linked file was downloaded and unpacked: `TBSJ.erf` (85 scripts, 72 items, 12 placeables, 10 dialogs, 8 merchants, 4 creatures) and its readme. The scripts were read in part (`tbsj_inc`, `tbsj_move`, `tbsj_asb_hb`). The demo module was not run. |
| Sailing Boats System, Ogrillion, v0.7 (NWN:EE) | Neverwinter Vault project page only. The scripts were not downloaded. |
| Sailing Ships and Enhanced Sailing Ships and Airships Package, Oseryn | Vault project page only. These are art and placeable assets. |
| Tabletop and board systems | Search summaries plus general knowledge of the rules. Rule details below are marked as general knowledge where no source was read. |
| UoA's own ship code | `src/nss/cannon_*.nss`, `inc_shiparrive.nss`, `shipctrl_used.nss`, and the conflict placeable section of `docs/DM_TOOLS_MANUAL.md`. |

Nothing in this report was run in game.

## 2. Constraints that decide the design

1. A placeable cannot move. `inc_shiparrive.nss` already works around this with `SetObjectVisualTransform` lerps: the real position stays at the landing spot and only the picture moves. The same limit applies to a ship that fights. Collision, line of sight and range need their own bookkeeping because the engine does not know where the hull appears to be.
2. The VM has an instruction limit per execution, so per-tick physics for many ships has to be spread over `DelayCommand` calls or kept simple.
3. Real-time movement of a creature-based ship (a polymorphed or tethered player) depends on client movement and latency. Results differ between players and are difficult to test with several people.
4. UoA already has instanced battle areas. A conflict placeable takes the players into an area cloned from the tile's terrain, and the area is currently empty (`docs/DM_TOOLS_MANUAL.md`, section 8). Its composition is undesigned, so a ship combat system can define what spawns there.
5. UoA's existing cannons (`cannon_used.nss`, `cannon_heart.nss`) are single placeables that cast fireball at the nearest hostile within 40 metres on a 10-second cooldown. They are a useful weapon placeable and are not a ship combat system.
6. The server runs NWN:EE with NWNX available, so `SetObjectVisualTransform`, NUI and NWNX events can be used. TBSJ dates from 2003 and predates all of these.

## 3. Systems compared

### 3.1 Turn Based Spelljammer (NWN, turn based)

- Verified in the files: ships are items in a captain's inventory with their statistics encoded in the item tag (for example `SJSmow_060_010_3_13_2_39` is a man o' war with tonnage, crew, manoeuvre class, armour rating and hull type). Weapons encode size, type, damage ranges, rate of fire, crew required, attack bonus, critical and range in hexes the same way.
- Movement is stepwise. `tbsj_move.nss` advances the ship 5 metres per movement point along its facing, checks for blocking placeables and the 100 by 100 area boundary, and moves the ship with `EffectDisappearAppear`. A polymorph gives the player the ship's appearance.
- Turns run through conversations (fire weapon, turn left or right, end turn, flee). Enemy captains are driven by `tbsj_asb_hb.nss`, an area heartbeat that runs the AI, and by spawn and perception scripts on the NPC.
- Strengths: complete (shops, crews, helms, rams, boarding planks, analysis conversation, NPC pirates, truce handling), fully turn based so latency does not matter, supports player against NPC, player against player and DM-run encounters.
- Weaknesses: needs the Arcane Space tileset hak and polymorph-based appearance, is built on creatures and the old effect system, encodes data in tags rather than 2DA or variables, has no stated licence in the readme, and has not been shown to work on EE. The hex grid is in practice a 5-metre square step with 8 or so facings, which is coarse.
- Fit for UoA: good as a design reference and for its data model (hull points, crew damage, weapon arcs, rate of fire). Poor as drop-in code.

### 3.2 Sailing Boats System (NWN:EE, real time)

- From the vault page: a pseudo-heartbeat timer drives boat movement, the pilot becomes an invisible object tethered to the boat, and there is no polymorph. Version 0.7 adds multiplayer roles (helm steers, sail sets speed, deck fires cannons) through a captain's hat item. Voice commands "attack l", "attack r" and "reload" fire cannons, and the firing script is replaceable through a variable.
- Stated limits from the page: no wind, no AI ships, no ownership or purchase, limited content pack compatibility.
- Strengths: written for EE, role split matches a crewed multiplayer ship, the firing hook is replaceable.
- Weaknesses: real-time movement with a tethered invisible player depends on latency and client position, and there are no AI opponents. Combat is shooting along a line with no hull, crew or damage model beyond what an author adds.
- Fit for UoA: reasonable for open-water travel and a simple player-versus-player duel. It would need a damage model and NPC ships built on top.

### 3.3 Sailing Ships hak and Enhanced Sailing Ships and Airships Package (art)

Placeable and tileset ships, docks, airships and effects. No combat. Relevant as visual assets for whichever system is chosen. Hak requirements and 2DA edits would need to be reconciled with UoA's haks.

### 3.4 Tabletop and board systems

| System | Model | Why it matters for NWScript |
|---|---|---|
| Spelljammer 2e (general knowledge) | Hex or grid tactical movement, per-ship statistics, hull points, crew and weapon stations, boarding. TBSJ is a port of this. | Maps well to a movement-point game, heavy on bookkeeping. |
| Spelljammer 5e and Ghosts of Saltmarsh (search summaries) | Ship stat blocks, a few ship actions, siege weapons, close and board. Described as light and close to ordinary D&D combat. | Few rules and one attack roll per weapon. Small enough to implement in a weekend and consistent with UoA's character combat. |
| Wooden Ships and Iron Men (search summary) | Hex grid, movement points set by wind direction and sail state, one 60 degree turn per hex, all or none of the movement used. | Wind as a movement multiplier is cheap to compute and adds tactics. |
| Close Action, Sails of Glory (search summary for Close Action; Sails of Glory from general knowledge) | Players plot moves secretly or in advance, then all ships resolve together. | Simultaneous plotting removes waiting for each player's turn and suits a server where orders arrive through a dialog or NUI panel. |
| Starfinder starship combat (general knowledge) | Crew roles (captain, pilot, gunner, engineer, science officer) act in fixed phases each round. | Gives every player in a crew a job, and each job is a few lines of script. |
| Puzzle Pirates, FTL, Sea of Thieves (general knowledge) | Crew stations, damage control, boarding. | Useful for station design. Their action minigames do not translate to NWN. |

## 4. Scoring

Scale 1 (poor) to 5 (good). NWScript fit means how directly the mechanism maps to scripts, areas and variables without engine tricks.

| Option | NWScript fit | Multiplayer fairness | Testing effort | Reuse of existing UoA parts | Total |
|---|---|---|---|---|---|
| TBSJ as is | 3 | 5 | 3 | 2 | 13 |
| TBSJ data model, rebuilt on EE | 4 | 5 | 3 | 4 | 16 |
| Sailing Boats System as is | 3 | 2 | 2 | 3 | 10 |
| Plotted-order rounds with crew stations (new, tabletop derived) | 5 | 5 | 4 | 5 | 19 |
| 5e style abstract ship stat blocks | 5 | 5 | 5 | 4 | 19 |

The two new options are not exclusive and combine in section 5.

## 5. Recommendation

Build a round-based system with simultaneous plotted orders and crew stations, using simple stat blocks, inside the cloned battle areas that conflict placeables already open. Use TBSJ and the Sailing Boats System as references, not as code to import.

Reasons:

1. Rounds resolved on a timer avoid latency effects and make results the same for every player.
2. Orders can be collected through a dialog, a NUI panel, or the existing `ActionStartConversation` pattern, and stored as local variables on the ship object. Resolution is a single script that runs through the ships once per round, so the instruction limit is not at risk.
3. Ships are placeables moved with `SetObjectVisualTransform` lerps, the technique `inc_shiparrive.nss` already uses. The round script keeps each ship's true grid position in variables and animates the hull toward it. Collision and range use the stored grid, not the engine position.
4. Crew stations (helm, gunnery, repair, optionally lookout) give each player a role. The roles come from Starfinder and Sails of Glory style orders, and the firing hook idea from the Sailing Boats System.
5. Hull points, crew damage, weapon arcs, rate of fire and ramming come from the TBSJ data model. Weapon attacks use an attack roll against an armour rating, as in the 5e stat blocks, so the numbers sit near the rest of UoA's combat.
6. Wind, as in Wooden Ships and Iron Men, can be added later as a movement multiplier without changing the structure.

Real time remains possible for open travel. Ogrillion's approach suits sailing between points. Combat should switch to rounds when a conflict placeable is entered, because that is the point where the fairness and testing problems appear.

### Outline of a first version

1. Data: a 2DA or a script include holding ship classes (hull points, speed, turn rate, crew slots, weapon mounts) and weapon classes (damage, range, arc, reload rounds). Variables on each ship placeable hold current values.
2. Battle area setup: on area entry, spawn the sides' ships on a grid, record grid positions and facings.
3. Round loop: a repeating `DelayCommand` of about 20 to 30 seconds. Players plot speed, turn and target through a panel. Unplotted ships repeat the last order or hold. NPC captains plot through a small AI function.
4. Resolution order: movement, then firing in initiative order, then boarding and repair, then end-of-round checks for sunk ships.
5. Aftermath: loot and survivors, and return of players through the green shaft the conflict placeable already uses.

### Open questions

- Whether battles should allow player-versus-player. TBSJ handles it by adjusting reputations, which carries side effects for the rest of the server.
- Whether the first release needs boarding, or only gunnery, movement and repair.
- Which visual assets to use. The Oseryn package is the main candidate and needs a check against UoA's haks.
- Licence terms for any TBSJ or Sailing Boats code or art that is copied. The TBSJ readme gives none, and the Vault page for each project states the permissions.

## Sources

- [Turn Based Spelljammer](https://neverwintervault.org/project/nwn1/script/turn-based-spelljammer)
- [Sailing Boats system](https://neverwintervault.org/project/nwnee/script/sailing-boats-system)
- [Sailing Ships](https://neverwintervault.org/project/nwn1/hakpak/original-hakpak/sailing-ships)
- [Enhanced Sailing Ships and Airships Package for NWN EE](https://neverwintervault.org/project/nwnee/hakpak/enhanced-sailing-ships-and-airships-package-nwn-ee)
- [SetObjectVisualTransform, NWN Lexicon](https://nwnlexicon.com/index.php?title=SetObjectVisualTransform)
- [Wooden Ships and Iron Men](https://en.wikipedia.org/wiki/Wooden_Ships_and_Iron_Men)
- [Close Action](https://en.wikipedia.org/wiki/Close_Action)
- [Ghosts of Saltmarsh](https://en.wikipedia.org/wiki/Ghosts_of_Saltmarsh)
- [Spelljammer 5e theater of the mind ship combat rules](https://laughingbeholder.com/rulesets/TFTGGW_Spelljammer_5E_Rules_Version_1.0.pdf)
- [Sea battle, Yohoho Puzzle Pirates wiki](https://yppedia.puzzlepirates.com/Sea_battle)
