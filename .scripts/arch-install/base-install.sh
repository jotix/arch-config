### jotix's arch l:inux base install
### requisites: 
### ef00 partition with LABEL=EFI
### btrfs partition with LABEL=btrfs-vol-1 

DOW="ParallelDownloads = 5"
sed -i "s/#$DOW/$DOW/g" /etc/pacman.conf

mount LABEL=btrfs-vol-1 /mnt
DIR=$PWD
cd /mnt
btrfs subvolume create arch
btrfs subvolume create home
btrfs subvolume create swap
btrfs filesystem mkswapfile --size 4g --uuid clear swap/swapfile
cd $DIR
umount /mnt

mount LABEL=btrfs-vol-1 /mnt -osubvol=arch
mkdir -p /mnt/home
mkdir -p /mnt/boot/efi
mount LABEL=btrfs-vol-1 /mnt/home -osubvol=home
mount LABEL=EFI /mnt/boot/efi

### extra filesystems
mkdir -p /mnt/mnt/btrfs-vol-1
mkdir -p /mnt/mnt/btrfs-vol-2
mkdir -p /mnt/mnt/btrfs-vol-3
mkdir -p /mnt/mnt/Ventoy
mkdir -p /mnt/mnt/swap
mount LABEL=btrfs-vol-1 /mnt/mnt/btrfs-vol-1
mount LABEL=btrfs-vol-1 /mnt/mnt/swap -osubvol=swap
swapon /mnt/mnt/swap/swapfile
mount LABEL=btrfs-vol-2 /mnt/mnt/btrfs-vol-2
mount LABEL=btrfs-vol-3 /mnt/mnt/btrfs-vol-3
mount LABEL=Ventoy /mnt/mnt/Ventoy

pacstrap /mnt base linux linux-firmware git neovim

genfstab -U /mnt >> /mnt/etc/fstab

mkdir -p /mnt/root/arch-install
cp -rv ./* /mnt/root/arch-install
echo ''
echo '-----------------------'
echo 'run the commands'
echo '> arch-chroot /mnt'
echo '> cd /root/arch-install'
echo 'nvim system-install'
echo 'EDIT the variable'
echo '> ./system-install.sh'
echo '-----------------------'
