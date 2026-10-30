<?php
/**
 * DM page: who rents what, where, for how much and until when.
 *
 * Two kinds of rental exist in the module, both stored in pwdata:
 *   - Domain houses (_domainuser.nss): "<planet>&<area>&Domain&<slot>" = tenant,
 *     "...Until" = the absolute game day the rent runs to.
 *   - Rental-door units (_unitrent.nss): "<area tag>&Unit&<x>_<y>&<n>" = tenant,
 *     "...Until" likewise, with the door's unit sizes in "<area tag>&Unit&<x>_<y>&Cfg".
 *
 * "Until" is a game day: ((year*12)+(month-1))*28+day, the same number
 * DomainGameDay() builds from the calendar. The calendar itself is saved in pwdata
 * as "Calendar" ("<year>/C1/<month>/C2/<day>/C3/<hour>/C4/"). Days left is
 * Until minus today; negative means the rent is overdue. A tenancy with no Until
 * yet has not started its clock (the module starts it the first time it looks).
 *
 * The rent amounts below are the defaults compiled into _module.nss
 * (iDomainHouseGP, iUnitRentSmall/Medium/Large, iDomainRentDays); keep them in
 * step if those change. Read only: nothing here writes to the database.
 */
require __DIR__ . '/dm_common.php';

$house_gp   = 500;                      // iDomainHouseGP
$unit_gp    = array(1 => 250, 2 => 500, 3 => 1000);   // iUnitRentSmall/Medium/Large
$unit_size  = array(1 => 'small', 2 => 'medium', 3 => 'large');
$rent_days  = 30;                       // iDomainRentDays

/** Every pwdata row whose name matches the regexp and whose value is not empty: name => val. */
function rentals_rows(mysqli $link, string $regexp): array {
    $stmt = mysqli_prepare($link, "SELECT name, val FROM pwdata WHERE player='~' AND tag='uoa' AND name REGEXP ? AND val <> ''");
    mysqli_stmt_bind_param($stmt, 's', $regexp);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $rows = array();
    while ($row = mysqli_fetch_assoc($result)) {
        $rows[$row['name']] = $row['val'];
    }
    return $rows;
}

/** Today's game day from the saved calendar, or 0 when it is not there. */
function rentals_today(mysqli $link): int {
    $cal = dm_pw_get($link, 'Calendar');
    if (!preg_match('~^(\d+)/C1/(\d+)/C2/(\d+)/C3/~', $cal, $m)) return 0;
    return ((((int)$m[1] * 12) + ((int)$m[2] - 1)) * 28) + (int)$m[3];
}

/** "3 days left", "overdue by 2 days" or "clock not started". */
function rentals_left(int $until, int $today): array {
    if ($until <= 0)  return array('clock not started', 'quiet', 0);
    if ($today <= 0)  return array('game day: ' . $until, 'quiet', 0);
    $left = $until - $today;
    if ($left < 0)    return array('overdue by ' . (-$left) . ' day(s)', 'warn', $left);
    return array($left . ' day(s) left', $left <= 3 ? 'warn' : 'ok', $left);
}

$today = rentals_today($link);
$filter = trim((string)($_GET['q'] ?? ''));
$rentals = array();

// Domain houses.
$houses = rentals_rows($link, '&Domain&[0-9]+$');
foreach ($houses as $key => $tenant) {
    if (!preg_match('~^(.+)&(.+)&Domain&(\d+)$~', $key, $m)) continue;
    $owner_rec = dm_pw_get($link, $m[1] . '&' . $m[2] . '&Interests');
    $owner = '';
    if (preg_match('~&1&(.*?)&2&~', $owner_rec, $om)) $owner = $om[1];
    $until = (int)dm_pw_get($link, $key . 'Until');
    $rentals[] = array(
        'kind' => 'House', 'tenant' => $tenant,
        'where' => $m[1] . ' ' . str_replace('m', '-', $m[2]),
        'detail' => 'slot ' . $m[3] . ($owner !== '' ? ', domain of ' . $owner : ''),
        'gp' => $house_gp, 'until' => $until,
    );
}

