FROM php:8.1-fpm-alpine

WORKDIR /var/www/html

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && install-php-extensions apcu \
    && install-php-extensions bcmath bz2 exif gd imagick intl mcrypt \
                              memcached pdo_mysql pdo_pgsql redis timezonedb zip @composer

RUN apk add --no-cache nodejs-current npm supervisor

EXPOSE 9000

CMD ["php-fpm"]
