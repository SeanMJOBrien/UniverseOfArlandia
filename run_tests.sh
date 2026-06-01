#!/usr/bin/env bash
# Run the full test suite.
# Usage:
#   ./run_tests.sh              — all suites
#   ./run_tests.sh --php        — PHP unit tests only
#   ./run_tests.sh --web        — HTML/web smoke tests only

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PHPUNIT="$SCRIPT_DIR/phpunit.phar"
CONFIG="$SCRIPT_DIR/phpunit.xml"

# Download PHPUnit if not present
if [[ ! -f "$PHPUNIT" ]]; then
    echo "Downloading PHPUnit 11..."
    curl -sL https://phar.phpunit.de/phpunit-11.phar -o "$PHPUNIT"
    chmod +x "$PHPUNIT"
fi

cd "$SCRIPT_DIR"

case "${1:-}" in
    --php)
        php "$PHPUNIT" --configuration "$CONFIG" --testsuite "PHP Unit Tests"
        ;;
    --web)
        php "$PHPUNIT" --configuration "$CONFIG" --testsuite "Web / HTML Smoke Tests"
        ;;
    *)
        php "$PHPUNIT" --configuration "$CONFIG"
        ;;
esac
