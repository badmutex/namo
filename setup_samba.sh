#!/usr/bin/env bash

set -e

user=mandos
share=/tank

# let SELinux allow docker sharing of data
chcon -Rt svirt_sandbox_file_t $share

# setup firewall
firewall-cmd --permanent --zone=public --add-service=samba
systemctl reload firewalld.service

# selinux should allow sharing
chcon -t samba_share_t $share

# fix permissions
chown -Rv $user:$user $share

# create docker image
cat <<EOF>Dockerfile
FROM phusion/baseimage

RUN apt-get -yqq update && apt-get -yqq install samba samba-client

VOLUME /etc/passwd
VOLUME /etc/group
VOLUME /share
VOLUME /etc/samba

ADD ./entry.sh /bin/entry.sh

EXPOSE 139 445
ENTRYPOINT ["/bin/entry.sh"]
EOF

cat <<EOF>entry.sh
#!/bin/bash

set -e

nmbd
smbd

tail -f /var/log/samba/log.smbd
EOF

chmod +x entry.sh

docker build -t badi/samba-server .


# samba server service
cat <<EOF>/etc/systemd/system/samba-server.service
[Unit]
Description=Samba server
After=docker.service
Requires=docker.service

[Service]
ExecStartPre=-/usr/bin/docker kill samba-server
ExecStartPre=-/usr/bin/docker rm samba-server
ExecStart=/usr/bin/env docker run --rm --privileged -p 139:139 -p 445:445 -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -v /tank/:/share -v $PWD/samba:/etc/samba --name samba-server badi/samba-server

[Install]
WantedBy=multi-user.target
EOF

systemctl enable samba-server.service
systemctl start samba-server.service
