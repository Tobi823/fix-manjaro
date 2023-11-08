#!/bin/bash

# boot live iso containing manjaro-tools-base

su

cryptsetup open /dev/nvme0n1p2 luksroot --type luks
mount -o subvol=@ /dev/mapper/luksroot /mnt
mount /dev/nvme0n1p1 /mnt/boot/efi
manjaro-chroot /mnt /bin/bash

# unsure if grub-btrfs is necessary
pacman -Syu grub grub-btrfs
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=manjaro --recheck
grub-mkconfig -o /boot/grub/grub.cfg

lsblk -o PATH,PTTYPE,PARTTYPE,FSTYPE,PARTTYPENAME
ls /sys/firmware/efi
exit

modprobe efivarfs
manjaro-chroot /mnt /bin/bash

mount -t efivarfs efivarfs /sys/firmware/efi/efivars
ls /sys/firmware/efi

sudo reboot
