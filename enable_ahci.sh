#!/bin/bash

# enable_ahci.sh
# by elkay14
#
# Script to enable certain AHCI compatible chipsets on unRAID
#
# SATA III 6Gps capable chips/HBAs:
# 1b4b0640 : Marvell 88SE9128 on HPT RocketRAID 640
# 1b4b9120 : Marvell 88SE9120 on HPT Rocket 620A (possibly others)
# 1b4b9123 : Marvell 88SE9128 found on motherboards and HBAs
# 1b4b9125 : Marvell 88SE9125 found on HPT Rocket 62X
# 1b4b9172 : Marvell 88SE9172 found on motherboards
# 1b4b917a : Marvell 88SE9172 found on motherboards
# 1b4b9192 : Marvell 88SE9172 found on motherboards
# 1b4b91a3 : Marvell 88SE9128 found on motherboards
# 11030620 : HPT Rocket 620
# 11030622 : HPT Rocket 622
# 11030640 : Marvell 88SE9128 on HPT RocketRAID 640
# 1b210612 : ASMedia ASM1061
#
# Version History
# 30 Apr 2012		First version
# 16 Dec 2012		Add 1b4b9120, thanks UhClem
#

PCI_IDS="1b4b0640 1b4b9120 1b4b9123 1b4b9125 1b4b9172 1b4b917a 1b4b9192 1b4b91a3 11030620 11030622 11030640 1b210612"

ENABLED=0
for PCI_ID in $PCI_IDS
do
	# look for it in pci devices table and enable it if not already mapped to ahci driver
	grep $PCI_ID /proc/bus/pci/devices | grep -v ahci > /dev/null
	if [ $? -eq 0 ]
	then
		echo "Enabling AHCI on PCI ID 0x$PCI_ID"
		VENDOR=${PCI_ID:0:4}
		DEVICE=${PCI_ID:4:4}
		echo $VENDOR $DEVICE > /sys/bus/pci/drivers/ahci/new_id
		ENABLED=1
	fi
done

# wait for kernel to detect all devices if enabled
if [ $ENABLED -eq 1 ]
then
	sleep 2
else
	echo "No devices enabled"
fi
