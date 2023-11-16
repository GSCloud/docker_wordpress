# WordPress in Docker

demo [https://wodpress-in-docker.mxd.cz]  
repo [https://github.com/GSCloud/docker_wordpress]

Run WordPress, MariaDB and phpMyAdmin in Docker containers using only a **Makefile**, **.env** configuration file and **docker-compose.yml** (alternative docker-compose examples are available).

`cmd_extras.sh` can be run after the installation inside the WP container (like adding extra modules), `install_extras.sh` can be run after the installation outside (like starting daemons).

You can run optional static web during suspend, backup and restore operations.

There's also **wp** binary support with shell completion and some bash aliases.

## Usage

Run `make`:

—  `install` - install containers and start the app  
—  `start` - start containers  
—  `stop` - stop containers  
—  `pause` - pause containers  
—  `unpause` - unpause containers  
—  `suspend` - suspend site (run a static web instead)  
—  `unsuspend` - unsuspend site  
—  `kill` - kill containers  
—  `test` - test WP and DB containers, force reinstall  
—  `fix` - fix web container permissions  
—  `update` - update themes and plugins via wp binary  
—  `cronrunall` - run all cron hooks  
—  `cronrundue` - run all cron hooks due right now  
—  `backup` - backup containers  
—  `restore` - restore containers  
—  `remove` - remove containers  
—  `debug` - install, run backend in the foreground  
—  `exec` - run bash inside WordPress container  
—  `exec run`='\<command\>' - run \<command\> inside WordPress container  
—  `config` - display configuration  
—  `jsoncontrol` - display a set of make control commands in JSON format  
—  `logs` - display logs  
—  `purge` - delete persistent data ❗️  
—  `docs` - build documentation into PDF format  

Author: Fred Brooker 💌 <git@gscloud.cz>  
GS Cloud Ltd. [https://gscloud.cz] ⛅️
