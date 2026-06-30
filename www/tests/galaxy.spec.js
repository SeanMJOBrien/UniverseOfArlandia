/**
 * Tests for galaxy.php — the planet/space map viewer and DM admin panel.
 *
 * Without DB: every mode immediately calls die("service offline").
 * With DB:
 *   ?planet=infos         → DM player table
 *   ?planet=Space&system= → star-system space map with compass arrows
 *   ?planet=<name>        → planet surface map with info panel
 */

const { test, expect } = require('@playwright/test');
const { isDbConnected } = require('./helpers/db');

let dbAvailable = false;

test.beforeAll(async ({ request }) => {
  dbAvailable = await isDbConnected(request);
});

// Locate a compass-arrow link by its image alt text (North/South/East/West)
function arrowLink(page, direction) {
  return page.locator('a').filter({ has: page.locator(`img[alt="${direction}"]`) });
}

// Pull galaxyx/galaxyy out of a galaxy.php href
function parseGalaxyParams(href) {
  const url = new URL(href, 'http://localhost');
  return {
    galaxyx: Number(url.searchParams.get('galaxyx')),
    galaxyy: Number(url.searchParams.get('galaxyy')),
  };
}

// ---------------------------------------------------------------------------
// Graceful degradation — always testable
// ---------------------------------------------------------------------------
test.describe('galaxy.php — without DB', () => {
  for (const url of [
    '/galaxy.php?planet=infos',
    '/galaxy.php?planet=Space&system=Arlandia',
    '/galaxy.php?planet=Arlandia',
  ]) {
    test(`${url} responds without a PHP crash`, async ({ page }) => {
      test.skip(dbAvailable, 'DB is connected — graceful-degradation test not applicable');
      await page.goto(url, { waitUntil: 'domcontentloaded' });
      const body = await page.textContent('body');
      // Must show the friendly "service offline" message, not an unhandled PHP error
      expect(body).toContain('service offline');
      await expect(page.locator('body')).not.toContainText('Fatal error');
      await expect(page.locator('body')).not.toContainText('Warning:');
    });
  }
});

// ---------------------------------------------------------------------------
// ?planet=infos — DM player admin panel
// ---------------------------------------------------------------------------
test.describe('galaxy.php?planet=infos — player admin panel', () => {
  test.beforeEach(async ({ page }) => {
    test.skip(!dbAvailable, 'Database not connected');
    await page.goto('/galaxy.php?planet=infos', { waitUntil: 'domcontentloaded' });
  });

  test('page title is present', async ({ page }) => {
    await expect(page).toHaveTitle('UOA Galaxy Viewer');
  });

  test('player table has expected column headers', async ({ page }) => {
    const table = page.locator('[data-testid="player-table"]');
    await expect(table).toBeVisible();
    await expect(table.locator('td').filter({ hasText: 'Player' }).first()).toBeVisible();
    await expect(table.locator('td').filter({ hasText: 'Character' }).first()).toBeVisible();
    await expect(table.locator('td').filter({ hasText: 'Planet' }).first()).toBeVisible();
    await expect(table.locator('td').filter({ hasText: 'Area' }).first()).toBeVisible();
    await expect(table.locator('td').filter({ hasText: 'Action' }).first()).toBeVisible();
  });

  test('player table body shows data or empty message — no PHP crash', async ({ page }) => {
    // The table renders either player rows with action buttons, the "No player data
    // found" message (when pwdata has zero Player* keys), or silently empty rows
    // (when Player* records exist but have no account name set). All three are valid.
    await expect(page.locator('[data-testid="player-table"]')).toBeVisible();
    await expect(page.locator('body')).not.toContainText('Fatal error');
    // If the "No player data found" message is present it should be inside the table
    const emptyMsg = page.locator('text=No player data found');
    if (await emptyMsg.count() > 0) {
      await expect(emptyMsg).toBeVisible();
    }
  });

  test('player rows have a "Set to 0,0" reset button', async ({ page }) => {
    const buttons = page.locator('button.action-button');
    const count = await buttons.count();
    if (count > 0) {
      await expect(buttons.first()).toContainText('Set to 0,0');
      // Button is inside a form that POSTs to galaxy.php?planet=infos
      const form = buttons.first().locator('xpath=ancestor::form');
      await expect(form).toHaveAttribute('method', 'post');
      await expect(form).toHaveAttribute('action', /galaxy\.php\?planet=infos/);
    }
  });

  test('has Actualise refresh link', async ({ page }) => {
    const links = page.locator('a').filter({ hasText: 'Actualise' });
    await expect(links.first()).toBeVisible();
    await expect(links.first()).toHaveAttribute('href', 'galaxy.php?planet=infos');
  });

  test('reset success message renders after redirect', async ({ page }) => {
    // Simulate the redirect that happens after a successful reset POST
    await page.goto('/galaxy.php?planet=infos&reset_success=TestChar', { waitUntil: 'domcontentloaded' });
    await expect(page.locator('.feedback-message')).toBeVisible();
    await expect(page.locator('.feedback-message')).toContainText('TestChar');
    await expect(page.locator('.feedback-message')).toContainText('0,0');
  });
});

