# WordPress in Docker

GitHub: [https://github.com/GSCloud/docker_wordpress]  
Demo: [https://wordpress-in-docker.mxd.cz]

Run WordPress, MariaDB and phpMyAdmin containers in Docker.

## Usage

* **make** -> CLI help

## Install WordPress

* run "**make install**"
* use the **Apache 2.4 conf** to run this on a real site through proxying
* WordPress -> open browser [http://localhost:5001/](http://localhost:5001/)
* PMA -> open browser [http://localhost:5003/](http://localhost:5003/)

## Uninstall WordPress

* run "**make remove**"
* persistent data remains in data storage (see below)

## WP-CLI commands

* run "**./cli.sh --info**" [https://make.wordpress.org/cli/handbook/guides/commands-cookbook/]
* run "**./cli.sh plugin list**"
* run "**./cli.sh plugin install disable-comments --activate**"

## Configuration

* configuration directives for Docker -> **.env**
* extra configuration directives for PHP -> **uploads.ini**
* WP-CLI -> **/usr/local/bin/wp**

## Data storage

* **WordPress** data & PHP code stored in **./www/**
* **MariaDB** database stored in **./db/**

Author: Filip Oščádal aka Fred Brooker 💌 <git@gscloud.cz>
