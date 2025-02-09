# WPD (WordPress in Docker) v1.12 2025-02-10

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
- suspend - suspend site
- unsuspend - unsuspend site
- test - test containers
- fix - fix web container permissions
- update - update themes and plugins
- kill - kill containers
- remove - remove containers
- cronrunall - run all cron hooks
- cronrundue - run all cron hooks due
- backup - backup containers
- restore - restore containers
- exec - run interactive shell
- exec run='\<command\>' - run \<command\> in shell
- debug - install and run in the foreground
- lock - lock installation for writing
- unlock - unlock installation for writing
- config - display configuration
- logs - display logs
- purge - delete persistent data ❗️
- docs - transform documentation into PDF

## Examples

- `make purge install` - purge everything and fresh install
- `make backup test` - make backup and test
- `make purge restore` - purge everything and restore from backup
- `make logs` - show logs
- `make test` - test containers

---

Author: Fred Brooker 💌 <git@gscloud.cz> ⛅️ GS Cloud Ltd. [https://gscloud.cz](https://gscloud.cz)
