#@author Fred Brooker <git@gscloud.cz>
include .env

run ?=
has_php != command -v php 2>/dev/null
wp_status != docker inspect --format '{{json .State.Running}}' ${WORDPRESS_CONTAINER_NAME} 2>/dev/null | grep true
pma_status != docker inspect --format '{{json .State.Running}}' ${PMA_CONTAINER_NAME} 2>/dev/null | grep true
db_status != docker inspect --format '{{json .State.Running}}' ${WORDPRESS_DB_CONTAINER_NAME} 2>/dev/null | grep true
wpdb_status := $(wp_status)$(db_status)
wpdbok = truetrue
STATIC_IMAGE_BACKUP ?= gscloudcz/backup-static-site:latest
STATIC_IMAGE_RESTORE ?= gscloudcz/restore-static-site:latest
STATIC_IMAGE_SUSPEND ?= gscloudcz/suspend-static-site:latest

ifneq ($(strip $(wp_status)),)
wpdot=🟢
else
wpdot=🔴
endif

ifneq ($(strip $(db_status)),)
dbdot=🟢
else
dbdot=🔴
endif

ifneq ($(strip $(pma_status)),)
pmadot=🟢
else
pmadot=🔴
endif


all: info
info:
	@echo "\n\e[1;32mWordPress in Docker 👾\e[0m v1.1 2023-11-16\n"
	@echo "\e[0;1m📦️ WP\e[0m container: \t$(wpdot) \e[0;4m${WORDPRESS_CONTAINER_NAME}\e[0m \tport: ${WORDPRESS_PORT} \t🚀 http://localhost:${WORDPRESS_PORT}"
	@echo "\e[0;1m📦️ DB\e[0m container: \t$(dbdot) \e[0;4m${WORDPRESS_DB_CONTAINER_NAME}\e[0m \tport: ${WORDPRESS_DB_PORT}"
ifneq ($(strip $(PMA_PORT)),)
	@echo "\e[0;1m📦️ PMA\e[0m container: \t$(pmadot) \e[0;4m${PMA_CONTAINER_NAME}\e[0m \tport: ${PMA_PORT} \t🚀 http://localhost:${PMA_PORT}"
endif
	@echo ""
ifneq ($(strip $(CMD_EXTRAS)),)
	@echo "\e[1;33mCMD_EXTRAS\e[0m\e[0;33m is set to run after installation.\e[0m"
endif
ifneq ($(strip $(INSTALL_EXTRAS)),)
	@echo "\e[1;33mINSTALL_EXTRAS\e[0m\e[0;33m is set to run after installation.\e[0m"
endif
	@echo ""
	@echo " - \e[0;1m install\e[0m - install containers and start the app"
	@echo " - \e[0;1m start\e[0m - start containers"
	@echo " - \e[0;1m stop\e[0m - stop containers"
	@echo " - \e[0;1m pause\e[0m - pause containers"
	@echo " - \e[0;1m unpause\e[0m - unpause containers"
	@echo " - \e[0;1m suspend\e[0m - suspend site (run a static web instead)"
	@echo " - \e[0;1m unsuspend\e[0m - unsuspend site"
	@echo " - \e[0;1m kill\e[0m - kill containers"
	@echo " - \e[0;1m test\e[0m - test containers, force reinstall"
	@echo " - \e[0;1m fix\e[0m - fix web container permissions"
	@echo " - \e[0;1m update\e[0m - update themes and plugins via wp binary"
	@echo " - \e[0;1m cronrunall\e[0m - run all cron hooks"
	@echo " - \e[0;1m cronrundue\e[0m - run all cron hooks due right now"
	@echo " - \e[0;1m backup\e[0m - backup containers"
	@echo " - \e[0;1m restore\e[0m - restore containers"
	@echo " - \e[0;1m remove\e[0m - remove containers"
	@echo " - \e[0;1m debug\e[0m - install, run backend in the foreground"
	@echo " - \e[0;1m exec\e[0m - run shell inside WordPress container"
	@echo " - \e[0;1m exec run='<command>'\e[0m - run <command> inside WordPress container"
	@echo " - \e[0;1m config\e[0m - display Docker compose configuration"
	@echo " - \e[0;1m jsoncontrol\e[0m - display a set of make control commands in JSON format"
	@echo " - \e[0;1m logs\e[0m - display logs"
	@echo " - \e[0;1m purge\e[0m - delete persistent data ❗️"
	@echo " - \e[0;1m docs\e[0m - build documentation into PDF format"
	@echo ""

jsoncontrol:
ifneq ($(strip $(has_php)),)
	@php -r 'echo json_encode(["control_set" => ["backup", "config", "cronrunall", "cronrundue", "debug", "exec", "fix", "install", "kill", "logs", "pause", "purge", "remove", "restore", "start", "stop", "suspend", "test", "unpause", "unsuspend", "update"]], JSON_PRETTY_PRINT);'
else
	@echo "❗️ php parser is not installed"
	@exit 99
