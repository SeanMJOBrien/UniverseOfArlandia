"""
Selenium tests for all static HTML pages.

No DB or PHP needed. Each page is checked for:
  1. Successful load (body renders in the browser).
  2. Non-blank, non-error body text.
  3. Page-specific key content.
"""

import pytest
from selenium.webdriver.common.by import By


STATIC_PAGES = [
    "/news.html",
    "/description.html",
    "/screenshots.html",
    "/interests.html",
    "/domains.html",
    "/crafting.html",
    "/races.html",
    "/classes.html",
    "/feats.html",
    "/grades.html",
    "/talents.html",
    "/downloads.html",
    "/links.html",
    "/contact.html",
    "/installation.html",
    "/factory.html",
]


# ---------------------------------------------------------------------------
# Smoke-load every static page
# ---------------------------------------------------------------------------
class TestStaticPagesSmoke:
    @pytest.mark.parametrize("path", STATIC_PAGES)
    def test_page_loads_with_content(self, driver, base_url, path):
        driver.get(f"{base_url}{path}")
        text = driver.find_element(By.CSS_SELECTOR, "body").text.strip()
        assert len(text) > 20, f"Body too short for {path}: {text!r}"
        assert "Fatal error" not in text, f"PHP error on {path}"


# ---------------------------------------------------------------------------
# screenshots.html — lightbox image gallery
# ---------------------------------------------------------------------------
class TestScreenshots:
    def test_contains_at_least_one_image(self, driver, base_url):
        driver.get(f"{base_url}/screenshots.html")
        imgs = driver.find_elements(By.CSS_SELECTOR, "img")
        assert len(imgs) > 0, "No <img> elements on screenshots page"

    def test_lightbox_js_is_referenced(self, driver, base_url):
        driver.get(f"{base_url}/screenshots.html")
        scripts = driver.find_elements(By.CSS_SELECTOR, "script[src]")
        srcs = [s.get_attribute("src") for s in scripts]
        has_lightbox = any(
            "lightbox" in (src or "") or "prototype" in (src or "")
            for src in srcs
        )
        assert has_lightbox, f"Lightbox/prototype JS not found. Script srcs: {srcs}"


# ---------------------------------------------------------------------------
# downloads.html — must have at least one link
# ---------------------------------------------------------------------------
class TestDownloads:
    def test_has_at_least_one_link(self, driver, base_url):
        driver.get(f"{base_url}/downloads.html")
        links = driver.find_elements(By.CSS_SELECTOR, "a[href]")
        assert len(links) > 0, "No links on downloads page"


# ---------------------------------------------------------------------------
# news.html — default content-pane page
# ---------------------------------------------------------------------------
class TestNews:
    def test_body_has_content(self, driver, base_url):
        driver.get(f"{base_url}/news.html")
        text = driver.find_element(By.CSS_SELECTOR, "body").text.strip()
        assert len(text) > 20, f"news.html body too short: {text!r}"


# ---------------------------------------------------------------------------
# description.html — module overview
# ---------------------------------------------------------------------------
class TestDescription:
    def test_body_has_content(self, driver, base_url):
        driver.get(f"{base_url}/description.html")
        text = driver.find_element(By.CSS_SELECTOR, "body").text.strip()
        assert len(text) > 50, f"description.html body too short: {text!r}"


# ---------------------------------------------------------------------------
# crafting.html
# ---------------------------------------------------------------------------
class TestCrafting:
    def test_body_has_content(self, driver, base_url):
        driver.get(f"{base_url}/crafting.html")
        assert len(driver.find_element(By.CSS_SELECTOR, "body").text.strip()) > 20


# ---------------------------------------------------------------------------
# races.html / classes.html — character info pages
# ---------------------------------------------------------------------------
class TestCharacterPages:
    @pytest.mark.parametrize("path", ["/races.html", "/classes.html", "/feats.html"])
    def test_body_has_content(self, driver, base_url, path):
        driver.get(f"{base_url}{path}")
        assert len(driver.find_element(By.CSS_SELECTOR, "body").text.strip()) > 20
