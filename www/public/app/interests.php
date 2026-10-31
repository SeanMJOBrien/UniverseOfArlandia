<?php
session_start();

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include('uoa.php');
include('helpers.php');
include('player_auth.php');

$is_dm = $_SESSION['is_dm'] ?? false;

mysqli_report(MYSQLI_REPORT_OFF); // mysqli_connect() must return false, not throw, on failure
$link = @mysqli_connect($host, $user, $pass, $data, (int)$port);
if (!$link) { die('service offline'); }

$galaxyx = (int)($_GET['galaxyx'] ?? 0);
$galaxyy = (int)($_GET['galaxyy'] ?? 0);
$planet  = $_GET['planet'] ?? '';
$area    = $_GET['area']   ?? '';

// Same visibility rule as the map itself: a detail page must not be readable
// by URL for a tile the viewer has not discovered.
$area_coord = str_replace('m', '-', $area);   // "m3_5" -> "-3_5"
$player_tiles = player_is_logged_in()
    ? player_discovered_tiles($link, player_cdkey(), $planet)
    : [];
$area_discovered = isset($player_tiles[$area_coord]);
$area_readable   = $is_dm || $area_discovered || pw_value($link, 'ShowAreas') == 1;

// Fetch the primary interest record
$stmt = mysqli_prepare($link, "SELECT val FROM pwdata WHERE player='~' AND tag='uoa' AND name=?");
$key = $planet . '&' . $area . '&Interests';
mysqli_stmt_bind_param($stmt, 's', $key);
mysqli_stmt_execute($stmt);
$row      = mysqli_fetch_assoc(mysqli_stmt_get_result($stmt));
$interest = str_replace('~', "'", $row['val'] ?? '');

$inttype = substr($interest, 0, 1);
$name    = between($interest, '&1&', '&2&');
$var     = between($interest, '&2&', '&3&');

$title_map = ['D' => 'Domain', '1' => $name, '2' => 'Dungeon', '3' => 'Castle', '4' => 'Ruins', '5' => 'Animal reserve', '6' => 'Resource mountain', '7' => 'Amusement place'];
$title = $title_map[$inttype] ?? 'Interest';

// Shared link parameters
$back_params   = http_build_query(['planet' => $planet, 'area' => $area, 'galaxyx' => $galaxyx, 'galaxyy' => $galaxyy]);
$map_url       = 'galaxy.php?'    . $back_params;
$refresh_url   = 'interests.php?' . $back_params;

