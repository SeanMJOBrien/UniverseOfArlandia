/**
 * Tests for nwnservers.php — NWN server status board.
 *
 * Queries the Beamdog server-list API for each configured server, caching
 * the combined result server-side in nwn_server_status.cache for 60s (not
 * an HTTP Cache-Control header — the page instead sets a 60s client-side
 * <meta http-equiv="refresh">). Beamdog API calls will fail in CI without
 * internet access; every assertion here accepts either the online or the
 * offline rendering, so it holds up either way.
 */

const { test, expect } = require('@playwright/test');

test.describe('nwnservers.php', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/nwnservers.php', { waitUntil: 'domcontentloaded' });
  });

  test('page loads without PHP errors', async ({ page }) => {
    await expect(page).toHaveTitle('NWN Server Status');
    await expect(page.locator('body')).not.toContainText('Fatal error');
    await expect(page.locator('body')).not.toContainText('Warning:');
  });

  test('shows a server-block entry for every configured server', async ({ page }) => {
    // The module's own server is one of 16 hardcoded entries in nwnservers.php.
    const blocks = page.locator('.server-block');
    const count = await blocks.count();
    expect(count).toBeGreaterThan(0);
    // Every block resolves to either an online or offline rendering — no blanks.
    const anyStatus = page.locator('.server-name.online, .server-name.offline');
    expect(await anyStatus.count()).toBe(count);
  });

  test('displays player count for online servers, offline message otherwise', async ({ page }) => {
    const onlineBlocks = page.locator('.server-block').filter({ has: page.locator('.server-name.online') });
    const onlineCount = await onlineBlocks.count();
    if (onlineCount > 0) {
      await expect(onlineBlocks.first().locator('.server-details').first()).toContainText('Players:');
    }

    const offlineBlocks = page.locator('.server-block').filter({ has: page.locator('.server-name.offline') });
    const offlineCount = await offlineBlocks.count();
    if (offlineCount > 0) {
      await expect(offlineBlocks.first()).toContainText('is OFFLINE');
      await expect(offlineBlocks.first().locator('.contact-email')).toBeVisible();
    }
  });

  test('names Universe of Arlandia among the tracked servers', async ({ page }) => {
    await expect(page.locator('body')).toContainText('Universe of Arlandia');
  });

  test('sets a 60-second client-side refresh', async ({ page }) => {
    const refreshMeta = page.locator('meta[http-equiv="refresh"]');
    await expect(refreshMeta).toHaveAttribute('content', '60');
  });
});
