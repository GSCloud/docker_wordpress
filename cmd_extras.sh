#!/bin/sh
# Fred Brooker <git@gscloud.cz>

apt-get -yqq update
apt-get -o DPkg::Lock::Timeout=30 -yq upgrade

exit 0
