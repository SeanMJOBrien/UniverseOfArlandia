# Web Dashboard (`www/`) Test Spec

Test-case spec for `www/` PHP dashboard changes over the last year
(2025-08-20 – 2026-08-08, commits `be3a1c3`..`6752100`). Grouped by
feature/theme. Written in the same style as the existing Playwright suite
in this directory (`test.describe` / `test`), with each case marked as
either **Automated** (an existing `*.spec.js` already covers it — file
named) or **Gap** (no automated coverage yet — needs a new spec or a
manual pass).

All pages here follow the project convention: DB connection is checked
before any HTML output, failing fast with "service offline" (or, on
pre-convention pages, a raw connection-failure message — see 4.1) rather
than a partial/broken render.

---

## 1. PHP 7 → 8 migration & DB layer

Covers: `be3a1c3`, `6ccd621`.

### 1.1 No PHP 8 deprecation warnings or fatals on any page
- **Automated (partial):** every `*.spec.js` file asserts the page body
  never contains `Fatal error` / `Warning:` — this is a project-wide
  convention, not one file's responsibility.
- **Gap:** no single spec asserts *zero PHP deprecation notices* across
  the full page set in one pass — worth a smoke-test sweep hitting every
  route once and grepping for `Deprecated:`.

### 1.2 DB queries use prepared statements, not string interpolation
- **Gap — not testable via Playwright.** This is a static/code-review
  property (per root `CLAUDE.md`: "always `mysqli_prepare` + bound
  params"), not browser-observable behavior. Recommend a `grep -rn
  "mysqli_query.*\$_" www/` sweep as a CI lint step instead of a spec.

### 1.3 SQL caching returns fresh-enough data
- **Setup:** Trigger a page that reads from a cached query (e.g.
  `statut.php`'s server-status cache, `nwnservers.php`'s 60s cache).
- **Expected:** Page reflects data no older than the documented cache
  window (60s for both of the above).
- **Automated:** `statut.spec.js` asserts the 60s meta-refresh tag;
  `nwnservers.spec.js` accepts either online/offline rendering but doesn't
  currently assert cache freshness directly — **Gap** for an explicit
  cache-age assertion.

---

## 2. Test infrastructure itself

Covers: `d09e79a`, `4e4a54c`, `aa43279`, `378a16f`.

### 2.1 `data-testid` locators are present and stable on galaxy.php
- **Automated:** `galaxy.spec.js` relies on `img[alt="North"|"South"|...]`
  and href-parsing rather than `data-testid` directly — confirm the
  `data-testid`/data-attributes added in `378a16f` are still present in
  current markup even if not yet consumed by every locator.

### 2.2 Selenium navigation tests mirror the Playwright ones
- **Status:** `aa43279` added a parallel Selenium suite for galaxy.php
  Space-view "to mirror Playwright". Confirm both suites still pass and
  haven't drifted apart (e.g. one covers a compass direction the other
  dropped).
- **Gap:** no CI step visible that runs both suites together and diffs
  coverage — worth a checklist item until formalized.

### 2.3 DB-down and DB-up code paths are both exercised
- **Automated:** `www/tests/helpers/db.js`'s `isDbConnected()` gates most
  specs into "without DB" vs "with DB" `describe` blocks
  (`statut.spec.js`, `galaxy.spec.js`, `playerInfo.spec.js`, etc.) — this
  pattern is in place and should be followed for any new page spec.

---

## 3. Docker Compose dev environment

Covers: `2e8fb26`, `ca5ae0e`, `071c2b9`, `144722e`.

### 3.1 `docker-compose up` brings up a working dev stack
- **Gap — infra-level, not a page spec.** Manual/CI check: `docker-compose
  up -d` from the project root succeeds, `www` and DB containers reach a
  healthy state, and `statut.php`/`galaxy.php` are reachable.

### 3.2 Claude Code container runs as non-root with persisted account data
- **Gap — infra-level.** Manual check: exec into the dev container, `whoami`
  is non-root; restart the container and confirm account/session data
  persisted (not wiped).

### 3.3 `.dockerignore` keeps the build context small
- **Gap — infra-level.** Manual check: `docker build` context size is
  small (no `node_modules`, no `.git`, no test-result artifacts bleeding
  into the image).

### 3.4 No legacy credential file is present or tracked
- **Gap — security check, not a page spec.** Verify via `git log
  --all --full-history -- '**/credentials*'` (or similar) that the
  removed legacy credential file (`144722e`) isn't reintroduced, and that
  `node_modules` stayed untracked afterward (`git ls-files www/node_modules
  | wc -l` should be `0`).

---

## 4. PC location tracking & security/HTML refactor

Covers: `b8bdf41`.

### 4.1 playerLocations.php renders without a PHP fatal
- **Gap — no spec file exists yet** (`www/tests/playerLocations.spec.js`
  is not present, tracked, or untracked, as of this pass). Needs a new
  spec following the `playerInfo.spec.js` pattern:
  - Without DB: page fails fast rather than a blank/broken page (confirm
    which convention it follows — "service offline" or the older raw
    connection-failure message noted in `playerInfo.spec.js`'s own
    comment).
  - With DB: shows the PC location table.

### 4.2 Output is escaped (XSS check)
- **Setup:** A PC name or location value containing `<script>` or
  `"onmouseover=`-style content reaches the page (via seeded test data or
  a mock).
