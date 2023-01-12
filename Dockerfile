FROM php:8.1-fpm

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /var/www/html

RUN set -ex \
    && curl -sLS https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get update \
    && apt-get install -y zip libzip-dev libpng-dev libpng-dev libjpeg62-turbo-dev libwebp-dev libfreetype6-dev libicu-dev libpq-dev libmemcached-dev nodejs \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j"$(nproc)" bcmath exif gd intl pcntl pdo_pgsql zip \
    && pecl install apcu memcached redis \
    && docker-php-ext-enable apcu memcached redis \
    && npm install -g npm

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

EXPOSE 9000

CMD ["php-fpm"]
