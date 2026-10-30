<?php
$host    = getenv('DB_HOST')     ?: 'db';
$port    = getenv('DB_PORT')     ?: '3306';
$user    = getenv('DB_USER')     ?: 'uoa';
$pass    = getenv('DB_PASS')     ?: 'uoa';
$data    = getenv('DB_NAME')     ?: 'uoa';
$nwnport = getenv('NWN_PORT')    ?: '5121';
// Dev-only default hashes the password "dmpassword".
$dmlogin = getenv('DM_PASSWORD_HASH') ?: '$2y$12$UcQ38h7Hih4WEmomCB8L5u/c/7dUqd.rH3l5AWy3yyXO2YPPEJRlm';
?>
