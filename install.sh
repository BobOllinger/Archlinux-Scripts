#! /bin/bash

# Connect to the internet

# Partition the disk
# Layout:
# sda2 EFI  /mnt/boot/EFI
# sda5 boot /mnt/boot
# sda6 root /mnt

modprobe dm-crypt

cryptsetup luksFormat /dev/sda6
cryptsetup open /dev/sda6 cryptroot

# Assumes existing Windows boot partition, so no mkfs.
mkfs.ext4 /dev/sda5
mkfs.ext4 /dev/mapper/cryptroot

mount /dev/mapper/cryptroot /mnt
mount --mkdir /dev/sda5 /mnt/boot
mount --mkdir /dev/sda2 /mnt/boot/EFI

pacstrap -K /mnt base base-devel linux linux-firmware linux-headers nano git intel-ucode

genfstab -U /mnt >> /mnt/etc/fstab
