FROM php:8.4-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libzip-dev \
    libonig-dev \
    libpq-dev \
    zip \
    curl \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        intl \
        zip \
        mbstring \
        pcntl

# custom PHP settings
RUN echo "memory_limit=512M" > /usr/local/etc/php/conf.d/zz-memory-limit.ini

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# prepare laravel folders
RUN mkdir -p \
    storage/app \
    storage/framework/cache \
    storage/framework/sessions \
    storage/framework/views \
    storage/logs \
    bootstrap/cache

# give wide permissions so both host + container can write
RUN chmod -R 777 storage bootstrap/cache