FROM registry.innovagile.com:5000/benipass/web
MAINTAINER innovAgile <hello@innovagile.com>

RUN apt-get -y update && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs build-essential unzip autoconf && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    npm i -g npm && \
    npm install -g gulp
