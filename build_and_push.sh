#!/usr/bin/env bash

CURRENT_DIR=`pwd`
cd `dirname $0`

DOCKER_VERSION=`git status -b | grep 'On branch' | cut -d " " -f 3 | tr "_" "."`
if [ $DOCKER_VERSION = "master" ]; then
  DOCKER_VERSION="latest"
fi

echo "Version $DOCKER_VERSION"

cd phpwebdocker && \
docker build -t innovagile/phpwebdocker:$DOCKER_VERSION . && \
docker push innovagile/phpwebdocker:$DOCKER_VERSION && \

cd ../phpwebdevdocker && \
docker build -t innovagile/phpwebdevdocker:$DOCKER_VERSION . && \
docker push innovagile/phpwebdevdocker:$DOCKER_VERSION && \
echo "Build completed"

cd $CURRENT_DIR
