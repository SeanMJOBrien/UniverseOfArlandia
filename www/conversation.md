# UOA Browser Test Suite — Design Discussion

## Context

**Project:** Universe of Arlandia (UOA) — a web frontend for a custom *Neverwinter Nights* persistent-world module.
**Stack:** Classic PHP 8.4 / MySQL (XAMPP-style), Apache, no build system, no package manager, no existing tests.
**Goal:** Establish a browser UI test suite to lock in current behaviour *before* refactoring and modernising the codebase.

---

## Why Tests Before Refactoring?

Refactoring legacy PHP without tests is risky. The existing pages have complex string-parsing logic (custom `&N&` / `_XX_` delimiters instead of JSON), DM login flows, dynamic map rendering, and several distinct page modes. A regression could break player-facing features silently.

The strategy:

1. **Write tests that describe what the pages do right now** — these become the contract the refactor must honour.
2. Run the suite before touching any PHP.
3. Refactor incrementally; re-run after each change.
4. Tests that were green must stay green.

---

## Framework Choices

### Playwright (JavaScript / Node.js)

Playwright was chosen for the first suite because:

- **Auto-waits** — no explicit `WebDriverWait` boilerplate; assertions retry automatically.
- **Built-in web server** — the `webServer` config block starts `php -S localhost:8765` before tests and kills it after; zero manual setup.
- **Fast** — parallel workers, headless by default.
- **`waitUntil: 'domcontentloaded'`** — important here because several PHP pages call `die()` mid-render when MySQL is offline, meaning `load` never fires (iframes never settle). `domcontentloaded` fires on whatever partial HTML was received.

Run with: `npm test`

### Selenium (Python / pytest)

Selenium was added as a second suite driven by Python because:

- Provides an independent verification path using a different automation engine.
- Python's `pytest` fixture model (`scope="session"` / `scope="class"` / function-scoped) maps cleanly onto the server lifecycle and per-test driver teardown.
- `pytest-html` generates a self-contained HTML report automatically.

Run with: `python3 -m pytest selenium/`

Both suites run against separate ports (Playwright → **8765**, Selenium → **8766**) so they can execute simultaneously without conflict.

---

## Architecture Decisions

### One DB-connectivity probe, used everywhere

Both suites probe `galaxy.php?planet=infos` at session start. That page calls `die("service offline")` immediately when MySQL is unreachable — making it a reliable, single-request signal.

All DB-dependent tests call `test.skip()` / `pytest.skip()` when the probe returns false. This means:

- The suite always runs without needing a database.
- DB-dependent assertions activate automatically when MySQL is available.
- CI without a database is not a failure; it's a partial run.

### Separate PHP server per suite

Rather than assuming Apache is running, each suite spawns `php -S localhost:PORT` as a subprocess for its session. This makes the tests self-contained and runnable on any machine with PHP in `$PATH`.

### Per-test WebDriver (Selenium) vs shared Page (Playwright)

Playwright reuses a browser context across tests in a describe block — fast, low overhead.

In Selenium, each test function gets a **fresh `driver` instance** (function-scoped fixture). This is slower (~1 s per test) but guarantees no state leakage between tests — essential since `driver.get()` accumulates cookies and session storage.

### Discovering live DB data at runtime

For planet maps and interest pages, hardcoding planet names would make tests brittle. Instead, both suites scrape `index.php` (for a planet name) and `galaxy.php?planet=Space` (for interest tile links) at runtime using HTTP, then pass those values into tests. Tests skip gracefully when no data is found.

---

## Key Technical Issues Encountered

### 1 — `or die()` in index.php

`index.php` uses `@ $result = mysqli_query($link, ...) or die()` — no error message, just silent exit. Without MySQL the page outputs partial HTML (left nav renders, then the connection is terminated mid-table-row). The right column and footer are never sent.

**Impact on tests:** Tests for the content iframe, footer, and star-systems column are gated behind `db_available`. Tests for nav links, the status iframe, and the DM login form run always, because those elements are emitted before the query.

**Playwright fix:** `waitUntil: 'domcontentloaded'` on all PHP pages so the test doesn't hang waiting for a `load` event that never fires.

### 2 — `toHaveCount({ gte: 2 })` is not a valid Playwright assertion

