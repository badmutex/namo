#!/usr/bin/env bash

set -e
set -x

### Make sure you run yum update -y && reboot before this to get the right kernel headers and kernel

yum localinstall --nogpgcheck -y \
    https://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm \
    http://archive.zfsonlinux.org/epel/zfs-release.el7.noarch.rpm
yum install -y kernel-devel zfs
