FROM webdevops/php-nginx:8.0

ENV PHP_DATE_TIMEZONE Asia/Jakarta
ENV PHP_DISPLAY_ERRORS 0
ENV PHP_MEMORY_LIMIT 1G
ENV PHP_UPLOAD_MAX_FILESIZE 50M
ENV PHP_POST_MAX_SIZE 50M
ENV PHP_MAX_EXECUTION_TIME 600
ENV PHP_XDEBUG_MODE debug
ENV PHP_XDEBUG_START_WITH_REQUEST yes
ENV PHP_XDEBUG_CLIENT_PORT 9001
ENV PHP_XDEBUG_REMOTE_AUTOSTART 1

RUN apt-get update
RUN apt-get install -y vim libpq-dev apt-utils \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql

RUN pecl install xdebug-3.0.4 \
     && docker-php-ext-enable xdebug

#ENV PHP_XDEBUG_MODE debug
#ENV PHP_XDEBUG_START_WITH_REQUEST yes
#ENV PHP_XDEBUG_CLIENT_PORT 9001
#ENV PHP_XDEBUG_REMOTE_AUTOSTART 1

ENV FPM_PM_MAX_CHILDREN 250
ENV FPM_PM_START_SERVERS 160
ENV FPM_PM_MIN_SPARE_SERVERS 70
ENV FPM_PM_MAX_SPARE_SERVERS 240

COPY . /external-api
COPY nginx/vhost.conf /opt/docker/etc/nginx/vhost.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf

RUN chown -R application:application /external-api

WORKDIR /external-api
RUN composer install

EXPOSE 5090
