FROM php:8.3-fpm

# Install sistem dependencies
RUN apt-get update && apt-get install -y \
    libgd-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev

# Install PHP GD extension
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

# (Lanjutkan dengan konfigurasi Laravel lainnya sesuai kebutuhanmu)
