#!/bin/bash

set -e

nmbd
smbd

tail -f /var/log/samba/log.smbd
