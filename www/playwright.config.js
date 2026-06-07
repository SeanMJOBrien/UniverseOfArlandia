const { defineConfig, devices } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './tests',
  timeout: 20000,
  expect: { timeout: 5000 },
  reporter: [
    ['list'],
    ['html', { open: 'never', outputFolder: 'test-results/report' }],
  ],
  outputDir: 'test-results/artifacts',
  use: {
    baseURL: 'http://localhost:8765',
    screenshot: 'only-on-failure',
    trace: 'retain-on-failure',
  },
  webServer: {
    command: 'php -S localhost:8765',
    url: 'http://localhost:8765/news.html',
    reuseExistingServer: true,
    timeout: 10000,
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
});
