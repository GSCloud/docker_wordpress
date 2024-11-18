# WP in Docker and MariaDB v1.8 2024-11-18

## WP is an open source web content management system

Run WP, MariaDB and phpMyAdmin (optional) as Docker containers using only: **Makefile**, **.env** and **docker-compose.yml**.

Alternative docker-compose examples and other demo files enclosed.

## Extras

- can run `cmd_extras.sh` after the installation inside the WP container (adding extra modules?)
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
- lock - lock installation for writing
- unlock - unlock installation for writing
- logs - display logs
- purge - delete persistent data ❗️
- docs - transpile documentation into PDF

## Examples

- `make purge install` - purge everything and fresh install
- `make backup test` - make backup and test functionality
- `make purge restore` - purge everything and restore from backup
- `make logs` - show logs from the main container
- `make test` - test containers (reinstall if it failes)

---

Author: Fred Brooker 💌 <git@gscloud.cz> ⛅️ GS Cloud Ltd. [https://gscloud.cz](https://gscloud.cz)
