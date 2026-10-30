<?php
/**
 * Send the queued domain alert emails (table mail_outbox, filled by the module).
 *
 *   php tools/send_outbox.php
 *
 * Run it from cron every 15 minutes or so. It uses PHP's mail(), so the host
 * needs a working sendmail or equivalent. Optional in www/uoa.php:
 *   $mail_from = 'uoa@yourdomain.example';
 * A message that fails 5 times is left in the table with sent_at empty.
 */
if (PHP_SAPI !== 'cli') { http_response_code(404); exit; }
include __DIR__ . '/../www/uoa.php';

mysqli_report(MYSQLI_REPORT_OFF);
$link = @mysqli_connect($host, $user, $pass, $data, (int)($port ?? 3306));
if (!$link) { fwrite(STDERR, "database offline\n"); exit(1); }

$from = $mail_from ?? ('noreply@' . (gethostname() ?: 'localhost'));
$res = @mysqli_query($link, 'SELECT id, to_addr, subject, body FROM mail_outbox WHERE sent_at IS NULL AND attempts < 5 ORDER BY id LIMIT 20');
if (!$res) { echo "No mail table yet.\n"; exit(0); }

$sent = 0; $failed = 0;
while ($row = mysqli_fetch_assoc($res)) {
    $to = str_replace(["\r", "\n"], '', $row['to_addr']);
    $subject = str_replace(["\r", "\n"], '', $row['subject']);
    $ok = filter_var($to, FILTER_VALIDATE_EMAIL)
        && mail($to, $subject, $row['body'], "From: $from\r\nContent-Type: text/plain; charset=utf-8");
    if ($ok) {
        $stmt = mysqli_prepare($link, 'UPDATE mail_outbox SET sent_at = ?, attempts = attempts + 1 WHERE id = ?');
        $now = time(); $id = (int)$row['id'];
        mysqli_stmt_bind_param($stmt, 'ii', $now, $id);
        $sent++;
    } else {
        $stmt = mysqli_prepare($link, 'UPDATE mail_outbox SET attempts = attempts + 1 WHERE id = ?');
        $id = (int)$row['id'];
        mysqli_stmt_bind_param($stmt, 'i', $id);
        $failed++;
    }
    mysqli_stmt_execute($stmt);
    mysqli_stmt_close($stmt);
}
echo "sent $sent, failed $failed\n";
