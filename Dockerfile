FROM php:8.3-apache

# 1. Install sistem dependensi
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libzip-dev zip unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo_mysql

# 2. STRATEGI RESET APACHE:
# Hapus paksa semua konfigurasi modul MPM sebelum mengaktifkan yang baru
RUN rm -f /etc/apache2/mods-enabled/mpm_*.load \
    && rm -f /etc/apache2/mods-enabled/mpm_*.conf \
    && a2enmod mpm_prefork

# 3. Konfigurasi Apache (VirtualHost)
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html/public\n\
    <Directory /var/www/html/public>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# 4. Aktifkan modul penting
RUN a2enmod rewrite

# 5. Persiapan Laravel
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY . /var/www/html
WORKDIR /var/www/html

# Izin folder dan Install Dependensi
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && composer install --no-dev --optimize-autoloader --ignore-platform-reqs

EXPOSE 80
