FROM php:7.4-fpm-alpine

WORKDIR /var/www

RUN apk add bash mysql-client nginx
RUN docker-php-ext-install pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY artisan /var/www/
COPY server.php /var/www/

COPY composer.json /var/www/
COPY composer.lock /var/www/

RUN composer install --no-scripts --no-dev --no-autoloader

RUN mkdir -p /var/www/bootstrap/cache/

COPY bootstrap/app.php /var/www/bootstrap/app.php
COPY public /var/www/public
COPY config /var/www/config
COPY database /var/www/database
COPY resources /var/www/resources
COPY routes /var/www/routes
COPY app /var/www/app

COPY .env.example /var/www/.env

RUN pwd
RUN ls -la

RUN composer dump-autoload

EXPOSE 9000