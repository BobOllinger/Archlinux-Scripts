#! /bin/bash

# Set localtime to Europe/Berlin
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

# Delete the hashtag from locale.gen for German and English
sed -i '133s/.//' /etc/locale.gen
sed -i '177s/.//' /etc/locale.gen

locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=de-latin1" > /etc/vconsole.conf
echo "arch" > /etc/hostname

echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

pacman -S grub efibootmgr os-prober ntfs-3g networkmanager gvfs reflector nftables pacman-contrib firefox vlc obs-studio 

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable reflector.timer
systemctl enable nftables.service
systemctl enable paccache.timer

useradd -m -G wheel bob

echo "Done!"
echo "- Change passwords"
echo "- Edit sudoers"
