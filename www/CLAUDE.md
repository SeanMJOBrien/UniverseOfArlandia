# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

This is the web frontend for **Universe of Arlandia (UOA)**, a custom persistent world module for *Neverwinter Nights (NWN)*. It is a classic PHP/HTML site designed to run under Apache+MySQL (XAMPP/WAMP stack). There is no build system, package manager, or test suite — files are edited and served directly.

## Running locally

Docker is the primary local dev environment — `docker compose up` from the repo root starts Apache + MySQL on port 88. The Apache DocumentRoot is `www/public/` (see `docker/apache-uoa.conf`); everything outside `www/public/` (tests, docs, `node_modules`) is not served.

To test PHP pages: `http://localhost:88/index.php`.

## Configuration

`www/public/app/uoa.php` is a loader with no secrets, `include()`d by every PHP script that needs a DB connection. The real values come from, in order: the file named by `UOA_CONFIG`, `/etc/uoa/uoa.local.php`, or `www/public/app/uoa.local.php` (git-ignored); anything not set there falls back to the `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASS`, `DB_NAME`, `NWN_PORT` and `DM_PASSWORD_HASH` environment variables. `docs/uoa.local.php.example` shows the variables (`$host`, `$user`, `$pass`, `$data`, `$nwnport`, `$dmlogin`, optional `$mail_from`). `$dmlogin` is a bcrypt hash, not the password.

Never put real credentials in `uoa.php`; deployment is described in `docs/DEPLOY_WEB.md`.

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
- `WebChars_<cdkey>` — characters seen on a public CD key, `<account>&1&<charname>&2&` repeated
- `WebCode_<cdkey>` — one-time website registration code (its `last` column is the issue time)
- `WMap_<PlanetName>_X<X>` — per-character discovered tiles, stored under
  `player=<account>, tag=<charname>` as a run of `&+05&` keys

Negative coordinates in keys are stored with `m` replacing `-` (e.g., `m3_5` = `-3,5`).

### Directory layout

```
www/                       dev files only; not served
  public/                  Apache DocumentRoot - the only folder that is deployed
    index.php              Main shell: 3-column layout (nav, iframe content, star systems)
    robots.txt, favicon.ico
    app/                   everything else of the site
      galaxy.php           Planet/space map viewer and DM admin panel (?planet=infos)
      interests.php        Detail view for a map area (town, dungeon, domain, ...)
      statut.php           Server status widget (iframe); pings NWN server via UDP
      map-data.php         JSON API: tile grid for a planet or Space sector
      register.php         Player registration (CD key + in-game .web code + password)
      helpers.php          Shared helpers: between(), tile_key(), encoded_field()
      player_auth.php      Player login/registration + per-player map discovery
      uoa.php              Config loader (no secrets; see Configuration)
      dm_*.php             DM pages (tools, bank, rentals, inactive accounts)
      ServerInfo.php       UDP library for NWN server queries
      *.html               Static content pages
      assets/ css/ js/ images/ news_fichiers/ Factory_fichiers/   static files
  tests/ selenium/         Playwright and Selenium suites
  chronicles-wiki, tfn-wiki, hos1-wiki, erithorn-map   wikis/maps managed outside git;
                           mapped by Alias lines in docker/apache-uoa.conf
```

### Map tile system

Tile types are two-digit codes in `pwdata` that map to named GIF files (e.g., `"04"` → `forest.gif`). Interest overlays append a suffix (e.g., `forest_town.gif`, `forest_dung.gif`). The full tile-to-filename map is defined inline in `galaxy.php`.

Interest type codes (first character of interest `val`):
- `D` = Domain, `1` = Town, `2` = Dungeon, `3` = Castle, `4` = Ruins, `5` = Animal reserve, `6` = Resource mountain, `7` = Amusement place

### Map tile images

All terrain tile GIFs (`forest.gif`, `plain_town.gif`, etc.) and domain/screenshot JPGs
live in `www/public/app/assets/`. They are referenced from PHP and HTML as `app/assets/forest.gif`
(from `index.php`) or `assets/forest.gif` (from pages in `app/`).

### Per-player map discovery

The map shows each player only the areas *they* have discovered.

- Players register at `register.php` with their 8-character public CD key plus a
  one-time code they get in game by typing `.web` (issued by `mod_chat.nss`, read
  from `WebCode_<cdkey>`, valid 30 minutes, burnt on use). Accounts live in the
  `web_players` table — `docker/mysql-init/02-web-players.sql`, which must be
  applied by hand to an existing database.
- They log in from the "Player area" box in `index.php`; the session holds
  `$_SESSION['player_cdkey']`.
- The module writes discovery per character (`WMap_<Planet>_X<X>`, from
  `_webmap.nss` via `transitions.nss` and `area_enter.nss`). The site unions
  every character on the CD key into one map.
- Visibility for a tile is decided by `tile_is_visible()` in `player_auth.php`:
  DM sees everything; the `ShowAreas` / `ShowInterests` module flags stay global
  overrides; otherwise the tile is drawn only for a logged-in player who has
  discovered it. Anonymous visitors get an empty grid and a login prompt.
- The server-wide `*` discovery marker on `<Planet>AreasX<X>` (and
  `Space<X>_<Y>Show`) is still written by the module and still drives discovery
  XP and DM tooling — it no longer reveals tiles on the website.

### DM area

The DM login in `index.php` POSTs a password that is compared against `$dmlogin` from `uoa.php`. There is no session — the login value is passed as a `login=` query parameter through subsequent page links. DMs see hidden map tiles and get access to `galaxy.php?planet=infos`.

### NWN launcher

`uoa.nwl` is a NWN launcher shortcut file pointing players directly to the server (`uoa.no-ip.org:5121`).

## Layout

Only `index.php`, `robots.txt` and `favicon.ico` are at the web root (`www/public/`). All other pages,
the includes (`uoa.php`, `helpers.php`, `player_auth.php`) and the static folders
(`assets`, `css`, `js`, `images`) are in `www/public/app/`. `index.php` links to `app/<page>`;
pages in `app/` link back with `../index.php`. There are no redirects from the old
root addresses.
