FROM registry.innovagile.com:5000/innovagile/web
MAINTAINER innovAgile <hello@innovagile.com>

RUN apt-get -y update && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs build-essential unzip autoconf && \
    apt-get install -y php-xdebug && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN npm i -g npm && \
    npm install -g gulp
RUN echo "xdebug.remote_enable=1" >> /etc/php/7.4/mods-available/xdebug.ini && \
    echo 'xdebug.remote_connect_back=0' >> /etc/php/7.4/mods-available/xdebug.ini && \
    echo 'xdebug.remote_port=9000' >> /etc/php/7.4/mods-available/xdebug.ini && \
    echo 'xdebug.remote_host=host.docker.internal' >> /etc/php/7.4/mods-available/xdebug.ini && \
    echo "xdebug.remote_autostart=0" >> /etc/php/7.4/mods-available/xdebug.ini
