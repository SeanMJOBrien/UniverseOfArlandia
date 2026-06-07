/**
 * Tests for all static HTML pages.
 *
 * These pages require no DB or PHP; they should load cleanly for any visitor.
 * Each test checks that:
 *   1. The page is reachable (HTTP 200).
 *   2. The <body> contains visible text (page is not blank/broken).
 *   3. No PHP error strings leaked into the output.
 *
 * Page-specific tests verify key headings / sections expected in each file.
 */

const { test, expect } = require('@playwright/test');

// ---------------------------------------------------------------------------
// Helper: assert a static page loads with content
// ---------------------------------------------------------------------------
async function assertStaticPage(page, path) {
  const response = await page.goto(path, { waitUntil: 'domcontentloaded' });
  expect(response?.status()).toBe(200);
  const text = await page.textContent('body');
  expect(text?.trim().length).toBeGreaterThan(20);
  await expect(page.locator('body')).not.toContainText('Fatal error');
}

// ---------------------------------------------------------------------------
// Smoke-test every static page in one parametrised block
// ---------------------------------------------------------------------------
const staticPages = [
  '/news.html',
  '/description.html',
  '/screenshots.html',
  '/interests.html',
  '/domains.html',
  '/crafting.html',
  '/races.html',
  '/classes.html',
  '/feats.html',
  '/grades.html',
  '/talents.html',
  '/downloads.html',
  '/links.html',
  '/contact.html',
  '/installation.html',
  '/factory.html',
];

for (const path of staticPages) {
  test(`${path} loads successfully`, async ({ page }) => {
    await assertStaticPage(page, path);
  });
}

// ---------------------------------------------------------------------------
// Page-specific content assertions
// ---------------------------------------------------------------------------

test.describe('news.html', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/news.html', { waitUntil: 'domcontentloaded' });
  });

  test('page loads without blank body', async ({ page }) => {
    const text = await page.textContent('body');
    expect(text?.trim().length).toBeGreaterThan(20);
  });
});

test.describe('description.html', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/description.html', { waitUntil: 'domcontentloaded' });
  });

  test('contains descriptive content about the module', async ({ page }) => {
    // Must have some body text — the exact copy may change but the page must not be empty
    const text = await page.textContent('body');
    expect(text?.trim().length).toBeGreaterThan(50);
  });
});

test.describe('screenshots.html', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/screenshots.html', { waitUntil: 'domcontentloaded' });
  });

  test('contains at least one image', async ({ page }) => {
    const images = page.locator('img');
    await expect(images.first()).toBeAttached();
  });

  test('lightbox JS files are referenced', async ({ page }) => {
    // Lightbox 2 is used for the screenshot gallery
    const scripts = await page.locator('script[src]').evaluateAll(
      els => els.map(e => e.getAttribute('src'))
    );
    const hasLightbox = scripts.some(s => s?.includes('lightbox') || s?.includes('prototype'));
    expect(hasLightbox).toBeTruthy();
  });
});

test.describe('races.html', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/races.html', { waitUntil: 'domcontentloaded' });
  });

  test('page has body content', async ({ page }) => {
    const text = await page.textContent('body');
    expect(text?.trim().length).toBeGreaterThan(20);
  });
});

test.describe('classes.html', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/classes.html', { waitUntil: 'domcontentloaded' });
  });

  test('page has body content', async ({ page }) => {
    const text = await page.textContent('body');
    expect(text?.trim().length).toBeGreaterThan(20);
  });
});

test.describe('downloads.html', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/downloads.html', { waitUntil: 'domcontentloaded' });
  });

  test('page has body content', async ({ page }) => {
    const text = await page.textContent('body');
    expect(text?.trim().length).toBeGreaterThan(20);
  });

  test('contains at least one downloadable link', async ({ page }) => {
    const links = page.locator('a[href]');
    await expect(links.first()).toBeAttached();
  });
});

test.describe('contact.html', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/contact.html', { waitUntil: 'domcontentloaded' });
  });

  test('page has body content', async ({ page }) => {
    const text = await page.textContent('body');
    expect(text?.trim().length).toBeGreaterThan(20);
  });
});

test.describe('crafting.html', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/crafting.html', { waitUntil: 'domcontentloaded' });
  });

  test('page has body content', async ({ page }) => {
    const text = await page.textContent('body');
    expect(text?.trim().length).toBeGreaterThan(20);
  });
});

test.describe('interests.html', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/interests.html', { waitUntil: 'domcontentloaded' });
  });

  test('page has body content', async ({ page }) => {
    const text = await page.textContent('body');
    expect(text?.trim().length).toBeGreaterThan(20);
  });
});

test.describe('domains.html', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/domains.html', { waitUntil: 'domcontentloaded' });
  });

  test('page has body content', async ({ page }) => {
    const text = await page.textContent('body');
    expect(text?.trim().length).toBeGreaterThan(20);
  });
});
