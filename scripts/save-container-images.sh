#!/bin/sh

set -e
set -o pipefail
set -o nounset

if [ -x "$(command -v docker)" ]; then

  IMAGES=$(docker images | awk '{ print $ 1}' | tail -n +2 | tr '\n' ' ')

  if [ ! -z "$IMAGES" ]; then
    cd /vagrant/images
    docker save -o $1-$2.tar $IMAGES
  fi
fi
