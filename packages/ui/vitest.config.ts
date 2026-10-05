import solid from 'vite-plugin-solid'
import { defineConfig } from 'vitest/config'

export default defineConfig({
  // `hot: false` keeps vite-plugin-solid from injecting the @solid-refresh
  // HMR module: tests never hot-reload, and the virtual `file:///@solid-refresh`
  // URL it registers is rejected by vitest on Windows
  // ("The argument 'filename' must be a file URL object..."), which would make
  // the cross-platform leg platform-dependent for no gain.
  plugins: [solid({ hot: false })],
  test: { environment: 'jsdom' },
})
