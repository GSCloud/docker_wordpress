#!/bin/bash
#@author Filip Oščádal <git@gscloud.cz>

. bin/_includes.sh

command -v docker >/dev/null 2>&1 || fail "Docker is NOT installed!"

if [ ! -r ".env" ]; then fail "Missing .env file!"; fi
export $(grep -v '^#' .env | xargs -d '\n')

if [ -z "$DB_NAME" ]; then fail "Missing DB_NAME definition!"; fi
if [ -z "$PMA_NAME" ]; then fail "Missing PMA_NAME definition!"; fi
if [ -z "$WP_NAME" ]; then fail "Missing WP_NAME definition!"; fi

mkdir -p db www

info Stopping $WP_NAME
docker stop $WP_NAME 2>/dev/null

info Stopping $PMA_NAME
docker stop $PMA_NAME 2>/dev/null

info Stopping $DB_NAME
docker stop $DB_NAME 2>/dev/null
echo -en "\n"

#docker-compose pull
docker-compose up -d
echo -en "\n"

docker-compose ps
echo -en "\n"

docker exec $WP_NAME php -i | grep 'memory_limit'
docker exec $WP_NAME php -i | grep 'upload_max_filesize'
echo -en "\n"

docker exec $WP_NAME wp --allow-root --info

echo -en "\nWordPress - http://localhost:$WP_PORT/"
echo -en "\nphpMyAdmin - http://localhost:${PMA_PORT}/"
echo -en "\n\nlogin as:\n\n\troot\n\t${MYSQL_ROOT_PASSWORD}"
echo -en "\n\nDone.\n"

exit 0
