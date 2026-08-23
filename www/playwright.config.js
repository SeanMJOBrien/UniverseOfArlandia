const { defineConfig, devices } = require('@playwright/test');

// By default the suite runs against a throwaway `php -S` server, which has no
// database — every DB-backed test then skips itself. Point UOA_BASE_URL at the
// docker stack (http://localhost:88) to run those tests for real.
const baseURL = process.env.UOA_BASE_URL || 'http://localhost:8765';
const useOwnServer = !process.env.UOA_BASE_URL;

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
    baseURL,
    screenshot: 'only-on-failure',
    trace: 'retain-on-failure',
  },
  ...(useOwnServer
    ? {
        webServer: {
          command: 'php -S localhost:8765',
          url: 'http://localhost:8765/news.html',
          reuseExistingServer: true,
          timeout: 10000,
        },
      }
    : {}),
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
});
