# WordPress in Docker

demo [https://wodpress-in-docker.mxd.cz]  
repo [https://github.com/GSCloud/docker_wordpress]

Run WordPress, MariaDB and phpMyAdmin (optional) as Docker containers using only: **Makefile**, **.env** and **docker-compose.yml**.

Alternative docker-compose examples and other demo files enclosed.

## Extras

- can run `cmd_extras.sh` after the installation inside the WP container (adding extra modules?),
- can run `install_extras.sh` after the installation outside (starting daemons?),
- available **temporary static web** (optional) containers during *suspend*, *backup* and *restore* operations (for users or monitoring services),
- available **wp** binary with **shell completion**, **bash aliases** and some *PHP ini setup* available.

## Usage

Run `make`:

- install - install containers
- start - start containers
- stop - stop containers
- pause - pause containers
- unpause - unpause containers
- suspend - suspend site (run a static web instead)
- unsuspend - unsuspend site
- test - test containers, force reinstall
- fix - fix web container permissions
- update - update themes and plugins via wp binary
- kill - kill containers
- remove - remove containers
- cronrunall - run all cron hooks
- cronrundue - run all cron hooks due right now
- backup - backup containers
- restore - restore containers
- exec - run shell inside WP container
- exec run='\<command\>' - run \<command\> inside WP container
- debug - install and run WP in the foreground
- config - display Docker compose configuration
- jsoncontrol - display a set of control commands in JSON
- logs - display logs
- purge - delete persistent data ❗️
- docs - transpile documentation into PDF

## Examples

- `make purge install` - purge everything and fresh install
- `make backup test` - make backup and test functionality
- `make purge restore` - purge everything and restore from backup

---

Author: Fred Brooker 💌 <git@gscloud.cz> ⛅️ GS Cloud Ltd. [https://gscloud.cz]
