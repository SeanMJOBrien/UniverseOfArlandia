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
    const table = page.locator('table').first();
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
    await expect(page.locator('table').first()).toBeVisible();
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
    await page.goto('/galaxy.php?planet=Space&system=Arlandia', { waitUntil: 'domcontentloaded' });
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
    const mapTable = page.locator('table').filter({ has: page.locator('td img') }).last();
    await expect(mapTable).toBeVisible();
    const rowCount = await mapTable.locator('tr').count();
    expect(rowCount).toBeGreaterThanOrEqual(2);
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
    const mapTable = page.locator('table').filter({ has: page.locator('td img') }).last();
    await expect(mapTable).toBeVisible();
  });
});
