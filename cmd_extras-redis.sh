#!/bin/sh
# Fred Brooker <git@gscloud.cz>

apt-get -yqq update
apt-get install -y redis-server && pecl install redis && docker-php-ext-enable redis
