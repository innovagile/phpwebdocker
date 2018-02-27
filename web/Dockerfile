FROM phusion/baseimage:0.10.0
MAINTAINER innovAgile <hello@innovagile.com>

RUN apt-get -y update && \
    apt-get install -y language-pack-en-base && \
    locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8 && \
    DEBIAN_FRONTEND=noninteractive LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y --force-yes php7.1-fpm php7.1-curl php7.1-cli php7.1-common php7.1-json php7.1-opcache php7.1-mysql php7.1-intl php-apcu openssl nginx && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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

COPY conf/php-fpm/php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf

EXPOSE 80

CMD ["/sbin/my_init"]
