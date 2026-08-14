# How Creature Spawning Works — A Student's Walkthrough

> Audience: someone new to this codebase who wants to understand where monsters
> "come from" — not a DM/builder how-to (see `CLUSTER_AREAS.md` for that style of
> doc), and not a spec. This is a guided tour through the actual code, in the order
> you'd read it to build a mental model from scratch.

## The one-sentence version

Every planet has a row of data (creature family + a level number from 1-9) sitting
in the database. When a PC first walks into an area on that planet, one big script —
`area_creatures.nss` — reads that row and creates a batch of creatures based on it.
That's it. There's no scheduler, no spawn-table asset, no central "monster manager."
It's one script, triggered once per area, reading one string.

Everything else in this doc is either "how that one string gets built" or "who else
also reads it for their own purposes."

## Step 1: where the number comes from

Planets are data, not code, but the data is *generated* by code once, at galaxy
creation. Open `src/nss/_galaxy.nss` and you'll find dozens of blocks that each look
like this (this one's around line 108-148):

```nss
sPlanetCre = SELF;                                //*// Creature family (SELF = uses this planet's own name)
iPlanetCre = 8;                                   //*// Average number of creatures per area
iPlanetLevel = 1;                                  //*// Planet level (from 1 to 9)
```

Every planet in the game has one of these blocks. `iPlanetLevel` is a plain integer a
builder picked by hand when they set up the planet — there's no formula. Think of it
as "how dangerous is this place," on a 1-9 scale, chosen once and then baked in.

At the end of each block, everything gets mashed together into one big
`&NNN&`-delimited string and written to persistent storage:

```nss
SetPersistentString(oModule, sPlanet,
  sPlanetPlace+"&001&"+iPlanetSize+"&002&"+ ... +
  sPlanetCre+"&004&"+ ... +iPlanetCre+"&007&"+ ...
  +iPlanetLevel+"&009&"+sPlanetDescription+"&010&");
```

That string is the planet's entire config record — size, terrain, creature family,
*and* level, all packed into one value under one database key (the planet's own
name, e.g. `Arland`). This is the "legacy PW data pattern" this whole codebase uses:
one generic `name`/`val` table, values are hand-rolled delimited strings, not JSON or
real columns. Once you've seen one of these encoded strings, you've seen them all —
it shows up again and again everywhere below.

**Student gotcha:** there is no central schema file listing "field 8 = level" — you
have to find it by reading whichever script wrote the string (`_galaxy.nss`) and
line up the `&NNN&` markers by hand. That's normal for this codebase, not a
shortcut someone forgot to clean up.

## Step 2: what actually reads that string and makes a monster

Search the whole codebase for who calls `area_creatures` and you'll find exactly two
callers:

- `src/nss/area_recall.nss:284` — this runs (indirectly) when a PC first steps into
  an area. It's gated by a pile of conditions (`iReady!=1`, `iNight==0`, area isn't a
  city/ocean/interior-with-no-spawns, etc.) — read lines ~264-284 if you want the
  exact list — but the short version is: "first time someone visits, if this isn't a
  special area, seed it with creatures."
- `src/nss/conv_dm020.nss:174` — a DM tool ("Camp" placement) also calls it directly,
  on demand.

Both do the exact same thing: `ExecuteScript("area_creatures", oArea)`. That's the
entire "spawn trigger" — no heartbeat loop, no timer. Once an area's been seeded,
nothing re-runs this automatically.

## Step 3: inside `area_creatures.nss` — decoding the string again

Open `src/nss/area_creatures.nss`. The first thing it does (lines 5-11) is pull the
planet's record back out of persistent storage and re-parse those `&NNN&` markers —
by hand, with `FindSubString`/`GetStringLeft`/`GetStringRight`, not a shared helper:

```nss
string sTot = GetPersistentString(oModule,sPlanet);
string sCreatures = /* ...substring math to pull out field &003& (creature family)... */
int iCreatures    = /* ...substring math to pull out field &006& (avg count)... */
int iLevel        = /* ...substring math to pull out field &008& (planet level)... */
```

If `sCreatures` came out as `"self"`, it's replaced with the planet's own name —
that's what `sPlanetCre = SELF;` back in `_galaxy.nss` meant.

From here the script branches twice, and it's important to keep these two branches
straight:

1. **By area tile tag** — is this area's tag `space0`, `clouds`, `underwater`, a
   `river`, etc.? These are environment overrides that apply *regardless* of planet
   family (a "clouds" tile spawns birds/griffons/djinn no matter which planet it's
   on).
2. **By creature family (`sCreatures`)** — for ordinary ground tiles, the planet's
   family name (`"Arland"`, `"Hinz"`, `"Kartac"`, ...) picks one of ~20 hardcoded
   blueprint lists, one `else if` block per family, each 30-80 lines long
   (`area_creatures.nss:149` onward).

