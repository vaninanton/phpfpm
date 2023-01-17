FROM php:8.1-fpm-alpine

LABEL org.opencontainers.image.authors="vaninanton@gmail.com"

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions apcu bcmath gd imagick intl memcached pdo_mysql pdo_pgsql redis zip @composer

EXPOSE 9000

CMD ["php-fpm"]