// ---------------------------------------------------------------------------
// ?planet=Space — star-system space map
// ---------------------------------------------------------------------------
test.describe('galaxy.php?planet=Space — space map', () => {
  test.beforeEach(async ({ page }) => {
    test.skip(!dbAvailable, 'Database not connected');
    await page.goto('/galaxy.php?planet=Space&system=Meth', { waitUntil: 'domcontentloaded' });
  });

  test('page title is present', async ({ page }) => {
    await expect(page).toHaveTitle('UOA Galaxy Viewer');
  });

  test('renders compass navigation arrows', async ({ page }) => {
    await expect(page.locator('img[alt="North"]')).toBeVisible();
    await expect(page.locator('img[alt="South"]')).toBeVisible();
    await expect(page.locator('img[alt="East"]')).toBeVisible();
    await expect(page.locator('img[alt="West"]')).toBeVisible();
  });

  test('compass arrows are navigation links', async ({ page }) => {
    const northLink = page.locator('a').filter({ has: page.locator('img[alt="North"]') });
    await expect(northLink).toHaveAttribute('href', /galaxy\.php\?planet=Space/);
  });

  test('renders map grid table with multiple rows', async ({ page }) => {
    // The map is a <table> with rows of tile cells
    const mapTable = page.locator('table.map-grid');
    await expect(mapTable).toBeVisible();
    const rowCount = await mapTable.locator('tr').count();
    expect(rowCount).toBeGreaterThanOrEqual(2);
  });

  // -------------------------------------------------------------------------
  // Compass-arrow panning math, grid re-render, and the nearest-SystemCenter
  // heading (see galaxy.php $system_centers / $planetname).
  // -------------------------------------------------------------------------
  test('arrow links pan by exactly one sector in the expected direction', async ({ page }) => {
    await page.goto('/galaxy.php?planet=Space&galaxyx=2&galaxyy=3', { waitUntil: 'domcontentloaded' });

    expect(parseGalaxyParams(await arrowLink(page, 'North').getAttribute('href')))
      .toEqual({ galaxyx: 2, galaxyy: 4 });
    expect(parseGalaxyParams(await arrowLink(page, 'South').getAttribute('href')))
      .toEqual({ galaxyx: 2, galaxyy: 2 });
    expect(parseGalaxyParams(await arrowLink(page, 'East').getAttribute('href')))
      .toEqual({ galaxyx: 3, galaxyy: 3 });
    expect(parseGalaxyParams(await arrowLink(page, 'West').getAttribute('href')))
      .toEqual({ galaxyx: 1, galaxyy: 3 });
  });

  test('clicking East re-renders the map at the new sector', async ({ page }) => {
    await page.goto('/galaxy.php?planet=Space&galaxyx=2&galaxyy=3', { waitUntil: 'domcontentloaded' });

    await arrowLink(page, 'East').click();
    await page.waitForLoadState('domcontentloaded');

    const url = new URL(page.url());
    expect(url.searchParams.get('galaxyx')).toBe('3');
    expect(url.searchParams.get('galaxyy')).toBe('3');

    await expect(page.locator('img[alt="North"]')).toBeVisible();
    await expect(page.locator('img[alt="South"]')).toBeVisible();
    await expect(page.locator('img[alt="East"]')).toBeVisible();
    await expect(page.locator('img[alt="West"]')).toBeVisible();
    await expect(page.locator('table.map-grid')).toBeVisible();
    await expect(page.locator('body')).not.toContainText('Fatal error');
    await expect(page.locator('body')).not.toContainText('Warning:');
  });

  test('axis labels pan by exactly 15 tiles after an East click', async ({ page }) => {
    await page.goto('/galaxy.php?planet=Space&galaxyx=2&galaxyy=3', { waitUntil: 'domcontentloaded' });

    const before = (await page.locator('td.map-col-label').allTextContents())
      .map(Number);

    await arrowLink(page, 'East').click();
    await page.waitForLoadState('domcontentloaded');

    const after = (await page.locator('td.map-col-label').allTextContents())
      .map(Number);

    expect(after.length).toBe(before.length);
    for (let i = 0; i < before.length; i++) {
      expect(after[i] - before[i]).toBe(15);
    }
  });

  test('axis labels pan by exactly 15 tiles after a North click', async ({ page }) => {
    await page.goto('/galaxy.php?planet=Space&galaxyx=2&galaxyy=3', { waitUntil: 'domcontentloaded' });

    const before = (await page.locator('td.map-row-label').allTextContents())
      .map(Number);

    await arrowLink(page, 'North').click();
    await page.waitForLoadState('domcontentloaded');

    const after = (await page.locator('td.map-row-label').allTextContents())
      .map(Number);

    expect(after.length).toBe(before.length);
    for (let i = 0; i < before.length; i++) {
      expect(after[i] - before[i]).toBe(15);
    }
  });

  test('East then West round-trips back to the original sector', async ({ page }) => {
    await page.goto('/galaxy.php?planet=Space&galaxyx=2&galaxyy=3', { waitUntil: 'domcontentloaded' });

    await arrowLink(page, 'East').click();
    await page.waitForLoadState('domcontentloaded');
    await arrowLink(page, 'West').click();
    await page.waitForLoadState('domcontentloaded');

    const url = new URL(page.url());
    expect(url.searchParams.get('galaxyx')).toBe('2');
    expect(url.searchParams.get('galaxyy')).toBe('3');
  });

  test('negative sectors render correctly (West then South from origin)', async ({ page }) => {
    await page.goto('/galaxy.php?planet=Space&galaxyx=0&galaxyy=0', { waitUntil: 'domcontentloaded' });

    await arrowLink(page, 'West').click();
    await page.waitForLoadState('domcontentloaded');
    await arrowLink(page, 'South').click();
    await page.waitForLoadState('domcontentloaded');

    const url = new URL(page.url());
    expect(url.searchParams.get('galaxyx')).toBe('-1');
    expect(url.searchParams.get('galaxyy')).toBe('-1');

    await expect(page.locator('table.map-grid')).toBeVisible();
    await expect(page.locator('img[alt="North"]')).toBeVisible();

    const headerLabels = await page.locator('td.map-col-label').allTextContents();
    expect(headerLabels.some((t) => t.trim().startsWith('-'))).toBe(true);

    const rowLabels = await page.locator('td.map-row-label').allTextContents();
    expect(rowLabels.some((t) => t.trim().startsWith('-'))).toBe(true);

    await expect(page.locator('body')).not.toContainText('Fatal error');
    await expect(page.locator('body')).not.toContainText('Warning:');
  });

  test('heading remains non-blank after arrow navigation drops system=', async ({ page }) => {
    await page.goto('/galaxy.php?planet=Space&system=Meth&galaxyx=0&galaxyy=0', { waitUntil: 'domcontentloaded' });
    await expect(page.locator('[data-testid="map-heading"]')).toHaveText('Meth');

    await arrowLink(page, 'East').click();
    await page.waitForLoadState('domcontentloaded');

    // system= is dropped by the arrow link, but $planetname is derived from
    // galaxyx/galaxyy on every render, so the heading must never go blank
    // (the original bug) — regardless of which system "wins" at this sector.
    const heading = (await page.locator('[data-testid="map-heading"]').textContent())?.trim();
    expect(heading).toBeTruthy();
    await expect(page.locator('body')).not.toContainText('Fatal error');
  });

  test('heading switches to a different system when panning into its territory', async ({ page }) => {
    await page.goto('/galaxy.php?planet=Space&galaxyx=0&galaxyy=0', { waitUntil: 'domcontentloaded' });
    const here = (await page.locator('[data-testid="map-heading"]').textContent())?.trim();

    test.skip(here === 'Space', 'No *SystemCenter data seeded — skipping system-transition test');

    await page.goto('/galaxy.php?planet=Space&galaxyx=2&galaxyy=0', { waitUntil: 'domcontentloaded' });
    const there = (await page.locator('[data-testid="map-heading"]').textContent())?.trim();

    expect(there).not.toBe('Space');
    expect(there).not.toBe(here);
  });

  test('heading shows "Space" when far (>2 sectors / 30 tiles) from any known system', async ({ page }) => {
    await page.goto('/galaxy.php?planet=Space&galaxyx=100&galaxyy=100', { waitUntil: 'domcontentloaded' });
    await expect(page.locator('[data-testid="map-heading"]')).toHaveText('Space');
    await expect(page.locator('body')).not.toContainText('Fatal error');
  });

  test('clicking the heading centers the viewport on that system\'s home sector', async ({ page }) => {
    await page.goto('/galaxy.php?planet=Space&galaxyx=3&galaxyy=0', { waitUntil: 'domcontentloaded' });
    const heading = page.locator('[data-testid="map-heading"]');
    const name = (await heading.textContent())?.trim();

    test.skip(name === 'Space', 'No *SystemCenter data seeded — heading is not a link');

    const headingLink = heading.locator('a');
    await expect(headingLink).toHaveText(name);
    await headingLink.click();
    await page.waitForLoadState('domcontentloaded');

    const url = new URL(page.url());
    expect(url.searchParams.get('planet')).toBe('Space');

    // After recentering, the same name should still be nearest (distance 0)
    await expect(page.locator('[data-testid="map-heading"]')).toHaveText(name);
    await expect(page.locator('body')).not.toContainText('Fatal error');
  });

  test('heading is plain text (not a link) when showing "Space"', async ({ page }) => {
    await page.goto('/galaxy.php?planet=Space&galaxyx=100&galaxyy=100', { waitUntil: 'domcontentloaded' });
    const heading = page.locator('[data-testid="map-heading"]');
    await expect(heading).toHaveText('Space');
    expect(await heading.locator('a').count()).toBe(0);
  });
});

