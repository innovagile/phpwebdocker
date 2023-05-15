FROM innovagile/phpwebdocker-alpine
LABEL author="innovAgile <hello@innovagile.com>"
LABEL version=${PHP_VERSION}

RUN apk --no-cache update && apk --no-cache upgrade && \
    apk --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main \
      add nodejs npm unzip autoconf php${PHP_VERSION_SHORT}-pecl-xdebug

RUN npm i -g npm && \
    npm install --global gulp-cli && \
    npm install --global --save-dev webpack webpack-cli

ADD conf/nginx /etc/nginx/

RUN cat /usr/local/etc/php/current/fpm/pool.d/www.conf | sed 's/^;pm.status_path = \/.\+$/pm.status_path = \/status_fpm/' > /tmp/www.conf && \
    mv /tmp/www.conf /usr/local/etc/php/current/fpm/pool.d/www.conf

RUN echo "clear_env = no" >> /usr/local/etc/php/current/fpm/pool.d/www.conf && \
    echo "env[DB_HOST] = \$DB_HOST" >> /usr/local/etc/php/current/fpm/pool.d/www.conf && \
    echo "env[DB_USER] = \$DB_USER" >> /usr/local/etc/php/current/fpm/pool.d/www.conf && \
    echo "env[DB_PASSWORD] = \$DB_PASSWORD" >> /usr/local/etc/php/current/fpm/pool.d/www.conf && \

    echo 'zend_extension=xdebug.so' >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo 'display_errors=true' >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo 'expose_php=true' >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo 'xdebug.discover_client_host=false' >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo 'xdebug.client_port=9003' >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo 'xdebug.client_host=host.docker.internal' >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.start_with_request=trigger" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN openssl req -batch -x509 -nodes -days 5000 -newkey rsa:2048 -keyout /etc/nginx/phpwebdev.key -out /etc/nginx/phpwebdev.crt
RUN cat /etc/nginx/sites-enabled/default \
        | sed 's/# phpwebdevdocker_placeholder/listen 443 ssl;\nssl_certificate phpwebdev.crt;\nssl_certificate_key phpwebdev.key;/g' \
        > /tmp/nginx-default && \
        mv -f /tmp/nginx-default /etc/nginx/sites-enabled/default

ADD www/public /var/www/public/