// Rental-door units.
$units = rentals_rows($link, '&Unit&-?[0-9]+_-?[0-9]+&[0-9]+$');
foreach ($units as $key => $tenant) {
    if (!preg_match('~^(.+&Unit&-?\d+_-?\d+)&(\d+)$~', $key, $m)) continue;
    $door = $m[1];
    $number = (int)$m[2];
    $size = 1;
    $cfg = dm_pw_get($link, $door . '&Cfg');          // "6&1,1,1,1,3,1"
    if (preg_match('~^\d+&(.*)$~', $cfg, $cm)) {
        $sizes = explode(',', $cm[1]);
        if (isset($sizes[$number - 1]) && isset($unit_gp[(int)$sizes[$number - 1]])) $size = (int)$sizes[$number - 1];
    }
    $until = (int)dm_pw_get($link, $key . 'Until');
    $pos = strpos($door, '&Unit&');
    $rentals[] = array(
        'kind' => 'Unit', 'tenant' => $tenant,
        'where' => substr($door, 0, $pos) . ' (door ' . substr($door, $pos + 6) . ')',
        'detail' => 'unit ' . $number . ', ' . $unit_size[$size],
        'gp' => $unit_gp[$size], 'until' => $until,
    );
}

if ($filter !== '') {
    $rentals = array_values(array_filter($rentals, function ($r) use ($filter) {
        return stripos($r['tenant'], $filter) !== false || stripos($r['where'], $filter) !== false;
    }));
}
usort($rentals, function ($a, $b) {
    $c = strcasecmp($a['tenant'], $b['tenant']);
    return $c !== 0 ? $c : strcmp($a['where'], $b['where']);
});

$overdue = 0; $total_gp = 0;
foreach ($rentals as $r) {
    $total_gp += $r['gp'];
    $left = rentals_left($r['until'], $today);
    if ($left[2] < 0) $overdue++;
}

dm_page_start('Rentals');
?>
<div class="panel">
<form method="get" style="display:flex;gap:10px;align-items:end;flex-wrap:wrap">
<label>Tenant or place<input name="q" value="<?= h($filter) ?>"></label>
<button type="submit">Filter</button>
<?php if ($filter !== ''): ?><a href="dm_rentals.php">Clear</a><?php endif; ?>
</form>
<p class="quiet">
<?= count($rentals) ?> rental(s)<?= $filter !== '' ? ' matching &ldquo;' . h($filter) . '&rdquo;' : '' ?>,
<?= $overdue ?> overdue, <?= $total_gp ?> GP per rent period of <?= (int)$rent_days ?> game days.
<?= $today > 0 ? 'Today is game day ' . $today . '.' : 'The game calendar is not in the database yet, so days left cannot be worked out.' ?>
</p>
</div>

<div class="panel scroll">
<?php if (!$rentals): ?>
<p class="quiet">No rentals found.</p>
<?php else: ?>
<table>
<tr><th>Tenant</th><th>Type</th><th>Where</th><th>Detail</th><th>Rent per period</th><th>Time</th></tr>
<?php foreach ($rentals as $r):
    $left = rentals_left($r['until'], $today); ?>
<tr>
<td><b><?= h($r['tenant']) ?></b></td>
<td><?= h($r['kind']) ?></td>
<td><?= h($r['where']) ?></td>
<td class="quiet"><?= h($r['detail']) ?></td>
<td><?= (int)$r['gp'] ?> GP</td>
<td class="<?= h($left[1]) ?>"><?= h($left[0]) ?></td>
</tr>
<?php endforeach; ?>
</table>
<?php endif; ?>
</div>
<p class="quiet">Rent amounts are the defaults in <code>_module.nss</code> (house <?= (int)$house_gp ?> GP; units <?= (int)$unit_gp[1] ?>/<?= (int)$unit_gp[2] ?>/<?= (int)$unit_gp[3] ?> GP by size). Game days run 28 to a month, 12 months to a year.</p>
<?php dm_page_end();
