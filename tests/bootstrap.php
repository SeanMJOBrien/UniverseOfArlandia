<?php
// Test bootstrap — sets up the environment for pure-function testing without a live DB.

define('WWW_DIR', __DIR__ . '/../www');

// Stub globals that sql.php sets (harmless to re-declare here first)
$db_error       = '';
$db_insertid    = 0;
$db_lastquery   = '';
$db_rowsaffected = 0;
$DatabasePrefix = '';

// DB_Test_Null is defined in database-mysql.php; stub it here so sql.php
// functions that reference it (e.g. DB_WhereClause) work without a DB.
function DB_Test_Null(string $field): string {
    return "ISNULL($field)";
}

// Include the pure-function library.
require_once WWW_DIR . '/sql.php';

// Include the logging helper.
require_once WWW_DIR . '/logging.php';

// Include the player-account / map-discovery helpers. Only its pure functions
// are unit tested; the DB-backed ones are exercised by the Playwright suite.
require_once WWW_DIR . '/player_auth.php';

// -----------------------------------------------------------------------
// Pure functions extracted from database-mysql.php.
// We cannot include that file directly because it does:
//   include "includes/sql.php";   (path does not exist)
//   $db_link = new mysqli();      (requires mysqli extension at include time)
// Instead we define only the two testable pure functions here.
// -----------------------------------------------------------------------

function DB_Field_Def_Match(string $SoftDef, string $DBDef): bool {
    $ldef = strtolower($SoftDef);
    $sdef = strtolower($DBDef);
    $sdef = preg_replace('/\;.*$/', '', $sdef);
    $sdef = preg_replace('/\b(tinyint|smallint|int|bigint)\(\d+\)/', '$1', $sdef);
    $ldef = preg_replace('/ ?\bprimary key\b/', '', $ldef);
    $ldef = preg_replace('/ ?\bindex\b/', '', $ldef);
    $ldef = preg_replace('/ ?\bfulltext\b/', '', $ldef);
    $ldef = preg_replace('/ ?\bauto_increment\b/', '', $ldef);
    $ldef = preg_replace('/ references \w+\(\w+\)/', '', $ldef);
    $ldef = preg_replace('/ references \w+\.\w+/', '', $ldef);

    if ($ldef !== $sdef) {
        return false;
    }

    if (preg_match('/\bAUTO_INCREMENT\b/', $SoftDef)) {
        if (!preg_match('/\bauto_increment\b/', $DBDef)) {
            return false;
        }
    }

    if (preg_match('/\bPRIMARY KEY\b/', $SoftDef)) {
        if (!preg_match('/\bPRI\b/', $DBDef)) {
            return false;
        }
    } elseif (preg_match('/\bINDEX\b/', $SoftDef)) {
        if (!preg_match('/\bMUL\b/', $DBDef)) {
            return false;
        }
    } elseif (preg_match('/\bFULLTEXT\b/', $SoftDef)) {
        if (!preg_match('/\bMUL\b/', $DBDef)) {
            return false;
        }
    }

    return true;
}

function DB_LocalizeDefinition(string $definition): string {
    $definition = preg_replace('/ INDEX$/', '', $definition);
    $definition = preg_replace('/ FULLTEXT$/', '', $definition);
    return $definition;
}