endif

docs:
	@echo "🔨 \e[1;32m Building documentation\e[0m"
	@bash ./bin/create_pdf.sh

debug:
	@docker compose up

install:
ifneq ($(strip $(ENABLE_STATIC_PAGES)),)
	@-docker rm ${WORDPRESS_CONTAINER_NAME}_static --force 2>/dev/null
endif
	@docker compose up -d
ifneq ($(strip $(CMD_EXTRAS)),)
	@docker cp ./cmd_extras.sh ${WORDPRESS_CONTAINER_NAME}:/
	@docker exec ${WORDPRESS_CONTAINER_NAME} /cmd_extras.sh
	@docker restart ${WORDPRESS_CONTAINER_NAME}
endif
ifneq ($(strip $(INSTALL_EXTRAS)),)
	@bash ./install_extras.sh
endif
	@echo "\n\e[0;1m📦️ WP\e[0m: 🚀 http://localhost:${WORDPRESS_PORT}"
ifneq ($(strip $(PMA_PORT)),)
	@echo "\e[0;1m📦️ PMA\e[0m: 🚀 http://localhost:${PMA_PORT}"
endif
	@echo ""

start:
	@echo "starting containers..."
ifneq ($(strip $(ENABLE_STATIC_PAGES)),)
	@-docker rm ${WORDPRESS_CONTAINER_NAME}_static --force 2>/dev/null
endif
	@docker start ${WORDPRESS_DB_CONTAINER_NAME}
	@docker start ${WORDPRESS_CONTAINER_NAME}
ifneq ($(strip $(PMA_PORT)),)
	@docker start ${PMA_CONTAINER_NAME}
endif

stop:
	@-docker stop ${WORDPRESS_CONTAINER_NAME}
	@-docker stop ${WORDPRESS_DB_CONTAINER_NAME}
ifneq ($(strip $(PMA_PORT)),)
	@-docker stop ${PMA_CONTAINER_NAME}
endif
ifneq ($(strip $(ENABLE_STATIC_PAGES)),)
	@-docker rm ${WORDPRESS_CONTAINER_NAME}_static --force 2>/dev/null
endif

kill:
	@docker compose kill

pause:
	@echo "⏯️"
	@docker compose pause

unpause:
	@echo "⏯️"
	@docker compose unpause

remove:
	@echo "removing containers..."
	@docker compose stop
	@-docker rm ${WORDPRESS_CONTAINER_NAME} --force 2>/dev/null
	@-docker rm ${WORDPRESS_DB_CONTAINER_NAME} --force 2>/dev/null
ifneq ($(strip $(PMA_PORT)),)
	@-docker rm ${PMA_CONTAINER_NAME} --force 2>/dev/null
endif
ifneq ($(strip $(ENABLE_STATIC_PAGES)),)
	@-docker rm ${WORDPRESS_CONTAINER_NAME}_static --force 2>/dev/null
endif

suspend: remove
ifneq ($(strip $(ENABLE_STATIC_PAGES)),)
	@-docker rm ${WORDPRESS_CONTAINER_NAME}_static --force 2>/dev/null
	@echo "⛔️ running suspend site"
	@docker run -d --rm -p ${WORDPRESS_PORT}:3000 --name ${WORDPRESS_CONTAINER_NAME}_suspended ${STATIC_IMAGE_SUSPEND}
else
	@echo "ℹ️ static sites are disabled in .env"
endif

unsuspend:
ifneq ($(strip $(ENABLE_STATIC_PAGES)),)
	@echo "⛔️ removing suspend site"
	@-docker rm ${WORDPRESS_CONTAINER_NAME}_suspended --force 2>/dev/null
	@-make install
else
	@echo "ℹ️ static sites are disabled in .env"
endif

config:
	@docker compose config

exec:
ifneq ($(strip $(run)),)
	@docker exec -it ${WORDPRESS_CONTAINER_NAME} $(run)
else
	@docker exec -it ${WORDPRESS_CONTAINER_NAME} bash
endif

fix:
ifneq ($(shell id -u),0)
	@echo "root permission required"
endif
	@sudo rm -f www/.maintenance
	@sudo chown -R www-data:www-data www/wp-content
	@echo "content permissions fixed"

update:
ifneq ($(shell id -u),0)
	@echo "root permission required"
endif
	@sudo rm -f www/.maintenance
	@sudo chown -R www-data:www-data www/wp-content
	@echo "content permissions fixed"
	@-docker exec -it ${WORDPRESS_CONTAINER_NAME} wp plugin update --all
	@-docker exec -it ${WORDPRESS_CONTAINER_NAME} wp theme update --all
	@sudo chown -R www-data:www-data www/wp-content
	@sudo rm -f www/.maintenance
	@echo "content permissions fixed"

cronrundue:
	@sudo rm -f www/.maintenance
	@-docker exec -it ${WORDPRESS_CONTAINER_NAME} wp cron event run --due-now
	@sudo rm -f www/.maintenance