if (!$area_readable) {
    mysqli_close($link);
    http_response_code(403);
    ?>
    <!DOCTYPE html>
    <html lang="fr-CH">
    <head>
        <meta charset="UTF-8">
        <title>Undiscovered area - UOA</title>
        <style>
            body {
                margin: 0; padding: 40px 30px;
                background-image: url('assets/UOA_BG2.jpg');
                color: #FFFFFF; font-family: Arial, sans-serif; text-align: center;
            }
            a { color: #00FFFF; }
            .lbl { color: #66CCFF; font-weight: bold; }
            code { color: #FFC800; }
        </style>
    </head>
    <body>
        <p class="lbl" data-testid="interest-undiscovered">You have not discovered this area yet.</p>
        <?php if (!player_is_logged_in()): ?>
            <p>
                <a target="_top" href="../index.php">Log in</a> with your CD key, or
                <a target="_top" href="register.php">register</a> — type <code>.web</code> in game for your code.
            </p>
        <?php endif; ?>
        <p><a href="<?= htmlspecialchars($map_url) ?>">back to map</a></p>
    </body>
    </html>
    <?php
    exit;
}
?>
<!DOCTYPE html>
<html lang="fr-CH">
<head>
    <meta charset="UTF-8">
    <title><?= htmlspecialchars($title) ?> - UOA</title>
    <style>
        body {
            margin: 0;
            padding: 0 30px;
            background-image: url('assets/UOA_BG2.jpg');
            color: #FFFFFF;
            font-family: Arial, sans-serif;
        }
        a { color: #FFFFFF; }
        a:hover { color: #00FF00; }

        table.info-table {
            border-collapse: collapse;
            border: 1px solid #404040;
            width: 100%;
            margin-bottom: 20px;
        }
        table.info-table td {
            padding: 10px;
            vertical-align: top;
            border: 1px solid #404040;
            font-size: 1.05em;
        }
        .lbl  { color: #66CCFF; font-weight: bold; }
        .val  { color: #FFC800; font-weight: bold; }
        .ok   { color: #00FF00; font-weight: bold; }
        .warn { color: #FFFF00; font-weight: bold; }
        .empty{ color: #FF0000; font-weight: bold; }
        .page-title { text-align: center; }
        .nav-bar { text-align: right; font-weight: bold; }
    </style>
</head>
<body>
<br>
<h2 class="page-title lbl"><u><?= htmlspecialchars($title) ?> informations</u></h2>

<p class="nav-bar">
    <u><a href="<?= htmlspecialchars($refresh_url) ?>">actualise</a></u> -
    <u><a href="<?= htmlspecialchars($map_url) ?>">back to map</a></u>
</p>

<table class="info-table">
    <tr>
        <td>
            <span class="lbl">Planet :</span> <span class="val"><?= htmlspecialchars($planet) ?></span><br><br>
            <span class="lbl">Area :</span> <span class="val"><?= htmlspecialchars($area) ?></span>
        </td>
    </tr>
</table>

<?php if ($inttype === 'D'): ?>
    <?php
    // Parse domain sector structure fields (_01_ through _11_ delimited)
    $fields = [];
    for ($i = 1; $i <= 11; $i++) {
        $curr = '_' . str_pad($i, 2, '0', STR_PAD_LEFT) . '_';
        $prev = $i > 1 ? '_' . str_pad($i - 1, 2, '0', STR_PAD_LEFT) . '_' : '';
        $fields[$i] = between($var, $prev, $curr);  // raw, untrimmed
    }
    // Field 8: mailbox flag is the last char before it is trimmed to '%'
    $var8b = substr($fields[8], -1);
    // Fields 1–10: trim to the '%' separator; field 11 (description) is not trimmed
    $levels = [];
    for ($i = 1; $i <= 10; $i++) {
        $pct = strpos($fields[$i], '%');
        $levels[$i] = $pct !== false ? (int)substr($fields[$i], $pct + 1) : 0;
        if ($pct !== false) $fields[$i] = substr($fields[$i], 0, $pct);
    }
    $var11 = $fields[11];

    // Classify sectors
    $primary = $secondary = $tertiary = 0;
    for ($i = 1; $i <= 10; $i++) {
        $s = (int)$fields[$i];
        if (in_array($s, [5, 7, 8, 21])) $primary++;
        elseif ($s === 6) $secondary++;
        elseif ($s !== 0) $tertiary++;
    }
    $sector_parts = [];
    if ($primary)   $sector_parts[] = 'Primary';
    if ($secondary) $sector_parts[] = 'Secondary';
    if ($tertiary)  $sector_parts[] = 'Tertiary';
    $sectors = implode(', ', $sector_parts) ?: '—';

    $var8b = substr($fields[8], -1);
    ?>
    <table class="info-table">
        <tr>
            <td colspan="2">
                <span class="lbl">Domain owner :</span> <span class="val"><?= htmlspecialchars($name) ?></span><br>
                <span class="lbl">Domain sectors :</span> <span class="val"><?= htmlspecialchars($sectors) ?></span>
            </td>
        </tr>
        <tr>
            <td width="30%"><span class="lbl">Domain description :</span></td>
            <td width="70%"><span class="ok"><?= htmlspecialchars($var11) ?></span></td>
        </tr>
    </table>

    <?php
    // What the structures in this domain offer to players. Slot 5 is always the
    // central place, slot 8 the entry (with the mailbox) and slot 10 the walls;
    // the other slots hold one of the buildings below. The access wording follows
    // the module: producers and the casern answer to the owner and the players
    // the owner approved (.wgrant); houses are rented by visitors; the rest are
    // described in game as open to adventurers.
    $structures = [
        1  => ['Airship station',   'public', 'Travel to other cities and towns.'],
        2  => ['Amusement place',   'public', 'Somewhere for the domain\'s people to have fun.'],
        3  => ['Casern',            'owner',  'Produces henchmen for the owner.'],
        4  => ['Dungeon',           'public', 'A fortified place for adventurers.'],
        5  => ['Extractor',         'owner',  'Gathers rock resources from the planet.'],
        6  => ['Factory',           'owner',  'Crafts resources and items into new items.'],
        7  => ['Farm',              'owner',  'Raises livestock.'],
        8  => ['Field',             'owner',  'Grows plant resources.'],
        9  => ['Guild hall',        'public', 'Players can join the guild here.'],
        10 => ['Hall',              'owner',  'The political and economic centre of the domain.'],
        11 => ['House',             'rent',   'Visitors can rent it.'],
        12 => ['Inn',               'public', 'A resting place for adventurers.'],
        13 => ['Mission office',    'public', 'Jobs and missions.'],
        14 => ['Personal house',    'owner',  'The home of the domain holder.'],
        15 => ['School',            'public', 'Players learn or teach here.'],
        16 => ['Shop',              'public', 'A special shop.'],
        17 => ['Starship station',  'public', 'Travel to other planets.'],
        18 => ['Tavern',            'public', 'A refreshing place for adventurers.'],
        19 => ['Temple',            'public', 'A special shop for monks and clerics.'],
        20 => ['Tower',             'public', 'Content like a dungeon, for adventurers.'],
        21 => ['Sawmill',           'owner',  'Cuts trees from the planet.'],
    ];
    $access_text = [
        'public' => ['Open to all players', 'ok'],
        'rent'   => ['For rent', 'warn'],
        'owner'  => ['Owner and approved users only', 'val'],
        'passive' => ['Not interactive', 'lbl'],
    ];
    $fixed_slots = [
        5  => ['Central place', 'public', 'A relaxing place for everyone in the domain.'],
        8  => ['Entry', 'public', 'The way into the domain; holds the mailbox.'],
        10 => ['Walls', 'passive', 'Protect the domain from outside danger.'],
    ];
    $cal = pw_value($link, 'Calendar');
    $today = 0;
    if (preg_match('~^(\d+)/C1/(\d+)/C2/(\d+)/C3/~', $cal, $cm)) {
        $today = ((((int)$cm[1] * 12) + ((int)$cm[2] - 1)) * 28) + (int)$cm[3];
    }
    $features = [];
    for ($i = 1; $i <= 10; $i++) {
        $code = (int)$fields[$i];
        if ($code === 0) continue;
        $info = $fixed_slots[$i] ?? ($structures[$code] ?? null);
        if ($info === null) continue;
        $note = $info[2];
        $access = $info[1];
        if ($info[0] === 'House') {
            $tenant = pw_value($link, $planet . '&' . $area . '&Domain&' . $i);
            if ($tenant === '') {
                $note = 'Free to rent.';
            } else {
                $access = 'owner';
                $until = (int)pw_value($link, $planet . '&' . $area . '&Domain&' . $i . 'Until');
                $note = 'Rented by ' . str_replace('~', "'", $tenant);
                if ($until > 0 && $today > 0) {
                    $left = $until - $today;
                    $note .= $left >= 0 ? ', ' . $left . ' game day(s) of rent left.' : ', rent overdue.';
                } else {
                    $note .= '.';
                }
            }
        }
        $features[] = ['name' => $info[0], 'level' => $levels[$i], 'access' => $access, 'note' => $note];
    }
    ?>
    <table class="info-table">
        <tr>
            <td colspan="3"><span class="lbl">What this domain offers :</span></td>
        </tr>
        <?php if (!$features): ?>
        <tr><td colspan="3"><span class="val">Nothing built yet.</span></td></tr>
        <?php endif; ?>
        <?php foreach ($features as $f):
            $a = $f['access'] === 'owner' && $f['name'] === 'House' ? ['Rented', 'val'] : ($access_text[$f['access']] ?? ['', 'val']); ?>
        <tr>
            <td width="22%"><span class="ok"><?= htmlspecialchars($f['name']) ?></span><?= $f['level'] > 0 ? ' <span class="lbl">level ' . (int)$f['level'] . '</span>' : '' ?></td>
            <td width="26%"><span class="<?= $a[1] ?>"><?= htmlspecialchars($a[0]) ?></span></td>
            <td><?= htmlspecialchars($f['note']) ?></td>
        </tr>
        <?php endforeach; ?>
    </table>

    <?php if ($var8b > 2):
        $mail_key = $planet . '&' . $area . '&Mailbox';
        mysqli_stmt_bind_param($stmt, 's', $mail_key);
        mysqli_stmt_execute($stmt);
        $mail_row = mysqli_fetch_assoc(mysqli_stmt_get_result($stmt));
        $mailbox  = $mail_row['val'] ?? '';
    ?>
    <table class="info-table">
        <tr>
            <td>
                <span class="lbl">Mailbox :</span>
                <?php if (empty($mailbox) || $mailbox === '0'): ?>
                    <span class="val">empty</span>
                <?php else: ?>
                    <span class="ok">mail</span>
                <?php endif; ?>
            </td>
        </tr>
    </table>
    <?php endif; ?>

<?php elseif ($inttype === '1'): ?>
    <?php
    $shop_labels = [
        '000' => 'Player Shop', '001' => 'General Shop', '002' => 'Weaponsmith',
        '003' => 'Armorsmith',  '004' => 'Arcane shop',  '005' => 'Alchemist shop',
        '006' => 'Jeweler',     '007' => 'Rogue shop',   '008' => 'Tailor',
        '009' => 'Library',     '010' => 'Bank',          '011' => 'Animal shop',
        '012' => 'Blacksmith',  '013' => 'Tavern',        '014' => 'Inn',
        '015' => 'Temple',      '016' => 'Architect',     '017' => 'Trainer',
    ];
    $shop_type = $shop_labels[$var] ?? $var;

    // Fetch all player shop items in one query
    $shop_items = [];
    $like = $planet . '&' . $area . '&SaleShop%';
    mysqli_stmt_bind_param($stmt, 's', $like);
    mysqli_stmt_execute($stmt);
    $res = mysqli_stmt_get_result($stmt);
    while ($row = mysqli_fetch_assoc($res)) {
        $data = str_replace('~', "'", $row['val']);
        $tot  = (int)substr($data, -4, 3);
        for ($iT = 1; $iT <= $tot; $iT++) {
            $curr_t = '&' . str_pad($iT, 3, '0', STR_PAD_LEFT) . '&';
            $prev_t = $iT > 1 ? '&' . str_pad($iT - 1, 3, '0', STR_PAD_LEFT) . '&' : '';
            $entry  = between($data, $prev_t, $curr_t);
            $item_name  = between($entry, '_B_', '_C_');
            $item_master = between($entry, '_D_', '_E_');
            $item_value = (int)between($entry, '_J_', '_K_');
            $item_wear  = between($entry, '_F_', '_G_');
            if ($item_value < 1) $item_value = 1;
            $shop_items[] = ['name' => $item_name, 'master' => $item_master, 'value' => $item_value, 'wear' => $item_wear];
        }
    }
    usort($shop_items, fn($a, $b) => strcmp($a['name'], $b['name']));
    ?>
    <table class="info-table">
        <tr>
            <td colspan="2">
                <span class="lbl">Special shop :</span> <span class="val"><?= htmlspecialchars($shop_type) ?></span>
            </td>
        </tr>
        <tr>
            <td width="30%"><span class="lbl">Local player shop :</span></td>
            <td width="70%">
                <?php foreach ($shop_items as $item): ?>
                    <span class="ok"><?= htmlspecialchars($item['name']) ?></span>
                    <span class="lbl">(</span>
                    <span class="val"><?= (int)$item['value'] ?></span>
                    <span class="lbl">GP /</span>
                    <span class="val"><?= htmlspecialchars($item['wear']) ?></span>
                    <span class="lbl">% / sold by</span>
                    <span class="val"><?= htmlspecialchars($item['master']) ?></span>
                    <span class="lbl">)</span><br>
                <?php endforeach; ?>
            </td>
        </tr>
    </table>

    <table class="info-table">
        <tr>
            <td width="30%"><span class="lbl">Local message board :</span></td>
            <td width="70%">
                <?php
                // Global (DH) board messages
                $like = $planet . '&DHBoard%';
                mysqli_stmt_bind_param($stmt, 's', $like);
                mysqli_stmt_execute($stmt);
                $res = mysqli_stmt_get_result($stmt);
                while ($row = mysqli_fetch_assoc($res)) {
                    $all     = str_replace('~', "'", $row['val']);
                    $author  = between($all, '',     '_A_');
                    $btitle  = between($all, '_A_',  '_B_');
                    $message = between($all, '_B_',  '');
                    ?>
                    <span class="empty"><u><?= htmlspecialchars($btitle) ?></u></span>
                    <span class="lbl">(posted by <span class="empty"><?= htmlspecialchars($author) ?></span>) :</span><br>
                    <span class="empty"><?= htmlspecialchars($message) ?></span><br><br>
                    <?php
                }

                // Local board messages
                $like = $planet . '&' . $area . '&Board%';
                mysqli_stmt_bind_param($stmt, 's', $like);
                mysqli_stmt_execute($stmt);
                $res = mysqli_stmt_get_result($stmt);
                while ($row = mysqli_fetch_assoc($res)) {
                    $all     = str_replace('~', "'", $row['val']);
                    $author  = between($all, '',    '_A_');
                    $btitle  = between($all, '_A_', '_B_');
                    $message = between($all, '_B_', '');
                    ?>
                    <span class="val"><u><?= htmlspecialchars($btitle) ?></u></span>
                    <span class="lbl">(posted by <span class="val"><?= htmlspecialchars($author) ?></span>) :</span><br>
                    <span class="ok"><?= htmlspecialchars($message) ?></span><br><br>
                    <?php
                }
                ?>
            </td>
        </tr>
    </table>

<?php elseif ($inttype === '2'): ?>
    <?php
    $dungeon_raw = between($interest, '', '&1&');
    $dungeontype = (int)between($dungeon_raw, '_A_', '_B_');
    $type_names  = [1 => 'Temple', 2 => 'Cave', 3 => 'Pyramid', 4 => 'Old Castle', 5 => 'Crypt', 6 => 'Tower', 7 => 'Tower', 8 => 'Underground dungeon'];
    $type_label  = $type_names[$dungeontype] ?? (string)$dungeontype;

    $dungeonfamily = between($dungeon_raw, '_C_', '_D_');
    if ($dungeonfamily == 1000 || $dungeonfamily === '') $dungeonfamily = 'None';
    if ($dungeonfamily === '0') $dungeonfamily = 'Unknown';

    $dungeonfull = (int)between($dungeon_raw, '_D_', '_E_');

    // Find dungeon completion data
    $count = 0; $check = 0;
    $like  = 'Dungeons%';
    mysqli_stmt_bind_param($stmt, 's', $like);
    mysqli_stmt_execute($stmt);
    $res = mysqli_stmt_get_result($stmt);
    while ($row = mysqli_fetch_assoc($res)) {
        $dplanet   = between($row['val'], '',    '_A_');
        $darea     = between($row['val'], '_A_', '_B_');
        $dremains  = between($row['val'], '_B_', '');
        if ($dplanet === $planet && $darea === $area) {
            $count = $dremains;
            $check = 1;
            break;
        }
    }

    if ($dungeonfamily === 'None') {
        $status_class = 'val'; $status = 'Empty';
    } elseif ($dungeonfamily === 'Unknown') {
        $status_class = 'val'; $status = 'Unknown';
    } elseif ($check > 0 && $count < 11) {
        $status_class = 'empty'; $status = 'Empty';
    } elseif ($check > 0 && $count < $dungeonfull - 10) {
        $status_class = 'warn'; $status = 'Started';
    } else {
        $status_class = 'ok'; $status = 'Full';
    }
    ?>
    <table class="info-table">
        <tr>
            <td colspan="2">
                <span class="lbl">Dungeon type :</span> <span class="val"><?= htmlspecialchars($type_label) ?></span><br><br>
                <span class="lbl">Dungeon monster family :</span> <span class="val"><?= htmlspecialchars($dungeonfamily) ?></span><br>
                <br>
                <span class="lbl">Dungeon statut :</span> <span class="<?= $status_class ?>"><?= htmlspecialchars($status) ?></span>
            </td>
        </tr>
    </table>

<?php elseif ($inttype === '5'): ?>
    <?php
    $animal_labels = [1 => 'Deers', 2 => 'Wild Angus', 3 => 'Badgers', 4 => 'Bears', 5 => 'Boars', 6 => 'Goats'];
    $pen_count = (int)between($interest, '_A_', '_B_');
    $pens = [];
    // Pen types live between _B_/_C_, _C_/_D_, ..., _F_/_G_ (one position ahead of count)
    for ($i = 1; $i <= 5; $i++) {
        $prev_delim = '_' . chr(ord('A') + $i) . '_';      // _B_, _C_, _D_, _E_, _F_
        $curr_delim = '_' . chr(ord('A') + $i + 1) . '_';  // _C_, _D_, _E_, _F_, _G_
        $raw = between($interest, $prev_delim, $curr_delim);
        $pens[$i] = substr($raw, 0, 1);
    }
    ?>
    <table class="info-table">
        <tr>
            <td colspan="2">
                <?php for ($i = 1; $i <= 5; $i++):
                    $code = (int)$pens[$i];
                    if ($i > $pen_count || $code === 0) {
                        $label = 'None'; $cls = 'empty';
                    } else {
                        $label = $animal_labels[$code] ?? 'Unknown'; $cls = 'val';
                    }
                ?>
                <span class="lbl">Pen <?= $i ?> :</span> <span class="<?= $cls ?>"><?= htmlspecialchars($label) ?></span><br>
                <?php endfor; ?>
            </td>
        </tr>
    </table>
<?php endif; ?>

<p class="nav-bar">
    <u><a href="<?= htmlspecialchars($refresh_url) ?>">actualise</a></u> -
    <u><a href="<?= htmlspecialchars($map_url) ?>">back to map</a></u>
</p>
<br>
<?php
mysqli_stmt_close($stmt);
mysqli_close($link);
?>
</body>
</html>
