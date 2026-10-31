#!/usr/bin/env bash
set -euo pipefail

# Site settings reach www/public/app/uoa.php through the DB_*, NWN_PORT and
# DM_PASSWORD_HASH environment variables set in docker-compose.yml.
# Dev-only fallback for the DM password: this hash is for "dmpassword".
if [ -z "${DM_PASSWORD_HASH:-}" ]; then
    export DM_PASSWORD_HASH='$2y$12$UcQ38h7Hih4WEmomCB8L5u/c/7dUqd.rH3l5AWy3yyXO2YPPEJRlm'
fi

exec "$@"
