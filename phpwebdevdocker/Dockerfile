FROM innovagile/phpwebdocker
LABEL author="innovAgile <hello@innovagile.com>"
LABEL version=${PHP_VERSION}

RUN apt-get -y update && \
    curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs build-essential unzip autoconf && \
    apt-get install -y php${PHP_VERSION}-xdebug && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN EXPECTED_SIGNATURE="$(curl -q https://composer.github.io/installer.sig)" && \
    curl -o /tmp/composer-setup.php https://getcomposer.org/installer && \
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', '/tmp/composer-setup.php');")" && \
    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then >&2 echo "ERROR: Invalid installer signature!\nExpected: $EXPECTED_SIGNATURE\nActual:   $ACTUAL_SIGNATURE"; rm /tmp/composer-setup.php; exit 1; fi && \
    php /tmp/composer-setup.php --install-dir=/bin --filename=composer && \
    rm /tmp/composer-setup.php && \
    npm i -g npm && \
    npm install --global gulp-cli && \
    npm install --global --save-dev webpack webpack-cli

ADD conf/nginx /etc/nginx/

RUN cat /etc/php/current/fpm/pool.d/www.conf | sed 's/^;pm.status_path = \/.\+$/pm.status_path = \/status_fpm/' > /tmp/www.conf && mv /tmp/www.conf /etc/php/current/fpm/pool.d/www.conf

RUN echo "clear_env = no" >> /etc/php/current/fpm/pool.d/www.conf && \
    echo "env[DB_HOST] = \$DB_HOST" >> /etc/php/current/fpm/pool.d/www.conf && \
    echo "env[DB_USER] = \$DB_USER" >> /etc/php/current/fpm/pool.d/www.conf && \
    echo "env[DB_PASSWORD] = \$DB_PASSWORD" >> /etc/php/current/fpm/pool.d/www.conf && \

    echo 'display_errors=true' >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini && \
    echo 'expose_php=true' >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini && \

    echo "xdebug.mode=debug" >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini && \
    echo 'xdebug.discover_client_host=false' >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini && \
    echo 'xdebug.client_port=9003' >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini && \
    echo 'xdebug.client_host=host.docker.internal' >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini && \
    echo "xdebug.start_with_request=trigger" >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini

RUN openssl req -batch -x509 -nodes -days 5000 -newkey rsa:2048 -keyout /etc/nginx/phpwebdev.key -out /etc/nginx/phpwebdev.crt
RUN cat /etc/nginx/sites-enabled/default \
        | sed 's/; phpwebdevdocker_placeholder/listen 443 ssl;\nssl_certificate phpwebdev.crt;\nssl_certificate_key phpwebdev.key;/g' \
        > /tmp/nginx-default && \
        mv -f /tmp/nginx-default /etc/nginx/sites-enabled/default

ADD www/public /var/www/public/
