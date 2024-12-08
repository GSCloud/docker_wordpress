# WP in Docker v1.9 2024-11-21

## WP is an open source web content management system

Run WP, MariaDB and phpMyAdmin (optional) as Docker containers using only: **Makefile**, **.env** and **docker-compose.yml**.

Alternative docker-compose examples and other demo files are enclosed.

## Extras

- can run `cmd_extras.sh` after the installation inside the container (adding extra modules?)
- can run `install_extras.sh` after the installation outside (starting daemons?)
- available **temporary static web** (optional) containers during *suspend*, *backup* and *restore* operations (for users or monitoring services)
- available **wp** binary with **shell completion**, **bash aliases** and some *PHP ini setup*

## Usage

Run `make`:

- install - install containers
- start - start containers
- stop - stop containers
- suspend - suspend site (run a static web instead)
- unsuspend - unsuspend site
- test - test containers
- fix - fix web container permissions
- update - update themes and plugins via wp binary
- kill - kill containers
- remove - remove containers
- cronrunall - run all cron hooks
- cronrundue - run all cron hooks due
- backup - backup containers
- restore - restore containers
- exec - run shell inside container
- exec run='\<command\>' - run \<command\> inside container
- debug - install and run in the foreground
- config - display Docker compose configuration
- lock - lock installation for writing
- unlock - unlock installation for writing
- logs - display logs
- purge - delete persistent data ❗️
- docs - transpile documentation into PDF

## Examples

- `make purge install` - purge everything and fresh install
- `make backup test` - make backup and test
- `make purge restore` - purge everything and restore from backup
- `make logs` - show logs
- `make test` - test containers

---

Author: Fred Brooker 💌 <git@gscloud.cz> ⛅️ GS Cloud Ltd. [https://gscloud.cz](https://gscloud.cz)
