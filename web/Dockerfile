FROM phusion/baseimage:0.11
MAINTAINER innovAgile <hello@innovagile.com>

RUN apt-get -y update && \
    apt-get install -y language-pack-en-base && \
    locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8 && \
    DEBIAN_FRONTEND=noninteractive LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y --force-yes php5.6-fpm php5.6-curl php5.6-cli php5.6-common php5.6-json php5.6-opcache php5.6-mysql php5.6-intl php5.6-mbstring php5.6-xml php5.6-zip php5.6-gd openssl nginx && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN EXPECTED_SIGNATURE="$(curl -q https://composer.github.io/installer.sig)" && \
    curl -o /tmp/composer-setup.php https://getcomposer.org/installer && \
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', '/tmp/composer-setup.php');")" && \
    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then >&2 echo 'ERROR: Invalid installer signature'; rm /tmp/composer-setup.php; exit 1; fi && \
    php /tmp/composer-setup.php --install-dir=/bin --filename=composer && \
    rm /tmp/composer-setup.php

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

COPY conf/php-fpm/php-fpm.conf /etc/php/5.6/fpm/php-fpm.conf

EXPOSE 80

CMD ["/sbin/my_init"]
