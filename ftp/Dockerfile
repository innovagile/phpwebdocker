FROM ubuntu:eoan
LABEL author="innovAgile <hello@innovagile.com>"
LABEL version="0.2.0"

RUN apt-get -y update && \
    apt-get install -y language-pack-en-base && \
    locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8 && \
    DEBIAN_FRONTEND=noninteractive LC_ALL=en_US.UTF-8 \
    apt-get install -y --force-yes lftp git && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