Inside *either* kind of branch, `iLevel` gates which specific creatures are eligible.
Here's the full "clouds" branch (lines ~44-69) as a concrete example:

```nss
if(iLevel<4)       { /* pick among: birds, eagle, falcon, owl, raven */ }
else if(iLevel<7)   { /* pick among: air elemental, griffon, living cloud */ }
else                { /* pick among: djinni x2 */ }
```

That's the whole mechanism: **an integer, and a chain of `if(iLevel<N)` checks,
repeated by hand in every branch.** There's no shared "tier 1 / tier 2 / tier 3"
table — each family's tiers were typed out independently, so the exact level cutoffs
differ block to block. If you ever need to change *when* something starts spawning,
you're editing that specific `if(iLevel<7)` (or `==`) literal, in that specific
block, not a config value.

Two more details worth knowing, both near the top of the file:

- **How many creatures spawn** (line 27): the average count (`iCreatures`, from the
  planet record) gets randomly nudged by up to ±5, so it's never exactly the same
  number twice.
- **Leaders** (line 25, used throughout): every creature has a 1-in-4 chance
  (`Random(iLeader)==0`, `iLeader = 4`) to be flagged `SetLocalInt(oNew,"Leader",1)` —
  that's a hook other systems (like camps) use, not anything spawn-specific.
- **`iCampSize`** (line 29): everything above only runs when `iCampSize==0` (a plain
  area). If a DM has placed a "camp" on the tile, a separate branch further down
  handles that instead — different code path, same `iLevel`/`sCreatures` inputs.

## Step 4: other systems read the *same* `iLevel`, independently

This is the part that trips people up most: `area_creatures.nss` is not the only
consumer of the planet's `iLevel` field. Several other scripts do their own
independent copy of the exact same parse-the-persistent-string dance (Step 3's first
code block, duplicated verbatim), then build their *own* level-gated table for a
totally different purpose:

| File | What it gates by `iLevel` |
|---|---|
| `src/nss/dungeons.nss:69` (and `184`, `408`, ... one `else if(iLevel==N)` per level 1-9) | Which dungeon family/size gets generated inside a dungeon interest point. |
| `src/nss/sewers.nss:18` (and `30`, `43`, ... through level 9) | Which creature set populates a sewer interest point. |
| `src/nss/missions.nss` (e.g. lines 353-360) | Which "kill the ___" target the mission-giver assigns — goblin at level 1, orc at 2, ogre at 3, giant at 4, all the way up to golems at level 8. |

None of these call `area_creatures.nss` or share code with it — they're five
separate hand-written level ladders that all happen to read the same underlying
number. Change a planet's `iPlanetLevel` and *all five* systems shift together
(different monsters, different dungeon families, different mission targets) — but if
you only wanted to change *one* of them, you have to edit that one file's ladder
specifically.

## The gotcha: two different things are both called "`iLevel`"

`src/nss/encounters.nss` also declares a local variable called `iLevel` — but it
means something completely different:

```nss
int iLevel = GetLevelByPosition(1,oPC)+GetLevelByPosition(2,oPC)+GetLevelByPosition(3,oPC);
```

That's the **PC party's character levels**, added up, used to scale scripted ambush
encounters (e.g. the castle-interior trap at the top of that file). It has nothing
to do with the planet's `iPlanetLevel` from Step 1 — same variable name, same "pick a
tougher monster as the number goes up" pattern, entirely different data source. If
you're grepping for `iLevel` to find planet-difficulty logic, `encounters.nss` will
show up and lead you astray unless you check where its `iLevel` comes from.

## Putting it together: one full trip, start to finish

1. A builder sets `iPlanetLevel = 6;` for planet "Kartac" in `_galaxy.nss`, next to
   `sPlanetCre = SELF;`.
2. Galaxy generation runs once, writes it all into one persistent string under key
   `Kartac`.
3. A PC walks into a Kartac area for the first time. `area_recall.nss` fires,
   conditions pass, it calls `ExecuteScript("area_creatures", oArea)`.
4. `area_creatures.nss` re-reads the `Kartac` persistent string, gets
   `sCreatures="Kartac"`, `iLevel=6`, matches the `sCreatures=="Kartac"` branch
   (`area_creatures.nss:365`), and — inside that branch — the `iLevel` tier logic
   picks which of Kartac's creatures are eligible at level 6, spawns a randomized
   count of them at random points in the area, and 1-in-4 get tagged as a leader.
5. Independently, if that same area happens to also be a dungeon or sewer interest
   point, or if a mission-giver there rolls a "kill monster" mission, `dungeons.nss`
   / `sewers.nss` / `missions.nss` each separately look up Kartac's `iLevel=6` again
   and pick from their own level-6 tables.

Nothing here is centralized, cached, or reused across files — it's one number,
copy-pasted logic to read it, and five independently-hand-tuned tables that key off
it. That's the whole system.
