"""
Selenium tests for statut.php — the server-status iframe widget.

statut.php makes a server-side HTTP call to the Beamdog NWN API before
generating any output, so it can be slow to respond. Without DB it shows
"service offline". The meta-refresh tag (in <head>, before PHP connects to DB)
is always present.
"""

import pytest
from selenium.webdriver.common.by import By


class TestStatutStructure:
    def test_meta_refresh_60_seconds(self, driver, base_url):
        driver.set_page_load_timeout(35)
        driver.get(f"{base_url}/statut.php")
        meta = driver.find_element(By.CSS_SELECTOR, 'meta[http-equiv="refresh"]')
        assert meta.get_attribute("content") == "60"

    def test_body_is_not_blank(self, driver, base_url):
        driver.set_page_load_timeout(35)
        driver.get(f"{base_url}/statut.php")
        text = driver.find_element(By.CSS_SELECTOR, "body").text.strip()
        assert len(text) > 0, "statut.php body is empty"

    def test_shows_online_or_service_offline_no_crash(self, driver, base_url):
        driver.set_page_load_timeout(35)
        driver.get(f"{base_url}/statut.php")
        text = driver.find_element(By.CSS_SELECTOR, "body").text
        assert "Online" in text or "service offline" in text, (
            f"Expected 'Online' or 'service offline', got: {text[:200]}"
        )
        assert "Fatal error" not in text
        assert "Warning:" not in text


class TestStatutOnline:
    def test_shows_online_indicator(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.set_page_load_timeout(35)
        driver.get(f"{base_url}/statut.php")
        assert "Online" in driver.find_element(By.CSS_SELECTOR, "body").text

    def test_shows_player_count(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.set_page_load_timeout(35)
        driver.get(f"{base_url}/statut.php")
        assert "Players:" in driver.find_element(By.CSS_SELECTOR, "body").text

    def test_shows_next_reboot(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.set_page_load_timeout(35)
        driver.get(f"{base_url}/statut.php")
        assert "next reboot" in driver.find_element(By.CSS_SELECTOR, "body").text

    def test_shows_ingame_calendar(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.set_page_load_timeout(35)
        driver.get(f"{base_url}/statut.php")
        text = driver.find_element(By.CSS_SELECTOR, "body").text
        assert "date" in text
        assert "hour" in text
