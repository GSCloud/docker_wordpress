# WordPress in Docker

demo [https://wodpress-in-docker.mxd.cz]  
repo [https://github.com/GSCloud/docker_wordpress]

Run WordPress, MariaDB and phpMyAdmin in Docker containers using a Makefile and .env configuration file.  
(an alternative docker-compose without phpMyAdmin is available)

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
