---
project: Universe of Arlandia — www (PHP/HTML web frontend)
updated: 2026-08-14
purpose: |
  Agent reference for established patterns. Follow these exactly when editing
  any PHP file. Do not introduce new patterns without updating this file.
---

# Code Patterns — Universe of Arlandia Web Frontend

---

## FILE STRUCTURE

Every PHP page follows this order — do not deviate:

```php
<?php
session_start();                    // 1. ALWAYS first, before any output

include('uoa.php');                 // 2. Config (DB creds, $dmlogin, $nwnport)
include('helpers.php');             // 3. String utilities (between, encoded_field, tile_key)

$link = mysqli_connect(...);        // 4. DB connection (fail fast if offline)
if (!$link) { echo 'service offline'; exit; }

// 5. ALL data fetching and processing
// 6. NO echo/HTML yet

?>
<!DOCTYPE html>                     // 7. HTML output starts here, never before
```

---

## DATABASE ACCESS

### Schema

The live (production) pwdata table has **5 columns** matching the APS persistent system:

| Column | Type | Notes |
|--------|------|-------|
| `player` | varchar(64) | `'~'` for module-level vars, lowercase account name for PC vars |
| `tag`    | varchar(64) | Module tag (`'uoa'`) for module vars, char name for PC vars |
| `name`   | varchar(64) | Variable name (`'Galaxy'`, `'Player1'`, etc.) |
| `val`    | text        | Encoded value string |
| `expire` / `last` | — | Managed by APS, not read by PHP |

**Primary key is `(player, tag, name)` — `name` alone is NOT unique.**

All web-page data is module-level: filter with `WHERE player='~' AND tag=?` using `$module_tag`
from `uoa.php`.

### Connection
```php
include('uoa.php');   // sets $host, $user, $pass, $data, $port
$link = mysqli_connect($host, $user, $pass, $data, (int)$port);
if (!$link) { echo 'service offline'; exit; }
```

### Single lookup (one key)
```php
// tag='uoa' is the NWN module tag — hardcoded because it never changes for this project
$stmt = mysqli_prepare($link, "SELECT val FROM pwdata WHERE player='~' AND tag='uoa' AND name=?");
$key  = 'SomeKey';
mysqli_stmt_bind_param($stmt, 's', $key);
mysqli_stmt_execute($stmt);
$row = mysqli_fetch_assoc(mysqli_stmt_get_result($stmt));
$val = $row['val'] ?? '';
mysqli_stmt_close($stmt);
```

### Bulk load (all rows matching a pattern)
```php
// galaxy.php pattern — load all module-level rows into associative array
$pwdata_cache = [];
$stmt = mysqli_prepare($link, "SELECT name, val FROM pwdata WHERE player='~' AND tag='uoa'");
mysqli_stmt_execute($stmt);
$res = mysqli_stmt_get_result($stmt);
while ($row = mysqli_fetch_assoc($res)) {
    $pwdata_cache[$row['name']] = $row['val'];
}
mysqli_stmt_close($stmt);
function get_pw(string $key): string {
    global $pwdata_cache;
    return $pwdata_cache[$key] ?? '';
}
```

### NEVER do this
```php
// WRONG — SQL injection risk
$val = mysqli_query($link, "SELECT val FROM pwdata WHERE name = '$key'");

// WRONG — raw GET param in SQL
$val = mysqli_query($link, "SELECT val FROM pwdata WHERE name = '{$_GET['planet']}'");

// WRONG — missing player/tag filter (returns all players' vars with the same name)
$stmt = mysqli_prepare($link, 'SELECT val FROM pwdata WHERE name = ?');
```

---

## DM AUTHENTICATION

### Check DM status (read-only page sections)
```php
$is_dm = $_SESSION['is_dm'] ?? false;
// Then gate output: if ($is_dm) { ... }
```

