<?php
// Site configuration loader. This file holds NO secrets and is safe to commit.
//
// The real values (database login, DM password hash, mail sender) live in a
// separate file that git never touches. The first one found is used:
//   1. the path in the UOA_CONFIG environment variable
//   2. /etc/uoa/uoa.local.php
//   3. uoa.local.php beside this file (git-ignored)
// See docs/uoa.local.php.example. Anything the local file does not set falls back
// to an environment variable (the Docker setup uses these), then to a safe default.
foreach ([getenv('UOA_CONFIG'), '/etc/uoa/uoa.local.php', __DIR__ . '/uoa.local.php'] as $uoa_config) {
    if ($uoa_config && is_file($uoa_config)) {
        include $uoa_config;
        break;
    }
}
if (!isset($host))    { $host    = getenv('DB_HOST')  ?: 'db'; }
if (!isset($port))    { $port    = getenv('DB_PORT')  ?: '3306'; }
if (!isset($user))    { $user    = getenv('DB_USER')  ?: 'uoa'; }
if (!isset($pass))    { $pass    = getenv('DB_PASS')  ?: ''; }
if (!isset($data))    { $data    = getenv('DB_NAME')  ?: 'uoa'; }
if (!isset($nwnport)) { $nwnport = getenv('NWN_PORT') ?: '5121'; }
// A bcrypt hash, never the password itself. Empty disables the DM login.
if (!isset($dmlogin)) { $dmlogin = getenv('DM_PASSWORD_HASH') ?: ''; }
unset($uoa_config);
