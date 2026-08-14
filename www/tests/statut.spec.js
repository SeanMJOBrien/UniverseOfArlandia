/**
 * Tests for statut.php — the server-status iframe widget.
 *
 * The page makes a server-side call to the Beamdog NWN API and queries the
 * pwdata table. Without DB it dies immediately with "service offline" (this
 * project's DB-connect-before-HTML convention) — no meta tag or other markup
 * renders. With DB and a live server it shows player count, in-game calendar,
 * and next-reboot time.
 */

const { test, expect } = require('@playwright/test');
const { isDbConnected } = require('./helpers/db');

let dbAvailable = false;

test.beforeAll(async ({ request }) => {
  dbAvailable = await isDbConnected(request);
});

test.describe('statut.php — without DB', () => {
  test('shows "service offline" without a PHP crash', async ({ page }) => {
    test.skip(dbAvailable, 'DB is connected — graceful-degradation test not applicable');
    await page.goto('/statut.php', { waitUntil: 'domcontentloaded', timeout: 30000 });
    const body = await page.textContent('body');
    expect(body).toContain('service offline');
    await expect(page.locator('body')).not.toContainText('Fatal error');
    await expect(page.locator('body')).not.toContainText('Warning:');
  });
});

test.describe('statut.php — page structure', () => {
  test.beforeEach(async ({ page }) => {
    test.skip(!dbAvailable, 'Database not connected');
    // Use a generous timeout — server-side @file_get_contents to the NWN API
    // can take several seconds before the page outputs anything.
    await page.goto('/statut.php', { waitUntil: 'domcontentloaded', timeout: 30000 });
  });

  test('has meta refresh tag set to 60 seconds', async ({ page }) => {
    const meta = page.locator('meta[http-equiv="refresh"]');
    await expect(meta).toBeAttached();
    await expect(meta).toHaveAttribute('content', '60');
  });

  test('page body is not blank', async ({ page }) => {
    const bodyText = await page.textContent('body');
    expect(bodyText?.trim().length).toBeGreaterThan(0);
  });

  test('shows either "Online" status or "service offline" — no PHP crash', async ({ page }) => {
    const body = await page.textContent('body');
    const isOnline  = body?.includes('Online');
    const isOffline = body?.includes('service offline');
    expect(isOnline || isOffline).toBeTruthy();
    await expect(page.locator('body')).not.toContainText('Fatal error');
    await expect(page.locator('body')).not.toContainText('Warning:');
  });
});

test.describe('statut.php — online content', () => {
  test.beforeEach(async ({ page }) => {
    test.skip(!dbAvailable, 'Database not connected');
    await page.goto('/statut.php', { waitUntil: 'domcontentloaded', timeout: 30000 });
  });

  test('shows "Online" indicator', async ({ page }) => {
    await expect(page.locator('body')).toContainText('Online');
  });

  test('shows player count', async ({ page }) => {
    await expect(page.locator('body')).toContainText('Players:');
  });

  test('shows next reboot time', async ({ page }) => {
    await expect(page.locator('body')).toContainText('next reboot');
  });

  test('shows in-game calendar date and hour', async ({ page }) => {
    await expect(page.locator('body')).toContainText('date');
    await expect(page.locator('body')).toContainText('hour');
  });
});
