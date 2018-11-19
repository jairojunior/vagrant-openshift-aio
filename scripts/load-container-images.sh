#!/bin/sh

set -e
set -o nounset

systemctl start docker

cd /vagrant/images

IMAGES_TARBALL="$1-$2.tar"

if [ -e "$IMAGES_TARBALL" ]; then
    docker load -i $IMAGES_TARBALL
fi