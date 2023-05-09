#!/usr/bin/env bash

CURRENT_DIR=`pwd`
cd `dirname $0`

DOCKER_VERSION=`git status -b | grep 'On branch' | cut -d " " -f 3 | tr "_" "."`
if [ $DOCKER_VERSION = "master" ]; then
  DOCKER_VERSION="latest"
fi

echo "Version $DOCKER_VERSION"

for DOCKER_IMAGE in "phpwebdocker" "phpwebdevdocker" "phpwebdocker-alpine" "phpwebdevdocker-alpine"
do
  cd $DOCKER_IMAGE && \
  docker build -t innovagile/$DOCKER_IMAGE:$DOCKER_VERSION . && \
  echo "=== Build of $DOCKER_IMAGE:$DOCKER_VERSION completed"
  docker push innovagile/$DOCKER_IMAGE:$DOCKER_VERSION && \
  echo "=== Push of $DOCKER_IMAGE:$DOCKER_VERSION completed"
  cd $CURRENT_DIR
done

echo "=== Build completed ==="
