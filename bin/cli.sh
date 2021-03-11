#!/bin/bash

export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/usr/local/go/bin
export PATH=$PATH:/root/bin:/root/go/bin:/root/.cargo/bin:/root/scripts

. bin/_includes.sh

command -v docker >/dev/null 2>&1 || fail "Docker is NOT installed!"

if [ ! -r ".env" ]; then fail "Missing .env file!"; fi
export $(grep -v '^#' .env | xargs -d '\n')

if [ -z "$DB_NAME" ]; then fail "Missing DB_NAME definition!"; fi
if [ -z "$PMA_NAME" ]; then fail "Missing PMA_NAME definition!"; fi
if [ -z "$WP_NAME" ]; then fail "Missing WP_NAME definition!"; fi

if [ ! "$#" -gt 0 ]; then fail "Missing parameter, eg. '--info'"; fi

docker exec $WP_NAME wp --allow-root "$@"

exit 0
