"""
Shared pytest fixtures for UOA Selenium tests.

PHP server lifecycle:  A PHP built-in server is started on port 8766 for the
entire test session and torn down afterwards.  Port 8766 is kept separate from
Playwright (8765) so both suites can run simultaneously.

WebDriver:  One Chrome WebDriver is created per test function; it is always
cleaned up in the fixture teardown even if the test raises.  Pass
HEADLESS=false to watch tests run: HEADLESS=false pytest selenium/

Screenshots:  After every test the driver fixture stores a reference in
item.stash.  A pytest_runtest_makereport hookwrapper (tryfirst=True, so its
"after yield" runs after pytest-html's) takes the screenshot while the driver
is still alive, saves it to selenium/screenshots/, and appends it directly to
report.extras for inline embedding in the HTML report.

DB availability:  galaxy.php immediately calls die("service offline") when
MySQL is unreachable.  The db_available session fixture probes that endpoint
once; DB-dependent tests call pytest.skip() when it returns False.
"""

import os
import subprocess
import time
import urllib.request
import urllib.error
import pytest
import pytest_html
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager

# --------------------------------------------------------------------------- #
# Configuration                                                                 #
# --------------------------------------------------------------------------- #
PORT             = int(os.environ.get("SELENIUM_PORT", "8766"))
BASE_URL         = f"http://localhost:{PORT}"
SITE_ROOT        = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
CHROME_BINARY    = os.environ.get("CHROME_BINARY", "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")
SCREENSHOTS_DIR  = os.path.join(os.path.dirname(__file__), "screenshots")
REPORT_DIR       = os.path.join(os.path.dirname(__file__), "report")

# Stash key used to pass the live driver from the fixture to the report hook.
_driver_stash_key = pytest.StashKey()


# --------------------------------------------------------------------------- #
# PHP server                                                                    #
# --------------------------------------------------------------------------- #
def _wait_for_server(url: str, retries: int = 30, delay: float = 0.25) -> None:
    for _ in range(retries):
        try:
            urllib.request.urlopen(url, timeout=1)
            return
        except Exception:
            time.sleep(delay)
    raise RuntimeError(f"PHP server did not start at {url}")


@pytest.fixture(scope="session", autouse=True)
def php_server():
    """Start php -S on PORT for the whole test session."""
    proc = subprocess.Popen(
        ["php", "-S", f"localhost:{PORT}"],
        cwd=SITE_ROOT,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    _wait_for_server(f"{BASE_URL}/news.html")
    yield BASE_URL
    proc.terminate()
    proc.wait(timeout=5)


# --------------------------------------------------------------------------- #
# DB availability probe                                                         #
# --------------------------------------------------------------------------- #
@pytest.fixture(scope="session")
def db_available(php_server):
    """Returns True when MySQL is reachable and galaxy.php renders content."""
    try:
        with urllib.request.urlopen(f"{BASE_URL}/galaxy.php?planet=infos", timeout=5) as r:
            return b"service offline" not in r.read()
    except Exception:
        return False


# --------------------------------------------------------------------------- #
# Chrome WebDriver                                                              #
# --------------------------------------------------------------------------- #
def _build_driver() -> webdriver.Chrome:
    opts = Options()
    keep_open = os.environ.get("KEEP_OPEN", "").lower() == "true"
    if not keep_open and os.environ.get("HEADLESS", "true").lower() != "false":
        opts.add_argument("--headless=new")
    opts.add_argument("--no-sandbox")
    opts.add_argument("--disable-dev-shm-usage")
    opts.add_argument("--disable-gpu")
    opts.add_argument("--window-size=1280,800")
    opts.binary_location = CHROME_BINARY

    # webdriver-manager downloads the ChromeDriver that matches the installed
    # Chrome version, bypassing any stale system-installed chromedriver.
    service = Service(ChromeDriverManager().install())
    driver = webdriver.Chrome(service=service, options=opts)
    driver.implicitly_wait(5)
    driver.set_page_load_timeout(20)
    return driver


@pytest.fixture
def driver(request):
    """Yield a fresh Chrome WebDriver for one test.

    Stores the live driver in item.stash so the pytest_runtest_makereport
    hook below can reach it for the end-of-test screenshot.

    Set KEEP_OPEN=true to leave the browser window open after the test
    finishes (forces headed mode automatically).
    """
    d = _build_driver()
    request.node.stash[_driver_stash_key] = d
    yield d
    try:
        del request.node.stash[_driver_stash_key]
    except KeyError:
        pass
    if os.environ.get("KEEP_OPEN", "").lower() != "true":
        d.quit()


# --------------------------------------------------------------------------- #
# Screenshot hook                                                               #
# --------------------------------------------------------------------------- #
@pytest.hookimpl(hookwrapper=True, tryfirst=True)
def pytest_runtest_makereport(item, call):
    """Take a screenshot after every test call and embed it in the HTML report.

    tryfirst=True makes this the outermost hookwrapper, so its "after yield"
    code runs last — after pytest-html has already populated report.extras.
    At that point the driver is still alive (fixture teardown is a separate
    phase that hasn't started yet), so get_screenshot_as_png() succeeds.
    """
    outcome = yield  # all other hooks (including pytest-html) run here

    report = outcome.get_result()
    if report.when != "call":
        return

    d = item.stash.get(_driver_stash_key, None)
    if d is None:
        return

    os.makedirs(SCREENSHOTS_DIR, exist_ok=True)
    os.makedirs(REPORT_DIR, exist_ok=True)
    safe_name = (
        item.nodeid
        .replace("/", "_")
        .replace("::", "_")
        .replace("[", "_")
        .replace("]", "_")
        .replace("?", "_")
        .replace("=", "_")
        .replace("&", "_")
        .replace(" ", "_")
    )
    path = os.path.join(SCREENSHOTS_DIR, f"{safe_name}.png")
    try:
        png = d.get_screenshot_as_png()
        with open(path, "wb") as fh:
            fh.write(png)
        # Relative path from the report directory so the HTML can find the file.
        # pytest-html's non-self-contained mode uses this as img src directly.
        rel_path = os.path.relpath(path, REPORT_DIR)
        extras = getattr(report, "extras", [])
        extras.append(pytest_html.extras.image(rel_path))
        report.extras = extras
    except Exception:
        pass  # never let a screenshot failure mask a real test result


# --------------------------------------------------------------------------- #
# Convenience: base_url as a plain fixture (alias for the session value)       #
# --------------------------------------------------------------------------- #
@pytest.fixture(scope="session")
def base_url(php_server):
    return php_server
