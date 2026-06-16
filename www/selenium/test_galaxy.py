"""
Selenium tests for galaxy.php — planet/space map viewer and DM admin panel.

Without DB: every URL mode immediately outputs "service offline".
With DB:
  ?planet=infos         → DM player table with reset buttons
  ?planet=Space&system= → star-system space map with compass arrows
  ?planet=<name>        → planet surface map with info panel
"""

import urllib.request
from urllib.parse import urlparse, parse_qs
import pytest
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


def _parse_url_params(url: str) -> dict:
    """Flat {key: first-value} dict for a URL's query string."""
    return {k: v[0] for k, v in parse_qs(urlparse(url).query).items()}


def _arrow_link_href(driver, direction: str) -> str:
    """Return the href of the compass arrow <a> for the given cardinal direction."""
    img = driver.find_element(By.CSS_SELECTOR, f'img[alt="{direction}"]')
    link = driver.execute_script("return arguments[0].closest('a')", img)
    return link.get_attribute("href")


def _click_arrow(driver, direction: str) -> None:
    """Click a compass arrow and wait for the new page to finish loading."""
    img = driver.find_element(By.CSS_SELECTOR, f'img[alt="{direction}"]')
    link = driver.execute_script("return arguments[0].closest('a')", img)
    link.click()
    WebDriverWait(driver, 10).until(
        lambda d: d.execute_script("return document.readyState") == "complete"
    )


def _heading_u(driver):
    """Return the <u> element inside span.lbl that shows the current system/planet name."""
    return driver.find_element(By.CSS_SELECTOR, "span.lbl u")


def _col_labels(driver) -> list:
    """Numeric X-axis column labels from the map-grid header row."""
    rows = driver.find_element(By.CSS_SELECTOR, "table.map-grid").find_elements(By.TAG_NAME, "tr")
    labels = []
    for td in rows[0].find_elements(By.TAG_NAME, "td")[1:]:
        try:
            labels.append(int(td.text.strip()))
        except ValueError:
            pass
    return labels


def _row_labels(driver) -> list:
    """Numeric Y-axis row labels from the map-grid data rows."""
    rows = driver.find_element(By.CSS_SELECTOR, "table.map-grid").find_elements(By.TAG_NAME, "tr")
    labels = []
    for row in rows[1:]:
        tds = row.find_elements(By.TAG_NAME, "td")
        if tds:
            try:
                labels.append(int(tds[0].text.strip()))
            except ValueError:
                pass
    return labels


def _discover_planet(base_url: str) -> str:
    """Scrape the first planet link from index.php."""
    try:
        with urllib.request.urlopen(f"{base_url}/index.php", timeout=5) as r:
            html = r.read().decode("utf-8", errors="replace")
        import re
        m = re.search(r'galaxy\.php\?planet=([^&"]+)&login', html)
        return urllib.request.unquote(m.group(1)) if m else ""
    except Exception:
        return ""


# ---------------------------------------------------------------------------
# Graceful degradation (no DB)
# ---------------------------------------------------------------------------
class TestGalaxyOffline:
    @pytest.mark.parametrize("path", [
        "/galaxy.php?planet=infos",
        "/galaxy.php?planet=Space&system=Arlandia",
        "/galaxy.php?planet=Arlandia",
    ])
    def test_service_offline_no_crash(self, driver, base_url, db_available, path):
        if db_available:
            pytest.skip("DB connected — offline test not applicable")
        driver.get(f"{base_url}{path}")
        body_text = driver.find_element(By.CSS_SELECTOR, "body").text
        assert "service offline" in body_text, f"Expected 'service offline', got: {body_text[:200]}"
        assert "Fatal error" not in body_text


