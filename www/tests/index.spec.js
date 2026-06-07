/**
 * Tests for index.php — the main 3-column shell page.
 *
 * Without DB: PHP renders the left nav column then calls `die()` at the galaxy
 * query. Title, header, left-nav links, status iframe, and DM login form are
 * all output before that point and are always testable.
 *
 * With DB: the full page renders including the content iframe, star-systems
 * right column, and footer. Those tests are skipped when DB is unavailable.
 */

const { test, expect } = require('@playwright/test');
const { isDbConnected } = require('./helpers/db');

let dbAvailable = false;

test.beforeAll(async ({ request }) => {
  dbAvailable = await isDbConnected(request);
});

// ---------------------------------------------------------------------------
// Structure — always testable (rendered before the DB query that may die())
// ---------------------------------------------------------------------------
test.describe('index.php — page structure', () => {
  test.beforeEach(async ({ page }) => {
    // domcontentloaded avoids hanging on the status iframe loading statut.php
    await page.goto('/index.php', { waitUntil: 'domcontentloaded' });
  });

  test('has page title "Universe of Arlandia"', async ({ page }) => {
    await expect(page).toHaveTitle('Universe of Arlandia');
  });

  test('renders main header text', async ({ page }) => {
    await expect(page.locator('h1.page-title')).toContainText('The Universe of Arlandia');
    await expect(page.locator('p.page-subtitle')).toContainText('For Neverwinter Nights');
  });

  test('shows server IP address', async ({ page }) => {
    await expect(page.locator('.ip-address')).toContainText('uoanwn.homeip.net');
  });

  test('left nav has all section headings', async ({ page }) => {
    const nav = page.locator('td.nav-cell').first();
    for (const heading of ['Server status', 'Connection', 'Module', 'Characters', 'Community', 'DM area']) {
      await expect(nav.locator(`text=${heading}`)).toBeVisible();
    }
  });

  test('status iframe targets statut.php', async ({ page }) => {
    const iframe = page.locator('iframe[name="Status"]');
    await expect(iframe).toBeAttached();
    await expect(iframe).toHaveAttribute('src', 'statut.php');
    await expect(iframe).toHaveClass(/status-iframe/);
  });

  test('Module nav links all present and target UOA_Frame', async ({ page }) => {
    const moduleLinks = [
      { href: 'news.html',        label: 'Home/News' },
      { href: 'description.html', label: 'Description' },
      { href: 'screenshots.html', label: 'Screenshots' },
      { href: 'interests.html',   label: 'Interests' },
      { href: 'domains.html',     label: 'Domains' },
      { href: 'crafting.html',    label: 'Crafting' },
    ];
    for (const { href, label } of moduleLinks) {
      const link = page.locator(`a[href="${href}"]`);
      await expect(link).toBeVisible();
      await expect(link).toHaveAttribute('target', 'UOA_Frame');
      await expect(link).toContainText(label);
    }
  });

  test('Characters nav links all present and target UOA_Frame', async ({ page }) => {
    const characterLinks = [
      { href: 'races.html',   label: 'Races' },
      { href: 'classes.html', label: 'Classes' },
      { href: 'feats.html',   label: 'Feats' },
      { href: 'grades.html',  label: 'Grades' },
      { href: 'talents.html', label: 'Talents' },
    ];
    for (const { href, label } of characterLinks) {
      const link = page.locator(`a[href="${href}"]`);
      await expect(link).toBeVisible();
      await expect(link).toHaveAttribute('target', 'UOA_Frame');
      await expect(link).toContainText(label);
    }
  });

  test('Community nav links all present', async ({ page }) => {
    for (const href of ['downloads.html', 'links.html', 'contact.html']) {
      await expect(page.locator(`a[href="${href}"]`)).toBeVisible();
    }
    // Forum opens in a new tab (external link)
    const forumLink = page.locator('a').filter({ hasText: 'Forum' });
    await expect(forumLink).toBeVisible();
    await expect(forumLink).toHaveAttribute('target', '_blank');
  });

  test('DM login form has correct structure', async ({ page }) => {
    const form = page.locator('form[name="dmarea"]');
    await expect(form).toBeAttached();
    await expect(form).toHaveAttribute('action', 'index.php');
    await expect(form).toHaveAttribute('method', 'post');
    await expect(form.locator('input[type="password"][name="login"]')).toBeVisible();
  });
});

// ---------------------------------------------------------------------------
// Full-page content — requires a working DB connection
// ---------------------------------------------------------------------------
test.describe('index.php — DB-dependent content', () => {
  test.beforeEach(async ({ page }) => {
    test.skip(!dbAvailable, 'Database not connected — skipping full-render tests');
    await page.goto('/index.php', { waitUntil: 'load' });
  });

  test('renders content iframe targeting news.html', async ({ page }) => {
    const iframe = page.locator('iframe[name="UOA_Frame"]');
    await expect(iframe).toBeVisible();
    await expect(iframe).toHaveAttribute('src', 'news.html');
    await expect(iframe).toHaveClass(/content-iframe/);
  });

  test('renders footer with copyright', async ({ page }) => {
    await expect(page.locator('footer')).toBeVisible();
    await expect(page.locator('footer')).toContainText('TheRack');
    await expect(page.locator('footer')).toContainText('2009-2011');
  });

  test('right nav column is present', async ({ page }) => {
    // Second .nav-cell is the star-systems column; it is only output after the DB query.
    await expect(page.locator('td.nav-cell').nth(1)).toBeAttached();
  });
});

// ---------------------------------------------------------------------------
// DM login behaviour
// ---------------------------------------------------------------------------
test.describe('index.php — DM login', () => {
  test('?logout=1 shows login form, not DM links', async ({ page }) => {
    await page.goto('/index.php?logout=1', { waitUntil: 'domcontentloaded' });
    await expect(page.locator('input[type="password"][name="login"]')).toBeVisible();
    await expect(page.locator('a[href*="galaxy.php?planet=infos"]')).toHaveCount(0);
  });

  test('wrong password keeps login form visible', async ({ page }) => {
    await page.goto('/index.php', { waitUntil: 'domcontentloaded' });
    await page.locator('input[type="password"][name="login"]').fill('wrong_password_xyz');
    await page.locator('form[name="dmarea"]').evaluate(f => f.submit());
    await page.waitForLoadState('domcontentloaded');
    await expect(page.locator('input[type="password"][name="login"]')).toBeVisible();
  });

  test('correct DM password shows DM links', async ({ page }) => {
    const dmPassword = process.env.UOA_DM_PASSWORD;
    test.skip(!dmPassword || !dbAvailable, 'Set UOA_DM_PASSWORD env var with DB running to test DM login');
    await page.goto('/index.php', { waitUntil: 'domcontentloaded' });
    await page.locator('input[type="password"][name="login"]').fill(dmPassword);
    await page.locator('form[name="dmarea"]').evaluate(f => f.submit());
    await page.waitForLoadState('domcontentloaded');
    await expect(page.locator('a[href*="galaxy.php?planet=infos"]')).toBeVisible();
    await expect(page.locator('a[href="index.php?logout=1"]')).toBeVisible();
  });
});
