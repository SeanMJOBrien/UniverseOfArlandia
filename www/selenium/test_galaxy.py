"""
Selenium tests for galaxy.php — planet/space map viewer and DM admin panel.

Without DB: every URL mode immediately outputs "service offline".
With DB:
  ?planet=infos         → DM player table with reset buttons
  ?planet=Space&system= → star-system space map with compass arrows
  ?planet=<name>        → planet surface map with info panel
"""

import urllib.request
import pytest
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


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
        links = driver.find_elements(By.XPATH, '//a[contains(text(),"Actualise")]')
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
