#!/bin/bash
#@author Filip Oščádal <git@gscloud.cz>

. bin/_includes.sh

command -v docker >/dev/null 2>&1 || fail "Docker is NOT installed!"

if [ ! -r ".env" ]; then fail "Missing .env file!"; fi
export $(grep -v '^#' .env | xargs -d '\n')

if [ -z "$DB_NAME" ]; then fail "Missing DB_NAME definition!"; fi
if [ -z "$PMA_NAME" ]; then fail "Missing PMA_NAME definition!"; fi
if [ -z "$WP_NAME" ]; then fail "Missing WP_NAME definition!"; fi

info Killing $WP_NAME
docker kill $WP_NAME 2>/dev/null

info Killing $PMA_NAME
docker kill $PMA_NAME 2>/dev/null

info Killing $DB_NAME
docker kill $DB_NAME 2>/dev/null

exit 0
