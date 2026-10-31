<?php
/**
 * Player accounts and per-player map discovery.
 *
 * Players register with the 8-character public CD key they play on, proved
 * with a one-time code they get in game (".web"), and pick a password. The
 * accounts live in the `web_players` table (see
 * docker/mysql-init/02-web-players.sql); everything else is read out of
 * pwdata, written by the module:
 *
 *   WebChars_<cdkey>        "<account>&1&<charname>&2&" repeated - the
 *                           characters seen on that CD key.
 *   WebCode_<cdkey>         one-time registration code; its `last` column is
 *                           the issue time and the only expiry we have.
 *   WMap_<Planet>_X<X>      per-character discovered tiles, stored under
 *                           (player=<account>, tag=<charname>) as a run of
 *                           "&+05&" / "&-03&" keys - same &±YY& form as the
 *                           <Planet>AreasX<X> terrain columns.
 *
 * Discovery is recorded per character; the site unions every character on the
 * CD key into a single map.
 *
 * Requires session_start() to have been called (same as helpers.php).
 */

// A public CD key is 8 alphanumeric characters. MySQL's default collation is
// case-insensitive, so an uppercase key still matches what the module wrote.
const CDKEY_PATTERN = '/^[A-Z0-9]{8}$/';

// How long an in-game registration code stays usable.
const WEB_CODE_TTL_MINUTES = 30;

const PLAYER_PASSWORD_MIN = 8;

// Failed logins allowed per session before the form stops accepting attempts.
const PLAYER_LOGIN_MAX_FAILURES = 10;
const PLAYER_LOGIN_LOCKOUT_SECONDS = 300;

/**
 * Normalise a CD key as typed by a player: trim, strip spaces, uppercase.
 */
function cdkey_normalize(string $raw): string {
    return strtoupper(preg_replace('/\s+/', '', $raw));
}

function cdkey_valid(string $cdkey): bool {
    return (bool)preg_match(CDKEY_PATTERN, $cdkey);
}

/**
 * The logged-in player's CD key, or '' when nobody is logged in.
 */
function player_cdkey(): string {
    return $_SESSION['player_cdkey'] ?? '';
}

function player_is_logged_in(): bool {
    return player_cdkey() !== '';
}

function player_logout(): void {
    unset($_SESSION['player_cdkey']);
}

/**
 * Escape a value for use inside a LIKE pattern (planet names may contain _).
 */
function like_escape(string $value): string {
    return str_replace(['\\', '%', '_'], ['\\\\', '\\%', '\\_'], $value);
}

/**
 * Read a single module-level pwdata value.
 */
function pw_value($link, string $key): string {
    $stmt = mysqli_prepare($link, "SELECT val FROM pwdata WHERE player='~' AND tag='uoa' AND name=?");
    mysqli_stmt_bind_param($stmt, 's', $key);
    mysqli_stmt_execute($stmt);
    $row = mysqli_fetch_assoc(mysqli_stmt_get_result($stmt));
    mysqli_stmt_close($stmt);
    return $row['val'] ?? '';
}

/**
 * Attempt a player login. Returns '' on success, or an error message.
 */
function player_login($link, string $cdkey, string $password): string {
    $cdkey = cdkey_normalize($cdkey);

    $failures = $_SESSION['player_login_failures'] ?? 0;
    $locked_until = $_SESSION['player_login_locked_until'] ?? 0;
    if ($failures >= PLAYER_LOGIN_MAX_FAILURES && time() < $locked_until) {
        return 'Too many failed attempts. Try again in a few minutes.';
    }

    if (!cdkey_valid($cdkey)) {
        return 'Enter your 8-character public CD key.';
    }

    $stmt = mysqli_prepare($link, 'SELECT cdkey, pass_hash FROM web_players WHERE cdkey=?');
    mysqli_stmt_bind_param($stmt, 's', $cdkey);
    mysqli_stmt_execute($stmt);
    $row = mysqli_fetch_assoc(mysqli_stmt_get_result($stmt));
    mysqli_stmt_close($stmt);

    if (!$row || !password_verify($password, $row['pass_hash'])) {
        $_SESSION['player_login_failures'] = $failures + 1;
        $_SESSION['player_login_locked_until'] = time() + PLAYER_LOGIN_LOCKOUT_SECONDS;
        // Same message either way - don't reveal which CD keys are registered.
        return 'Unknown CD key or wrong password.';
    }

    unset($_SESSION['player_login_failures'], $_SESSION['player_login_locked_until']);
    // Use the stored spelling of the key so later lookups are consistent.
    session_regenerate_id(true);
    $_SESSION['player_cdkey'] = $row['cdkey'];

    $upd = mysqli_prepare($link, 'UPDATE web_players SET last_login=NOW() WHERE cdkey=?');
    mysqli_stmt_bind_param($upd, 's', $row['cdkey']);
    mysqli_stmt_execute($upd);
    mysqli_stmt_close($upd);

    return '';
}

/**
 * Register a new player account. Returns '' on success, or an error message.
 */
