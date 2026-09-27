import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    host: true // bind 0.0.0.0, not just localhost - required to reach it via a public/EC2 IP
  },
  preview: {
    port: 3000,
    host: true
  }
});
