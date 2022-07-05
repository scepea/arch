#!/bin/sh
#Pre-installation
loadkeys uk #Set console keyboard layout to UK.
ls /sys/firmware/efi/efivars || (echo "System not booted in UEFI mode." && exit 1) #Verify system is booted in UEFI mode with this folder's existence else exit.

(source ./wifi_connect.sh)

timedatectl set-ntp true #Update the system clock
