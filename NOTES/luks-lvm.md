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
  - GRUB_CMDLINE_LINUX_DEFAULT="... button.lid_init_state=open" # Razer blade suspend loop fix

grub-install –boot-directory=/boot –efi-directory=/boot/efi /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg


## resize luks

> https://unix.stackexchange.com/a/322631



1. cryptsetup luksOpen /dev/sda2 crypt-volume to open the encrypted volume.
1. parted /dev/sda to extend the partition. resizepart NUMBER END.
1. vgchange -a n fedora_chocbar. Stop using the VG so you can do the next step.
1. cryptsetup luksClose crypt-volume. Close the encrypted volume for the next steps.
1. cryptsetup luksOpen /dev/sda2 crypt-volume. Open it again.
1. cryptsetup resize crypt-volume. Will automatically resize the LUKS volume to the available space.
1. vgchange -a y fedora_chocbar. Activate the VG.
1. pvresize /dev/mapper/crypt-volume. Resize the PV.
1. lvresize -l+100%FREE /dev/fedora_chocbar/home. Resize the LV for /home to 100% of the free space.
1. e2fsck -f /dev/mapper/fedora_chocbar-home. Throw some fsck magic at the resized fs.
1. resize2fs /dev/mapper/fedora_chocbar-home. Resize the filesystem in /home (automatically uses 100% free space)