- **Expected:** Rendered as inert text (`htmlspecialchars`-escaped), not
  executed.
- **Gap:** not covered by any current spec; add once `playerLocations.spec.js`
  exists.

### 4.3 State-changing actions are CSRF-gated and DM-gated
- **Automated (pattern reference):** `playerInfo.spec.js` already checks
  that its "Set to 0,0" reset action requires an active DM session
  (`$_SESSION['is_dm']`) plus CSRF token — confirm `playerLocations.php`'s
  reset/edit actions (`ddffa62`'s "web-triggered player reset") follow the
  same gating.
- **Gap:** needs its own assertion once `playerLocations.spec.js` exists.

---

## 5. galaxy.php Space-view

Covers: `c969709`, `aa43279`, `378a16f`.

### 5.1 Space-view heading reflects the current viewport
- **Automated:** `galaxy.spec.js` — confirm it asserts the heading text
  updates dynamically as `galaxyx`/`galaxyy` change via the compass
  arrows, not just that the arrows exist.

### 5.2 Compass navigation updates both URL params and visible heading together
- **Automated:** `galaxy.spec.js`'s `arrowLink()`/`parseGalaxyParams()`
  helpers suggest this is covered — confirm North/South/East/West all
  round-trip correctly (clicking North then South returns to the origin
  viewport).

### 5.3 DM admin panel (`?planet=infos`) still works post-refactor
- **Automated:** `galaxy.spec.js` per its header comment covers the DM
  player table mode — confirm it wasn't affected by the heading-dynamism
  change in `c969709`.

---

## 6. map-data.php

Covers: `0b5ad59`.

### 6.1 Queries are targeted, not full-table scans
- **Gap — no spec file exists** (`map-data.spec.js` absent). Add a spec
  that at minimum confirms the endpoint returns data scoped to the
  requested planet/area rather than the entire map dataset.

### 6.2 Undiscovered tiles hide terrain (no map-reveal info leak)
- **Setup:** Request map data for a region containing tiles the
  requesting player hasn't discovered.
- **Expected:** Undiscovered tiles' terrain is omitted/masked in the
  response — a player can't read the full map by querying this endpoint
  directly.
- **Gap:** security-relevant and currently untested — should be a
  priority addition, not just a nice-to-have.

---

## 7. Site restructure

Covers: `aed6884`, `34b6507`, `6752100`.

### 7.1 All page routes still resolve after the `www/public/` + `www/app/`
    restructure
- **Automated (indirect):** every existing `*.spec.js` navigating to
  `/galaxy.php`, `/statut.php`, etc. exercises this — a wholesale route
  failure would show up as failures across the whole suite. No dedicated
  "site map" spec exists that enumerates every route in one place.
- **Gap:** consider a single smoke-test spec that iterates a known route
  list and asserts each returns 200 + no fatal, as a fast first line of
  defense for future restructures.

### 7.2 Removed dead files stay removed
- **Setup:** Check for `www/UOA_Crafting.html`, `www/UOA_Crafting2.html`,
  `www/crafting.html`, `www/phpinfo.php`, `www/test.php`,
  `www/testmysql.php` (deleted in `6752100`/the `main` merge history).
- **Expected:** None of these exist on disk; `phpinfo.php` and
  `testmysql.php` in particular should never come back — both are
  explicitly called out as things to never ship in the root `CLAUDE.md`
  ("Never ship `phpinfo.php`... or legacy `mysql_*`-API files to
  production").
- **Gap:** no automated check; a simple `test -f` guard in CI would catch
  a regression cheaply.

### 7.3 Asset paths resolve under the new `app/assets` layout
- **Gap:** no spec directly asserts CSS/JS/image 404s across pages post-
  restructure. Worth folding into the smoke-test spec from 7.1 (assert no
  4xx network responses while loading each route).

---

## Summary: coverage gaps to prioritize

In rough priority order (security/correctness first):

1. **6.2** — undiscovered-tile map-data leak check (security).
2. **4.1–4.3** — `playerLocations.php` has no spec at all yet.
3. **6.1** — `map-data.php` has no spec at all yet.
4. **7.2** — guard against dead/dangerous files (`phpinfo.php` etc.)
   reappearing.
5. **7.1/7.3** — a route-list smoke test, cheap insurance against the next
   restructure.
