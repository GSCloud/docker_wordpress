#!/bin/sh

apt-get -yq update
apt-get -o DPkg::Lock::Timeout=30 install -y less libxml2-dev

docker-php-ext-install soap

php -i | grep -i soap
