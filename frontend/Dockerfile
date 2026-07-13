# Gunakan Node 22 berbasis Alpine (versi stabil terbaru)
FROM node:22-alpine

WORKDIR /app

# Salin package.json saja dulu
COPY package*.json ./

# HAPUS package-lock jika bermasalah dan paksa install arsitektur Linux
RUN rm -rf package-lock.json node_modules
RUN npm install --include=optional

# Salin sisa file kode
COPY . .

# Jalankan build
RUN npm run build

# Install server statis
RUN npm install -g serve

CMD ["serve", "-s", "dist", "-l", "8080"]