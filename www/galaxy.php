<?php
session_start();

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include('uoa.php');
include('helpers.php');

$is_dm = $_SESSION['is_dm'] ?? false;

$link = mysqli_connect($host, $user, $pass, $data, (int)($port ?? 3306));
if (!$link) {
    die('service offline');
}

// Action: reset a player's map coordinates (DM only)
if ($is_dm && isset($_POST['reset_player_char_name'])) {
    $charToReset = $_POST['reset_player_char_name'];

    $stmt = mysqli_prepare($link, "SELECT name, val FROM pwdata WHERE name LIKE 'Player%'");
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    $playerKey  = null;
    $playerData = null;
    while ($row = mysqli_fetch_assoc($result)) {
        $charName = str_replace('~', "'", between($row['val'], '&1&', '&2&'));
        if ($charName === $charToReset) {
            $playerKey  = $row['name'];
            $playerData = $row['val'];
            break;
        }
    }
    mysqli_stmt_close($stmt);

    if ($playerKey && $playerData) {
        $newData = preg_replace('/(&3&)(.*?)(?=&4&)/', '$10_0', $playerData, 1);
        if ($newData !== null && $newData !== $playerData) {
            $upd = mysqli_prepare($link, 'UPDATE pwdata SET val = ? WHERE name = ?');
            mysqli_stmt_bind_param($upd, 'ss', $newData, $playerKey);
            mysqli_stmt_execute($upd);
            mysqli_stmt_close($upd);
        }
    }
    header('Location: ' . $_SERVER['PHP_SELF'] . '?planet=infos&reset_success=' . urlencode($charToReset));
    exit();
}

// Action: teleport a player to a new location (DM only)
if ($is_dm && isset($_POST['teleport_player_key'])) {
    $playerKey = $_POST['teleport_player_key'];
    if (!preg_match('/^Player\d+$/', $playerKey)) {
        http_response_code(400); exit('Invalid player key');
    }

    $stmt = mysqli_prepare($link, 'SELECT val FROM pwdata WHERE name = ?');
    mysqli_stmt_bind_param($stmt, 's', $playerKey);
    mysqli_stmt_execute($stmt);
    $row = mysqli_fetch_assoc(mysqli_stmt_get_result($stmt));
    $val = $row['val'] ?? '';
    mysqli_stmt_close($stmt);

    $charname = '';
    if ($val !== '') {
        $account  = between($val, '',    '&1&');
        $charname = between($val, '&1&', '&2&');
        $after4   = between($val, '&4&', '');

        $new_planet = preg_replace('/[^A-Za-z0-9_ \'-]/', '', $_POST['tp_planet'] ?? '');
        $new_x      = (int)($_POST['tp_x'] ?? 0);
        $new_y      = (int)($_POST['tp_y'] ?? 0);

        $new_val = $account . '&1&' . $charname . '&2&'
                 . $new_planet . '&3&' . $new_x . '_' . $new_y . '&4&'
                 . $after4;

        $upd = mysqli_prepare($link, 'UPDATE pwdata SET val = ? WHERE name = ?');
        mysqli_stmt_bind_param($upd, 'ss', $new_val, $playerKey);
        mysqli_stmt_execute($upd);
        mysqli_stmt_close($upd);
    }
    header('Location: ' . $_SERVER['PHP_SELF'] . '?planet=infos&tp_success=' . urlencode($charname));
    exit();
}

// URL parameters
$galaxyx = (int)($_GET['galaxyx'] ?? 0);
$galaxyy = (int)($_GET['galaxyy'] ?? 0);
$system  = $_GET['system'] ?? '';
$planet  = $_GET['planet'] ?? '';

// Cache all pwdata in one query
$pwdata_cache = [];
$res = mysqli_query($link, 'SELECT name, val FROM pwdata');
while ($row = mysqli_fetch_assoc($res)) {
    $pwdata_cache[$row['name']] = $row['val'];
}
function get_pw(string $key): string {
    global $pwdata_cache;
    return $pwdata_cache[$key] ?? '';
}

