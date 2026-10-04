import { expect, test } from '@playwright/test'

test('home renders the shell and hydrates the island', async ({ page }) => {
  await page.goto('/')
  await expect(page.getByRole('heading', { level: 1 })).toContainText('Astro shell')
  await page.getByRole('button').click()
  await expect(page.getByRole('button')).toContainText('1 times')
})