Playwright's `toHaveCount()` only accepts a plain integer. The fix was to call `.count()` and assert with `expect(n).toBeGreaterThanOrEqual(2)`.

### 3 — Player table: buttons absent but empty-message also absent

`galaxy.php?planet=infos` shows `"No player data found."` only when zero `Player*` keys exist in `pwdata`. When keys exist but all have an empty account-name field (`$var1 == ""`), neither the reset buttons nor the empty message appear. The original test assumed: _no buttons → empty message_. That assumption is false.

**Fix:** Rewrote the test to verify the table structure exists and no PHP error appears, without asserting on which variant of the empty state is shown.

### 4 — Selenium form `action` attribute returns absolute URL

`element.get_attribute("action")` in Selenium returns the resolved absolute URL (`http://localhost:8766/index.php`), not the literal HTML attribute value (`index.php`). Playwright returns the literal value.

**Fix:** Changed the assertion from `== "index.php"` to `.endswith("index.php")`.

### 5 — ChromeDriver version mismatch (Selenium)

System Chrome was **149** but `/usr/local/bin/chromedriver` was **139** — installed at some earlier point and never updated. Selenium picks up the system `chromedriver` from `$PATH` before Selenium Manager can run.

**Fix:** Added `webdriver-manager` to `selenium/requirements.txt`. The `_build_driver()` function now passes an explicit `Service(ChromeDriverManager().install())` which downloads and caches the correct ChromeDriver for the installed Chrome, completely bypassing the stale system binary.

---

## Test Coverage Summary

| Page | Playwright | Selenium |
|---|---|---|
| `index.php` — structure (no DB) | ✓ | ✓ |
| `index.php` — full render (DB) | ✓ | ✓ |
| `index.php` — DM login flow | ✓ | ✓ |
| `galaxy.php?planet=infos` | ✓ | ✓ |
| `galaxy.php?planet=Space` | ✓ | ✓ |
| `galaxy.php?planet=<name>` | ✓ | ✓ |
| `statut.php` | ✓ | ✓ |
| `interests.php` (common) | ✓ | ✓ |
| `interests.php` (Domain) | ✓ | ✓ |
| `interests.php` (Dungeon) | ✓ | ✓ |
| 16 static HTML pages | ✓ | ✓ |
| Lightbox gallery (screenshots) | ✓ | ✓ |

**Playwright:** 64 pass, 18 skip — `npm test`
**Selenium:** 70 pass, 19 skip — `python3 -m pytest selenium/`

Skipped tests activate automatically when MySQL is running. The DM login success test additionally requires `UOA_DM_PASSWORD=<password>` in the environment.

---

## File Layout

```
uoawww/
├── package.json              # Node deps: @playwright/test
├── playwright.config.js      # Playwright config (port 8765, Chromium)
├── tests/                    # Playwright test suite
│   ├── helpers/db.js         #   DB connectivity probe
│   ├── index.spec.js
│   ├── galaxy.spec.js
│   ├── statut.spec.js
│   ├── interests.spec.js
│   └── static.spec.js
└── selenium/                 # Python Selenium test suite
    ├── requirements.txt      #   selenium, pytest, pytest-html, webdriver-manager
    ├── pytest.ini            #   pytest config (port 8766, HTML report)
    ├── conftest.py           #   fixtures: PHP server, Chrome driver, DB probe
    ├── test_index.py
    ├── test_galaxy.py
    ├── test_statut.py
    ├── test_interests.py
    └── test_static.py
```

---

## Keeping Browser Windows Open After Tests

### The Question

> What changes would need to be made to include an option of leaving browser windows open after the test is complete?

This is useful when debugging a failure — you want to inspect the page state exactly as the test left it, rather than reconstructing it by re-running.

### Approach for Each Framework

**Selenium** — one fixture change in `conftest.py`. The `driver` fixture already has a clean teardown point; `d.quit()` just needs to be conditional:

```python
@pytest.fixture
def driver():
    d = _build_driver()
    yield d
    if os.environ.get("KEEP_OPEN", "").lower() != "true":
        d.quit()
```

**Playwright** — more involved, because Playwright auto-closes the browser context on teardown and there is no global `conftest` equivalent. The options are:

