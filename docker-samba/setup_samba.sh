#!/usr/bin/env bash

grp=smbgrp
grpid=1002

user=badi
userid=1001

share=/tank

# setup samba
yum install -y samba samba-client

cat <<EOF>/etc/samba/smb.conf
[global]
workgroup = WORKGROUP
server string = Samba Server %v
#netbios name = centos
security = User
map to guest = Bad User
encrypt passwords = yes
loglevel = 2

[mandos2]
path = $share
valid users = @smbgrp
writable = yes
browsable =yes
inherit owner = yes
inherit permissions = yes
inherit acls = yes
guest ok = yes
read only = no

EOF

systemctl enable smb nmb
systemctl start smb nmb
smbpasswd -n -a $user

# setup firewall
firewall-cmd --permanent --zone=public --add-service=samba
systemctl reload firewalld.service

# selinux should allow sharing
chcon -t samba_share_t $share

# fix permissions
chown -Rv $user:$grp $share

# done
echo "Samba is now configured"
echo "Run the following to setup the user:"
echo "smbpasswd $user"