cronrunall:
	@sudo rm -f www/.maintenance
	@-docker exec -it ${WORDPRESS_CONTAINER_NAME} wp cron event run --all
	@sudo rm -f www/.maintenance

logs:
	@docker logs -f ${WORDPRESS_CONTAINER_NAME}

backup: start
ifneq ($(shell id -u),0)
	@echo "root permission required"
	@sudo echo ""
endif
	@date
	@rm -rf bak
	@mkdir bak
	@echo "exporting database"
	@-docker exec ${WORDPRESS_DB_CONTAINER_NAME} mariadb-dump -uroot -p${MYSQL_ROOT_PASSWORD} --all-databases > bak/mariadb.sql
	@-docker stop ${WORDPRESS_CONTAINER_NAME}
	@-docker stop ${WORDPRESS_DB_CONTAINER_NAME}
ifneq ($(strip $(PMA_PORT)),)
	@-docker stop ${PMA_CONTAINER_NAME}
endif
ifneq ($(strip $(ENABLE_STATIC_PAGES)),)
	@echo "running static site"
	@-docker run -d --rm -p ${WORDPRESS_PORT}:3000 --name ${WORDPRESS_CONTAINER_NAME}_static ${STATIC_IMAGE_BACKUP}
endif
ifneq ($(shell id -u),0)
	@echo "root permission required"
endif
	@sudo tar czf bak/db.tgz db
	@sudo tar czf bak/www.tgz www
	@cp Makefile bak/
	@cp .env bak/
	@cp apache/* bak/
	@cp docker-compose.yml bak/
ifneq ($(strip $(CMD_EXTRAS)),)
	@cp cmd_extras.sh bak/
endif
ifneq ($(strip $(INSTALL_EXTRAS)),)
	@cp install_extras.sh bak/
endif
ifneq ($(strip $(ENABLE_STATIC_PAGES)),)
	@echo "closing static site"
	@-docker rm ${WORDPRESS_CONTAINER_NAME}_static --force 2>/dev/null
endif
	@-make install
	@date

restore: remove
ifneq ($(shell id -u),0)
	@echo "root permission required"
	@sudo echo ""
endif
	@date
ifneq ($(strip $(ENABLE_STATIC_PAGES)),)
	@echo "running static site"
	@-docker run -d --rm -p ${WORDPRESS_PORT}:3000 --name ${WORDPRESS_CONTAINER_NAME}_static ${STATIC_IMAGE_RESTORE}
endif
ifneq ($(shell id -u),0)
	@echo "root permission required"
endif
	@sudo rm -rf db www
ifneq ($(wildcard ./bak/.),)
	@echo "🎒 backup location: bak"
ifneq ($(wildcard bak/db.tgz),)
	@-sudo tar xzf bak/db.tgz 2>/dev/null
else
	@echo "❗️ missing database archive"
	exit 1
endif
ifneq ($(wildcard bak/www.tgz),)
	@-sudo tar xzf bak/www.tgz 2>/dev/null
else
	@echo "❗️ missing WordPress archive"
	exit 1
endif
else
	@echo "🎒 backup location: ."
ifneq ($(wildcard db.tgz),)
	@-sudo tar xzf db.tgz 2>/dev/null
else
	@echo "❗️ missing database archive"
	exit 1
endif
ifneq ($(wildcard www.tgz),)
	@-sudo tar xzf www.tgz 2>/dev/null
else
	@echo "❗️ missing WordPress archive"
	exit 1
endif
endif
ifneq ($(strip $(CMD_EXTRAS)),)
	@cp bak/cmd_extras.sh . 2>/dev/null
endif
ifneq ($(strip $(INSTALL_EXTRAS)),)
	@cp bak/install_extras.sh . 2>/dev/null
endif
ifneq ($(strip $(ENABLE_STATIC_PAGES)),)
	@echo "closing static site"
	@-docker rm ${WORDPRESS_CONTAINER_NAME}_static --force 2>/dev/null
endif
	@-make install
	@date

purge: remove
	@-docker rm ${WORDPRESS_CONTAINER_NAME}_static --force 2>/dev/null
	@-docker rm ${WORDPRESS_DB_CONTAINER_NAME}_static --force 2>/dev/null
	@echo "💀 deleting permanent storage"
ifneq ($(shell id -u),0)
	@echo "root permission required"
endif
	sudo rm -rf db/ www/

test:
ifneq ($(strip $(ENABLE_STATIC_PAGES)),)
	@-docker rm ${WORDPRESS_CONTAINER_NAME}_static --force 2>/dev/null
endif
ifneq ($(strip $(wp_status)),)
	@echo "🟢 WP is up and running or paused"
else
	@echo "🔴 WP is down"
endif
ifneq ($(strip $(db_status)),)
	@echo "🟢 DB is up and running or paused"
else
	@echo "🔴 DB is down"
endif
ifneq ($(wpdb_status), $(wpdbok))
	@-make install
	@exit 1
else
	@exit 0
endif
