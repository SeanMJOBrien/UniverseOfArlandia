---
project: Universe of Arlandia — www (PHP/HTML web frontend)
updated: 2026-06-09
stack: PHP 8.4 · MySQLi prepared statements · Apache · Playwright (Node)
validate_with: |
  PHP: open page in browser via Apache; check for PHP errors/warnings.
  Tests: cd /var/www/html/www && npx playwright test
  Security: grep for patterns listed in each verify block.
---

# Web Frontend TODO — Universe of Arlandia

Each task is self-contained with enough context to act on without reading other tasks.

---

## CRITICAL

---

### WEB-01: Delete or restrict phpinfo.php
- **status**: todo
- **action**: Delete `phpinfo.php`. It exposes full PHP configuration, loaded modules, and all environment variables (including DB credentials and DM password) to any visitor.
- **file**: `www/phpinfo.php` — entire file
- **pattern**:
  ```
  ACTION: rm /var/www/html/www/phpinfo.php
  ```
- **constraint**: Confirm nothing links to it first: `grep -r "phpinfo" /var/www/html/www/*.php /var/www/html/www/*.html`. If it must be kept, restrict via Apache `<Files>` directive to localhost only.
- **verify**: `curl http://localhost/phpinfo.php` returns 404 or 403.

---

## HIGH

---

### WEB-02: Delete legacy test files with deprecated mysql_* functions
- **status**: todo
- **action**: Delete `test.php` and `testmysql.php`. Both use the removed `mysql_query()` / `mysql_connect()` functions (deprecated PHP 5.5, removed PHP 7.0) and are not used by any production page.
- **files**:
  - `www/test.php` — uses `mysql_query()`, `mysql_result()`
  - `www/testmysql.php` — uses `mysql_connect()`
- **pattern**:
  ```
  ACTION: rm /var/www/html/www/test.php /var/www/html/www/testmysql.php
  ```
- **constraint**: Confirm no page links to them: `grep -r "test\.php\|testmysql" /var/www/html/www/*.php /var/www/html/www/*.html`
- **verify**: Files no longer exist. `curl http://localhost/test.php` returns 404.

---

### WEB-03: Remove or sanitise uoaBKP.php
- **status**: todo
- **action**: Delete `uoaBKP.php`. It contains hardcoded DB credentials and DM password inside HTML comments. Not used by any production page.
- **file**: `www/uoaBKP.php` — entire file
- **pattern**:
  ```
  ACTION: rm /var/www/html/www/uoaBKP.php
  ```
- **constraint**: Confirm it is not included anywhere: `grep -r "uoaBKP" /var/www/html/www/`
- **verify**: File no longer exists.

---

### WEB-04: Add CSRF tokens to all POST forms
- **status**: todo
- **action**: Add a CSRF token to every form that performs a state-changing POST. The DM login form (index.php) and the player reset form (galaxy.php, playerInfo.php) are the affected pages.
- **files**:
  - `www/index.php` — DM login form
  - `www/galaxy.php` — player reset form (POST `reset_player_char_name`)
  - `www/playerInfo.php` — player reset form (POST `reset_player`)
- **pattern**:
  ```php
  // In session_start() section, generate token once per session:
  if (empty($_SESSION['csrf_token'])) {
      $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
  }

  // In form HTML:
  <input type="hidden" name="csrf_token"
         value="<?= htmlspecialchars($_SESSION['csrf_token']) ?>">

  // In POST handler, before acting:
  if (!hash_equals($_SESSION['csrf_token'], $_POST['csrf_token'] ?? '')) {
      http_response_code(403);
      exit('Invalid CSRF token');
  }
  ```
- **constraint**: Token must be compared with `hash_equals()` to prevent timing attacks. Session must be active (`session_start()` called) before generating or validating the token.
- **verify**: Submit each form without the token (via curl -X POST) and confirm it returns 403. Submit with the correct token and confirm it succeeds.

---

