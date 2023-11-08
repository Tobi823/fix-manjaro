#!/bin/bash

# boot live iso containing manjaro-tools-base

su
mount -o subvol=@ /dev/nvme0n1p2 /mnt
mount /dev/nvme0n1p1 /mnt/boot/efi
manjaro-chroot /mnt /bin/bash

# new shell will open

pacman -Syu grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=manjaro --recheck
grub-mkconfig -o /boot/grub/grub.cfg




# optional:

lsblk -o PATH,PTTYPE,PARTTYPE,FSTYPE,PARTTYPENAME
ls /sys/firmware/efi
exit
modprobe efivarfs
manjaro-chroot /mnt /bin/bash

# new shell will open

mount -t efivarfs efivarfs /sys/firmware/efi/efivars
ls /sys/firmware/efi

# reboot

sudo reboot