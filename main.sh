#!/usr/bin/env bash

set -e
set -x

./install_zfs.sh
./setup_zfs.sh

./setup_sw.sh
./setup_users.sh
./setup_docker.sh
./setup_samba.sh
