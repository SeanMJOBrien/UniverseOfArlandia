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
10. [How time is tracked](#10-how-time-is-tracked)
11. [Domain ownership and access](#11-domain-ownership-and-access)
12. [DM web pages and email alerts](#12-dm-web-pages-and-email-alerts)

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

---

## 10. How time is tracked

The module has three clocks. Which one an activity uses decides whether it keeps
running while the player is offline, and whose time it is.

| Clock | Counts | Runs while the player is offline? | Where it is stored |
|---|---|---|---|
| Online ticks (`Counter`) | One tick per module heartbeat, 6 real seconds. 576 ticks = one "day" (about 58 real minutes) | No. Only players logged in and not DMs | Goldbag item (saved with the character), mirrored to `pwdata` as `OnlineTicks&<Name>` |
| Game calendar | The in-game date (28-day months) | Yes. It ticks for everyone while the server is up | `pwdata`, as an absolute day number |

The module calendar is saved to the `Calendar` key in `pwdata` every game hour and
at shutdown, then restored on load (`mod_load`). It survives restarts, but the
game date only moves while the server is up.

### Online ticks and the owner clock

`mod_heartbeat` adds 1 to the `Counter` on each connected player's goldbag every
heartbeat. The same value is mirrored to `pwdata` (`OnlineTicks&<Name>`) together
with a real-world `LastSeen_<Name>` unix time (read from the native SQLite clock, `inc_sqlite_time.nss`; the NWNX_Time plugin is not in the server image), at login, at logout and every
`DOMAIN_CLOCK_SYNC_TICKS` (50 ticks, 5 minutes). A server crash loses at most that
much of a player's play time on the mirror, never the other way.

**Domain structures run on the owner's clock.** A domain's owner is the area's
`Master`. Whoever opens a structure's dialog, a granted user, a renter or the
owner, sees the owner's numbers: the owner's live `Counter` if they are online,
otherwise the mirrored value. An offline owner's structures stay frozen until
they log in. Code: `_domainstate.nss`.

### Domain state

A structure's slot contents and last-production markers are stored per domain in
`pwdata` under `DS&<Planet>&<Area><Slot>`, `...Counter` and `...Counter<i>`, and
`...&DomainLink&<from><to>`. They were locals on the speaker's goldbag before.
They are read and written directly, with no cache or separate save step, so a
crash cannot lose a collected item. The first time a domain's owner opens one of
its dialogs, the old goldbag data is copied across once (`DS&<Planet>&<Area>&Migrated`
marks it). The old goldbag values are left in place and no longer used.

- **Production** (extractor, farm, field, sawmill, factory): one item per
  `hours * 24` ticks, shortened by the area bonus, halved at structure level 5, and
  capped by the container size (doubled at level 3). The first dialog of an
  extractor, farm, field and sawmill shows the stock ready and the time to the next
  item. A factory dialog collects its finished goods when opened, so it shows the
  time to the next product and how many products are waiting for input materials.
- **Casern troops** (`conv_domain007`): one clock per casern, owner ticks minus the
  marker. A level costs `iDomainCasern * 20 * factor` ticks (factor 1, 2, 3, 5, 7
  for levels 1 to 5), less the area bonus. Troops waiting are `ticks passed /
  cost`. Collecting resets the clock. There is no separate training period; a
  troop is available as soon as it has been produced.
- **Guild membership**: the member's own clock. The term is stored as an end point
  (`GuildEnd`, a goldbag `Counter` value) and the ticks left are `GuildEnd -
  Counter`, worked out when read (`_guild.nss`). Nothing runs per heartbeat. A paid
  term is `iDomainGuildMB * 576` ticks. Terms from the old countdown (`GuildMB`)
  are converted the first time they are read.
- **Guild roster** (`_guildroster.nss`): each member's remaining ticks are mirrored
  to `GuildMember&<hall owner>&<character>` when they join, renew, leave, log in
  or out, and every 5 minutes. A member's clock only moves while they are online,
  so the mirrored figure stays right while they are away. The hall's first dialog
  shows how many members have time left, how many are online and the first eight
  names.

### Bank accounts

Rates, term, month length, bank-day length, account price, the deposit/withdraw and investment amounts offered, and whether investments are open are read
from `BankSetting_<name>` rows in `pwdata` each time they are needed, falling back
to the compiled values in `_module.nss`. The DM page `dm_bank.php` edits them
(section 12).

Interest is settled when the account is opened, not by the heartbeat (`_bank.nss`).
The account item remembers the holder's online ticks at its last settlement
(`GPmark`, `IVmark`) and catches up for the time since:

- **Normal interest:** `iNormalInterest` % per month (2%, a month being
  `iBankMonthDays` = 28 bank days), added each full 576 ticks of the holder's
  online time, compounding. The part of a gold piece
  that rounds off is carried (`GPfrac`), so small balances grow too. Up to 400 days
  are applied in one settlement.
- **Investments:** a deposit locks the principal for `iInvestmentDelay` bank days
  (20). The rate (`IVrate`, tenths of a percent per month) and the term (`IVdays`)
  are stored on the item at purchase, so changing the settings later never alters
  a deal in progress. The term counts down by the holder's online ticks. When it
  ends the principal grows once by `(1 + rate) ^ (term / iBankMonthDays)`,
  which is `iInvestmentInterest` % per month (3%) compounded daily, with a month of
  28 bank days. It shows as matured (`-1`) and the player can then take it out.
  An investment bought before this rule has no `IVrate` and is paid back at face
  value.
- **Compare with the normal account:** over a 20-day term the investment returns
  about 2.1% and the same money in the normal account about 1.4%.

An account earns only while its holder is logged in and carrying it.

### Game calendar (house rent)

The module runs 2 real minutes per game hour, so a game day is 48 real minutes.
The calendar has 12 months of 28 days: a game month is about 22.4 real hours and a
game year (336 days) about 11.2 real days. A bank day (576 ticks, 58 online
minutes) is a little longer than a game day.

House and apartment rent does not touch a bank account. It is paid in gold straight
from the player's purse when they rent or pay a month at the structure. The
expiry is stored as an absolute game day in `pwdata`
(`<Planet>&<Area>&Domain&<Slot>Until`, see `DomainRentExtend` in `_domainuser.nss`)
and `DomainRentDaysLeft` is that day minus today's `DomainGameDay()`. A month buys
`iDomainRentDays` (30) game days. It counts down for offline tenants too. An
expired tenancy is released the next time somebody looks at the slot, not on a
timer.

An older `<Planet>&<Area>&Rent&<Slot>` counter is still written to the goldbag when
rent is paid, but nothing reads it for expiry.

---

## 11. Domain ownership and access

A domain has one owner, recorded in its Interests record and on every object placed
in it. Other characters can be given the use of one structure or the whole domain.
A grant lets them use a structure (collect, hire, rent) but never build or destroy.

### Chat commands (DMs, standing in the domain)

| Command | What it does |
|---|---|
| `.wdomain` | Shows the owner, how long they have been away, whether the domain is for sale, and every access grant. |
| `.wowner <Character Name> [keep] [force]` | Gives the domain to another character. Stand in the domain's outdoor area, not inside a structure. |
| `.wgrant <Character Name> [slot]` | Lets a character use one structure (slot 1 to 10) or, with no slot, the whole domain. |
| `.wrevoke <Character Name> [slot]` | Takes that access away. |

`.wowner` updates the Interests record and the `Master` of every object in the
area, keeps slot contents and stock, and restarts the production timers from the
new owner's clock, so nothing is lost and the next item is a full period away.
Access grants are cleared unless you add `keep`. Renters keep their tenancy. The
command refuses a name the server has never recorded (a typo guard) unless you add
`force`. If the old owner is online their unimported structure data is copied first.

Two limits: guild members hold the hall owner's name in their own data, so a guild
hall changing hands loses its members' membership; and structure data that was
never imported from an offline owner's character stays on that character, so the
new owner's structures start unconfigured.

### Domain owner index

`DomainIndex&<Character>` in `pwdata` lists the domains each character owns. It is
built once from the Interests records shortly after the module loads, and kept up
to date when a domain is created, destroyed or handed over. When an owner logs in,
the structure data of every domain they own is imported from their character at
once, instead of at the first structure dialog.

### Inactive owners, the notice and buying an abandoned domain

An owner is inactive once they have been away `iDomainAbandonedDays` real days
(365). "Away" is the real-world `LastSeen_<Name>` time, written when a character
logs in or out and every 5 minutes. A character with no recorded time is given
one by the first sweep, so every owner has a full 365 days from then to return.

The sweep runs after the module loads and every 6 hours. When an owner passes 365
days, each of their domains is noticed once. If their account has registered an
email address, a message is queued saying the domain goes on sale in
`iDomainSaleWaitDays` (30) days unless they log in. Logging in with the owner
character is enough, and it resets the clock.

After the waiting period (395 days away) a player at the domain's sign is offered
the domain for `iDomainAbandonedGP` (5000 GP, taken from the buyer and removed from
the game). The buyer receives it exactly as `.wowner` would hand it over, with
access grants cleared and the notice record reset. The old owner is emailed if they
registered one. Nothing returns the domain to them except a DM using `.wowner`.
`.wdomain` shows whether an owner is inactive, how many days remain before the
sale, and whether email alerts are on.

### Email alerts (players)

Any player can type `.email you@example.com` in game to register an address for
their account, `.email` to see it and `.email off` to remove it. It is stored by
player account, so it covers every character on that account. The message is
cleared from chat. The address is not verified: anyone using the account can set
it, and the server cannot tell whether it is the owner's.

---

## 12. DM web pages and email alerts

These pages are part of the PHP site and live in `www/app/` with the rest of the site
(only `index.php`, `robots.txt` and `favicon.ico` are at the web root). Log in from the
DM area on the home page first, then use its **Tools** link, which opens `dm_tools.php`,
the list of DM pages. Every page checks that session and every change needs the page's
form token. The database settings are in `www/app/uoa.php`.

### Bank (`dm_bank.php`)

Sets the normal account rate, the account price, the investment rate, term and
month length, the length of a bank day in minutes of play, the three deposit/withdraw
amounts and the three investment amounts the dialog offers, and opens or closes new
investments. The dialog texts (terms, payouts, time left) are built from these values,
so they always match the page. Bank-note values are fixed by their items. Rates are percent per month in
steps of 0.1. Values are checked against their limits, written to `pwdata` and
recorded in the `dm_audit` table. The module reads them the next time an account is
opened, so no restart is needed. A running investment keeps the rate and term it was
bought with. The page also shows what each investment amount returns under the current values and
warns when investing returns less than a normal account. The defaults shown for a
setting that has never been saved must match `_module.nss`.

### Inactive accounts (`dm_inactive.php`)

Lists player accounts, oldest first, whose newest character has not been saved for
365 days. The server vault has one folder per account (the public CD key) with one
`.bic` per character; a `.bic` is rewritten whenever the character is saved, and
the later of that time and the character's `LastSeen_` record counts. Each account
shows its characters, when each was last saved, whether it has an email registered
and the domains its characters own.

The page changes nothing by itself. To remove an account's characters, type its
folder name and press the button. The `.bic` files are moved to
`servervault_removed/<date>/<account>/` next to the vault, so a mistake can be undone
by moving them back; emptying that folder is a separate manual step. An account
with any character active in the last 365 days is refused. Domains and placed
objects are never touched. Hand a domain over with `.wowner`, or remove its objects
by hand in game.

The web server must be able to read the vault, and write to its parent folder to
remove characters. Set `UOA_VAULT` to the vault path if it is not
`/home/qlippoth/uoa/server/servervault`.

### Sending the emails

The module only queues messages, in the `mail_outbox` table. Send them by running
`php tools/send_outbox.php` on the host from cron every 15 minutes. It uses PHP's
`mail()`, so the host needs a working mail setup (sendmail or equivalent). Set
`$mail_from` in `www/app/uoa.php` to the sender address. A message that fails five times
stays in the table unsent.

