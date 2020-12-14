- fdisk, two partitions
  - /dev/sda1 (512M) linux (bootable!!)
  - /dev/sda2 (rest) linux
cryptsetup luksFormat /dev/sda2
cryptsetup open /dev/sda2 <name>
pvcreate /dev/mapper/<name>
vgcreate <GName> /dev/mapper/<name>
lvcreate -L 8G <GName> -n swap
lvcreate -l 100%FREE <GName> -n root
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/<GName>/root
mkswap /dev/<GName>/swap

mount /dev/<GName>/root /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

arch-chroot /mnt

vim /etc/mkinitcpio.conf
  - HOOKS=(base udev autodetect keyboard keymap modconf encrypt lvm2 filesystems keyboard fsck)
mkinitcpio -P

// find /dev/sda2 UUID
lsblk -o +UUID

vim /etc/default/grub
  - GRUB_CMDLINE_LINUX="cryptdevice=UUID=<DEVSDA2UUID>:<name> root=/dev/<GName>/root"
grub-install –boot-directory=/boot –efi-directory=/boot/efi /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

