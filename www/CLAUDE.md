# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

This is the web frontend for **Universe of Arlandia (UOA)**, a custom persistent world module for *Neverwinter Nights (NWN)*. It is a classic PHP/HTML site designed to run under Apache+MySQL (XAMPP/WAMP stack). There is no build system, package manager, or test suite — files are edited and served directly.

## Running locally

Docker is the primary local dev environment — `docker compose up` from the repo root starts Apache + MySQL on port 88. The Apache DocumentRoot is `www/public/` (see `docker/apache-uoa.conf`).

To test PHP pages: `http://localhost:88/index.php`.

## Configuration

All DB credentials and game settings live in `public/uoa.php` — this file is `include()`d by every PHP script that needs a DB connection:

```
$host = '127.0.0.1'
$user = 'uoa'
$pass = '...'
$data = 'uoa'
$nwnport = "5121"
$dmlogin = "uoadm"
```

Do **not** commit credential changes to `public/uoa.php`.

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

### Directory layout

```
www/
  *.gif / *.jpg       terrain tile GIFs and domain/screenshot JPGs (served via AliasMatch)
  public/             Apache DocumentRoot — all PHP and HTML served from here
    index.php         Main shell — 3-column layout (nav, iframe content, star systems)
    galaxy.php        Planet/space map viewer and DM admin panel (?planet=infos)
    interests.php     Detail view for a map area (town, dungeon, castle, domain, etc.)
    statut.php        Server status widget (iframe); pings NWN server via UDP
    map-data.php      JSON API — returns tile grid for a planet or Space sector
    helpers.php       Shared PHP helpers: between(), tile_key(), encoded_field()
    uoa.php           Config only: DB credentials, NWN port, DM password
    ServerInfo.php    UDP library for NWN BNES/BNER/BNXI/BNXR server queries
    database-mysql.php  Legacy DB abstraction layer (not used by main pages)
    logging.php       console_log() helper — echoes a <script>console.log()</script> block
    playerInfo.php    Supplementary player info display
    css/              Lightbox 2 stylesheet
    js/               Lightbox 2 + Prototype/Scriptaculous scripts
    images/           Lightbox UI chrome assets
    news_fichiers/    Images embedded in news.html
    Factory_fichiers/ Images embedded in factory.html
    *.html            Static content pages (classes, crafting, races, downloads, etc.)
```

The AliasMatch in `docker/apache-uoa.conf` maps bare `/forest.gif` and `/Dom_01.jpg`
requests to `www/` so PHP pages can reference tile images without path prefixes.

### Map tile system

Tile types are two-digit codes in `pwdata` that map to named GIF files (e.g., `"04"` → `forest.gif`). Interest overlays append a suffix (e.g., `forest_town.gif`, `forest_dung.gif`). The full tile-to-filename map is defined inline in `galaxy.php`.

Interest type codes (first character of interest `val`):
- `D` = Domain, `1` = Town, `2` = Dungeon, `3` = Castle, `4` = Ruins, `5` = Animal reserve, `6` = Resource mountain, `7` = Amusement place

### Map tile images

All map tile GIFs (`forest.gif`, `plain_town.gif`, etc.) and domain/screenshot JPGs live
in `www/` (not in `public/`). They are web-accessible via the AliasMatch rule in the
Apache config and are referenced from PHP output as bare filenames.

### DM area

The DM login in `index.php` POSTs a password that is compared against `$dmlogin` from `uoa.php`. There is no session — the login value is passed as a `login=` query parameter through subsequent page links. DMs see hidden map tiles and get access to `galaxy.php?planet=infos`.

### NWN launcher

`uoa.nwl` is a NWN launcher shortcut file pointing players directly to the server (`uoa.no-ip.org:5121`).