### DM login handler (index.php only)
```php
if (isset($_GET['logout'])) {
    session_destroy();
    header('Location: index.php');
    exit();
}
if (isset($_POST['login'])) {
    if (hash_equals($dmlogin, $_POST['login'])) {
        $_SESSION['is_dm'] = true;
    }
}
$is_dm = $_SESSION['is_dm'] ?? false;
```

### Gate a state-changing POST action
```php
if ($is_dm && isset($_POST['reset_player_char_name'])) {
    // perform privileged action
}
```

---

## PLAYER AUTHENTICATION (CD key)

Players log in with the 8-character public CD key they play on. `player_auth.php`
owns every piece of this — never re-implement the lookups inline.

### Include order
```php
session_start();
include('uoa.php');
include('helpers.php');
include('player_auth.php');   // after helpers.php, before any data fetching
```

### Check player status
```php
$is_dm = $_SESSION['is_dm'] ?? false;   // DM checks are unchanged
if (player_is_logged_in()) { $cdkey = player_cdkey(); }
```

### Decide whether a map tile is visible
```php
// Load the viewer's discovered tiles once per page, before mysqli_close():
$player_tiles = player_is_logged_in()
    ? player_discovered_tiles($link, player_cdkey(), $planet)
    : [];

// Then per tile — never hand-roll this rule:
$discovered   = isset($player_tiles[$XX . '_' . $YY]);   // plain signed ints
$tile_visible = !empty($tiletype)
    && tile_is_visible($is_dm, $discovered, $showAreas, $showInterests, $interest2);
```

`tile_is_visible()` is the single source of truth: DM sees everything, the
`ShowAreas` / `ShowInterests` module flags are global overrides, and otherwise
only the viewer's own discoveries show. The trailing `*` on a terrain code is
the *server-wide* discovery marker — strip it from the code, but never treat it
as a reason to display a tile.

### NEVER do this
```php
// WRONG — the "*" flag reveals the tile to every visitor
$visible = (substr($tiletype, -1) === '*');

// WRONG — a detail page must be gated too, not just the map grid
// (interests.php answers 403 for a tile the viewer has not discovered)
```

---

## OUTPUT ESCAPING

### All user-facing string output
```php
echo htmlspecialchars($value);          // text content
echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');  // inside HTML attributes
```

### URL parameters
```php
$url = 'galaxy.php?' . http_build_query([
    'planet'  => $planet_name,
    'galaxyx' => $x,
    'galaxyy' => $y,
]);
echo '<a href="' . htmlspecialchars($url) . '">';
```

### JavaScript values (e.g. confirm dialogs)
```php
// Use json_encode(), NOT addslashes()
onclick="return confirm('Reset ' + <?= json_encode($charname) ?> + '?')"
```

### NEVER do this
```php
echo $_GET['planet'];          // WRONG — unescaped user input
echo "<a href='$url'>";        // WRONG — unescaped URL
```

---

## STRING PARSING (pwdata format)

### Import the helpers
```php
include('helpers.php');
```

### between() — extract a substring between two delimiters
```php
// Signature: between(string $data, string $after, string $before): string
// $after  = '' means start from beginning
// $before = '' means read to end

$year  = between($calendar, '',     '/C1/');   // before first delimiter
$month = between($calendar, '/C1/', '/C2/');   // between two delimiters
$hour  = between($calendar, '/C3/', '/C4/');
```

### encoded_field() — extract Nth field from &001&-delimited string
```php
// Signature: encoded_field(string $data, int $n): string
// Field 1 = value before &001&
// Field 2 = value between &001& and &002&

$position    = encoded_field($planet, 1);
$size        = encoded_field($planet, 2);
$tiletype    = encoded_field($planet, 3);
$description = encoded_field($planet, 10);
```

### tile_key() — format Y coordinate for pwdata map keys
```php
// Signature: tile_key(int $y): string
// Returns signed zero-padded string: 5 → '+05', -3 → '-03'

$key = $planet_name . 'AreasX' . $x;            // column key
$key = $planet_name . '&' . $x . '_' . tile_key($y) . '&Interests';
```

