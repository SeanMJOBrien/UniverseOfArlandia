# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

This is the web frontend for **Universe of Arlandia (UOA)**, a custom persistent world module for *Neverwinter Nights (NWN)*. It is a classic PHP/HTML site designed to run under Apache+MySQL (XAMPP/WAMP stack). There is no build system, package manager, or test suite — files are edited and served directly.

## Running locally

Serve via Apache with PHP and MySQL (XAMPP on Windows, or equivalent). The site root should point to this directory. The NWN game server runs separately on port `5121` (see `NWNX.ini`).

To test PHP pages, visit them in a browser via the local Apache server (e.g. `http://localhost/uoa-www/index.php`).

## Configuration

All DB credentials and game settings live in `uoa.php` — this file is `include()`d by every PHP script that needs a DB connection:

```
$host = '127.0.0.1'
$user = 'uoa'
$pass = '...'
$data = 'uoa'
$nwnport = "5121"
$dmlogin = "uoadm"
```

Do **not** commit credential changes to `uoa.php`.

## Architecture

### Database: one table, string-encoded values

All persistent game data lives in a single MySQL table `pwdata` with two columns: `name` (key) and `val` (value). Values are custom-delimited strings — not JSON or relational rows. The delimiter format uses `&N&` (for numbered fields) and `_` (for coordinates).

Key naming conventions:
- `Galaxy` — master record listing all star systems and their planet counts
- `<PlanetName>` — planet config: size, tile type, description, level, weather, etc.
- `<PlanetName>AreasX<XX>` — column of tiles at X coordinate, encoded as `&+YY&tiletype`
- `<PlanetName>&<X>_<Y>&Interests` — interest point at a map coordinate (town, dungeon, castle, etc.)
- `Player<N>` — player state: account name, char name, planet, area, is-DM flag
- `Calendar` — server time (/C3/ = hour, /C4/ = next field delimiter)
- `ShowAreas`, `ShowInterests`, `ShowPlanets` — DM visibility flags
- `Space<X>_<Y>` — space tile data for the star map

Negative coordinates in keys are stored with `m` replacing `-` (e.g., `m3_5` = `-3,5`).

### PHP pages

| File | Role |
|---|---|
| `index.php` | Main shell — 3-column layout (nav, iframe content, star systems). Reads galaxy/planet list from DB and renders the right-side navigation. Contains the DM login form. |
| `galaxy.php` | Planet/space map viewer. Renders a 2D grid of tile GIFs for a planet or star system. Also serves the DM admin panel (`?planet=infos`) for viewing online players and resetting stuck character coordinates. |
| `statut.php` | Server status widget rendered in an iframe on the left sidebar. Pings the NWN server using the BNES/BNXI UDP protocol (via `ServerInfo.php`) and queries `pwdata` for live player count. Auto-refreshes every 60 seconds. |
| `interests.php` | Detail view for a map area (town, dungeon, castle, domain, etc.). Reads nested interest sub-records from `pwdata`. |
| `uoa.php` | Config-only file. No logic — only sets `$host`, `$user`, `$pass`, `$data`, `$nwnport`, `$dmlogin`. |
| `ServerInfo.php` | UDP packet library implementing the NWN BNES/BNER, BNLM/BNLR, BNDS/BNDR, BNXI/BNXR protocol pairs for querying a live NWN server. |
| `database-mysql.php` | Generic DB abstraction layer (a separate older codebase). Defines `DB_Connect`, `DB_Insert`, `DB_GetArray`, etc. via a global `$db_link`. Not used by the main UOA pages (which use `mysqli_*` directly). |
| `logging.php` | Single helper `console_log()` — echoes a `<script>console.log()</script>` block. |
| `playerInfo.php` | Supplementary player info display. |

### Map tile system

Tile types are two-digit codes in `pwdata` that map to named GIF files (e.g., `"04"` → `forest.gif`). Interest overlays append a suffix (e.g., `forest_town.gif`, `forest_dung.gif`). The full tile-to-filename map is defined inline in `galaxy.php`.

Interest type codes (first character of interest `val`):
- `D` = Domain, `1` = Town, `2` = Dungeon, `3` = Castle, `4` = Ruins, `5` = Animal reserve, `6` = Resource mountain, `7` = Amusement place

### Frontend assets

- `css/lightbox.css` + `js/lightbox.js` (+ `prototype.js`, `scriptaculous.js`, `effects.js`, `builder.js`) — Lightbox 2 image gallery, used on screenshot pages.
- All map tile GIFs (`forest.gif`, `plain_town.gif`, etc.) live in the root directory alongside the PHP files.
- `images/` — Lightbox UI chrome assets only.

### DM area

The DM login in `index.php` POSTs a password that is compared against `$dmlogin` from `uoa.php`. There is no session — the login value is passed as a `login=` query parameter through subsequent page links. DMs see hidden map tiles and get access to `galaxy.php?planet=infos`.

### NWN launcher

`uoa.nwl` is a NWN launcher shortcut file pointing players directly to the server (`uoa.no-ip.org:5121`).
