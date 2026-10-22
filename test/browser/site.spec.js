const { test, expect } = require('@playwright/test');
const fs = require('node:fs');
const publicationCount = (fs.readFileSync('_bibliography/papers.bib', 'utf8').match(/^@(?!string\b|comment\b|preamble\b)\w+\s*\{/gmi) || []).length;
test('bibliography search filters and restores publications', async ({ page }) => {
  await page.goto('/publications/');
  const entries = page.locator('.bibliography > li:visible');
  await expect(entries).toHaveCount(publicationCount);
  await page.locator('#bibsearch').fill('傾聴');
  await expect.poll(() => entries.count()).toBeLessThan(publicationCount);
  expect(await entries.count()).toBeGreaterThan(0);
  await page.locator('#bibsearch').fill('no-publication-matches-this-query');
  await expect(entries).toHaveCount(0);
  await page.locator('#bibsearch').fill('');
  await expect(entries).toHaveCount(publicationCount);
});
for (const width of [390, 1280]) {
  test(`personal pages fit viewport ${width}`, async ({ page }) => {
    await page.setViewportSize({ width, height: 900 });
    for (const route of ['/', '/research/', '/publications/', '/lecture/', '/graduationthesis/']) {
      await page.goto(route);
      await expect(page.locator('main, .post').first()).toBeVisible();
      expect(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth + 2)).toBeTruthy();
    }
  });
}

test('desktop navigation, search dialog and theme switch work', async ({ page }) => {
  await page.setViewportSize({ width: 1280, height: 900 });
  await page.goto('/');
  await expect(page.locator('nav a[href="/publications/"]')).toBeVisible();
  await page.locator('nav a[href="/publications/"]').click();
  await expect(page).toHaveURL(/publications/);
  await page.locator('#search-toggle').click();
  await expect(page.locator('ninja-keys input')).toBeVisible();
  await page.locator('ninja-keys input').fill('Research');
  await expect(page.locator('ninja-keys ninja-action').filter({ hasText: 'Research' }).first()).toBeVisible();
  await page.keyboard.press('Escape');
  await page.locator('#light-toggle').click();
  await expect(page.locator('html')).toHaveAttribute('data-theme', /light|dark/);
});
test('mobile navigation opens and follows a link', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto('/');
  await page.getByRole('button', { name: 'Toggle navigation' }).click();
  await expect(page.locator('nav a[href="/lecture/"]')).toBeVisible();
  await page.locator('nav a[href="/lecture/"]').click();
  await expect(page).toHaveURL(/lecture/);
});
