# DM Tools Manual — Universe of Arlandia

How to use the module's own DM tools. This manual does not cover the DMFI
tools, which are third-party and documented separately.

Everything here needs DM status. The module accepts a DM-possessed creature as
well as a logged-in DM for most tools.

## Contents

1. [The `.w` chat commands](#1-the-w-chat-commands)
2. [The DM Tool item](#2-the-dm-tool-item)
3. [Location mode: the world menu](#3-location-mode-the-world-menu)
4. [Target mode: acting on one creature](#4-target-mode-acting-on-one-creature)
5. [Area mode: acting on everything at once](#5-area-mode-acting-on-everything-at-once)
6. [Spawn groups](#6-spawn-groups)
7. [Rental doors and apartment buildings](#7-rental-doors-and-apartment-buildings)
8. [Conflict placeables](#8-conflict-placeables)
9. [Coordinates and terrain codes](#9-coordinates-and-terrain-codes)

---

## 1. The `.w` chat commands

Type these into the ordinary chat box. The module intercepts any message
starting with `.w`, so the text never reaches other players.

Typing `.w` on its own, or any unrecognised `.w` command, prints the usage
line.

### `.wjump <X_Y>`

Travels to a world coordinate on the planet you are currently on.

```
.wjump 3_5
.wjump m2_7
```

Coordinates use `m` for a negative number, so `m2_7` means X = −2, Y = 7. This
applies to every command below that takes a coordinate.

### `.warea <tagprefix> [X_Y]`

Places one of your own hand-built areas at a world coordinate. Give the area's
tag prefix. If you leave the coordinate out, the command uses the tile you are
standing on.

```
.warea myfortress
.warea myfortress 4_m1
```

The area must be a static, uniquely-tagged area. A `000` template will not
work, because those are destroyed when the last player leaves, and neither will
an area already serving another world tile.

### `.wcluster [X_Y]`

Opens the cluster editor for a coordinate. A cluster is a group of your own
areas that all share one world tile, with up to four entrances — one per
compass direction.

The window stays open while you walk around. For each side you want to open,
walk into the area that should serve that side, return to the window, and press
**Set to my area**. Press **Block** to close a side again, then **Save**.

Entering the tile from a given side lands the player in that side's area.
Arriving without a direction — by `.wjump`, an airship ticket, or a recall —
lands them in the first mapped side, checked north, east, south, west.

To control exactly where arrivals land, place a waypoint tagged
`CLU_ENTRY_NORTH`, `CLU_ENTRY_EAST`, `CLU_ENTRY_SOUTH` or `CLU_ENTRY_WEST`
inside the member area.

**Remove cluster** clears the mapping, releases the member areas, and resets
the tile to plain forest. Use `.warea` afterwards if you want something else
there.

The mapping is stored in the database and rebuilt at every server start.

### `.wunits <count> [sizes]`

Configures the nearest apartment door — a placeable tagged `unitdoor` — within
10 metres. See [section 7](#7-rental-doors-and-apartment-buildings).

```
.wunits 6 1,1,1,1,3,1
.wunits 4
.wunits 0
```

`count` is how many units the building has. `sizes` is an optional comma list,
one number per unit: **1** small, **2** medium, **3** large. A short list, or
no list at all, makes the remaining units small. A count of `0` clears the
door.

The setting is written to the database, so it survives a server restart.

### `.web` (players, not DMs)

Players type `.web` to get a one-time code for registering on the website. It
is listed here only so you recognise it when a player mentions it.

---

## 2. The DM Tool item

The **Dm Tool** item opens the main DM menu. Which menu you get depends on what
you activate it on:

| Activated on | Menu |
|---|---|
| The ground | **Location mode** — build and manage the world |
| A creature | **Target mode** — act on that one creature |
| Anything, after choosing AREA MODE | **Area mode** — act on every creature in the area |

Area mode stays on until you turn it off. Both the target and area menus carry
an **AREA MODE** entry that toggles it.

---

## 3. Location mode: the world menu

Activate the DM Tool on the ground.

### Creatures

- **Recall creatures** — rebuilds the area's saved creatures.
- **Destroy creatures** — removes them.
- **Creatures land** — places a creature you choose. A creature landed with the
  **Persistent** option survives a server restart. Inside a cluster member area
  it is snapshotted the moment you land it, so it also survives a crash, and it
  is refreshed again before every scheduled restart so its position and health
  come back as you last left them.

### Place

- **Camp** — a monster campfire, big camp, or fort.
- **Interest** — an amusement place, animal reserve, castle, dungeon, resources
  mountain, ruins, or town.
- **Scenery** — bridges, buildings, fields, roads, and castle, domain or
  graveyard walls. **All placeables in square** clears a patch first.
- **Store** — an alchemist, animal trader, architect, armourer, bank,
  blacksmith, clothier, general store, inn, jeweller, library, or magic shop.

### Players

Lists the players online, ten to a page, with **Next page** and **Refresh**.
Choose one to act on them.

### Sound

Plays a sound, or starts and stops the area's background and battle music.

### Teleport

Moves you to a custom location, an axis location, the nearest creature, or the
nearest placeable.

### World

- **Advance time for 1 hour**
- **Change area** — swap the tile's terrain.
- **Check area objects** — counts what the area holds.
- **Destroy all area creatures** / **Destroy all area placeables**
- **Destroy nearest** / **Destroy scenery**
- **Remove interest** — clears the tile's interest record.
- **Toogle area revealed** / **Toogle planet areas revealed** — controls what
  the website map shows. (The spelling is the module's own.)
- **Toggle reboot** — arms or disarms the scheduled restart.
- **Toggle wandering** — whether creatures walk about.
- **Weather**
- **Build area** — the area builder.
- **Mark cluster coordinate** / **Register cluster area** — the older
  cluster-building path. `.wcluster` is easier.
- **Debug** and **Test** — diagnostic output.

---

## 4. Target mode: acting on one creature

Activate the DM Tool on a creature.

| Option | What it does |
|---|---|
| **Animations/Effects** | Plays an animation or applies a visual effect |
| **Appearances** | Changes the creature's model, and can restore the original |
| **Cavalry** | Mounts the creature |
| **Check henchmen** | Lists a player's henchmen |
| **Destroy** | Removes the creature |
| **Duplicate** | Copies it |
| **Faction** | Changes which faction it belongs to |
| **Flee** | Makes it run |
| **Henchman** | Makes it follow as a henchman |
| **Leader** | Marks it a leader |
| **Level up** | Adds a level |
| **Name** / **No name** | Sets or clears its name |
| **Persistent** | Marks it to survive a restart |
| **Reputation** | Adjusts how it regards a player |
| **Stabilise** | Stops it bleeding |
| **Stock** | Fills a store's inventory |
| **Transform** | Changes it into something else |
| **Wandering** | Whether it walks about |
| **Debug** | Prints its internal state |

## 5. Area mode: acting on everything at once

Choose **AREA MODE** from either menu. The same options then apply to **every
creature in the area at once**, so use it deliberately — **Destroy** in area
mode empties the area.

Area mode drops the options that only make sense on one creature: Check
henchmen, Duplicate, Name, Reputation and Stock.

Choose **AREA MODE** again to return to single-target work.

---

## 6. Spawn groups

A spawn group is a layout of creatures and placeables that you build once and
then stamp anywhere. The module can also spawn a saved group in place of a
randomly generated monster camp.

You need two items: **spawngrab** to capture, **spawnstamp** to place.

### Capturing a group

1. Decorate an area with the creatures and placeables you want. Any staging
   area will do.
2. On the **spawngrab** item, set two variables with the DM variable editor:
   - `GrpName` — a name for the group.
   - `GrpLevel` — the lowest planet level the group may appear at.
3. Activate the item.

The message `Spawn group '<name>' saved: N object(s), min level M` confirms it.
Creatures keep their equipment and settings.

### Stamping a group

Set `GrpName` on the **spawnstamp** item and activate it to place that group.
Leave `GrpName` empty to place a random eligible group instead.

The layout always appears at the **centre of the area**, not where you stand.

Stamped objects are flagged as camp content, so the normal camp cleanup applies
to them.

---

## 7. Rental doors and apartment buildings

A rental door lets one doorway serve several rented homes.

### Setting one up

1. Place a **pla_unitdoor** placeable where the entrance should be. Face it the
   way the building faces — the interior's own door is chosen to match, so a
   door facing the wrong way gives a home whose entrance is on the wrong wall.
2. Stand within 10 metres and type `.wunits`, for example:

```
.wunits 6 1,1,1,1,3,1
```

That gives six units, of which the fifth is large and the rest small.

### What players see

Using the door opens a list:

```
6 units, 2 for rent
1. Bruno Beltrix
2. Vadil Tourn
3. Amber Rose
4. Gradle                    (yours, 23d)   [Enter] [Pay] [Leave]
5. VACANT: Large unit                       [Rent 1000gp]
6. VACANT: Small unit                       [Rent 250gp]
```

A tenant sees their days remaining and can enter, pay, or give the unit up.
Other people's units show a name only.

### Sizes

| Size | Interior | Floors | Chests | Rent |
|---|---|---|---|---|
| 1 small | 2×2 | 1 | 1 | 250 gp |
| 2 medium | 4×2 | 2 | 2 | 500 gp |
| 3 large | 3×5 | 3 | 4 | 1000 gp |

Rents are set by `iUnitRentSmall`, `iUnitRentMedium` and `iUnitRentLarge` in
`src/nss/_module.nss`. The term is `iDomainRentDays`, 30 game days.

### Things to know

- A character may **rent** only one home at a time, whether a rental unit or
  someone else's domain house. They must give one up before taking another.
  This limit covers rented homes only. A player who builds their own domains
  may have a Personal House in each, and there is no limit on how many domains
  they build — see below.
- Rent that runs out releases the unit the next time anyone opens that door. A
  building nobody visits keeps its expired tenants until someone looks.
- A tenant who re-rents their own unit finds their furniture as they left it. A
  different tenant gets an empty one.
- Storage chests hold the player's account storage rather than anything kept in
  the building, so losing a unit never costs anyone their belongings.
- Two rental doors are always separate buildings, even side by side in one area.

---

### Houses a player owns, versus homes they rent

Two domain structures look like housing and behave differently:

| | **House** (structure 11) | **Personal House** (structure 14) |
|---|---|---|
| Who lives there | a tenant | the domain owner |
| Rent | tenant pays; owner earns from it at structure level 3 and above | none |
| Counts against the one-rental limit | for the tenant only | no |

A **House** is rental property. The domain owner is its landlord and cannot
live in it — standing at its flag gives them the build menu, never the option
to rent.

A **Personal House** is the owner's own residence, rent-free.

Neither domains nor Personal Houses are limited. A player who builds five
domains may have five Personal Houses, and may still rent one home elsewhere on
top of that. This is deliberate: the one-rental limit governs tenants, not
what a player builds for themselves.

---

## 8. Conflict placeables

A conflict placeable is a red light shaft representing a fight in progress. It
belongs in a ship-travel area — space, clouds, or ocean. A player who clicks it
is taken into a battle area cloned from that tile's own terrain, and comes back
through the green shaft there.

Place a **pla_conflict** where you want the fight. Everyone who clicks the same
shaft joins the same instance.

The battle area is currently created **empty**: the composition of the two
opposing sides is not yet designed, so nothing spawns in it. Nothing places
these shafts automatically either, so a conflict exists only where you put one.

---

## 9. Coordinates and terrain codes

World coordinates are written `X_Y`, with `m` standing in for a minus sign:

| Written | Means |
|---|---|
| `0_0` | origin |
| `3_5` | X = 3, Y = 5 |
| `m2_7` | X = −2, Y = 7 |
| `m4_m1` | X = −4, Y = −1 |

Planet `Arland`, coordinate `0_0` is the starting city, Arlandia.

Commands that take a coordinate use the tile you are standing on when you leave
it out.
