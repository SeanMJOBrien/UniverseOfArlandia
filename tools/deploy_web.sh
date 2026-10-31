#!/usr/bin/env bash
# Update the website from git on the web server and check it still parses.
# Run from anywhere: it works on the clone this script lives in.
set -euo pipefail
repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo"
git fetch --quiet origin
git checkout --quiet main
git pull --ff-only --quiet origin main
echo "At $(git log --oneline -1)"
bad=0
while IFS= read -r -d '' f; do
    php -l "$f" >/dev/null 2>&1 || { echo "PHP error in $f"; bad=1; }
done < <(find www/public -name '*.php' -print0)
[ "$bad" -eq 0 ] && echo "All PHP files parse." || exit 1
