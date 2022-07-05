#!/bin/sh

#Disk Parameters
Disk_Path="/dev/sda"

#Prepare Disk for Partions and Filesystems
swapoff -a
umount /dev/sda1
umount /dev/sda3
wipefs $Disk_Path -a #Wipe all filesystems 
sfdisk --delete $Disk_Path #Delete existing partitions.
sfdisk $Disk_Path < ./partitions #Create partitions from the specified dump file.

#Format partions
mkfs.ext4 /dev/sda3 -F
mkswap /dev/sda2
mkfs.vfat /dev/sda1

#Mount Filesystems
mount /dev/sda3 /mnt
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
swapon /dev/sda2 #Enable swap volume.

#Installation
#Install Essential Packages
pacstrap /mnt base linux linux-firmware #Minimal

#Configure the System
#Fstab
genfstab -U /mnt >> /mnt/etc/fstab

#Chroot
cp user_installation.sh /mnt/root/user_installation.sh #Copy user specific installation script.
cp post_installation.sh /mnt/root/post_installation.sh #Copy the second part of the setup to the local system so it can continue.
arch-chroot /mnt /root/post_installation.sh