- Override the `context` fixture in a shared `tests/fixtures.js` and change every spec's import from `@playwright/test` to that file (one-line change per spec, but touches every file).
- Add a global `afterEach` that calls `page.pause()` — this blocks the runner interactively rather than leaving windows passively open.

The tradeoff: Selenium's teardown is explicit Python code you own; Playwright's teardown is managed by the framework, so bypassing it requires working with its fixture extension mechanism.

### Decision

Only the Selenium change was applied. Playwright was left as-is.

### Implementation

Two edits to `selenium/conftest.py`:

1. **`_build_driver`** — `KEEP_OPEN=true` bypasses the headless check, so headed mode is implied automatically. No need to set `HEADLESS=false` separately.

```python
keep_open = os.environ.get("KEEP_OPEN", "").lower() == "true"
if not keep_open and os.environ.get("HEADLESS", "true").lower() != "false":
    opts.add_argument("--headless=new")
```

2. **`driver` fixture** — `d.quit()` is skipped when `KEEP_OPEN=true`.

```python
if os.environ.get("KEEP_OPEN", "").lower() != "true":
    d.quit()
```

### Usage

```bash
# All tests, windows stay open after each one
KEEP_OPEN=true python3 -m pytest selenium/

# Single file
KEEP_OPEN=true python3 -m pytest selenium/test_index.py
```

The suite continued to pass (70 passed, 19 skipped) with the default behaviour unchanged.

---

## Screenshot Display Fixes

### The Problem

After the screenshot feature was implemented, two issues appeared when opening the report in a browser:

1. **Screenshots not visible** — all passing test rows were collapsed by default. The screenshot lives inside the `.extras-row` element, which pytest-html hides with a `hidden` class when a test is collapsed. Users had to click every test to expand it.

2. **Clicking an image opened a blank page** — the click handler in pytest-html's JavaScript does `window.open(media.path, '_blank')`. When the image was embedded as a `data:image/png;base64,...` URI (49 MB self-contained HTML file), Chrome blocks `data:` URI navigation in new tabs as a security measure.

3. **Broken images for parametrized tests** — test IDs with URL parameters in the parametrize argument (e.g. `[/galaxy.php?planet=infos]`) produced filenames containing `?`. The browser interprets `?` as the start of a query string, so `img src="../screenshots/test_name?planet=infos_.png"` resolved to the wrong path.

### Root Causes

**Issue 1 — collapsed rows:** pytest-html 4.x defaults to `render_collapsed = passed` in its ini config. All passing tests start collapsed.

**Issue 2 — self-contained HTML:** The original setup used `--self-contained-html`, which base64-encodes every screenshot directly into the JSON blob inside the HTML. This produced a 49 MB file and forced all image navigation through `data:` URIs.

**Issue 3 — filename sanitisation:** The `safe_name` generation in `conftest.py` replaced `/`, `::`, `[`, and `]` but not `?`, `=`, `&`, or spaces.

### Fixes

**`selenium/pytest.ini`:**

- Removed `--self-contained-html` from `addopts`. pytest-html now writes images as separate files in `selenium/report/assets/` and uses relative `img src` paths. The HTML report shrinks from 49 MB to ~108 KB.
- Added `render_collapsed =` (empty value). An empty list means no test categories are collapsed by default — all screenshots are visible immediately when the report is opened.

**`selenium/conftest.py`:**

- Added `REPORT_DIR` constant pointing to `selenium/report/`.
- Removed `import base64` (no longer needed).
- Screenshot hook now passes the relative file path to `extras.image()` instead of a raw base64 string:

```python
rel_path = os.path.relpath(path, REPORT_DIR)
extras.append(pytest_html.extras.image(rel_path))
```

pytest-html's non-self-contained `_media_content` method detects that the content is not valid base64 and returns it as-is, so the report uses the relative path directly as `img src`. The browser loads the file; clicking opens the actual PNG.

- Extended the `safe_name` sanitiser to also replace `?`, `=`, `&`, and spaces with `_`:

```python
safe_name = (
    item.nodeid
    .replace("/", "_").replace("::", "_")
    .replace("[", "_").replace("]", "_")
    .replace("?", "_").replace("=", "_")
    .replace("&", "_").replace(" ", "_")
)
```

### Result

The report opens instantly (108 KB), all 76 screenshots are visible without expanding rows, clicking a screenshot opens the PNG directly, and all filenames are URL-safe.
