FROM php:8.3-apache

# Install sistem dependensi
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo_mysql

# --- BAGIAN PENTING: Perbaikan MPM ---
RUN a2dismod mpm_event mpm_worker mpm_prefork || true
RUN a2enmod mpm_prefork
# ------------------------------------

# Arahkan Document Root ke folder 'public' Laravel
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Salin semua file proyek
COPY . /var/www/html

# Set working directory
WORKDIR /var/www/html

# Berikan akses folder
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Aktifkan mod_rewrite
RUN a2enmod rewrite

# Jalankan instalasi dependensi
RUN composer install --no-dev --optimize-autoloader

# Expose port
EXPOSE 80