function player_register($link, string $cdkey, string $code, string $password, string $confirm): string {
    $cdkey = cdkey_normalize($cdkey);
    $code  = trim($code);

    if (!cdkey_valid($cdkey)) {
        return 'Enter your 8-character public CD key (letters and digits only).';
    }
    if ($password !== $confirm) {
        return 'The two passwords do not match.';
    }
    if (strlen($password) < PLAYER_PASSWORD_MIN) {
        return 'Password must be at least ' . PLAYER_PASSWORD_MIN . ' characters.';
    }

    $stmt = mysqli_prepare($link, 'SELECT cdkey FROM web_players WHERE cdkey=?');
    mysqli_stmt_bind_param($stmt, 's', $cdkey);
    mysqli_stmt_execute($stmt);
    $exists = (bool)mysqli_fetch_assoc(mysqli_stmt_get_result($stmt));
    mysqli_stmt_close($stmt);
    if ($exists) {
        return 'That CD key is already registered. Log in instead, or ask a DM to reset it.';
    }

    // The code proves the person registering is the person holding the key:
    // only someone in game on that key can run ".web" and read it.
    $key = 'WebCode_' . $cdkey;
    $stmt = mysqli_prepare($link,
        'SELECT val FROM pwdata
         WHERE player=\'~\' AND tag=\'uoa\' AND name=?
           AND last >= NOW() - INTERVAL ' . WEB_CODE_TTL_MINUTES . ' MINUTE');
    mysqli_stmt_bind_param($stmt, 's', $key);
    mysqli_stmt_execute($stmt);
    $row = mysqli_fetch_assoc(mysqli_stmt_get_result($stmt));
    mysqli_stmt_close($stmt);

    $expected = trim($row['val'] ?? '');
    if ($expected === '' || !hash_equals($expected, $code)) {
        return 'That code is wrong or has expired. Type .web in game for a fresh one.';
    }

    $hash = password_hash($password, PASSWORD_BCRYPT);
    $ins  = mysqli_prepare($link, 'INSERT INTO web_players (cdkey, pass_hash) VALUES (?, ?)');
    mysqli_stmt_bind_param($ins, 'ss', $cdkey, $hash);
    $ok = mysqli_stmt_execute($ins);
    mysqli_stmt_close($ins);
    if (!$ok) {
        return 'Could not create the account. Try again.';
    }

    // Burn the code so it cannot be replayed.
    $del = mysqli_prepare($link, "DELETE FROM pwdata WHERE player='~' AND tag='uoa' AND name=?");
    mysqli_stmt_bind_param($del, 's', $key);
    mysqli_stmt_execute($del);
    mysqli_stmt_close($del);

    return '';
}

/**
 * Characters seen on this CD key, as [['account' => ..., 'charname' => ...], ...].
 * Names keep the module's APS encoding (apostrophes stored as ~), because they
 * are matched against the pwdata player/tag columns.
 */
function player_characters($link, string $cdkey): array {
    $val = pw_value($link, 'WebChars_' . $cdkey);
    if ($val === '') return [];

    $chars = [];
    foreach (explode('&2&', $val) as $entry) {
        if ($entry === '') continue;
        $parts = explode('&1&', $entry, 2);
        if (count($parts) !== 2 || $parts[0] === '' || $parts[1] === '') continue;
        $chars[] = ['account' => $parts[0], 'charname' => $parts[1]];
    }
    return $chars;
}

/**
 * Tiles this CD key has discovered on one planet ('Space' included), as a set
 * keyed "<X>_<Y>" (plain signed integers, e.g. "-3_5"). Empty when the player
 * has never been there — or is not logged in.
 */
function player_discovered_tiles($link, string $cdkey, string $planet): array {
    if ($cdkey === '' || $planet === '') return [];

    $chars = player_characters($link, $cdkey);
    if (!$chars) return [];

    $prefix = 'WMap_' . $planet . '_X';
    $like   = like_escape($prefix) . '%';

    $where  = implode(' OR ', array_fill(0, count($chars), '(player=? AND tag=?)'));
    $types  = 's' . str_repeat('ss', count($chars));
    $params = [$like];
    foreach ($chars as $char) {
        $params[] = $char['account'];
        $params[] = $char['charname'];
    }

    $stmt = mysqli_prepare($link, "SELECT name, val FROM pwdata WHERE name LIKE ? AND ($where)");
    mysqli_stmt_bind_param($stmt, $types, ...$params);
    mysqli_stmt_execute($stmt);
    $res = mysqli_stmt_get_result($stmt);

    $tiles = [];
    while ($row = mysqli_fetch_assoc($res)) {
        $x_part = substr($row['name'], strlen($prefix));
        if ($x_part === '' || !preg_match('/^-?\d+$/', $x_part)) continue;
        $x = (int)$x_part;
        // val is a run of &+05&&-03& keys - one per discovered row in column X.
        if (preg_match_all('/&([+-]\d+)&/', $row['val'] ?? '', $m)) {
            foreach ($m[1] as $y) {
                $tiles[$x . '_' . (int)$y] = true;
            }
        }
    }
    mysqli_stmt_close($stmt);

    return $tiles;
}

/**
 * Should this map tile be drawn for the current viewer?
 *
 * DMs see everything (unchanged). The ShowAreas / ShowInterests module flags
 * stay global overrides — that is what a DM sets them for. Otherwise a tile is
 * only drawn for a logged-in player who has discovered it themselves; the
 * server-wide "*" discovery flag no longer reveals tiles to everyone.
 */
function tile_is_visible(
    bool $is_dm,
    bool $player_discovered,
    $show_areas,
    $show_interests,
    string $interest_code
): bool {
    if ($is_dm) return true;
    if ($show_areas == 1) return true;
    if ($show_interests == 1 && $interest_code !== '') return true;
    return $player_discovered;
}