### WEB-05: Hash DM password with bcrypt
- **status**: todo
- **action**: Replace plaintext DM password storage with a bcrypt hash. The password is currently compared with `hash_equals($dmlogin, $_POST['login'])` where `$dmlogin` is a plaintext env var.
- **files**:
  - `www/uoa.php` — where `$dmlogin` is set from `DM_PASSWORD` env var
  - `www/index.php` — where `hash_equals($dmlogin, $_POST['login'])` is called
- **pattern**:
  ```
  CURRENT (uoa.php):
    $dmlogin = getenv('DM_PASSWORD') ?: 'dmpassword';

  CURRENT (index.php):
    if (hash_equals($dmlogin, $_POST['login'])) { $_SESSION['is_dm'] = true; }

  NEW (uoa.php) — store hash, not plaintext:
    $dmlogin = getenv('DM_PASSWORD_HASH') ?: '';

  NEW (index.php) — verify against hash:
    if ($dmlogin !== '' && password_verify($_POST['login'], $dmlogin)) {
        $_SESSION['is_dm'] = true;
    }
  ```
  ```
  MIGRATION: Generate hash for existing password:
    php -r "echo password_hash('your_password', PASSWORD_BCRYPT);"
  Set DM_PASSWORD_HASH env var to the output. Remove DM_PASSWORD env var.
  ```
- **constraint**: `password_verify()` is already timing-safe; `hash_equals()` is no longer needed once bcrypt is used. Do not keep both env vars active simultaneously. Update Docker/server env config.
- **verify**: Login with correct password succeeds. Login with wrong password fails. `getenv('DM_PASSWORD')` returns empty string in production.

---

## MEDIUM

---

### WEB-06: Fix JavaScript escaping in galaxy.php confirm dialog
- **status**: todo
- **action**: Replace `addslashes()` in the JavaScript `confirm()` call with `json_encode()`. `addslashes()` is for SQL, not JavaScript string escaping — a character name containing a single quote breaks the JS syntax.
- **file**: `www/galaxy.php` — the `onclick` attribute on the reset form button
- **pattern**:
  ```php
  BEFORE:
    onclick="return confirm('Reset coordinates for <?= htmlspecialchars(addslashes($var2)) ?> to 0,0?')"

  AFTER:
    onclick="return confirm('Reset coordinates for ' + <?= json_encode($var2) ?> + ' to 0,0?')"
  ```
- **constraint**: `json_encode()` produces a properly JS-escaped string literal including the surrounding quotes. Do not add extra quotes around it in the HTML attribute. `htmlspecialchars()` is still needed on the attribute value as a whole if not using `json_encode` — but `json_encode` handles this.
- **verify**: A character name containing a single quote (e.g., `O'Brien`) renders the confirm dialog correctly without JS syntax error.

---

### WEB-07: Add session_start() to playerInfo.php
- **status**: todo
- **action**: Add `session_start()` as the very first line of `playerInfo.php` for consistency and to allow future use of `$_SESSION['is_dm']` checks.
- **file**: `www/playerInfo.php` — line 1
- **pattern**:
  ```php
  BEFORE (line 1):
    <?php

  AFTER (line 1):
    <?php
    session_start();
  ```
- **constraint**: `session_start()` must appear before any output. Confirm no HTML or whitespace precedes it in the file.
- **verify**: Page loads without "Cannot start session — headers already sent" warning.

---

### WEB-08: Add pwdata parse validation to helpers.php
- **status**: todo
- **action**: Add bounds/safety checks to `between()` and `encoded_field()` in `helpers.php` so corrupted pwdata records fail gracefully rather than returning misleading partial data.
- **file**: `www/helpers.php`
- **pattern**:
  ```php
  CURRENT between():
    function between(string $data, string $after, string $before): string {
        // no bounds check if delimiter missing

  ADD: return '' if $after not found in $data (already done for $before side)
  ADD: log a warning (error_log()) if delimiter not found and $data is non-empty

  CURRENT encoded_field():
    // no check that $n is in valid range

  ADD: if ($n < 1) return '';
  ```
