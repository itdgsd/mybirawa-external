FROM webdevops/php-nginx:8.0
#FROM php:8.0-fpm
#FROM php:7.4.24-fpm-buster

RUN apt-get update
RUN apt-get install -y vim libpq-dev apt-utils zip unzip \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql exif
 
RUN pecl install xdebug-3.0.4 \
    && docker-php-ext-enable xdebug

RUN docker-php-ext-install mysqli pdo pdo_mysql

ENV xdebug.mode debug

COPY . /external-api
COPY nginx/vhost.conf /opt/docker/etc/nginx/vhost.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf

#WORKDIR /app/security
#WORKDIR /var/www
WORKDIR /external-api

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

COPY . .

RUN composer install
