<?php
/**
 * Extract text between two delimiter strings.
 * Pass $after='' to start from the beginning of $data.
 * Pass $before='' to go to the end of $data.
 */
function between(string $data, string $after, string $before): string {
    if ($before !== '') {
        $end = strpos($data, $before);
        if ($end === false) return '';
        $data = substr($data, 0, $end);
    }
    if ($after === '') return $data;
    $start = strpos($data, $after);
    if ($start === false) return '';
    return substr($data, $start + strlen($after));
}

/**
 * Extract the Nth field from a &NNN& encoded string (3-digit zero-padded index).
 * Field 1 = before &001&, field 2 = between &001& and &002&, etc.
 */
function encoded_field(string $data, int $n): string {
    $curr = '&' . str_pad($n, 3, '0', STR_PAD_LEFT) . '&';
    $prev = $n > 1 ? '&' . str_pad($n - 1, 3, '0', STR_PAD_LEFT) . '&' : '';
    return between($data, $prev, $curr);
}

/**
 * Format a Y coordinate as a signed, zero-padded 2-digit string (e.g. +03, -12).
 * Used for map tile keys in the pwdata format.
 */
function tile_key(int $y): string {
    return ($y >= 0 ? '+' : '-') . str_pad(abs($y), 2, '0', STR_PAD_LEFT);
}
