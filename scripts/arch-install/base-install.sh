### jotix's arch linux base install
### requisites: 
### ef00 partition with LABEL=JTX-EFI
### btrfs partition with LABEL=jtx-system

DOW="ParallelDownloads = 5"
sed -i "s/#$DOW/$DOW/g" /etc/pacman.conf

### creating btrfs subvolumes
mount LABEL=jtx-system /mnt
DIR=$PWD
cd /mnt
btrfs subvolume create arch
btrfs subvolume create arch/root
btrfs subvolume create arch/home
btrfs subvolume create arch/swap
btrfs filesystem mkswapfile --size 4g --uuid clear arch/swap/swapfile
cd $DIR
umount /mnt

### mounting root
mount LABEL=jtx-system /mnt -osubvol=arch/root

### mounting home
mkdir -p /mnt/home
mount LABEL=jtx-system /mnt/home -osubvol=arch/home

### mountin esp partition
mkdir -p /mnt/boot/efi
mount LABEL=JTX-EFI /mnt/boot/efi

### mounting swap
mkdir -p /mnt/mnt/swap
mount LABEL=jtx-system /mnt/mnt/swap -osubvol=arch/swap
swapon /mnt/mnt/swap/swapfile

### mounting extra FS
mkdir -p /mnt/mnt/jtx-nvme
mkdir -p /mnt/mnt/jtx-ssd
mount LABEL=jtx-nvme /mnt/mnt/jtx-nvme
mount LABEL=jtx-ssd  /mnt/mnt/jtx-ssd

### install base system
pacstrap /mnt base linux linux-firmware git neovim btrfs-progs

### generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

### copy arch-install scripts to the new installation
cp -rv /root/arch-config /mnt/root/arch-config
echo ''
echo '-----------------------'
echo 'run the commands'
echo '> arch-chroot /mnt'
echo '> cd /root/arch-config/scipts/rch-install'
echo 'nvim system-install'
echo 'EDIT the variables'
echo '> ./system-install.sh'
echo '-----------------------'