### Negative coordinates in pwdata keys
```php
// Negative coordinates stored with 'm' replacing '-': -3 → 'm3'
// tile_key() handles this automatically for interests lookup
// For raw column keys: use sprintf('%+03d', $x) style if needed
```

---

## PWDATA KEY NAMING CONVENTIONS

| Key Pattern | Content |
|---|---|
| `Galaxy` | Master list of all star systems and planets |
| `<PlanetName>` | Planet config: size, tiletype, description, level, weather |
| `<PlanetName>AreasX<X>` | Column of map tiles at X coordinate |
| `<PlanetName>&<X>_<Y>&Interests` | Interest point at map coordinate |
| `Player<N>` | Player state: account, charname, planet, area, coords, is_dm |
| `PCLoc_<CharacterName>` | Last known location per character (never deleted) — see below |
| `Calendar` | Server in-game date/time |
| `Reboot` | Minutes until next reboot (or literal `rebooting`) |
| `Space<X>_<Y>` | Space tile type at star map coordinate |
| `Space<X>_<Y>Show` | Space tile visibility flag (server-wide; not used for web visibility) |
| `WebChars_<cdkey>` | Characters seen on a public CD key — see below |
| `WebCode_<cdkey>` | One-time website registration code; `last` column = issue time |
| `WMap_<Planet>_X<X>` | Per-character discovered tiles (player=account, tag=charname) |

---

## TILE SYSTEM

### Tile type → GIF filename
```php
// Two-digit tile type code maps to a base GIF name:
$tile_map = [
    '01' => 'plain',  '04' => 'forest', '07' => 'mountain',
    // full map defined in galaxy.php
];
// Interest overlay: append suffix to base name
// e.g., 'forest' + town → 'forest_town.gif'
//        'plain'  + dung → 'plain_dung.gif'
```

### Interest type codes (first char of interest val)
| Code | Type |
|------|------|
| `D`  | Domain |
| `1`  | Town |
| `2`  | Dungeon |
| `3`  | Castle |
| `4`  | Ruins |
| `5`  | Animal reserve |
| `6`  | Resource mountain |
| `7`  | Amusement place |

---

## MAP GRID CSS (galaxy.php)

Tile cells require zero-gap CSS to prevent whitespace around 24×24 GIF tiles:

```css
table.map-grid td.map-tile {
    padding: 0; margin: 0; line-height: 0; font-size: 0;
    width: 24px; height: 24px;
}
table.map-grid td.map-tile img { display: block; }
table.map-grid td:not(.map-tile) { font-size: 0.8em; }  /* axis labels */
```

---

## INCLUDE DEPENDENCY CHAIN

```
uoa.php          ← config only (no includes)
helpers.php      ← utilities only (no includes)
player_auth.php  ← player accounts + map discovery (no includes)

index.php        → uoa.php, helpers.php, player_auth.php
galaxy.php       → uoa.php, helpers.php, player_auth.php
interests.php    → uoa.php, helpers.php, player_auth.php
map-data.php     → uoa.php, helpers.php, player_auth.php
statut.php       → uoa.php, helpers.php
playerLocations.php → uoa.php, helpers.php
playerInfo.php   → uoa.php  (helpers.php not currently used)
register.php     → uoa.php, helpers.php, player_auth.php
nwnservers.php   → standalone (no includes)

database-mysql.php → sql.php  (legacy bundle, NOT used by main pages)
```

---

## PLAYER DATA FORMAT (pwdata key: Player<N>)

```
<account_name>&1&<char_name>&2&<planet>&3&<coord_X>_<coord_Y>&4&<area>&5&<is_dm>&...
```

- Apostrophes stored as `~` (e.g., `O'Brien` → `O~Brien`) — unescape for display
- `coord_X_Y` is the map tile coordinate on the planet surface
- `is_dm` flag: `1` = DM, `0` or empty = player

