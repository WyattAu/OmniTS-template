import { defineConfig } from '@playwright/test'

export default defineConfig({
  testDir: 'tests',
  use: { baseURL: 'http://localhost:4321' },
  webServer: {
    command: 'bun run build && bun run preview --port 4321',
    url: 'http://localhost:4321',
    reuseExistingServer: true,
    timeout: 120_000,
  },
})
