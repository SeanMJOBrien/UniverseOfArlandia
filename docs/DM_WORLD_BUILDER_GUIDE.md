# DM World-Builder Guide

Covers two DM-only tools added to UOA: the in-game `.w` chat commands for
placing hand-built content into the world (including linked-area clusters),
and the website's Planet Creator page for adding new planets, moons, and
asteroids to the galaxy. Both are additions on top of the original UOA DM
toolset — see `www/UOA_DMguide.pdf` for the base DM tool (Creator, Chooser,
Players menu, etc.), which this guide doesn't repeat.

## Contents

1. [World coordinates, quick primer](#world-coordinates-quick-primer)
2. [In-game: `.w` chat commands](#in-game-w-chat-commands)
3. [In-game: building a cluster](#in-game-building-a-cluster)
   - [Creatures placed inside a cluster member](#creatures-placed-inside-a-cluster-member)
4. [Website: Planet Creator](#website-planet-creator)
5. [Troubleshooting](#troubleshooting)

---

## World coordinates, quick primer

Every planet is a grid of tiles addressed as `X_Y`. Negative numbers use an
`m` prefix instead of a minus sign: `-3,5` is written `m3_5`. `0_0` is the
center of the grid. A planet's size determines its valid range — a
size-40 planet runs from `m20_m20` to `20_20`.

You can always find your own coordinate in-game via the standard DM tool's
location display, or with `.winfo` (see below) once you're standing on a
tile.

---

## In-game: `.w` chat commands

Type these in normal chat. They only work for a DM or DM-possessed
character; everyone else's chat is unaffected, and DM commands are never
broadcast to the channel. All coordinates use the `X_Y` form above.

| Command | Effect |
|---|---|
| `.wjump <X_Y>` | Teleport to a coordinate on your current planet. |
| `.warea <tagprefix\|01-23> [X_Y]` | Replace a tile with a hand-built area, or a plain terrain type. Defaults to your current tile if `X_Y` is omitted. |
| `.wcluster [X_Y]` | Open the cluster editor (see next section). |

### `.warea` — placing a single hand-built area

```
.warea h_castle1_
```

The argument is the **area's tag with its `000`/`001` suffix removed**. For
example, if your hand-built area is tagged `h_castle1_001`, use
`h_castle1_`. The game looks for `<prefix>000` (a template it will clone
fresh each time, via `CopyArea`) or `<prefix>001` (a single static
instance reused every time) — build your area with one of those two tag
patterns.

You can also give a plain terrain code (`01`–`23` — clouds, desert,
forest, ocean, etc.) to reset a tile back to normal generated terrain.

```
.warea 04            # reset the current tile to forest
.warea h_tower_ m5_3  # put a hand-built tower at m5_3, not your current tile
```

What happens:
- If anyone other than a DM is standing on the tile, the command is refused
  ("Players are at ... - move them out first"). Move them, then retry.
- The old area is saved and, if it was a temporary clone, destroyed. Records
  tied to the coordinate — town/dungeon/castle interests, domain buildings,
  dropped-object records — are **never touched**, so anything already
  registered at that tile survives the swap.
- The tile is marked "discovered" so the change survives a server reboot.
  (Undiscovered tiles get their terrain re-rolled at every reboot — this is
  why every DM write sets the flag automatically.)
- You are not auto-teleported there; `.wjump` to it afterward to check your
  work.

### `.winfo` and `.whelp`

- `.winfo [X_Y]` — reports the raw tile code, whether it's discovered, the
  live area's tag if one is currently instantiated, and (for cluster tiles)
  the decoded per-direction mapping.
- `.whelp` — prints a one-line reminder of all commands.

---

## In-game: building a cluster

A **cluster** is a group of your own hand-built areas that all occupy a
*single* world coordinate, with up to four exits — one per compass
direction — each leading to a different member area. This lets you build,
say, a keep with a courtyard, an inner hall, and a dungeon, all reachable
from one map tile, with the world's cardinal edges each opening into a
different part of the complex.

Rules:
- Each compass side (North/East/South/West) of the coordinate is either
  **blocked** or mapped to exactly **one** member area.
- Entering the coordinate from a given side lands you in that side's
  member. If you arrive with no direction (`.wjump`, an airship ticket, a
  recall), you land in the first mapped member (checked in N, E, S, W
  order).
- Inside a member area, only the edge matching its mapped direction leads
  back out to the wider world; every other edge trigger in that area prints
  "There is no exit this way." Members do **not** need their own doors or
  internal edge triggers to connect to each other — do that with ordinary
  doors/waypoints inside your build, same as any other multi-area complex.
- A member area must be a **static, uniquely-tagged area** — not a `000`
  template (which gets destroyed when everyone leaves) and not already
  serving as another world tile.

### Workflow

1. Build your member areas in the toolset as usual, each with its own
   unique tag.
2. Stand in the world (or walk to) the coordinate you want the cluster at,
   then type `.wcluster` (or `.wcluster <X_Y>` from elsewhere).
3. A window opens listing North/East/South/West. For each side you want
   open: walk into the area that should serve that side, come back to the
   window (it stays open across area changes), and click **"Set to my
   area"** next to that direction. Click **Block** to clear a mapping.
4. Click **Save**. This is the same "evict + preserve other records" write
   `.warea` does — if a non-DM player is on the tile you'll be asked to
   move them first.
5. Optional: place a waypoint tagged `CLU_ENTRY_NORTH` (or `_EAST` /
   `_SOUTH` / `_WEST`) inside a member area to control exactly where
   arrivals from that side land, instead of the default edge position.
6. **Remove cluster** clears the mapping, releases the member areas, and
   resets the tile to plain forest terrain — use `.warea` afterward if you
   want something else there.

The cluster mapping is saved to the database and rebuilt automatically at
every server reboot, so it survives restarts without you needing to redo
anything.

### Creatures placed inside a cluster member

Creatures you land with the base toolset's Creator tool ("Land creatures")
inside a cluster member area are **not** covered by the game's normal
per-tile object persistence — cluster members are excluded from that system
so multiple members sharing one coordinate don't overwrite each other's
saved objects. Instead, a creature landed with the Creator tool's
**Persistent** toggle on survives restarts through a separate path:

- It's snapshotted immediately when you land it, so it comes back even
  after a crash or an unscheduled restart — at the position/HP it had when
  placed.
- Its position and HP are refreshed once more right before every scheduled
  reboot, so a normal restart brings it back as you last left it (moved,
  damaged, etc.) rather than only where you originally placed it.
- A creature without **Persistent** checked is session-only, same as
  everywhere else in the world.

---

## Website: Planet Creator

`planetCreator.php` on the DM website lets you add a new planet, moon, or
asteroid to the galaxy without touching game scripts. Log in with the DM
password first (same login as the rest of the admin pages), then open
**Planet Creator** from the nav bar.

### Creating an orb

1. Pick a **Kind preset** (Planet / Moon / Asteroid) to prefill sensible
   defaults — every field stays editable afterward. The module doesn't have
   a distinct asteroid model, so asteroids reuse the moon visuals with a
   small, resource-heavy profile.
2. Fill in the fields, grouped as:
   - **Identity** — which star system it belongs to, its name, orb type
     (planet/moon/star/black hole visual), galaxy position, surface size,
     level (1–9), and whether it's shown on the public galaxy map.
   - **Surface tiles** — up to five terrain types with relative
     probability weights, used to randomly generate the planet's tile grid
     the same way the built-in planets are generated. Tile 1 is required.
   - **Life & ambiance** — creature and resource "families" (use `self`
     for the planet's own, or name another planet/family to borrow from)
     and roughly how many of each per area, plus an ambiance track.
   - **Interests** — the overall chance per area of a notable location, and
     the relative weights between towns, dungeons, castles, ruins, animal
     reserves, resource mountains, and amusement places.
   - **Description** — free text shown to players in-game.
3. Click **Create orb**.

The new orb is written to the database immediately, but the surface grid,
creatures, and interests are generated by the module's galaxy system —
**this only happens at the next server reboot**. The page tells you this
after saving, and lists the orb as "awaiting reboot" until then.

### Editing or removing an orb

The table at the top of the page lists every DM-created orb with an
**Edit** and **Delete** link.

- **Edit** reopens the form prefilled with that orb's current stats (its
  name can't be changed once created — delete and recreate if you need a
  different name).
- **Delete** removes the database record. At the next reboot, the module's
  own cleanup pass notices the planet is gone and automatically wipes its
  generated areas, tiles, and interest records — you don't need to do
  anything else.

### Validation

The form rejects: duplicate planet names, a galaxy position already
occupied by another orb, reserved names that would collide with internal
database keys (`Space`, `Galaxy`, `Player`, etc.), and out-of-range values
for size/level/probabilities. Errors are shown above the form without
losing what you typed.

---

## Troubleshooting

- **"Players are at ... - move them out first"** (`.warea`/`.wcluster`
  Save/Remove) — a non-DM character is standing on the target tile. Ask
  them to step off, or wait until the area is empty, then retry. You
  yourself standing there is fine.
- **"There is no exit this way."** inside a cluster member — that edge
  isn't the one mapped to this member. Check `.winfo` on the cluster
  coordinate to see the current mapping, or reopen `.wcluster` there.
- **A new area doesn't show up in-game / `.warea` says "No area tagged
  ... exists"** — the tag prefix must match `<prefix>000` or `<prefix>001`
  exactly (case-sensitive), and the area must already be built and part of
  the installed module.
- **A newly created planet isn't in the galaxy yet** — it's created in the
  database but only generated at the next reboot; check the page's status
  column ("live" vs "awaiting reboot").
- **A DM-built area gets wiped when everyone leaves** — you tagged it as a
  `000` template, which the game treats as disposable and regenerates from
  scratch each time. Use a `001` tag (or any tag not ending in `000`) for
  anything you want to persist.
