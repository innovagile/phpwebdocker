FROM phusion/baseimage:jammy-1.0.0
ENV PHP_VERSION=8.2
LABEL author="innovAgile <hello@innovagile.com>"
LABEL version=${PHP_VERSION}

RUN apt-get -y update && \
    apt-get install -y language-pack-en-base && \
    locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8 && \
    DEBIAN_FRONTEND=noninteractive LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y --force-yes \
        php${PHP_VERSION}-fpm \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-cli \
        php${PHP_VERSION}-common \
        php${PHP_VERSION}-opcache \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-intl \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-apcu \
        php${PHP_VERSION}-zip \
        php${PHP_VERSION}-gd \
        openssl \
        nginx \
    && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /etc/php/current/fpm/pool.d/
COPY conf/php-fpm/pool-www.conf /etc/php/current/fpm/pool.d/www.conf

RUN mkdir -p /var/www
ADD www/public /var/www/public/

RUN mkdir -p /etc/my_init.d
ADD conf/my_init.d /etc/my_init.d/
RUN chmod +x /etc/my_init.d/*.sh

RUN mkdir -p /etc/service/nginx /run/nginx/cache /run/nginx/proxy
ADD services/nginx.sh /etc/service/nginx/run

RUN mkdir -p /etc/service/php-fpm /run/php
ADD services/php-fpm.sh /etc/service/php-fpm/run

RUN chmod +x /etc/service/*/run

RUN rm -fr /etc/nginx
ADD conf/nginx /etc/nginx/

COPY conf/php-fpm/php-fpm.conf /etc/php/${PHP_VERSION}/fpm/php-fpm.conf

EXPOSE 80 2443

CMD ["/sbin/my_init"]
