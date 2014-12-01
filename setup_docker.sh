#!/usr/bin/env bash

set -e
set -x

# for running in VM

cat <<EOF>/etc/sysconfig/docker
OPTIONS=--selinux-enabled --registry-mirror=http://docker-registry:5000 --dns 8.8.8.8 --dns 8.8.4.4 --dns 10.0.0.1
EOF


systemctl restart docker
