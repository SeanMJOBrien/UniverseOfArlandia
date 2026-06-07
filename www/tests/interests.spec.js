/**
 * Tests for interests.php — the map-interest detail view.
 *
 * Requires ?planet=<name>&area=<X_Y> query params referencing real DB records.
 * Without DB the page immediately dies with "service offline".
 * With DB the page varies by interest type (D/1/2/3/4/5); common elements
 * (title, planet/area info, back-to-map link, refresh link) are always present.
 *
 * Interest-type-specific tests discover live data from the galaxy before running.
 */

const { test, expect } = require('@playwright/test');
const { isDbConnected } = require('./helpers/db');

let dbAvailable = false;

test.beforeAll(async ({ request }) => {
  dbAvailable = await isDbConnected(request);
});

// ---------------------------------------------------------------------------
// Graceful degradation
// ---------------------------------------------------------------------------
test.describe('interests.php — without DB', () => {
  test('shows "service offline" without a PHP crash', async ({ page }) => {
    test.skip(dbAvailable, 'DB is connected — graceful-degradation test not applicable');
    await page.goto('/interests.php?planet=TestPlanet&area=0_0', { waitUntil: 'domcontentloaded' });
    const body = await page.textContent('body');
    expect(body).toContain('service offline');
    await expect(page.locator('body')).not.toContainText('Fatal error');
    await expect(page.locator('body')).not.toContainText('Warning:');
  });
});

// ---------------------------------------------------------------------------
// Common page structure — present for every interest type when DB is connected
// ---------------------------------------------------------------------------
test.describe('interests.php — common structure', () => {
  /** planet and area discovered at runtime from live galaxy data */
  let testPlanet = '';
  let testArea   = '';

  test.beforeAll(async ({ request }) => {
    if (!dbAvailable) return;
    try {
      // galaxy.php renders tile <a> links to interests.php when interests exist.
      // We scrape the first one to get a real planet+area combination.
      const response = await request.get('/galaxy.php?planet=Space&system=Arlandia');
      const html = await response.text();
      const match = html.match(/interests\.php\?planet=([^&"]+)&area=([^&"]+)/);
      if (match) {
        testPlanet = decodeURIComponent(match[1]);
        testArea   = decodeURIComponent(match[2]);
      }
    } catch {
      // leave empty — tests will skip
    }
  });

  test.beforeEach(async ({ page }) => {
    test.skip(!dbAvailable || !testPlanet, 'Database not connected or no interest data found');
    await page.goto(
      `/interests.php?planet=${encodeURIComponent(testPlanet)}&area=${encodeURIComponent(testArea)}`,
      { waitUntil: 'domcontentloaded' }
    );
  });

  test('page body is not blank', async ({ page }) => {
    const text = await page.textContent('body');
    expect(text?.trim().length).toBeGreaterThan(0);
  });

  test('displays the interest type in the heading', async ({ page }) => {
    // Heading always contains one of the known interest type names
    const knownTitles = ['Domain', 'Dungeon', 'Castle', 'Ruins', 'Animal reserve', 'Resource mountain', 'Amusement place'];
    const body = await page.textContent('body');
    const found = knownTitles.some(t => body?.includes(t));
    expect(found).toBeTruthy();
  });

  test('shows planet and area info table', async ({ page }) => {
    await expect(page.locator('body')).toContainText('Planet');
    await expect(page.locator('body')).toContainText('Area');
  });

  test('has "back to map" link pointing to galaxy.php', async ({ page }) => {
    const backLink = page.locator('a').filter({ hasText: 'back to map' });
    await expect(backLink).toBeVisible();
    await expect(backLink).toHaveAttribute('href', /galaxy\.php/);
  });

  test('has "actualise" self-refresh link', async ({ page }) => {
    const refreshLink = page.locator('a').filter({ hasText: 'actualise' });
    await expect(refreshLink.first()).toBeVisible();
    await expect(refreshLink.first()).toHaveAttribute('href', /interests\.php/);
  });

  test('no PHP errors in output', async ({ page }) => {
    await expect(page.locator('body')).not.toContainText('Fatal error');
    await expect(page.locator('body')).not.toContainText('Warning:');
  });
});

