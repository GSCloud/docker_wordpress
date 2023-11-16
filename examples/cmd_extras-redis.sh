#!/bin/sh
# Fred Brooker <git@gscloud.cz>

apt-get -yqq update
apt-get -o DPkg::Lock::Timeout=30 install -y less redis-server
pecl install redis
docker-php-ext-enable redis

exit 0
