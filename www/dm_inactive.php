<?php
/**
 * DM page: player accounts whose characters have all been inactive for 365 real days.
 *
 * The server vault holds one folder per player account (the public CD key), each
 * with one .bic file per character. A .bic is rewritten whenever the character
 * is saved, so its modified time is the last time the character was played. The
 * module also records LastSeen_<character> in pwdata; the later of the two counts.
 *
 * Everything here is manual. Nothing is removed unless a DM presses the button
 * on one account and types its folder name. Removing a character moves its .bic
 * files out of the vault into servervault_removed/<date>/<account>/, so a
 * mistake can be undone by moving them back, and deleting the archive is a
 * separate manual step. Domains and placed objects are never touched: they are
 * listed so the DM can hand them over (.wowner in game) or remove them in game.
 */
require __DIR__ . '/dm_common.php';

$vault = rtrim((string)(getenv('UOA_VAULT') ?: '/home/qlippoth/uoa/server/servervault'), '/');
$archive_root = dirname($vault) . '/servervault_removed';
$inactive_days = 365;
$now = time();

function acct_valid(string $folder): bool {
    return (bool)preg_match('/^[A-Za-z0-9]{4,20}$/', $folder);
}

/** pwdata value for a module-level key, or ''. */
function inactive_pw(mysqli $link, string $name): string {
    return dm_pw_get($link, $name);
}

/** Scan the vault and join in what pwdata knows about each account. */
function scan_accounts(mysqli $link, string $vault, int $now): array {
    $accounts = [];
    foreach (scandir($vault) ?: [] as $folder) {
        if ($folder[0] === '.' || !acct_valid($folder) || !is_dir("$vault/$folder")) continue;
        $files = glob("$vault/$folder/*.[bB][iI][cC]") ?: [];
        if (!$files) continue;
        $names = [];
        $newest = 0;
        $chars = [];
        foreach ($files as $file) {
            $mtime = (int)filemtime($file);
            $base = pathinfo($file, PATHINFO_FILENAME);
            $chars[$base] = ['mtime' => $mtime, 'file' => $file];
            $newest = max($newest, $mtime);
            $names[$base] = true;
        }
        // Character names the module has seen on this CD key, and the player account name.
        $web = inactive_pw($link, 'WebChars_' . $folder);
        $player = '';
        if ($web !== '') {
            foreach (explode('&2&', $web) as $part) {
                if (strpos($part, '&1&') === false) continue;
                [$acct, $char] = explode('&1&', $part, 2);
                if ($char === '') continue;
                $names[$char] = true;
                if ($player === '') $player = $acct;
            }
        }
        $seen = 0;
        $domains = [];
        foreach (array_keys($names) as $name) {
            $seen = max($seen, (int)inactive_pw($link, 'LastSeen_' . $name));
            $list = inactive_pw($link, 'DomainIndex&' . $name);
            foreach (array_filter(explode('|', $list)) as $entry) $domains[$name . ': ' . str_replace('&', ' ', $entry)] = true;
        }
        $last = max($newest, $seen);
        $accounts[] = [
            'folder' => $folder, 'player' => $player, 'chars' => $chars, 'last' => $last,
            'days' => (int)floor(($now - $last) / 86400), 'domains' => array_keys($domains),
            'email' => $player !== '' ? (inactive_pw($link, 'Email&' . $player) !== '') : false,
        ];
    }
    usort($accounts, function ($a, $b) { return $a['last'] <=> $b['last']; });
    return $accounts;
}

if (!is_dir($vault) || !is_readable($vault)) {
    dm_page_start('Inactive accounts');
    echo '<div class="panel warn">The vault folder <code>' . h($vault) . '</code> cannot be read by the web server. '
       . 'Set the UOA_VAULT environment variable to the servervault path and make it readable (and writable to remove characters).</div>';
    dm_page_end();
    exit;
}