// ---------------------------------------------------------------------------
// Interest type: Domain (inttype === 'D')
// ---------------------------------------------------------------------------
test.describe('interests.php — Domain interest type', () => {
  let domainPlanet = '';
  let domainArea   = '';

  test.beforeAll(async ({ request }) => {
    if (!dbAvailable) return;
    try {
      // Search galaxy map for domain tiles (domain tile filenames contain "_doma")
      const response = await request.get('/galaxy.php?planet=Space&system=Arlandia');
      const html = await response.text();
      // Domain interest links use inttype='D', so the interest URL is the same as others
      // Try to find a domain interest by checking the tile alt text
      const match = html.match(/href='(interests\.php\?planet=[^&']+&area=[^&']+[^']+)'[^>]*><img[^>]+src='[^']*doma[^']*'/);
      if (match) {
        const url = new URL(match[1], 'http://localhost:8765');
        domainPlanet = url.searchParams.get('planet') || '';
        domainArea   = url.searchParams.get('area') || '';
      }
    } catch {
      // leave empty — tests will skip
    }
  });

  test.beforeEach(async ({ page }) => {
    test.skip(!dbAvailable || !domainPlanet, 'No domain interest data found in DB');
    await page.goto(
      `/interests.php?planet=${encodeURIComponent(domainPlanet)}&area=${encodeURIComponent(domainArea)}`,
      { waitUntil: 'domcontentloaded' }
    );
  });

  test('shows "Domain informations" heading', async ({ page }) => {
    await expect(page.locator('body')).toContainText('Domain informations');
  });

  test('shows Domain owner', async ({ page }) => {
    await expect(page.locator('body')).toContainText('Domain owner');
  });

  test('shows Domain sectors', async ({ page }) => {
    await expect(page.locator('body')).toContainText('Domain sectors');
  });
});

// ---------------------------------------------------------------------------
// Interest type: Dungeon (inttype === '2')
// ---------------------------------------------------------------------------
test.describe('interests.php — Dungeon interest type', () => {
  let dungeonPlanet = '';
  let dungeonArea   = '';

  test.beforeAll(async ({ request }) => {
    if (!dbAvailable) return;
    try {
      const response = await request.get('/galaxy.php?planet=Space&system=Arlandia');
      const html = await response.text();
      const match = html.match(/href='(interests\.php\?planet=[^&']+&area=[^&']+[^']+)'[^>]*><img[^>]+src='[^']*dung[^']*'/);
      if (match) {
        const url = new URL(match[1], 'http://localhost:8765');
        dungeonPlanet = url.searchParams.get('planet') || '';
        dungeonArea   = url.searchParams.get('area') || '';
      }
    } catch {
      // leave empty — tests will skip
    }
  });

  test.beforeEach(async ({ page }) => {
    test.skip(!dbAvailable || !dungeonPlanet, 'No dungeon interest data found in DB');
    await page.goto(
      `/interests.php?planet=${encodeURIComponent(dungeonPlanet)}&area=${encodeURIComponent(dungeonArea)}`,
      { waitUntil: 'domcontentloaded' }
    );
  });

  test('shows "Dungeon informations" heading', async ({ page }) => {
    await expect(page.locator('body')).toContainText('Dungeon informations');
  });

  test('shows Dungeon type', async ({ page }) => {
    await expect(page.locator('body')).toContainText('Dungeon type');
  });

  test('shows Dungeon monster family', async ({ page }) => {
    await expect(page.locator('body')).toContainText('Dungeon monster family');
  });

  test('shows Dungeon status (Empty/Started/Full)', async ({ page }) => {
    await expect(page.locator('body')).toContainText('Dungeon statut');
  });
});
