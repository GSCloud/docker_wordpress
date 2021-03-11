#@author Filip Oščádal <git@gscloud.cz>
all: info

info:
	@echo "\e[1;32m👾 Welcome to WordPress in Docker 👾\n"

	@echo "🆘 \e[0;1mmake clean\e[0m - clean current installation"
	@echo "🆘 \e[0;1mmake config\e[0m - show Docker configuration"
	@echo "🆘 \e[0;1mmake docs\e[0m - build documentation"
	@echo "🆘 \e[0;1mmake install\e[0m - install containers"
	@echo "🆘 \e[0;1mmake remove\e[0m - kill containers"

docs:
	@echo "🔨 \e[1;32m Building documentation\e[0m"
	@bash ./bin/create_pdf.sh

install:
	@echo "🔨 \e[1;32m Installing\e[0m"
	@bash ./bin/install.sh

remove:
	@echo "🔨 \e[1;32m Removing\e[0m"
	@bash ./bin/remove.sh

config:
	docker-compose config

clean: remove
	sudo rm -rf db/ www/

everything: remove install
