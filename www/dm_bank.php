<?php
/**
 * DM page: bank interest, investment terms and the account price.
 *
 * Values are stored as BankSetting_<name> rows in pwdata. The module (_bank.nss)
 * reads them each time an account is opened, so a change applies from the next
 * account opened with no restart. A running investment keeps the rate and term
 * it was bought with. A setting never saved falls back to the compiled default
 * in _module.nss; the defaults below must match it.
 */
require __DIR__ . '/dm_common.php';

// name => [label, unit, default, min, max, step, scale (stored = shown * scale), help]
$settings = [
    'normal10' => ['Normal account interest', '% per month', 2, 0, 10, 0.1, 10, 'Added daily on the holder\'s online time. Rounding is carried, so small balances grow.'],
    'price'    => ['Account price', 'GP', 100, 0, 10000, 50, 1, 'Charged when a player opens an account on a planet.'],
    'rate10'   => ['Investment interest', '% per month', 3, 0, 20, 0.1, 10, 'Paid once at the end of the term, compounded daily over it.'],
    'month'    => ['Bank days in a month', 'bank days', 28, 7, 60, 1, 1, 'Turns both monthly rates into daily ones. One bank day is 576 ticks, about 58 minutes online.'],
    'term'     => ['Investment term', 'bank days', 20, 1, 90, 1, 1, 'How long an investment is locked. Running investments keep their term.'],
    'open'     => ['Investments open to new deposits', '1 = open, 0 = closed', 1, 0, 1, 1, 1, 'Closing it stops new deposits only. Existing investments can still be collected.'],
];

function bank_current(mysqli $link, string $key, array $spec): float {
    $saved = dm_pw_get($link, 'BankSetting_' . $key);
    if ($saved === '') return (float)$spec[2];
    return (float)$saved / $spec[6];
}

$messages = [];
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!csrf_verify()) {
        $messages[] = ['warn', 'The form expired. Reload the page and try again.'];
    } else {
        foreach ($settings as $key => $spec) {
            if (!isset($_POST[$key])) continue;
            $raw = trim((string)$_POST[$key]);
            if ($raw === '' || !is_numeric($raw)) { $messages[] = ['warn', $spec[0] . ' must be a number.']; continue; }
            $value = (float)$raw;
            if ($value < $spec[3] || $value > $spec[4]) {
                $messages[] = ['warn', $spec[0] . ' must be between ' . $spec[3] . ' and ' . $spec[4] . '.'];
                continue;
            }
            $stored = (int)round($value * $spec[6]);
            $before = bank_current($link, $key, $spec);
            if (abs($before - $stored / $spec[6]) < 0.0001) continue;
            dm_pw_set($link, 'BankSetting_' . $key, (string)$stored);
            dm_audit($link, 'bank_setting', $spec[0] . ': ' . $before . ' to ' . ($stored / $spec[6]) . ' ' . $spec[1]);
            $messages[] = ['ok', $spec[0] . ' changed from ' . $before . ' to ' . ($stored / $spec[6]) . '.'];
        }
        if (!$messages) $messages[] = ['quiet', 'Nothing changed.'];
    }
}

dm_page_start('Bank');
foreach ($messages as [$cls, $text]) echo '<div class="panel ' . h($cls) . '">' . h($text) . '</div>';

$normal = bank_current($link, 'normal10', $settings['normal10']);
$rate = bank_current($link, 'rate10', $settings['rate10']);
$month = bank_current($link, 'month', $settings['month']);
$term = bank_current($link, 'term', $settings['term']);
$invest = 1000 * pow(1 + $rate / 100, $term / $month);
$plain = 1000 * pow(1 + $normal / 100, $term / $month);
?>
<div class="panel">
<h2>Settings</h2>
<form method="post" action="dm_bank.php">
<input type="hidden" name="csrf_token" value="<?= h(csrf_token()) ?>">
<div class="grid">
<?php foreach ($settings as $key => $spec): $val = bank_current($link, $key, $spec); ?>
<label><?= h($spec[0]) ?> <span class="quiet">(<?= h($spec[1]) ?>)</span>
<input name="<?= h($key) ?>" type="number" min="<?= h((string)$spec[3]) ?>" max="<?= h((string)$spec[4]) ?>" step="<?= h((string)$spec[5]) ?>" value="<?= h((string)$val) ?>">
<span class="quiet"><?= h($spec[7]) ?></span></label>
<?php endforeach; ?>
</div>
<p><button type="submit">Save changes</button></p>
</form>
</div>
<div class="panel">
<h2>What a player gets from 1000 GP over the current term</h2>
<table><tr><td>Investment</td><td><b><?= h(number_format($invest)) ?> GP</b></td></tr>
<tr><td>Normal account, same time</td><td><b><?= h(number_format($plain)) ?> GP</b></td></tr></table>
<?php if ($invest < $plain): ?><p class="warn">Investing would return less than a normal account.</p><?php endif; ?>
</div>
<div class="panel"><h2>Recent changes</h2>
<table><tr><th>When</th><th>Change</th></tr>
<?php foreach (dm_audit_recent($link, 'bank_setting') as $row): ?>
<tr><td class="quiet"><?= h(date('Y-m-d H:i', (int)$row['at'])) ?></td><td><?= h($row['detail']) ?></td></tr>
<?php endforeach; ?></table></div>
<?php dm_page_end();
