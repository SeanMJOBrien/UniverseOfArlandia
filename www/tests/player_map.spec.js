/**
 * Tests for the per-player map: register.php, the index.php player login, and
 * the discovery gating in galaxy.php / map-data.php / interests.php.
 *
 * These only assert behaviour that holds for any database contents — an
 * anonymous visitor sees no tiles and gets a login prompt, bad credentials are
 * rejected, and undiscovered interest pages 403. Asserting that a *specific*
 * player sees a specific tile needs seeded pwdata (WebChars_/WMap_ rows) and a
 * registered account, which this suite does not create.
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
test.describe('register.php — without DB', () => {
  test('responds without an unhandled PHP crash', async ({ page }) => {
    test.skip(dbAvailable, 'DB is connected — graceful-degradation test not applicable');
    await page.goto('/register.php', { waitUntil: 'domcontentloaded' });
    const body = await page.textContent('body');
    expect(body).toContain('service offline');
    await expect(page.locator('body')).not.toContainText('Fatal error');
    await expect(page.locator('body')).not.toContainText('Warning:');
  });
});

// ---------------------------------------------------------------------------
// Registration form
// ---------------------------------------------------------------------------
test.describe('register.php', () => {
  test.beforeEach(async ({ page }) => {
    test.skip(!dbAvailable, 'Database not connected');
    await page.goto('/register.php', { waitUntil: 'domcontentloaded' });
  });

  test('shows the .web instructions and a CSRF-protected form', async ({ page }) => {
    await expect(page.getByTestId('register-form')).toBeVisible();
    await expect(page.locator('body')).toContainText('.web');
    await expect(page.locator('input[name="csrf_token"]')).toHaveCount(1);
  });

  test('rejects a CD key that is not 8 characters', async ({ page }) => {
    await page.fill('#cdkey', 'ABC');
    await page.fill('#code', '123456');
    await page.fill('#password', 'longenoughpassword');
    await page.fill('#password2', 'longenoughpassword');
    await page.click('input[type="submit"]');
    await expect(page.getByTestId('register-error')).toContainText('8-character');
  });

  test('rejects mismatched passwords', async ({ page }) => {
    await page.fill('#cdkey', 'ABCD1234');
    await page.fill('#code', '123456');
    await page.fill('#password', 'longenoughpassword');
    await page.fill('#password2', 'differentpassword');
    await page.click('input[type="submit"]');
    await expect(page.getByTestId('register-error')).toContainText('do not match');
  });

  test('rejects a code that was never issued', async ({ page }) => {
    await page.fill('#cdkey', 'ZZZZ9999');
    await page.fill('#code', '000000');
    await page.fill('#password', 'longenoughpassword');
    await page.fill('#password2', 'longenoughpassword');
    await page.click('input[type="submit"]');
    await expect(page.getByTestId('register-error')).toContainText('expired');
  });
});

// ---------------------------------------------------------------------------
// Player login on index.php
// ---------------------------------------------------------------------------
test.describe('index.php — player area', () => {
  test.beforeEach(async ({ page }) => {
    test.skip(!dbAvailable, 'Database not connected');
    await page.goto('/index.php', { waitUntil: 'domcontentloaded' });
  });

  test('offers a CD-key login and a register link', async ({ page }) => {
    await expect(page.getByTestId('player-login-form')).toBeVisible();
    await expect(page.locator('a[href="register.php"]')).toHaveCount(1);
  });

  test('rejects an unknown CD key without revealing whether it exists', async ({ page }) => {
    await page.fill('input[name="player_cdkey"]', 'ZZZZ9999');
    await page.fill('input[name="player_password"]', 'whatever');
    await page.getByTestId('player-login-form').locator('input[type="submit"]').click();
    await expect(page.getByTestId('player-login-error')).toContainText('Unknown CD key or wrong password');
  });

  test('leaves the DM login untouched', async ({ page }) => {
    await expect(page.locator('form[name="dmarea"]')).toBeVisible();
  });
});

// ---------------------------------------------------------------------------
// Map gating for anonymous visitors
// ---------------------------------------------------------------------------
test.describe('galaxy.php — anonymous visitor', () => {
  test.beforeEach(async ({ page }) => {
    test.skip(!dbAvailable, 'Database not connected');
  });

  test('shows the login prompt and draws no terrain tiles', async ({ page }) => {
    await page.goto('/galaxy.php?planet=Alderan', { waitUntil: 'domcontentloaded' });
    await expect(page.getByTestId('map-login-notice')).toBeVisible();
    // Tile cells still lay out the grid, they are just empty.
    await expect(page.locator('td.map-tile img')).toHaveCount(0);
  });

  test('map-data.php reports every tile hidden', async ({ request }) => {
    const response = await request.get('/map-data.php?planet=Alderan');
    const body = await response.json();
    expect(Array.isArray(body.tiles)).toBe(true);
    expect(body.tiles.some((tile) => tile.visible)).toBe(false);
  });

  test('interests.php refuses an undiscovered area', async ({ page }) => {
    const response = await page.goto('/interests.php?planet=Alderan&area=0_0', {
      waitUntil: 'domcontentloaded',
    });
    expect(response.status()).toBe(403);
    await expect(page.getByTestId('interest-undiscovered')).toBeVisible();
  });
});
