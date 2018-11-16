#!/bin/sh

cd /vagrant/images

docker save -o $1-$2.tar $(docker images | awk '{ print $ 1}' | tail -n +2 | tr '\n' ' ')