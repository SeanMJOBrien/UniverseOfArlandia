/**
 * Tests for playerInfo.php — supplementary DM player-management panel.
 *
 * Without DB: mysqli_connect throws inside a try/catch, producing
 * "Database connection failed: ..." (not the "service offline" convention
 * used elsewhere, since this page pre-dates that convention).
 * With DB: shows a player table; the "Set to 0,0" reset action is gated on
 * an active DM session ($_SESSION['is_dm']) plus a CSRF token.
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
test.describe('playerInfo.php — without DB', () => {
  test('responds without an unhandled PHP crash', async ({ page }) => {
    test.skip(dbAvailable, 'DB is connected — graceful-degradation test not applicable');
    await page.goto('/playerInfo.php', { waitUntil: 'domcontentloaded' });
    const body = await page.textContent('body');
    expect(body).toContain('Database connection failed');
    await expect(page.locator('body')).not.toContainText('Fatal error');
  });
});

// ---------------------------------------------------------------------------
// With DB — player table
// ---------------------------------------------------------------------------
test.describe('playerInfo.php — player management panel', () => {
  test.beforeEach(async ({ page }) => {
    test.skip(!dbAvailable, 'Database not connected');
    await page.goto('/playerInfo.php', { waitUntil: 'domcontentloaded' });
  });

  test('page loads without PHP errors', async ({ page }) => {
    await expect(page.locator('h1')).toHaveText('Player Management');
    await expect(page.locator('body')).not.toContainText('Fatal error');
    await expect(page.locator('body')).not.toContainText('Warning:');
  });

  test('shows player table with expected column headers', async ({ page }) => {
    const headers = page.locator('table th');
    await expect(headers).toHaveText([
      'Player Account', 'Character Name', 'Current Planet', 'Coordinates', 'Action',
    ]);
  });

  test('shows player data or empty state message', async ({ page }) => {
    const rows = page.locator('table tr').filter({ hasNot: page.locator('th') });
    const count = await rows.count();
    expect(count).toBeGreaterThan(0);
    const emptyMsg = page.locator('text=No players found in the database.');
    if (await emptyMsg.count() > 0) {
      await expect(emptyMsg).toBeVisible();
    }
  });

  test('reset button only visible with DM session', async ({ page }) => {
    // No session cookie was ever established for this request context, so
    // $_SESSION['is_dm'] is falsy and the reset form must not render at all.
    const buttons = page.locator('table button');
    expect(await buttons.count()).toBe(0);
  });
});

// ---------------------------------------------------------------------------
// Reset action — requires an authenticated DM session
// ---------------------------------------------------------------------------
test.describe('playerInfo.php — reset action (DM session required)', () => {
  const dmPassword = process.env.UOA_DM_PASSWORD;

  test.beforeEach(async ({ page }) => {
    test.skip(!dbAvailable || !dmPassword, 'Set UOA_DM_PASSWORD env var with DB running to test the DM-gated reset action');
    // Establish a DM session the same way a real DM would: via index.php's login form.
    await page.goto('/index.php', { waitUntil: 'domcontentloaded' });
    await page.locator('input[type="password"][name="login"]').fill(dmPassword);
    await page.locator('form[name="dmarea"]').evaluate((f) => f.submit());
    await page.waitForLoadState('domcontentloaded');
  });

  test('reset button is visible once a DM session is active', async ({ page }) => {
    await page.goto('/playerInfo.php', { waitUntil: 'domcontentloaded' });
    const buttons = page.locator('table button');
    const count = await buttons.count();
    // Zero is valid if there is no player data at all; if there IS a row, it must have a button.
    const rows = page.locator('table tr').filter({ hasNot: page.locator('th') });
    const rowCount = await rows.count();
    const hasRealRow = rowCount > 0 && !(await page.locator('text=No players found in the database.').count());
    if (hasRealRow) {
      expect(count).toBeGreaterThan(0);
    }
  });

  test('reset action shows a success or error feedback message', async ({ page }) => {
    await page.goto('/playerInfo.php', { waitUntil: 'domcontentloaded' });
    const button = page.locator('table button').first();
    test.skip((await button.count()) === 0, 'No player rows with a reset button to exercise');

    page.once('dialog', (dialog) => dialog.accept());
    await button.click();
    await page.waitForLoadState('domcontentloaded');

    const feedback = page.locator('.feedback');
    await expect(feedback).toBeVisible();
    await expect(feedback).toContainText(/Success|Error/);
  });
});
