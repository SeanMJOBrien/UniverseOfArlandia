"""
Selenium tests for index.php — the main 3-column shell page.

Without DB: PHP renders the left nav then dies at the galaxy query.
Title, header, nav links, status iframe, and DM login form are emitted before
that point and are always testable.

DB-dependent sections (content iframe, footer, star-systems column) are
pytest.skip()-ed when the database is unreachable.
"""

import os
import pytest
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


BASE_URL_SESSION = None  # set via fixture injection in each test


# ---------------------------------------------------------------------------
# Page structure — always testable (rendered before the DB query that dies)
# ---------------------------------------------------------------------------
class TestIndexStructure:
    def test_page_title(self, driver, base_url):
        driver.get(f"{base_url}/index.php")
        assert driver.title == "Universe of Arlandia"

    def test_main_header(self, driver, base_url):
        driver.get(f"{base_url}/index.php")
        h1 = driver.find_element(By.CSS_SELECTOR, "h1.page-title")
        assert "The Universe of Arlandia" in h1.text
        subtitle = driver.find_element(By.CSS_SELECTOR, "p.page-subtitle")
        assert "For Neverwinter Nights" in subtitle.text

    def test_server_ip_address(self, driver, base_url):
        driver.get(f"{base_url}/index.php")
        ip = driver.find_element(By.CSS_SELECTOR, ".ip-address")
        assert "uoanwn.homeip.net" in ip.text

    def test_left_nav_section_headings(self, driver, base_url):
        driver.get(f"{base_url}/index.php")
        nav = driver.find_element(By.CSS_SELECTOR, "td.nav-cell")
        nav_text = nav.text
        for heading in ("Server status", "Connection", "Module", "Characters", "Community", "DM area"):
            assert heading in nav_text, f'Missing nav heading: "{heading}"'

    def test_status_iframe_src(self, driver, base_url):
        driver.get(f"{base_url}/index.php")
        iframe = driver.find_element(By.CSS_SELECTOR, 'iframe[name="Status"]')
        assert iframe.get_attribute("src").endswith("statut.php")
        assert "status-iframe" in iframe.get_attribute("class")

    @pytest.mark.parametrize("href,label", [
        ("news.html",        "Home/News"),
        ("description.html", "Description"),
        ("screenshots.html", "Screenshots"),
        ("interests.html",   "Interests"),
        ("domains.html",     "Domains"),
        ("crafting.html",    "Crafting"),
    ])
    def test_module_nav_links(self, driver, base_url, href, label):
        driver.get(f"{base_url}/index.php")
        link = driver.find_element(By.CSS_SELECTOR, f'a[href="{href}"]')
        assert label in link.text, f"{href} link text was: {link.text!r}"
        assert link.get_attribute("target") == "UOA_Frame"

    @pytest.mark.parametrize("href", [
        "races.html", "classes.html", "feats.html", "grades.html", "talents.html",
    ])
    def test_characters_nav_links(self, driver, base_url, href):
        driver.get(f"{base_url}/index.php")
        link = driver.find_element(By.CSS_SELECTOR, f'a[href="{href}"]')
        assert link.get_attribute("target") == "UOA_Frame"

    def test_community_nav_links(self, driver, base_url):
        driver.get(f"{base_url}/index.php")
        for href in ("downloads.html", "links.html", "contact.html"):
            link = driver.find_element(By.CSS_SELECTOR, f'a[href="{href}"]')
            assert link.is_displayed(), f"{href} link not visible"

    def test_forum_link_opens_new_tab(self, driver, base_url):
        driver.get(f"{base_url}/index.php")
        forum = driver.find_element(By.XPATH, '//a[contains(text(),"Forum")]')
        assert forum.get_attribute("target") == "_blank"

    def test_dm_login_form_structure(self, driver, base_url):
        driver.get(f"{base_url}/index.php")
        form = driver.find_element(By.CSS_SELECTOR, 'form[name="dmarea"]')
        assert form.get_attribute("action").endswith("index.php")
        assert form.get_attribute("method") == "post"
        pw = form.find_element(By.CSS_SELECTOR, 'input[type="password"][name="login"]')
        assert pw.is_displayed()


# ---------------------------------------------------------------------------
# DB-dependent full-page content
# ---------------------------------------------------------------------------
class TestIndexDbContent:
    def test_content_iframe(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/index.php")
        iframe = driver.find_element(By.CSS_SELECTOR, 'iframe[name="UOA_Frame"]')
        assert iframe.is_displayed()
        assert iframe.get_attribute("src").endswith("news.html")
        assert "content-iframe" in iframe.get_attribute("class")

    def test_footer_copyright(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/index.php")
        footer = driver.find_element(By.CSS_SELECTOR, "footer")
        assert "TheRack" in footer.text
        assert "2009-2011" in footer.text

    def test_right_nav_column_present(self, driver, base_url, db_available):
        if not db_available:
            pytest.skip("Database not connected")
        driver.get(f"{base_url}/index.php")
        nav_cells = driver.find_elements(By.CSS_SELECTOR, "td.nav-cell")
        assert len(nav_cells) >= 2, f"Expected ≥2 nav cells, found: {len(nav_cells)}"


# ---------------------------------------------------------------------------
# DM login behaviour
# ---------------------------------------------------------------------------
class TestIndexDmLogin:
    def test_logout_shows_login_form(self, driver, base_url):
        driver.get(f"{base_url}/index.php?logout=1")
        pw = driver.find_element(By.CSS_SELECTOR, 'input[type="password"][name="login"]')
        assert pw.is_displayed()
        dm_links = driver.find_elements(By.CSS_SELECTOR, 'a[href*="galaxy.php?planet=infos"]')
        assert len(dm_links) == 0, "DM link should not appear after logout"

    def test_wrong_password_keeps_form(self, driver, base_url):
        driver.get(f"{base_url}/index.php")
        pw = driver.find_element(By.CSS_SELECTOR, 'input[type="password"][name="login"]')
        pw.send_keys("wrong_password_xyz")
        driver.execute_script('document.querySelector(\'form[name="dmarea"]\').submit()')
        wait = WebDriverWait(driver, 8)
        pw_reloaded = wait.until(
            EC.presence_of_element_located((By.CSS_SELECTOR, 'input[type="password"][name="login"]'))
        )
        assert pw_reloaded.is_displayed()

    def test_correct_dm_password_shows_dm_links(self, driver, base_url, db_available):
        dm_password = os.environ.get("UOA_DM_PASSWORD")
        if not dm_password or not db_available:
            pytest.skip("Set UOA_DM_PASSWORD env var with DB running to test DM login")
        driver.get(f"{base_url}/index.php")
        pw = driver.find_element(By.CSS_SELECTOR, 'input[type="password"][name="login"]')
        pw.send_keys(dm_password)
        driver.execute_script('document.querySelector(\'form[name="dmarea"]\').submit()')
        wait = WebDriverWait(driver, 8)
        info_link = wait.until(
            EC.presence_of_element_located((By.CSS_SELECTOR, 'a[href*="galaxy.php?planet=infos"]'))
        )
        assert info_link.is_displayed()
        logout = driver.find_element(By.CSS_SELECTOR, 'a[href="index.php?logout=1"]')
        assert logout.is_displayed()
