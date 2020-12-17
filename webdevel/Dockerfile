FROM innovagile/web:latest
LABEL author="innovAgile <hello@innovagile.com>"
LABEL version=${PHP_VERSION}

RUN apt-get -y update && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs build-essential unzip autoconf && \
    apt-get install -y php${PHP_VERSION}-xdebug && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN  EXPECTED_SIGNATURE="$(curl -q https://composer.github.io/installer.sig)" && \
    curl -o /tmp/composer-setup.php https://getcomposer.org/installer && \
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', '/tmp/composer-setup.php');")" && \
    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then >&2 echo "ERROR: Invalid installer signature!\nExpected: $EXPECTED_SIGNATURE\nActual:   $ACTUAL_SIGNATURE"; rm /tmp/composer-setup.php; exit 1; fi && \
    php /tmp/composer-setup.php --install-dir=/bin --filename=composer && \
    rm /tmp/composer-setup.php && \
    npm i -g npm && \
    npm install --global gulp-cli && \
    npm install --global --save-dev webpack webpack-cli
RUN echo "clear_env = no" >> /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    echo "env[DB_HOST] = \$DB_HOST" >> /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    echo "env[DB_USER] = \$DB_USER" >> /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    echo "env[DB_PASSWORD] = \$DB_PASSWORD" >> /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    echo "xdebug.remote_enable=1" >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini && \
    echo 'xdebug.remote_connect_back=0' >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini && \
    echo 'xdebug.remote_port=9000' >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini && \
    echo 'xdebug.remote_host=host.docker.internal' >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini && \
    echo "xdebug.remote_autostart=0" >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini

ADD www/public /var/www/public/
