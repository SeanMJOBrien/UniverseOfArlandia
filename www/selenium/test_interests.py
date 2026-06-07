"""
Selenium tests for interests.php — the map-interest detail view.

Requires ?planet=&area= params pointing to live DB records.
Without DB: dies with "service offline".
With DB: tests discover live interest data from the space map at runtime.
"""

import re
import urllib.request
import pytest
from selenium.webdriver.common.by import By


def _scrape_interest_url(base_url: str, tile_suffix: str = "") -> tuple[str, str]:
    """Return (planet, area) from the first interest link on the space map.
    tile_suffix filters by GIF name (e.g. 'doma', 'dung') when set.
    """
    try:
        with urllib.request.urlopen(
            f"{base_url}/galaxy.php?planet=Space&system=Arlandia", timeout=8
        ) as r:
            html = r.read().decode("utf-8", errors="replace")

        if tile_suffix:
            pattern = (
                rf"href='(interests\.php\?planet=[^&']+&area=[^&']+[^']+)'"
                rf"[^>]*><img[^>]+src='[^']*{re.escape(tile_suffix)}[^']*'"
            )
        else:
            pattern = r"href='(interests\.php\?planet=[^&']+&area=[^&']+[^']+)'"

        m = re.search(pattern, html)
        if not m:
            return "", ""
        raw = m.group(1)
        pm = re.search(r"planet=([^&]+)", raw)
        am = re.search(r"area=([^&]+)", raw)
        if pm and am:
            return urllib.request.unquote(pm.group(1)), urllib.request.unquote(am.group(1))
    except Exception:
        pass
    return "", ""


# ---------------------------------------------------------------------------
# Graceful degradation (no DB)
# ---------------------------------------------------------------------------
class TestInterestsOffline:
    def test_service_offline_no_crash(self, driver, base_url, db_available):
        if db_available:
            pytest.skip("DB connected — offline test not applicable")
        driver.get(f"{base_url}/interests.php?planet=TestPlanet&area=0_0")
        text = driver.find_element(By.CSS_SELECTOR, "body").text
        assert "service offline" in text
        assert "Fatal error" not in text


