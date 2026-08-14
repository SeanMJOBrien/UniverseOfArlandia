<?php
/**
 * Extract text between two delimiter strings.
 * Pass $after='' to start from the beginning of $data.
 * Pass $before='' to go to the end of $data.
 */
function between(string $data, string $after, string $before): string {
    if ($before !== '') {
        $end = strpos($data, $before);
        if ($end === false) {
            if ($data !== '') error_log("between(): delimiter '$before' not found in non-empty data");
            return '';
        }
        $data = substr($data, 0, $end);
    }
    if ($after === '') return $data;
    $start = strpos($data, $after);
    if ($start === false) {
        if ($data !== '') error_log("between(): delimiter '$after' not found in non-empty data");
        return '';
    }
    return substr($data, $start + strlen($after));
}

/**
 * Extract the Nth field from a &NNN& encoded string (3-digit zero-padded index).
 * Field 1 = before &001&, field 2 = between &001& and &002&, etc.
 */
function encoded_field(string $data, int $n): string {
    if ($n < 1) return '';
    $curr = '&' . str_pad($n, 3, '0', STR_PAD_LEFT) . '&';
    $prev = $n > 1 ? '&' . str_pad($n - 1, 3, '0', STR_PAD_LEFT) . '&' : '';
    return between($data, $prev, $curr);
}

/**
 * CSRF token helpers. Requires session_start() to already have been called.
 */
function csrf_token(): string {
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

function csrf_verify(): bool {
    return isset($_SESSION['csrf_token'], $_POST['csrf_token'])
        && hash_equals($_SESSION['csrf_token'], $_POST['csrf_token']);
}

/**
 * Format a Y coordinate as a signed, zero-padded 2-digit string (e.g. +03, -12).
 * Used for map tile keys in the pwdata format.
 */
function tile_key(int $y): string {
    return ($y >= 0 ? '+' : '-') . str_pad(abs($y), 2, '0', STR_PAD_LEFT);
}
