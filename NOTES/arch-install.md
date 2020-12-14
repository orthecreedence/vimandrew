<see luks-lvm>

pacstrap /mnt base linux linux-firmware cryptsetup lvm2 iproute2 dhcpcd
arch-chroot /mnt

# first boot

## networking 

ip-link		# shows devices, aka enp0s3
systemctl enable dhcpcd@enp0s3.service
systemctl start dhcpcd@enp0s3.service

## swap

lsblk -o +UUID      # list blocks with uuid, find swap
vim /etc/fstab

    UUID=<swap-uuid>    none    swap    defaults    0 0

## locales

vim /etc/locale.gen
  - uncomment "en_US.UTF-8 UTF-8
sudo locale-gen

## xorg

pacman -S xorg lightdm lightdm-gtk-greeter

## pacman

- Apt autoremove
  - `pacman -Rcs $(pacman -Qdtq)`

