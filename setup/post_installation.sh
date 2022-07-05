#!/bin/sh
#This script should be called chrooted into the local system.
#Time Zone
ln -sf /usr/share/zoneinfo/GB /etc/localtime
hwclock --systohc

#Localization
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo 'LANG=en_GB.UTF-8' > /etc/locale.conf
echo 'KEYMAP=uk' > /etc/vconsole.conf

pacman -Syy #Force package sync before proceeding.
pacman -S --noconfirm archlinux-keyring # This may not be needed with an up-to-date iso.

#Network Configuration
pacman -S --noconfirm dhcpcd
systemctl enable dhcpcd

pacman -S --noconfirm networkmanager
systemctl enable NetworkManager

echo "Provide a computer name:"
read computer_name
echo "$computer_name" > /etc/hostname
echo -e "127.0.0.1\tlocalhost" >> /etc/hosts
echo -e "::1\t\tlocalhost" >> /etc/hosts
echo -e "127.0.0.1\t$computer_name" >> /etc/hosts

#User Configuration
pacman -S --noconfirm sudo
echo "Provide a root password:"
read root_password
echo -e "$root_password\n$root_password" | passwd #Set root password
echo "Provide a main username:"
read main_username
useradd -m -G wheel $main_username
echo "Provide a password for main user:"
read main_password
echo -e "$main_password\n$main_password" | passwd $main_username
sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g' /etc/sudoers

#Bootloader
pacman -S --noconfirm intel-ucode grub efibootmgr
grub-install --target=x86_64-efi --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg

#Tidy Up
mv /root/user_installation.sh /home/$main_username
rm /root/post_installation.sh
