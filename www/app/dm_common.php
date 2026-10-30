<?php
/**
 * Shared start-up for the DM pages (dm_bank.php, dm_inactive.php).
 * Opens the database, requires the DM session set by the DM area on ../index.php,
 * and provides pwdata access, an audit trail and the page frame.
 */
session_start();
include __DIR__ . '/uoa.php';
include_once __DIR__ . '/helpers.php';

mysqli_report(MYSQLI_REPORT_OFF);
$link = @mysqli_connect($host, $user, $pass, $data, (int)($port ?? 3306));
if (!$link) {
    die('service offline');
}
if (!($_SESSION['is_dm'] ?? false)) {
    http_response_code(403);
    echo 'DM login required. Log in from the DM area on the home page, then come back.';
    exit;
}

function h(string $text): string {
    return htmlspecialchars($text, ENT_QUOTES, 'UTF-8');
}

function dm_pw_get(mysqli $link, string $name): string {
    $stmt = mysqli_prepare($link, "SELECT val FROM pwdata WHERE player='~' AND tag='uoa' AND name=?");
    mysqli_stmt_bind_param($stmt, 's', $name);
    mysqli_stmt_execute($stmt);
    $row = mysqli_fetch_assoc(mysqli_stmt_get_result($stmt));
    mysqli_stmt_close($stmt);
    return $row['val'] ?? '';
}

function dm_pw_set(mysqli $link, string $name, string $val) {
    $stmt = mysqli_prepare($link,
        "INSERT INTO pwdata (player, tag, name, val, expire) VALUES ('~', 'uoa', ?, ?, 0)
         ON DUPLICATE KEY UPDATE val = VALUES(val), last = now()");
    mysqli_stmt_bind_param($stmt, 'ss', $name, $val);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_close($stmt);
}

/** Record a DM action. The table is created on first use. */
function dm_audit(mysqli $link, string $action, string $detail) {
    mysqli_query($link, "CREATE TABLE IF NOT EXISTS dm_audit (
        id INT AUTO_INCREMENT PRIMARY KEY, at INT NOT NULL,
        action VARCHAR(40) NOT NULL, detail VARCHAR(500) NOT NULL, ip VARCHAR(45) NOT NULL DEFAULT '')");
    $stmt = mysqli_prepare($link, 'INSERT INTO dm_audit (at, action, detail, ip) VALUES (?, ?, ?, ?)');
    $now = time();
    $ip = (string)($_SERVER['REMOTE_ADDR'] ?? '');
    mysqli_stmt_bind_param($stmt, 'isss', $now, $action, $detail, $ip);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_close($stmt);
}

/** The most recent audit rows for one action, newest first. */
function dm_audit_recent(mysqli $link, string $action, int $limit = 15): array {
    $rows = [];
    $stmt = @mysqli_prepare($link, 'SELECT at, detail FROM dm_audit WHERE action = ? ORDER BY id DESC LIMIT ?');
    if (!$stmt) return $rows;
    mysqli_stmt_bind_param($stmt, 'si', $action, $limit);
    mysqli_stmt_execute($stmt);
    $res = mysqli_stmt_get_result($stmt);
    while ($row = mysqli_fetch_assoc($res)) $rows[] = $row;
    mysqli_stmt_close($stmt);
    return $rows;
}

function dm_page_start(string $title) {
    ?><!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title><?= h($title) ?> - DM</title>
<style>
:root{--bg:#f3f5f7;--panel:#fff;--ink:#14202b;--quiet:#586775;--line:#d9e0e6;--accent:#0f6b66;--warn:#a8470f;--ok:#1f7a3d}
@media (prefers-color-scheme:dark){:root{--bg:#0f161c;--panel:#17212a;--ink:#e6ecef;--quiet:#93a3b0;--line:#2a3945;--accent:#4db6ac;--warn:#f0a070;--ok:#6fcf8c;color-scheme:dark}}
*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--ink);font:15px/1.55 system-ui,sans-serif;padding:20px max(16px,env(safe-area-inset-left))}
main{max-width:980px;margin:0 auto;display:flex;flex-direction:column;gap:18px}
nav a{margin-right:14px;color:var(--accent)}h1{font-size:24px;margin:0}h2{font-size:18px;margin:0 0 8px}
.panel{background:var(--panel);border:1px solid var(--line);border-radius:8px;padding:16px;min-width:0}
.quiet{color:var(--quiet)}.warn{color:var(--warn)}.ok{color:var(--ok)}
table{border-collapse:collapse;width:100%}th,td{text-align:left;padding:6px 8px;border-bottom:1px solid var(--line);vertical-align:top}
th{font-size:12px;text-transform:uppercase;letter-spacing:.05em;color:var(--quiet)}
.scroll{overflow-x:auto}label{display:flex;flex-direction:column;gap:3px;font-size:13px;color:var(--quiet)}
input,select{font:inherit;color:var(--ink);background:var(--bg);border:1px solid var(--line);border-radius:5px;padding:6px 8px;max-width:100%}
button{font:inherit;padding:7px 14px;border-radius:5px;border:1px solid var(--accent);background:var(--accent);color:var(--bg);cursor:pointer}
button.danger{border-color:var(--warn);background:var(--warn)}
.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(210px,1fr));gap:12px}
code{font:13px ui-monospace,monospace}
</style></head><body><main>
<nav><a href="../index.php" target="_top">Home</a><a href="dm_tools.php">Tools</a><a href="dm_bank.php">Bank</a><a href="dm_rentals.php">Rentals</a><a href="dm_inactive.php">Inactive accounts</a></nav>
<h1><?= h($title) ?></h1>
<?php
}

function dm_page_end() {
    echo "</main></body></html>\n";
}
