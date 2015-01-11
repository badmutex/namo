#!/usr/bin/env bash

chmod +x enable_ahci.sh
mv enable_ahci.sh /usr/local/sbin/enable_ahci

cat <<EOF>/etc/systemd/system/enable-ahci.service
[Unit]
Description=Enable AHCI for PCI raid/sata controllers
After=basic.target
Requires=basic.target

[Service]
Type=oneshot
StartCmdExec=/usr/local/bin/enable_ahci

[Install]
WantedBy=multi-user.target
EOF


sed -i 's/Before=local-fs.target/After=enable-ahci.service\nRequires=enable-ahci.service/' /usr/lib/systemd/system/zfs-mount.service
systemctl enable enable-ahci