$planet_row = get_pw($planet);
$tiletype   = encoded_field($planet_row, 3);
?>
<!DOCTYPE html>
<html lang="fr-CH">
<head>
    <meta charset="UTF-8">
    <title>UOA Galaxy Viewer</title>
    <meta name="description" content="Universe of Arlandia for Neverwinter Nights - The Universe is infinite">
    <meta name="keywords" content="arlandia, uoa, universe, neverwinter nights, nwn, lkt, the rack, therack, marc racordon">
    <meta name="author" content="TheRack">
    <meta name="copyright" content="TheRack, 2009-2011">
    <style>
        body {
            margin: 0;
            padding: 0 30px;
            background-color: #000;
            color: #FFFFFF;
            font-family: Arial, sans-serif;
            background-image: url('UOA_BG2.jpg');
        }
        a { color: #FFFFFF; }
        a:hover { color: #00FF00; }

        table.data-table {
            border-collapse: collapse;
            width: 100%;
        }
        table.data-table td {
            color: #FFC800;
            font-weight: bold;
            font-size: 0.9em;
            padding: 5px;
            text-align: center;
            vertical-align: top;
            border: 1px solid #FFFFFF;
        }
        table.data-table td.col-header {
            background-color: #005064;
            color: #66CCFF;
        }
        .feedback-message {
            padding: 10px;
            margin: 15px 0;
            border: 1px solid #008f00;
            background-color: #0c4b0c;
            color: #9dff9d;
            font-weight: bold;
            text-align: center;
            border-radius: 4px;
        }
        .action-button {
            background-color: #a00;
            color: white;
            border: 1px solid #d00;
            padding: 4px 8px;
            cursor: pointer;
            border-radius: 3px;
            font-weight: bold;
        }
        .action-button:hover { background-color: #c00; }

        .lbl { color: #66CCFF; font-weight: bold; }
        .val { color: #00FFFF; font-weight: bold; }
        .nav-link { text-align: right; font-size: 0.9em; font-weight: bold; }

        /* Map grid: tile cells only — coordinate label cells are excluded */
        table.map-grid td.map-tile {
            padding: 0;
            margin: 0;
            line-height: 0;
            font-size: 0;
            width: 24px;
            height: 24px;
        }
        table.map-grid td.map-tile img { display: block; }
        table.map-grid td:not(.map-tile) { font-size: 0.8em; }
    </style>
</head>
<body>

<?php if ($planet === 'infos'): ?>

    <p class="nav-link"><a href="galaxy.php?planet=infos"><u>Actualise</u></a></p>

    <?php if ($is_dm): ?>
    <p class="nav-link"><a href="playerLocations.php">All Characters</a></p>
    <?php endif; ?>

    <?php if (isset($_GET['reset_success'])): ?>
        <div class="feedback-message">
            Success: Player <?= htmlspecialchars($_GET['reset_success']) ?>'s coordinates have been reset to 0,0.
        </div>
    <?php endif; ?>

    <?php if (isset($_GET['tp_success'])): ?>
        <div class="feedback-message">
            Teleported <?= htmlspecialchars($_GET['tp_success']) ?>.
        </div>
    <?php endif; ?>

    <table class="data-table">
        <tr>
            <td class="col-header"><u>Player</u> :</td>
            <td class="col-header"><u>Character</u> :</td>
            <td class="col-header"><u>Planet</u> :</td>
            <td class="col-header"><u>Area</u> :</td>
            <td class="col-header"><u>Action</u> :</td>
        </tr>
        <?php
        $player_keys = array_filter(array_keys($pwdata_cache), fn($k) => str_starts_with($k, 'Player'));
        if (empty($player_keys)) {
            echo '<tr><td colspan="5">No player data found.</td></tr>';
        } else {
            natsort($player_keys);
            foreach (array_reverse($player_keys) as $pk) {
                $p = get_pw($pk);
                if (empty($p)) continue;
                $var1 = str_replace('~', "'", between($p, '',    '&1&'));
                $var2 = str_replace('~', "'", between($p, '&1&', '&2&'));
                $var3 = str_replace('~', "'", between($p, '&2&', '&3&'));
                $var4 = str_replace('~', "'", between($p, '&3&', '&4&'));
                $var5 = str_replace('~', "'", between($p, '&4&', '&5&'));
                if ($var1 === '') continue;
                ?>
                <tr>
                    <td><?= htmlspecialchars($var1) ?></td>
                    <td><?= htmlspecialchars($var2) ?><?php if ($var5 === '1') echo ' <span style="color:#FF0000">(DM)</span>'; ?></td>
                    <td><?= htmlspecialchars($var3) ?></td>
                    <td><?= htmlspecialchars($var4) ?></td>
                    <td>
                        <?php if ($is_dm): ?>
                        <form method="post" action="galaxy.php?planet=infos" style="margin:0;">
                            <input type="hidden" name="reset_player_char_name" value="<?= htmlspecialchars($var2) ?>">
                            <button type="submit" class="action-button"
                                onclick="return confirm('Reset coordinates for ' + <?= json_encode($var2) ?> + ' to 0,0?')">
                                Set to 0,0
                            </button>
                        </form>
                        <form method="post" action="galaxy.php?planet=infos" style="margin:4px 0 0 0; white-space:nowrap;">
                            <input type="hidden" name="teleport_player_key" value="<?= htmlspecialchars($pk) ?>">
                            <?php
                                $coords = explode('_', $var4, 2);
                                $cur_x  = $coords[0] ?? '0';
                                $cur_y  = $coords[1] ?? '0';
                            ?>
                            <input name="tp_planet" value="<?= htmlspecialchars($var3) ?>" size="10" title="Planet">
                            X:<input name="tp_x" value="<?= htmlspecialchars($cur_x) ?>" size="3">
                            Y:<input name="tp_y" value="<?= htmlspecialchars($cur_y) ?>" size="3">
                            <button type="submit" class="action-button">Move</button>
                        </form>
                        <?php endif; ?>
                    </td>
                </tr>
                <?php
            }
        }
        ?>
    </table>
    <p class="nav-link"><a href="galaxy.php?planet=infos"><u>Actualise</u></a></p>

<?php elseif (substr($tiletype, 0, 1) === 'b' || substr($tiletype, 0, 1) === 's'): ?>

    <br>
    <div style="text-align:center;">
        <p><span class="lbl"><u><?= htmlspecialchars($planet) ?></u></span></p>
        <img src="<?= htmlspecialchars($tiletype) ?>.jpg" alt="<?= htmlspecialchars($planet) ?>">
    </div>

<?php else: ?>

    <?php
    $planetname = ($planet === 'Space') ? $system : $planet;
    $showAreas     = get_pw('ShowAreas');
    $showInterests = get_pw('ShowInterests');
    $showPlanets   = get_pw('ShowPlanets');

    if ($planet === 'Space') {
        $size = 30;
        $center = get_pw($system . 'SystemCenter');
        $sep    = strpos($center, '_');
        $sysx   = ($sep !== false) ? (int)substr($center, 0, $sep) : 0;
        $sysy   = ($sep !== false) ? (int)substr($center, $sep + 1) : 0;
        if ($sysx !== 0) $galaxyx = (int)($sysx / ($size / 2));
        if ($sysy !== 0) $galaxyy = (int)($sysy / ($size / 2));
    } else {
        $size = (int)encoded_field(get_pw($planet), 2);
    }
    $Y = (int)($size / 2) + 1;
    ?>

    <br>
    <div style="text-align:center;">
        <p><span class="lbl"><u><?= htmlspecialchars($planetname) ?></u></span></p>

    <?php if ($planet === 'Space'): ?>
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="33%"></td>
                <td width="34%" style="text-align:center;"><a href="galaxy.php?planet=Space&galaxyx=<?= $galaxyx ?>&galaxyy=<?= $galaxyy + 1 ?>"><img border="0" src="Arrow_N.gif" alt="North"></a></td>
                <td width="33%"></td>
            </tr><tr>
                <td width="33%" style="text-align:center;"><a href="galaxy.php?planet=Space&galaxyx=<?= $galaxyx - 1 ?>&galaxyy=<?= $galaxyy ?>"><img border="0" src="Arrow_W.gif" alt="West"></a></td>
                <td width="34%"></td>
                <td width="33%" style="text-align:center;"><a href="galaxy.php?planet=Space&galaxyx=<?= $galaxyx + 1 ?>&galaxyy=<?= $galaxyy ?>"><img border="0" src="Arrow_E.gif" alt="East"></a></td>
            </tr><tr>
                <td width="33%"></td>
                <td width="34%" style="text-align:center;"><a href="galaxy.php?planet=Space&galaxyx=<?= $galaxyx ?>&galaxyy=<?= $galaxyy - 1 ?>"><img border="0" src="Arrow_S.gif" alt="South"></a></td>
                <td width="33%"></td>
            </tr>
        </table>
    <?php else: ?>
        <table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;width:100%;">
            <tr>
                <td colspan="4" style="text-align:left;">
                    <p><span class="lbl"><u>Local informations</u> :</span></p>
                    <?php
                    $descr = str_replace('~', "'", encoded_field(get_pw($planet), 10));
                    if (empty($descr) || $descr === '0') $descr = 'no description';
                    ?>
                    <p><span class="val"><?= htmlspecialchars($descr) ?></span></p>
                </td>
            </tr>
            <tr>
                <td width="30%" valign="top">
                    <p><span class="lbl">Position :</span></p>
                    <p><span class="lbl">Level :</span></p>
                </td>
                <td width="30%" valign="top">
                    <?php
                    $position = encoded_field(get_pw($planet), 1);
                    $level    = encoded_field(get_pw($planet), 9);
                    if (empty($level)) $level = 'unknown';
                    ?>
                    <p><span class="val"><?= htmlspecialchars($position) ?></span></p>
                    <p><span class="val"><?= htmlspecialchars($level) ?></span></p>
                </td>
                <td width="20%" valign="top">
                    <p><span class="lbl">Time :</span></p>
                    <p><span class="lbl">Weather :</span></p>
                </td>
                <td width="20%" valign="top">
                    <?php
                    $cal  = get_pw('Calendar');
                    $hour = (int)between($cal, '/C3/', '/C4/');
                    if ($hour >= 8 && $hour <= 20) {
                        echo '<img src="time_day.gif" alt="Day">';
                    } else {
                        echo '<img src="time_night.gif" alt="Night">';
                    }
                    $weather_icons = ['0' => 'clear', '1' => 'rain', '2' => 'snow', '3' => 'fog', '4' => 'storm'];
                    $weather = encoded_field(get_pw($planet), 11);
                    $icon    = $weather_icons[$weather] ?? 'clear';
                    ?>
                    <br><br>
                    <img src="weather_<?= htmlspecialchars($icon) ?>.gif" alt="<?= ucfirst($icon) ?>">
                </td>
            </tr>
        </table>
    <?php endif; ?>

    <br>
    <table class="map-grid" border="1" cellpadding="0" cellspacing="0" bordercolor="#C0C0C0">
    <?php
    $tile_map = [
        '01' => 'clouds',    '02' => 'desert',    '03' => 'foothills', '04' => 'forest',
        '05' => 'frozenland','22' => 'gaz',        '06' => 'ground',    '07' => 'hills',
        '08' => 'moon',      '09' => 'mountain',   '10' => 'mountsnow', '11' => 'mounts',
        '12' => 'ocean',     '13' => 'plain',      '14' => 'river',     '15' => 'rural',
        '16' => 'ruralcastle','17' => 'ruralswamp','18' => 'seafloor',  '19' => 'snow',
        '20' => 'swamp',     '21' => 'tropical',
    ];
    $interest_map = ['D' => 'doma', '1' => 'town', '2' => 'dung', '3' => 'cast', '4' => 'ruin', '5' => 'anre', '6' => 'remo', '7' => 'amus'];
    $alt_map      = ['D' => 'Domain', '2' => 'Dungeon', '3' => 'Castle', '4' => 'Ruins', '5' => 'Animal reserve', '6' => 'Resource mountain', '7' => 'Amusement place'];
    $half         = (int)($size / 2);

    while ($Y > -($half + 1)) {
        echo '<tr>';
        if ($Y === $half + 1) {
            // Header row: column numbers
            echo '<td><img src="black.gif"></td>';
            for ($X = -$half; $X < $half + 1; $X++) {
                echo '<td style="background:#005064;text-align:center;">' . ($X + $galaxyx * 15) . '</td>';
            }
        } else {
            // Row label
            echo '<td style="background:#005064;text-align:center;">' . ($Y + $galaxyy * 15) . '</td>';

            for ($X = -$half; $X < $half + 1; $X++) {
                $XX = $X + $galaxyx * 15;
                $YY = $Y + $galaxyy * 15;

                $tile_col  = get_pw($planet . 'AreasX' . $XX);
                $curr_key  = '&' . tile_key($YY) . '&';
                $prev_key  = ($YY === -$half) ? '' : '&' . tile_key($YY - 1) . '&';
                $tiletype  = between($tile_col, $prev_key, $curr_key);

                $show = (substr($tiletype, -1) === '*');
                if ($show) $tiletype = substr($tiletype, 0, -1);
                if ($planet !== 'Space') $tiletype = $tile_map[$tiletype] ?? $tiletype;

                echo '<td class="map-tile">';

                $area_key  = str_replace('-', 'm', $XX . '_' . $YY);
                $interests = get_pw($planet . '&' . $area_key . '&Interests');
                $interest2 = substr(between($interests, '', '&1&'), 0, 1);
                $iname     = between($interests, '&1&', '&2&');
                $visible   = between($interests, '&3&', '&4&');

                if ($visible == 0 && !$is_dm) $interest2 = '';

                $space_data  = get_pw('Space' . $area_key);
                $planet_show = between($space_data, '&004&', '&005&');
                $show2       = get_pw('Space' . $area_key . 'Show');

                $alt = $area_key . ' : ' . ucwords($tiletype);
                if (strpos($tiletype, 'city') === 0) { $tiletype = 'city'; $alt = $area_key . ' : ' . $iname; }

                $tile_visible = !empty($tiletype) && ($is_dm || $show || $showAreas == 1 || ($showInterests == 1 && $interest2 !== ''));
                $space_visible = $planet === 'Space' && !empty($space_data) && ($is_dm || $planet_show == 1 || $show2 == 1);

                if ($tile_visible || $space_visible) {
                    if ($planet === 'Space') {
                        if (!empty($space_data)) {
                            $iname    = between($space_data, '', '&001&');
                            $tiletype = between($space_data, '&003&', '&004&');
                            $alt      = $area_key . ' : ' . $iname;
                        } else {
                            $tiletype = 'space';
                        }
                        $tiletype2 = $tiletype;
                    } else {
                        if (isset($interest_map[$interest2])) {
                            $display_name = ($interest2 === '1') ? $iname : ($alt_map[$interest2] ?? $interest2);
                            $alt          = $area_key . ' : ' . $display_name;
                            $tiletype2    = $tiletype . '_' . $interest_map[$interest2];
                        } else {
                            $tiletype2 = $tiletype;
                        }
                    }

                    $href = '';
                    if ($tiletype === 'city' || (ctype_digit($interest2) && $interest2 > 0) || $interest2 === 'D') {
                        $href = 'interests.php?planet=' . urlencode($planet) . '&area=' . urlencode($area_key) . '&galaxyx=' . $galaxyx . '&galaxyy=' . $galaxyy;
                    } elseif ($planet === 'Space' && $tiletype !== '') {
                        $href = 'galaxy.php?planet=' . urlencode($iname) . '&galaxyx=' . $galaxyx . '&galaxyy=' . $galaxyy;
                    }

                    $img = '<img src="' . htmlspecialchars($tiletype2) . '.gif" alt="' . htmlspecialchars($alt) . '">';
                    if ($href !== '') {
                        echo '<a title="' . htmlspecialchars($alt) . '" href="' . htmlspecialchars($href) . '">' . $img . '</a>';
                    } else {
                        echo $img;
                    }
                }
                echo '</td>';
            }
        }
        echo '</tr>';
        $Y--;
    }
    ?>
    </table>
    </div>
    <br><br>
<?php endif; ?>

<?php mysqli_close($link); ?>
</body>
</html>
