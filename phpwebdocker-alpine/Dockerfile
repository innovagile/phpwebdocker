FROM php:8.2.5-fpm-alpine
ENV PHP_VERSION=8.2
ENV PHP_VERSION_SHORT=82
LABEL author="innovAgile <hello@innovagile.com>"
LABEL version=${PHP_VERSION}

RUN apk --no-cache update && apk --no-cache upgrade && \
    apk add --no-cache \
      supervisor \
      openssl \
      nginx

RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main \
    libpng \
    libwebp \
    libxpm \
    freetype \
    libjpeg \
    libjpeg-turbo \
    libpcre2-16 \
    php${PHP_VERSION_SHORT}-apcu \
    php${PHP_VERSION_SHORT}-gd \
    php${PHP_VERSION_SHORT}-phar \
    php${PHP_VERSION_SHORT}-json \
    php${PHP_VERSION_SHORT}-intl \
    php${PHP_VERSION_SHORT}-pdo_mysql

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"; \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer; \
    php -r "unlink('composer-setup.php');";

COPY conf/supervisord.conf /etc/supervisord.conf

RUN mkdir -p /etc/service/nginx /run/nginx/cache /run/nginx/proxy
ADD services/nginx.sh /etc/service/nginx/run
RUN mkdir -p /etc/service/php-fpm /run/php
ADD services/php-fpm.sh /etc/service/php-fpm/run
RUN chmod +x /etc/service/*/run

RUN mkdir -p /var/www
ADD www/public /var/www/public/

RUN mkdir -p /usr/local/etc/php/current/fpm/pool.d/
COPY conf/php-fpm/pool-www.conf /usr/local/etc/php/current/fpm/pool.d/www.conf
COPY conf/php-fpm/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY conf/php-fpm/php.ini /usr/local/etc/php/php.ini
COPY conf/nginx /etc/nginx

EXPOSE 80 2443

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
