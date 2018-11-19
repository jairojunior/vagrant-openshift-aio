#!/bin/sh

set -e
set -o pipefail
set -o nounset

cd /vagrant/images

if [ -x "$(command -v docker)" ]; then
  docker save -o $1-$2.tar $(docker images | awk '{ print $ 1}' | tail -n +2 | tr '\n' ' ')
fi
