#!/bin/bash

# Prompt user for RAID level
echo "Please enter the desired RAID level (0, 1, 5, or 6):"
read RAID_LEVEL

# Install mdadm package if not already installed
opkg update
opkg install mdadm

# Create RAID array
mdadm --create /dev/md0 --level=$RAID_LEVEL --raid-devices=2 /dev/sda1 /dev/sdb1

# Format RAID array
mkfs.ext4 /dev/md0

# Mount RAID array
mkdir /mnt/raid
mount /dev/md0 /mnt/raid

# Add RAID array to fstab for automatic mounting at boot
echo "/dev/md0 /mnt/raid ext4 defaults 0 0" >> /etc/fstab

# Confirm RAID setup
echo "RAID array successfully created and mounted at /mnt/raid"