$messages = [];
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'remove') {
    $folder = (string)($_POST['account'] ?? '');
    if (!csrf_verify()) {
        $messages[] = ['warn', 'The form expired. Reload and try again.'];
    } elseif (!acct_valid($folder) || !is_dir("$vault/$folder")) {
        $messages[] = ['warn', 'Unknown account folder.'];
    } elseif (trim((string)($_POST['confirm'] ?? '')) !== $folder) {
        $messages[] = ['warn', 'Type the account folder name exactly to confirm.'];
    } else {
        $target = null;
        foreach (scan_accounts($link, $vault, $now) as $acct) if ($acct['folder'] === $folder) $target = $acct;
        if ($target === null) {
            $messages[] = ['warn', 'That account has no characters.'];
        } elseif ($target['days'] < $inactive_days) {
            $messages[] = ['warn', "That account was active {$target['days']} days ago, less than $inactive_days. Nothing was removed."];
        } else {
            $dest = $archive_root . '/' . date('Ymd-His') . '/' . $folder;
            $moved = 0; $failed = 0;
            if (!is_dir($dest)) @mkdir($dest, 0775, true);
            foreach ($target['chars'] as $char) {
                if (@rename($char['file'], $dest . '/' . basename($char['file']))) $moved++; else $failed++;
            }
            dm_audit($link, 'remove_bic', "$folder: moved $moved, failed $failed, to $dest");
            $messages[] = [$failed ? 'warn' : 'ok', "$folder: moved $moved character file(s) to $dest" . ($failed ? ", $failed could not be moved (check write access)" : '') . '.'];
        }
    }
}

$show_all = isset($_GET['all']);
$accounts = scan_accounts($link, $vault, $now);
$shown = array_filter($accounts, function ($a) use ($show_all, $inactive_days) { return $show_all || $a['days'] >= $inactive_days; });

dm_page_start('Inactive accounts');
foreach ($messages as $message) echo '<div class="panel ' . h($message[0]) . '">' . h($message[1]) . '</div>';
?>
<div class="panel">
<p>Accounts whose newest character file is at least <b><?= (int)$inactive_days ?> days</b> old, oldest first.
<?= count($shown) ?> of <?= count($accounts) ?> accounts shown.
<a href="dm_inactive.php<?= $show_all ? '' : '?all=1' ?>"><?= $show_all ? 'Show inactive only' : 'Show all accounts' ?></a></p>
<p class="quiet">Removing characters moves their files to <code><?= h($archive_root) ?></code>. Domains and placed objects stay as they are:
use <code>.wdomain</code> and <code>.wowner</code> in game to hand a domain over, and remove objects by hand.</p>
</div>
<?php foreach ($shown as $acct): $old = $acct['days'] >= $inactive_days; ?>
<div class="panel">
<h2><?= h($acct['folder']) ?> <span class="quiet"><?= $acct['player'] !== '' ? '(' . h($acct['player']) . ')' : '' ?></span></h2>
<p>Last active <b><?= (int)$acct['days'] ?> days ago</b> (<?= h(date('Y-m-d', $acct['last'])) ?>).
<?= $acct['email'] ? 'Email alerts registered.' : '<span class="quiet">No email registered.</span>' ?></p>
<div class="scroll"><table><tr><th>Character file</th><th>Last saved</th></tr>
<?php foreach ($acct['chars'] as $base => $c): ?>
<tr><td><?= h($base) ?></td><td><?= h(date('Y-m-d', $c['mtime'])) ?> (<?= (int)floor(($now - $c['mtime']) / 86400) ?> days)</td></tr>
<?php endforeach; ?></table></div>
<p><b>Domains (matched by character name):</b>
<?= $acct['domains'] ? h(implode('; ', $acct['domains'])) : '<span class="quiet">none found</span>' ?></p>
<?php if ($old): ?>
<form method="post" action="dm_inactive.php" style="display:flex;flex-wrap:wrap;gap:10px;align-items:flex-end">
<input type="hidden" name="csrf_token" value="<?= h(csrf_token()) ?>">
<input type="hidden" name="action" value="remove">
<input type="hidden" name="account" value="<?= h($acct['folder']) ?>">
<label>Type <code><?= h($acct['folder']) ?></code> to confirm<input name="confirm" autocomplete="off"></label>
<button class="danger" type="submit">Remove <?= count($acct['chars']) ?> character file(s)</button>
</form>
<?php endif; ?>
</div>
<?php endforeach; ?>
<div class="panel"><h2>Recent removals</h2><table><tr><th>When</th><th>Result</th></tr>
<?php foreach (dm_audit_recent($link, 'remove_bic') as $row): ?>
<tr><td class="quiet"><?= h(date('Y-m-d H:i', (int)$row['at'])) ?></td><td><?= h($row['detail']) ?></td></tr>
<?php endforeach; ?></table></div>
<?php dm_page_end();
