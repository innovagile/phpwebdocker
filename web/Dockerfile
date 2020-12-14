FROM phusion/baseimage:0.11
LABEL author="innovAgile <hello@innovagile.com>"
LABEL version="7.4"

RUN apt-get -y update && \
    apt-get install -y language-pack-en-base && \
    locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8 && \
    DEBIAN_FRONTEND=noninteractive LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y --force-yes php7.4-fpm php7.4-curl php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-mysql php7.4-intl php7.4-mbstring php7.4-xml php-apcu php-zip php-gd openssl nginx && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer && \
    php -r "if (hash_file('sha384', '/tmp/composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo    'Installer verified'; } else { echo 'Installer corrupt'; unlink('/tmp/composer-setup.php'); } echo PHP_EOL;" && \
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

COPY conf/php-fpm/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

EXPOSE 80

CMD ["/sbin/my_init"]
