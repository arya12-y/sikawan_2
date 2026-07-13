import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  // TAMBAHKAN BLOK PREVIEW DI BAWAH INI
  preview: {
    allowedHosts: ['sikawan.up.railway.app', '.up.railway.app']
  }
})