# ---------------------------------------------------------------------------
# Common structure (first available interest)
# ---------------------------------------------------------------------------
class TestInterestsCommon:
    @pytest.fixture(scope="class")
    def interest_coords(self, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        planet, area = _scrape_interest_url(base_url)
        if not planet:
            pytest.skip("No interest data found in DB")
        return planet, area

    def test_body_not_blank(self, driver, base_url, interest_coords):
        planet, area = interest_coords
        driver.get(f"{base_url}/interests.php?planet={urllib.request.quote(planet)}&area={urllib.request.quote(area)}")
        text = driver.find_element(By.CSS_SELECTOR, "body").text.strip()
        assert len(text) > 0

    def test_heading_contains_known_interest_type(self, driver, base_url, interest_coords):
        planet, area = interest_coords
        driver.get(f"{base_url}/interests.php?planet={urllib.request.quote(planet)}&area={urllib.request.quote(area)}")
        text = driver.find_element(By.CSS_SELECTOR, "body").text
        known = ("Domain", "Dungeon", "Castle", "Ruins", "Animal reserve", "Resource mountain", "Amusement place")
        assert any(t in text for t in known), f"No known interest type in: {text[:300]}"

    def test_shows_planet_and_area_info(self, driver, base_url, interest_coords):
        planet, area = interest_coords
        driver.get(f"{base_url}/interests.php?planet={urllib.request.quote(planet)}&area={urllib.request.quote(area)}")
        text = driver.find_element(By.CSS_SELECTOR, "body").text
        assert "Planet" in text
        assert "Area" in text

    def test_back_to_map_link(self, driver, base_url, interest_coords):
        planet, area = interest_coords
        driver.get(f"{base_url}/interests.php?planet={urllib.request.quote(planet)}&area={urllib.request.quote(area)}")
        links = driver.find_elements(By.XPATH, '//a[contains(text(),"back to map")]')
        assert len(links) > 0, '"back to map" link not found'
        assert "galaxy.php" in links[0].get_attribute("href")

    def test_actualise_refresh_link(self, driver, base_url, interest_coords):
        planet, area = interest_coords
        driver.get(f"{base_url}/interests.php?planet={urllib.request.quote(planet)}&area={urllib.request.quote(area)}")
        links = driver.find_elements(By.XPATH, '//a[contains(text(),"actualise")]')
        assert len(links) > 0, '"actualise" link not found'
        assert "interests.php" in links[0].get_attribute("href")

    def test_no_php_errors(self, driver, base_url, interest_coords):
        planet, area = interest_coords
        driver.get(f"{base_url}/interests.php?planet={urllib.request.quote(planet)}&area={urllib.request.quote(area)}")
        text = driver.find_element(By.CSS_SELECTOR, "body").text
        assert "Fatal error" not in text
        assert "Warning:" not in text


# ---------------------------------------------------------------------------
# Domain interest type
# ---------------------------------------------------------------------------
class TestInterestsDomain:
    @pytest.fixture(scope="class")
    def domain_coords(self, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        planet, area = _scrape_interest_url(base_url, tile_suffix="doma")
        if not planet:
            pytest.skip("No domain interest found in DB")
        return planet, area

    def test_domain_informations_heading(self, driver, base_url, domain_coords):
        planet, area = domain_coords
        driver.get(f"{base_url}/interests.php?planet={urllib.request.quote(planet)}&area={urllib.request.quote(area)}")
        assert "Domain informations" in driver.find_element(By.CSS_SELECTOR, "body").text

    def test_domain_owner_label(self, driver, base_url, domain_coords):
        planet, area = domain_coords
        driver.get(f"{base_url}/interests.php?planet={urllib.request.quote(planet)}&area={urllib.request.quote(area)}")
        assert "Domain owner" in driver.find_element(By.CSS_SELECTOR, "body").text

    def test_domain_sectors_label(self, driver, base_url, domain_coords):
        planet, area = domain_coords
        driver.get(f"{base_url}/interests.php?planet={urllib.request.quote(planet)}&area={urllib.request.quote(area)}")
        assert "Domain sectors" in driver.find_element(By.CSS_SELECTOR, "body").text


# ---------------------------------------------------------------------------
# Dungeon interest type
# ---------------------------------------------------------------------------
class TestInterestsDungeon:
    @pytest.fixture(scope="class")
    def dungeon_coords(self, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        planet, area = _scrape_interest_url(base_url, tile_suffix="dung")
        if not planet:
            pytest.skip("No dungeon interest found in DB")
        return planet, area

    def test_dungeon_informations_heading(self, driver, base_url, dungeon_coords):
        planet, area = dungeon_coords
        driver.get(f"{base_url}/interests.php?planet={urllib.request.quote(planet)}&area={urllib.request.quote(area)}")
        assert "Dungeon informations" in driver.find_element(By.CSS_SELECTOR, "body").text

    def test_dungeon_type_label(self, driver, base_url, dungeon_coords):
        planet, area = dungeon_coords
        driver.get(f"{base_url}/interests.php?planet={urllib.request.quote(planet)}&area={urllib.request.quote(area)}")
        assert "Dungeon type" in driver.find_element(By.CSS_SELECTOR, "body").text

    def test_dungeon_monster_family_label(self, driver, base_url, dungeon_coords):
        planet, area = dungeon_coords
        driver.get(f"{base_url}/interests.php?planet={urllib.request.quote(planet)}&area={urllib.request.quote(area)}")
        assert "Dungeon monster family" in driver.find_element(By.CSS_SELECTOR, "body").text

    def test_dungeon_statut_label(self, driver, base_url, dungeon_coords):
        planet, area = dungeon_coords
        driver.get(f"{base_url}/interests.php?planet={urllib.request.quote(planet)}&area={urllib.request.quote(area)}")
        assert "Dungeon statut" in driver.find_element(By.CSS_SELECTOR, "body").text
