#!/bin/sh

apt-get -yq update

apt-get install -y redis-server && pecl install redis && docker-php-ext-enable redis
