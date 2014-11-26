#!/usr/bin/env bash

grp=smbgrp
grpid=1002

user=smb
userid=1001

share=/tank

# setup samba
yum install -y samba samba-client

cat <<EOF>/etc/samba/smb.conf
[global]
workgroup = WORKGROUP
server string = Samba Server %v
#netbios name = centos
security = user
map to guest = bad user
dns proxy = no

[mandos]
path = $share
valid users = @smbgrp
browsable =yes
writable = yes
guest ok = no
read only = no
EOF

# cat <<EOF>/etc/samba/smb.conf
# [global]
#    workgroup = WORKGROUP
#    server string = File server
#    security = user
#    map to guest = Bad User
#    dns proxy = no 

# [mandos]
#    path = /mandos
#    public = yes
#    only guest = yes
#    writable = yes
# EOF

systemctl enable smb nmb
systemctl start smb nmb

# setup firewall
firewall-cmd --permanent --zone=public --add-service=samba
systemctl reload firewalld.service

# selinux should allow sharing
chcon -t samba_share_t $share

# setup users
groupadd -g $grpid $grp
useradd -G $grp -u $userid $user
echo foo | passwd --stdin $user
echo foo | smbpasswd -a -n $user

# fix permissions
chown -Rv $user:$grp $share
