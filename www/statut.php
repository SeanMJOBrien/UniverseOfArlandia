<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include('uoa.php');
include('helpers.php');

mysqli_report(MYSQLI_REPORT_OFF); // mysqli_connect() must return false, not throw, on failure
$link = @mysqli_connect($host, $user, $pass, $data, (int)$port);
if (!$link) {
    echo 'service offline';
    exit;
}

$stmt = mysqli_prepare($link, "SELECT val FROM pwdata WHERE player='~' AND tag='uoa' AND name=?");

// Player count from DB (Player1, Player2, ... records deleted on logout)
$pc_stmt = mysqli_prepare($link, "SELECT COUNT(*) FROM pwdata WHERE player='~' AND tag='uoa' AND name REGEXP '^Player[0-9]+$' AND val != ''");
mysqli_stmt_execute($pc_stmt);
$pc_row = mysqli_fetch_row(mysqli_stmt_get_result($pc_stmt));
$player_count = (int)($pc_row[0] ?? 0);
mysqli_stmt_close($pc_stmt);

// Next reboot time
$key = 'Reboot';
mysqli_stmt_bind_param($stmt, 's', $key);
mysqli_stmt_execute($stmt);
$row = mysqli_fetch_assoc(mysqli_stmt_get_result($stmt));
$reboot_val = $row['val'] ?? '';

if ($reboot_val === 'rebooting') {
    $time2 = 'rebooting';
} else {
    $total_minutes = (int)between($reboot_val, '&&&', '');
    $h = intdiv($total_minutes, 60);
    $m = $total_minutes % 60;
    $time2 = $h . 'h' . str_pad($m, 2, '0', STR_PAD_LEFT);
}

// In-game calendar
$key = 'Calendar';
mysqli_stmt_bind_param($stmt, 's', $key);
mysqli_stmt_execute($stmt);
$row      = mysqli_fetch_assoc(mysqli_stmt_get_result($stmt));
$calendar = $row['val'] ?? '';

$year  = between($calendar, '',     '/C1/');
$month = between($calendar, '/C1/', '/C2/');
$day   = between($calendar, '/C2/', '/C3/');
$hour  = between($calendar, '/C3/', '/C4/');

mysqli_stmt_close($stmt);
mysqli_close($link);
?>
<!DOCTYPE html>
<html lang="fr-CH">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="60">
    <title></title>
    <style>
        body {
            margin: 0;
            padding: 4px;
            background: transparent;
            color: #FFFFFF;
            font-family: Arial, sans-serif;
            font-size: 0.85em;
            font-weight: bold;
            text-align: center;
        }
        a:hover { color: #00FF00; }
        p { margin: 2px 0; }
        .online    { color: #00FF00; }
        .info      { color: #E6E6E6; }
        .highlight { color: #00FFFF; }
    </style>
</head>
<body>
<p class="online">Online</p>
<p class="info">Players: <?= (int)$player_count ?></p>
<p class="info">next reboot : <span class="highlight"><?= htmlspecialchars($time2) ?></span></p>
<br>
<p class="info">date : <span class="highlight"><?= htmlspecialchars("$day.$month.$year") ?></span></p>
<p class="info">hour : <span class="highlight"><?= htmlspecialchars($hour) ?></span>h...</p>
</body>
</html>
