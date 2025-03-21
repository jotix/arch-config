#!/usr/bin/env bash

set -e

echo
lsblk -o +LABEL
echo
read -p "In which disk will NixOS be instaled: " DISK
DISK="/dev/$DISK"
if [[ ! -b $DISK ]]; then
    echo "The disk $DISK doesn't exist."
    exit
fi

echo
read -p "Wich host install (jtx or ffm): " HOST
if [[ $HOST != "jtx" ]] && [[ $HOST != "ffm" ]]; then
    echo "The host $HOST doesn't exists"
    exit
fi
HOST=$HOST-arch

echo
read -p "The disk $DISK will be complete deleted. Continue? (yes/no): " CONTINUE
if [[ $CONTINUE != "yes" ]]; then
    echo "Aborting installation."
    exit
fi

echo
echo "Installing Arch Linux in $DISK"
echo "Hostname: $HOST"
echo

### disk configuration ########################################################

# create partition table
sudo parted $DISK mklabel gpt

# make EFI & btrfs partitions
sudo parted $DISK mkpart ARCH-BOOT fat32 1MiB 1GiB
sudo parted $DISK mkpart Arch btrfs 1GiB 100%

# set esp flag in EFI partition
sudo parted $DISK set 1 esp on

# make the filesystems
sudo mkfs.vfat -F32 -n ARCH-BOOT /dev/disk/by-partlabel/ARCH-BOOT
sudo mkfs.btrfs -L Arch /dev/disk/by-partlabel/Arch -f

# Subvolumes Layout
# @          /
# @home      /home
# @snapshots /.snapshots
# @log       /var/log
# @cache     /var/cache
# @tmp       /var/tmp

# mount the disk & create the subvolumes
mount LABEL=Arch /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@tmp
umount -R /mnt

# make the directories
mount LABEL=Arch /mnt -osubvol=/@
mkdir -p /mnt/boot
mkdir -p /mnt/home
mkdir -p /mnt/.snapshots
mkdir -p /mnt/var/log
mkdir -p /mnt/var/cache
mkdir -p /mnt/var/tmp
mkdir -p /mnt/mnt/root-partition

# mount ESP part
mount LABEL=ARCH-BOOT /mnt/boot

# mounting btrfs main disk subvolumes
mount LABEL=Arch /mnt/home -osubvol=@home
mount LABEL=Arch /mnt/.snapshots -osubvol=@snapshots
mount LABEL=Arch /mnt/var/log -osubvol=@log
mount LABEL=Arch /mnt/var/cache -osubvol=@cache
mount LABEL=Arch /mnt/var/tmp -osubvol=@tmp
mount LABEL=Arch /mnt/mnt/root-partition -osubvol=/

if [[ -b "/dev/disk/by-label/jtx-ssd" ]]; then
  mkdir -p /mnt/mnt/jtx-ssd
  mount LABEL=jtx-ssd /mnt/mnt/jtx-ssd -osubvol=/
fi

if [[ -b "/dev/disk/by-label/jtx-nvme" ]]; then
  mkdir -p /mnt/mnt/jtx-nvme
  mount LABEL=jtx-nvme /mnt/mnt/jtx-nvme -osubvol=/
fi

### enable parallel downloads
sed -i -e 's/#ParallelDownloads = 5/ParallelDownloads = 10/g' /etc/pacman.conf
sed -i -e 's/ParallelDownloads = 5/ParallelDownloads = 10/g' /etc/pacman.conf

### install base system
pacstrap /mnt base linux linux-firmware

### generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

### network configuration
echo $HOST > /mnt/etc/hostname

### enable parallel downloads in new installation
sed -i -e 's/#ParallelDownloads = 5/ParallelDownloads = 10/g' /mnt/etc/pacman.conf
sed -i -e 's/ParallelDownloads = 5/ParallelDownloads = 10/g' /etc/pacman.conf

### chroot installation #######################################################

### chr function
chr() {
  arch-chroot /mnt $@
}

### locale config
chr ln -sf /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime
chr hwclock --systohc
sed -i -e 's/#en_US.UTF-8/en_US.UTF-8/g' /mnt/etc/locale.gen
sed -i -e 's/#es_AR.UTF-8/es_AR.UTF-8/g' /mnt/etc/locale.gen
chr locale-gen
echo LANG=en_US.UTF-8 > /mnt/etc/locale.conf

### Desktop Environment ########################################################
chr pacman -S --noconfirm --needed gnome gnome-extra
chr systemctl enable gdm

### install packages ##########################################################
PACKAGES="
networkmanager ntp arch-install-scripts
exfatprogs ntfs-3g dosfstools btrfs-progs
efibootmgr amd-ucode
unzip p7zip
base-devel cmake sudo fish
less man-pages man-db
exa bat lsb-release usbutils
ttf-jetbrains-mono ttf-jetbrains-mono-nerd
ttf-ubuntu-font-family ttf-ubuntu-mono-nerd ttf-ubuntu-nerd
git lazygit openssh fastfetch
stow rclone neovim emacs
mesa xf86-video-amdgpu vulkan-radeon
cups ghostscript mpv firefox chromium
"
chr pacman -S --noconfirm --needed $PACKAGES

### config the bootloader
chr bootctl install
echo -e "default  arch.conf
timeout  5
console-mode max
editor   no
" > /mnt/boot/loader/loader.conf

echo -e "title   Arch Linux
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
options root=LABEL=Arch rootflags=subvol=/@ rootfstype=btrfs rw
" > /mnt/boot/loader/entries/arch.conf

echo -e "title   Arch Linux (fallback initramfs)
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux-fallback.img
options root=LABEL=Arch rootflags=subvol=/@ rootfstype=btrfs rw
" > /mnt/boot/loader/entries/arch-fallback.conf

### config sudo
sed -i -e 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g' /mnt/etc/sudoers

### set the password & users
echo -e "\nSET ROOT PASSWORD\n"
chr passwd

echo -e "\nSET JOTIX PASSWORD\n"
chr useradd -m -G wheel -s /usr/bin/fish jotix
chr passwd jotix

if [[ $HOST == "ffm-arch" ]]; then
    chr useradd -m -s /usr/bin/fish filofem
    echo -e "\nSET FILOFEM PASSWORD"
    chr passwd filofem
fi

### enable services
chr systemctl enable fstrim.timer
chr systemctl enable cups.service
chr systemctl enable NetworkManager
chr systemctl enable ntpdate

### unmount & reboot
echo "Installation finished, you can do some final asjustements now or reboot and use the new system:
> umount -R /mnt
> reboot"
