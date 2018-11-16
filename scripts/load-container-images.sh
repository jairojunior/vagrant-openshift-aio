#!/bin/sh

systemctl start docker

cd /vagrant/images

docker load -i "$1-$2.tar"