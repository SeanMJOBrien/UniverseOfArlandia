# Cluster Areas — Builder & DM Manual

> Covers the feature added on branch `cluster-areas` (commits `47d0218`, `87c90a6`).
> Audience: builders placing clusters in the toolset, and DMs registering them in-game.

## What this is

A "cluster" lets a single planet coordinate (`Planet` + `X_Y`) resolve to a group of
permanently static, hand-built toolset areas — e.g. a 15-area city — instead of the
usual randomly-generated or `CopyArea()`'d terrain tile. Internal navigation between a
cluster's own areas uses plain NWN doors/triggers; only the four outer edges need a
script, to route players back into the normal coordinate-transition system.

**Cluster areas are never `CopyArea()`'d and never `DestroyArea()`'d.** They behave
like any other hand-placed toolset area that happens to be reachable from the
world-coordinate grid. This also means cluster areas never participate in
`area_save.nss`/`area_recall.nss` (no object persistence/respawn cycle, no creature
spawning, no quest-object placement) — see **Limitations** below.

## Data model

One pwdata key per registered cluster coordinate:

```
<Planet>&<X_Y>&Cluster = <DefaultTag>&001&<NorthTag>&002&<SouthTag>&003&<EastTag>&004&<WestTag>&005&
```

Example: `Arland&5_3&Cluster = arland_city_default&001&arland_city_n&002&&003&&004&&005&`
(North built, South/East/West not yet built).

Only the **Default** slot is required. A blank direction slot is not an error — a PC
entering from that direction is simply routed to the Default area instead. This
fallback is a plain tag lookup (`GetObjectByTag`), never a runtime area copy, so it's
safe to register a cluster with only the Default slot filled in and build the rest
later.

## Building a cluster (toolset)

1. Build the Default entry area. Tag it uniquely (e.g. `arland_city_default`).
2. Build internal cluster areas and connect them with ordinary NWN area-transition
   doors/triggers — no scripting needed for internal navigation.
3. On the cluster's **outer** border(s), place a trigger per exit direction. Tag
   doesn't matter, but each trigger needs:
   - `OnEnter` script: `cluster_exit`
   - Local string `ClusterPlanet` = the coordinate's planet name (e.g. `Arland`)
   - Local string `ClusterArea` = the coordinate's `X_Y` string (e.g. `5_3`)
4. Build North/South/East/West dedicated entry areas over time. Treat the Default
   fallback as a temporary stand-in, not a resting state — register each direction as
   soon as it exists (see DM workflow below).

## Registering a cluster (in-game, DM)

Menu path: talk to the DM conversation → **"Which option ?"** →

- **"Mark cluster coordinate."** — stand on the target *terrain tile* (the ordinary,
  already-resolved coordinate you want to convert), select this option. It reads that
  tile's `Planet`/`Area` and remembers it as your pending cluster coordinate.
- **"Register cluster area..."** — walk/jump to the entry area you just built, select
  this, then pick a slot: **Default / North / South / East / West**. This writes the
  current area's tag into that slot of the pending coordinate's `Cluster` record.

Repeat "Register cluster area..." for each direction as you build it — no server
restart needed, takes effect on the next transition into that coordinate.

**Two-step, two-location by design:** this DM tool has no free-text input (mirrors
every other `conv_dm0XX.nss` tool in this module, which are all menu/`Choice1`-driven).
Step 1 captures the coordinate from your current tile; step 2 captures the area tag
from wherever you're standing when you register it — they're necessarily different
locations, since a cluster area itself never carries `Planet`/`Area` locals.

## How it works (reference)

| File | Role |
|---|---|
| `src/nss/transitions.nss` | New branch, checked before the normal CopyArea/static-tile resolution: reads the `Cluster` pwdata record, picks the slot matching the PC's `Direction` local (falling back to Default), resolves it via `GetObjectByTag()`. |
| `src/nss/area_transition.nss` | Sets `Direction` on the PC (from the border trigger's own tag) before handing off to `transitions.nss`. Also refactored to call the new `AdvanceCoordAxis()` helper instead of 8 duplicated inline wrap-boundary ternary chains — pure refactor, no behavior change. |
| `src/nss/cluster_exit.nss` | *(new)* OnEnter script for a cluster's outer border triggers. Reads `ClusterPlanet`/`ClusterArea` off the trigger, advances the coordinate via `AdvanceCoordAxis()`, sets `Direction`/`PlanetDest`/`AreaDest` on the PC, hands off to `transitions.nss`. |
| `src/nss/_string_utils.nss` | New `AdvanceCoordAxis(sCoord, iPlanetSize, iStep, bIsSpace)` helper — advances one coordinate axis by one step, wrapping at ±`iPlanetSize/2` (space tiles never wrap). |
| `src/nss/conv_dm045.nss` | DM tool step 1 — marks the pending cluster coordinate from the DM's current tile. |
| `src/nss/conv_dm046.nss` | DM tool step 2 — writes the DM's current area's tag into the chosen slot of the pending coordinate's `Cluster` record. |
| `src/dlg/dm.dlg.json` | Adds "Mark cluster coordinate." and "Register cluster area..." (→ Default/North/South/East/West) to the main DM "Which option ?" menu. |

## Limitations

- **No diagonal-corner handling.** `cluster_exit.nss` only handles straight N/S/E/W
  crossings — keep border triggers away from tile corners, same as the base terrain
  transition system's corner-jump logic (which cluster areas don't get).
- **No quest/mission targeting inside cluster areas.** Missions and "last town
  visited" tracking key off an area's `Planet`/`Area` locals; cluster areas
  deliberately never set these, so a cluster's internal areas can't be a mission
  destination or `LastCiv` target today.
- **No object/creature persistence via `area_recall`/`area_save`.** Cluster areas are
  never entered by the dynamic spawn/save cycle — anything placed in them lives only
  as long as the area itself (i.e., permanently, since it's never destroyed), but
  doesn't get the toolset-object plot/permanent protection that a normal `Planet`/
  `Area`-tagged area gets on first entry.
- **A cluster near a bad tag silently blackholes.** If a registered slot's tag points
  to a deleted/renamed area, that direction (or the whole coordinate, if Default is
  broken) resolves to nothing and the PC sees "*no area available*" with no automatic
  fallback beyond Default.
- **Single entry point per direction, not per approach path.** All players entering
  from, say, the north land at the same spot in the North area regardless of exactly
  where they crossed the border.

## Verification performed

- `nwnsc` compiled `_string_utils.nss`, `area_transition.nss`, `transitions.nss`,
  `cluster_exit.nss`, `conv_dm045.nss`, `conv_dm046.nss` — 0 errors, 0 warnings.
- `dm.dlg.json` edit verified two ways: a full structural diff confirming every
  pre-existing entry/reply is unchanged, and a round-trip through the real `nwn_gff`
  tool (JSON → GFF binary → JSON) confirming the new nodes survive intact.

**Not yet done — recommended before relying on this in production:**
- In-game playtest: register a cluster, walk in from an unbuilt direction (confirm
  Default fallback), build+register a second direction, confirm the DM menu path
  ("Mark cluster coordinate." → "Register cluster area..." → slot choice) actually
  produces the expected floating-text confirmations and persistent-string writes.
- Confirm a PC leaving via a border trigger lands on the correct adjacent coordinate
  and that henchmen/associates follow through the vanilla internal cluster doors.