// ---------------------------------------------------------------------------
// ?planet=<name> — planet surface map
// ---------------------------------------------------------------------------
test.describe('galaxy.php?planet=<name> — planet surface map', () => {
  // We use a planet name from the CLAUDE.md architecture description.
  // If no planets exist in the DB, these tests show "service offline" and we skip.
  let testPlanet = '';

  test.beforeAll(async ({ request }) => {
    if (!dbAvailable) return;
    // Discover a real planet name from the galaxy record so tests use live data.
    try {
      const response = await request.get('/index.php');
      const html = await response.text();
      // Planet links look like: href="galaxy.php?planet=NAME&login=..."
      const match = html.match(/galaxy\.php\?planet=([^&"]+)&login/);
      if (match) testPlanet = decodeURIComponent(match[1]);
    } catch {
      // leave testPlanet empty — tests below will skip
    }
  });

  test.beforeEach(async ({ page }) => {
    test.skip(!dbAvailable || !testPlanet, 'Database not connected or no planet data found');
    await page.goto(`/galaxy.php?planet=${encodeURIComponent(testPlanet)}`, { waitUntil: 'domcontentloaded' });
  });

  test('planet name shown as heading', async ({ page }) => {
    await expect(page.locator('body')).toContainText(testPlanet);
  });

  test('local info panel shows Position and Level fields', async ({ page }) => {
    await expect(page.locator('body')).toContainText('Position');
    await expect(page.locator('body')).toContainText('Level');
  });

  test('time indicator image is present (day or night)', async ({ page }) => {
    const timeImg = page.locator('img[alt="Day"], img[alt="Night"]');
    await expect(timeImg).toBeVisible();
  });

  test('weather indicator image is present', async ({ page }) => {
    const weatherImg = page.locator('img[alt]').filter({
      hasText: '', // filter for non-empty alt
    });
    const weatherAlts = ['Clear', 'Rain', 'Snow', 'Fog', 'Storm'];
    let found = false;
    for (const alt of weatherAlts) {
      if (await page.locator(`img[alt="${alt}"]`).count() > 0) {
        found = true;
        break;
      }
    }
    expect(found).toBeTruthy();
  });

  test('renders map grid table', async ({ page }) => {
    const mapTable = page.locator('table.map-grid');
    await expect(mapTable).toBeVisible();
  });
});
