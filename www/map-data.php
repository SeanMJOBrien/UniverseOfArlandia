<?php
session_start();

include('uoa.php');
include('helpers.php');

$is_dm = $_SESSION['is_dm'] ?? false;

mysqli_report(MYSQLI_REPORT_OFF); // mysqli_connect() must return false, not throw, on failure
$link = @mysqli_connect($host, $user, $pass, $data, (int)($port ?? 3306));
if (!$link) {
    http_response_code(503);
    header('Content-Type: application/json');
    echo json_encode(['error' => 'service offline']);
    exit;
}

$planet  = $_GET['planet'] ?? '';
$cx      = (int)($_GET['cx'] ?? 0);
$cy      = (int)($_GET['cy'] ?? 0);

if ($planet === '' || $planet === 'infos') {
    http_response_code(400);
    header('Content-Type: application/json');
    echo json_encode(['error' => 'invalid planet']);
    mysqli_close($link);
    exit;
}

$pwdata_cache = [];
if ($planet === 'Space') {
    $stmt = mysqli_prepare($link,
        "SELECT name, val FROM pwdata
         WHERE player='~' AND tag='uoa'
           AND (name IN ('ShowAreas','ShowInterests') OR name LIKE 'Space%')");
    mysqli_stmt_execute($stmt);
    $res = mysqli_stmt_get_result($stmt);
} else {
    $stmt = mysqli_prepare($link,
        "SELECT name, val FROM pwdata
         WHERE player='~' AND tag='uoa'
           AND (name IN ('ShowAreas','ShowInterests',?)
                OR name LIKE ?
                OR name LIKE ?)");
    $areasX    = $planet . 'AreasX%';
    $interests = $planet . '&%&Interests';
    mysqli_stmt_bind_param($stmt, 'sss', $planet, $areasX, $interests);
    mysqli_stmt_execute($stmt);
    $res = mysqli_stmt_get_result($stmt);
}
while ($row = mysqli_fetch_assoc($res)) {
    $pwdata_cache[$row['name']] = $row['val'];
}
mysqli_close($link);

function get_pw(string $key): string {
    global $pwdata_cache;
    return $pwdata_cache[$key] ?? '';
}

$showAreas     = get_pw('ShowAreas');
$showInterests = get_pw('ShowInterests');

if ($planet === 'Space') {
    $size = 30;
} else {
    $size = (int)encoded_field(get_pw($planet), 2);
    if ($size <= 0) {
        http_response_code(404);
        header('Content-Type: application/json');
        echo json_encode(['error' => 'planet not found']);
        exit;
    }
}
$half = (int)($size / 2);

$tile_map = [
    '01' => 'clouds',    '02' => 'desert',    '03' => 'foothills', '04' => 'forest',
    '05' => 'frozenland','22' => 'gaz',        '06' => 'ground',    '07' => 'hills',
    '08' => 'moon',      '09' => 'mountain',   '10' => 'mountsnow', '11' => 'mounts',
    '12' => 'ocean',     '13' => 'plain',      '14' => 'river',     '15' => 'rural',
    '16' => 'ruralcastle','17' => 'ruralswamp','18' => 'seafloor',  '19' => 'snow',
    '20' => 'swamp',     '21' => 'tropical',
];
$interest_map = ['D' => 'doma', '1' => 'town', '2' => 'dung', '3' => 'cast', '4' => 'ruin', '5' => 'anre', '6' => 'remo', '7' => 'amus'];

$tiles = [];
for ($Y = $half; $Y >= -$half; $Y--) {
    for ($X = -$half; $X <= $half; $X++) {
        $XX = $X + $cx * 15;
        $YY = $Y + $cy * 15;

        $tile_col  = get_pw($planet . 'AreasX' . $XX);
        $curr_key  = '&' . tile_key($YY) . '&';
        $prev_key  = ($YY === -$half) ? '' : '&' . tile_key($YY - 1) . '&';
        $tiletype  = between($tile_col, $prev_key, $curr_key);

        $discovered = (substr($tiletype, -1) === '*');
        if ($discovered) $tiletype = substr($tiletype, 0, -1);
        if ($planet !== 'Space') $tiletype = $tile_map[$tiletype] ?? $tiletype;

        $area_key  = str_replace('-', 'm', $XX . '_' . $YY);
        $interests = get_pw($planet . '&' . $area_key . '&Interests');
        $interest2 = substr(between($interests, '', '&1&'), 0, 1);
        $iname     = between($interests, '&1&', '&2&');
        $visible   = between($interests, '&3&', '&4&');

        if ($visible == 0 && !$is_dm) $interest2 = '';

        $space_data  = '';
        $planet_show = '';
        $show2       = '';
        if ($planet === 'Space') {
            $space_data  = get_pw('Space' . $area_key);
            $planet_show = between($space_data, '&004&', '&005&');
            $show2       = get_pw('Space' . $area_key . 'Show');
        }

        $tile_visible  = !empty($tiletype) && ($is_dm || $discovered || $showAreas == 1 || ($showInterests == 1 && $interest2 !== ''));
        $space_visible = $planet === 'Space' && !empty($space_data) && ($is_dm || $planet_show == 1 || $show2 == 1);

        $href = '';
        if ($tile_visible || $space_visible) {
            if ($tiletype === 'city' || (ctype_digit($interest2) && $interest2 > 0) || $interest2 === 'D') {
                $href = 'interests.php?planet=' . urlencode($planet) . '&area=' . urlencode($area_key) . '&galaxyx=' . $cx . '&galaxyy=' . $cy;
            } elseif ($planet === 'Space' && !empty($space_data)) {
                $space_name = between($space_data, '', '&001&');
                $href = 'galaxy.php?planet=' . urlencode($space_name) . '&galaxyx=' . $cx . '&galaxyy=' . $cy;
            }
        }

        $tile_shown = $tile_visible || $space_visible;
        $tiles[] = [
            'x'          => $XX,
            'y'          => $YY,
            'terrain'    => $tile_shown ? $tiletype : '',
            'discovered' => $discovered,
            'interest'   => $tile_shown ? (isset($interest_map[$interest2]) ? $interest_map[$interest2] : '') : '',
            'iname'      => $tile_shown ? $iname : '',
            'visible'    => $tile_shown,
            'href'       => $href,
        ];
    }
}

header('Content-Type: application/json');
echo json_encode([
    'planet' => $planet,
    'size'   => $size,
    'cx'     => $cx,
    'cy'     => $cy,
    'tiles'  => $tiles,
]);
