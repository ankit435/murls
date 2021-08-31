import type { Manifest } from 'webextension-polyfill-ts'
import pkg from '../package.json'
import { isDev, port } from '../scripts/utils'

export async function getManifest(): Promise<Manifest.WebExtensionManifest> {
  return {
    manifest_version: 2,
    name: pkg.displayName || pkg.name,
    version: pkg.version,
    description: pkg.description,
    browser_action: {
      default_icon: './assets/icon-512.png',
      default_popup: './dist/popup/index.html',
    },
    background: {
      scripts: ['./dist/background/index.global.js'],
      persistent: false,
    },
    content_scripts: [
      {
        matches: ['http://*/*', 'https://*/*'],
        js: ['./dist/content/index.global.js'],
      },
    ],
    icons: {
      16: './assets/icon-512.png',
      48: './assets/icon-512.png',
      128: './assets/icon-512.png',
    },
    permissions: [
      'tabs',
      'storage',
      'activeTab',
      'http://*/',
      'https://*/',
    ],
    // this is required on dev for Vite script to load
    content_security_policy: isDev
      ? `script-src \'self\' http://localhost:${port}; object-src \'self\'`
      : undefined,
  }
}