- **constraint**: Do not throw exceptions — return empty string and log. NWN game server may write empty or partial records during server startup/shutdown; graceful degradation is required.
- **verify**: Pass a deliberately malformed string to `between()` and `encoded_field()` in a test script; confirm they return `''` without PHP warnings.

---

## LOW

---

### WEB-09: Write Playwright tests for playerInfo.php
- **status**: todo
- **action**: Create `www/tests/playerInfo.spec.js` covering the same scenarios as `galaxy.spec.js` infos panel tests.
- **file**: `www/tests/playerInfo.spec.js` (new file)
- **pattern**:
  ```js
  // Minimum coverage:
  test('page loads without PHP errors')
  test('shows player table with expected column headers')
  test('shows player data or empty state message')
  test('reset button only visible with DM session')  // if DM gate added
  test('reset action redirects with success message')
  ```
- **constraint**: Follow the pattern in `galaxy.spec.js` — use the `dbAvailable` helper from `tests/helpers/db.js` to skip DB-dependent assertions when MySQL is not connected.
- **verify**: `npx playwright test tests/playerInfo.spec.js` passes with 0 failures.

---

### WEB-10: Write Playwright tests for nwnservers.php
- **status**: todo
- **action**: Create `www/tests/nwnservers.spec.js`.
- **file**: `www/tests/nwnservers.spec.js` (new file)
- **pattern**:
  ```js
  // Minimum coverage:
  test('page loads without PHP errors')
  test('shows server list table')
  test('displays player count or offline status per server')
  test('cache header is set (60s)')
  ```
- **constraint**: Beamdog API calls will fail in CI without internet. Mock or skip API-dependent assertions when offline.
- **verify**: `npx playwright test tests/nwnservers.spec.js` passes with 0 failures.

---

### WEB-11: Expand interests.spec.js for type-specific rendering
- **status**: todo
- **action**: Add per-interest-type tests to `www/tests/interests.spec.js` for Domain, Town, Dungeon, Castle, Animal Reserve, and Resource Mountain types.
- **file**: `www/tests/interests.spec.js` — append new test blocks
- **pattern**:
  ```js
  // For each type, test the type-specific fields that should be visible:
  // Domain: owner name, tax rate, guild info, sector list
  // Town:   shop items table, inn section (if present)
  // Dungeon: dungeon family, difficulty, completion status
  // Animal reserve: pen status cells
  // Resource mountain: resource type and stock level
  ```
- **constraint**: Tests must locate a live DB record of each type to run against. Use the discovery pattern already in `interests.spec.js` (queries galaxy map for interest coordinates) to find real records dynamically. Skip if no record of that type exists in the DB.
- **verify**: `npx playwright test tests/interests.spec.js` passes; coverage report shows type-specific assertions firing.

---

### WEB-12: Remove or repurpose duplicate crafting HTML files
- **status**: todo
- **action**: Determine which of the three crafting files (`crafting.html`, `UOA_Crafting.html`, `UOA_Crafting2.html`, `Crafting.html`) is canonical and delete the rest.
- **files**:
  - `www/crafting.html` — FrontPage-era static page
  - `www/UOA_Crafting.html` — original Excel export (no longer the working version)
  - `www/UOA_Crafting2.html` — current working version (dark theme, paired recipe columns)
  - `www/Crafting.html` — copy of UOA_Crafting2.html
- **pattern**:
  ```
  RECOMMENDED:
    Keep:   www/Crafting.html  (canonical working version)
    Delete: www/crafting.html, www/UOA_Crafting.html, www/UOA_Crafting2.html
    Update: any nav links pointing to crafting.html to point to Crafting.html
  ```
- **constraint**: Check what nav links in `index.php` and `.html` files reference before deleting. `grep -r "crafting" /var/www/html/www/*.html /var/www/html/www/*.php`
- **verify**: All nav links to crafting pages resolve to one file. Deleted files return 404.