# ---------------------------------------------------------------------------
# ?planet=infos — DM player admin panel
# ---------------------------------------------------------------------------
class TestGalaxyInfos:
    def test_page_title(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=infos")
        assert driver.title == "UOA Galaxy Viewer"

    def test_player_table_column_headers(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=infos")
        table = driver.find_element(By.CSS_SELECTOR, "table")
        table_text = table.text
        for col in ("Player", "Character", "Planet", "Area", "Action"):
            assert col in table_text, f'Missing column header: "{col}"'

    def test_player_table_no_php_crash(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=infos")
        body_text = driver.find_element(By.CSS_SELECTOR, "body").text
        assert "Fatal error" not in body_text
        # Table must always be present
        assert driver.find_element(By.CSS_SELECTOR, "table").is_displayed()

    def test_reset_buttons_form_structure(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=infos")
        buttons = driver.find_elements(By.CSS_SELECTOR, "button.action-button")
        if not buttons:
            pytest.skip("No player data in DB")
        btn = buttons[0]
        assert "Set to 0,0" in btn.text
        form = driver.execute_script("return arguments[0].closest('form')", btn)
        assert form.get_attribute("method") == "post"
        action = form.get_attribute("action")
        assert "galaxy.php" in action and "planet=infos" in action

    def test_actualise_refresh_link(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=infos")
        links = driver.find_elements(By.XPATH, '//a[contains(.,"Actualise")]')
        assert len(links) > 0, "No 'Actualise' link found"
        href = links[0].get_attribute("href")
        assert "galaxy.php" in href and "planet=infos" in href

    def test_reset_success_feedback_message(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=infos&reset_success=TestChar")
        msg = driver.find_element(By.CSS_SELECTOR, ".feedback-message")
        assert msg.is_displayed()
        assert "TestChar" in msg.text
        assert "0,0" in msg.text


# ---------------------------------------------------------------------------
# ?planet=Space — star-system space map
# ---------------------------------------------------------------------------
class TestGalaxySpaceMap:
    def test_page_title(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=Space&system=Arlandia")
        assert driver.title == "UOA Galaxy Viewer"

    def test_compass_arrows_visible(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=Space&system=Arlandia")
        for direction in ("North", "South", "East", "West"):
            img = driver.find_element(By.CSS_SELECTOR, f'img[alt="{direction}"]')
            assert img.is_displayed(), f'{direction} arrow not visible'

    def test_compass_arrows_are_links(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=Space&system=Arlandia")
        north_img = driver.find_element(By.CSS_SELECTOR, 'img[alt="North"]')
        north_link = driver.execute_script("return arguments[0].closest('a')", north_img)
        href = north_link.get_attribute("href")
        assert "galaxy.php" in href and "planet=Space" in href

    def test_map_grid_has_multiple_rows(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=Space&system=Arlandia")
        tables = driver.find_elements(By.CSS_SELECTOR, "table")
        map_table = tables[-1]
        rows = map_table.find_elements(By.CSS_SELECTOR, "tr")
        assert len(rows) >= 2, f"Expected ≥2 rows in map table, found: {len(rows)}"


# ---------------------------------------------------------------------------
# ?planet=Space — compass-arrow panning, heading derivation, recenter link
# ---------------------------------------------------------------------------
class TestGalaxySpaceMapNavigation:
    """
    Mirrors the Playwright navigation tests in galaxy.spec.js:
    arrow-pan math, axis-label shifts, round-trips, negative sectors,
    nearest-SystemCenter heading logic, and the click-to-recenter link.
    """

    _BASE   = "/galaxy.php?planet=Space&galaxyx=2&galaxyy=3"
    _ORIGIN = "/galaxy.php?planet=Space&galaxyx=0&galaxyy=0"

    def test_arrow_links_pan_one_sector(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}{self._BASE}")
        expected = {
            "North": {"galaxyx": "2", "galaxyy": "4"},
            "South": {"galaxyx": "2", "galaxyy": "2"},
            "East":  {"galaxyx": "3", "galaxyy": "3"},
            "West":  {"galaxyx": "1", "galaxyy": "3"},
        }
        for direction, exp in expected.items():
            params = _parse_url_params(_arrow_link_href(driver, direction))
            assert params.get("galaxyx") == exp["galaxyx"], f"{direction}: wrong galaxyx"
            assert params.get("galaxyy") == exp["galaxyy"], f"{direction}: wrong galaxyy"

    def test_clicking_east_rerenders_at_new_sector(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}{self._BASE}")
        _click_arrow(driver, "East")
        params = _parse_url_params(driver.current_url)
        assert params.get("galaxyx") == "3"
        assert params.get("galaxyy") == "3"
        for direction in ("North", "South", "East", "West"):
            assert driver.find_element(By.CSS_SELECTOR, f'img[alt="{direction}"]').is_displayed()
        assert driver.find_element(By.CSS_SELECTOR, "table.map-grid").is_displayed()
        body = driver.find_element(By.CSS_SELECTOR, "body").text
        assert "Fatal error" not in body
        assert "Warning:" not in body

    def test_axis_labels_shift_15_after_east(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}{self._BASE}")
        before = _col_labels(driver)
        _click_arrow(driver, "East")
        after = _col_labels(driver)
        assert before and len(after) == len(before)
        for b, a in zip(before, after):
            assert a - b == 15, f"Expected +15, got {a - b}"

    def test_axis_labels_shift_15_after_north(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}{self._BASE}")
        before = _row_labels(driver)
        _click_arrow(driver, "North")
        after = _row_labels(driver)
        assert before and len(after) == len(before)
        for b, a in zip(before, after):
            assert a - b == 15, f"Expected +15, got {a - b}"

    def test_east_then_west_round_trips(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}{self._BASE}")
        _click_arrow(driver, "East")
        _click_arrow(driver, "West")
        params = _parse_url_params(driver.current_url)
        assert params.get("galaxyx") == "2"
        assert params.get("galaxyy") == "3"

    def test_negative_sectors_render_correctly(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}{self._ORIGIN}")
        _click_arrow(driver, "West")
        _click_arrow(driver, "South")
        params = _parse_url_params(driver.current_url)
        assert params.get("galaxyx") == "-1"
        assert params.get("galaxyy") == "-1"
        assert driver.find_element(By.CSS_SELECTOR, "table.map-grid").is_displayed()
        assert driver.find_element(By.CSS_SELECTOR, 'img[alt="North"]').is_displayed()
        assert any(v < 0 for v in _col_labels(driver)), "No negative column labels"
        assert any(v < 0 for v in _row_labels(driver)), "No negative row labels"
        body = driver.find_element(By.CSS_SELECTOR, "body").text
        assert "Fatal error" not in body
        assert "Warning:" not in body

    def test_heading_non_blank_after_arrow_drops_system(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=Space&system=Meth&galaxyx=0&galaxyy=0")
        assert _heading_u(driver).text.strip() == "Meth"
        _click_arrow(driver, "East")
        heading = _heading_u(driver).text.strip()
        assert heading, "Heading went blank after arrow navigation (original bug regressed)"
        assert "Fatal error" not in driver.find_element(By.CSS_SELECTOR, "body").text

    def test_heading_switches_system_when_panning(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=Space&galaxyx=0&galaxyy=0")
        here = _heading_u(driver).text.strip()
        if here == "Space":
            pytest.skip("No *SystemCenter data seeded — skipping system-transition test")
        driver.get(f"{base_url}/galaxy.php?planet=Space&galaxyx=2&galaxyy=0")
        there = _heading_u(driver).text.strip()
        assert there != "Space"
        assert there != here

    def test_heading_shows_space_when_far(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=Space&galaxyx=100&galaxyy=100")
        assert _heading_u(driver).text.strip() == "Space"
        assert "Fatal error" not in driver.find_element(By.CSS_SELECTOR, "body").text

    def test_clicking_heading_centers_on_home_sector(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=Space&galaxyx=3&galaxyy=0")
        heading_u = _heading_u(driver)
        name = heading_u.text.strip()
        if name == "Space":
            pytest.skip("No *SystemCenter data seeded — heading is not a link")
        heading_link = heading_u.find_element(By.TAG_NAME, "a")
        assert heading_link.text.strip() == name
        heading_link.click()
        WebDriverWait(driver, 10).until(
            lambda d: d.execute_script("return document.readyState") == "complete"
        )
        params = _parse_url_params(driver.current_url)
        assert params.get("planet") == "Space"
        # Distance from home sector to itself is 0 — same name is still nearest
        assert _heading_u(driver).text.strip() == name
        assert "Fatal error" not in driver.find_element(By.CSS_SELECTOR, "body").text

    def test_heading_is_plain_text_not_link_for_space(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/galaxy.php?planet=Space&galaxyx=100&galaxyy=100")
        heading_u = _heading_u(driver)
        assert heading_u.text.strip() == "Space"
        assert not heading_u.find_elements(By.TAG_NAME, "a"), "Heading 'Space' should not be a link"


# ---------------------------------------------------------------------------
# ?planet=<name> — planet surface map
# ---------------------------------------------------------------------------
class TestGalaxyPlanetMap:
    @pytest.fixture(scope="class")
    def test_planet(self, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        planet = _discover_planet(base_url)
        if not planet:
            pytest.skip("No planet data found in DB")
        return planet

    def test_planet_name_in_page(self, driver, base_url, test_planet):
        driver.get(f"{base_url}/galaxy.php?planet={urllib.request.quote(test_planet)}")
        assert test_planet in driver.find_element(By.CSS_SELECTOR, "body").text

    def test_info_panel_has_position_and_level(self, driver, base_url, test_planet):
        driver.get(f"{base_url}/galaxy.php?planet={urllib.request.quote(test_planet)}")
        body_text = driver.find_element(By.CSS_SELECTOR, "body").text
        assert "Position" in body_text
        assert "Level" in body_text

    def test_time_indicator_image(self, driver, base_url, test_planet):
        driver.get(f"{base_url}/galaxy.php?planet={urllib.request.quote(test_planet)}")
        found = any(
            driver.find_elements(By.CSS_SELECTOR, f'img[alt="{alt}"]')
            for alt in ("Day", "Night")
        )
        assert found, "No Day/Night time indicator image found"

    def test_weather_indicator_image(self, driver, base_url, test_planet):
        driver.get(f"{base_url}/galaxy.php?planet={urllib.request.quote(test_planet)}")
        found = any(
            driver.find_elements(By.CSS_SELECTOR, f'img[alt="{alt}"]')
            for alt in ("Clear", "Rain", "Snow", "Fog", "Storm")
        )
        assert found, "No weather indicator image found"

    def test_map_grid_renders(self, driver, base_url, test_planet):
        driver.get(f"{base_url}/galaxy.php?planet={urllib.request.quote(test_planet)}")
        tables = driver.find_elements(By.CSS_SELECTOR, "table")
        assert tables, "No table found on planet page"
        rows = tables[-1].find_elements(By.CSS_SELECTOR, "tr")
        assert len(rows) >= 2, f"Expected ≥2 map rows, found: {len(rows)}"


# make urllib.request.quote available to class methods
import urllib.request