```php
// Parse player record (galaxy.php pattern)
$account  = between($player_val, '',    '&1&');
$charname = between($player_val, '&1&', '&2&');
$planet   = between($player_val, '&2&', '&3&');
$coords   = between($player_val, '&3&', '&4&');
$area     = between($player_val, '&4&', '&5&');
```

---

## PC LOCATION FORMAT (pwdata key: PCLoc_<CharacterName>)

Written on every area transition (`area_enter.nss`), never deleted — unlike `Player<N>`,
this persists for offline characters too. Used by `playerLocations.php` (DM-only "All
Characters" lookup).

```
<account>&001&<char_name>&002&<planet>&003&<tile_area_X_Y>&004&<area_tag>&005&<x>&006&<y>&007&<z>&008&<facing>&009&<is_dm>&010&
```

| Field | Content |
|---|---|
| 1 | account name |
| 2 | character name (key suffix, also `GetName(oPC)`) |
| 3 | planet (tile-grid name) |
| 4 | tile area `X_Y` (galaxy-map coordinate) |
| 5 | NWN area tag (precise in-world area) |
| 6 | X position |
| 7 | Y position |
| 8 | Z position |
| 9 | facing |
| 10 | is_dm flag: `1` = DM, `0` = player |

- Apostrophes stored as `~` — unescape for display, same as `Player<N>`
- Uses `&00N&`-style delimiters (`FIELD_1`..`FIELD_10` from `_constants.nss`), not the
  `&N&` style used by `Player<N>`

```php
// Parse PC location record (playerLocations.php pattern)
$account  = str_replace('~', "'", encoded_field($p, 1));
$charname = str_replace('~', "'", encoded_field($p, 2));
$planet   = str_replace('~', "'", encoded_field($p, 3));
$tilearea = encoded_field($p, 4);
$areatag  = encoded_field($p, 5);
$x        = encoded_field($p, 6);
$y        = encoded_field($p, 7);
$z        = encoded_field($p, 8);
$facing   = encoded_field($p, 9);
$is_dm    = encoded_field($p, 10);
```

---

## PER-PLAYER MAP DISCOVERY FORMAT

Written by `_webmap.nss` (module side), read by `player_auth.php` (web side).

### WebChars_<cdkey> — module-level row, one per CD key
```
<account>&1&<charname>&2&<account>&1&<charname>&2&...
```
Repeated entries, each terminated by `&2&`. Account is lowercase, matching the
`player` column APS writes for per-PC rows; apostrophes are stored as `~` in
both this value and the `tag` column, so the two match without unescaping.

### WMap_<Planet>_X<X> — per-PC row (player=account, tag=charname)
```
&+05&&-03&&+00&
```
A run of `&±YY&` keys — the same signed, zero-padded form used by
`<Planet>AreasX<X>` — one per discovered row in that column. Presence means
discovered; there is no value. `Space` is stored as a planet name like any other.

```php
// Parse (player_auth.php pattern)
preg_match_all('/&([+-]\d+)&/', $val, $m);
foreach ($m[1] as $y) { $tiles[$x . '_' . (int)$y] = true; }
```

---

## CALENDAR FORMAT (pwdata key: Calendar)

```
<year>/C1/<month>/C2/<day>/C3/<hour>/C4/...
```

```php
$year  = between($calendar, '',     '/C1/');
$month = between($calendar, '/C1/', '/C2/');
$day   = between($calendar, '/C2/', '/C3/');
$hour  = between($calendar, '/C3/', '/C4/');
```

---

## REBOOT FORMAT (pwdata key: Reboot)

```
&&&<total_minutes>    (e.g., &&&125 = 2h05m)
OR
rebooting             (literal string when server is rebooting)
```

```php
if ($reboot_val === 'rebooting') {
    $time2 = 'rebooting';
} else {
    $total_minutes = (int)between($reboot_val, '&&&', '');
    $h = intdiv($total_minutes, 60);
    $m = $total_minutes % 60;
    $time2 = $h . 'h' . str_pad($m, 2, '0', STR_PAD_LEFT);
}
```
