# prepare the USB drive

Copy de ISO file to a disk with Ventoy in it or use the following command to burn the image in a USB stick:
    
    dd bs=4M if=path/to/archlinux-version-x86_64.iso of=/dev/disk/by-id/usb-My_flash_drive conv=fsync oflag=direct status=progress

# configure the keyboard

    localectl list-keymaps

    loadkeys es
    setfont ter-132b

    timedatectl

# prepare de partitions

    cgdisk /dev/nvme0n1

    # make a linux (8300) & an EFI (ef00) partitions
    mkfs.btrfs /dev/nvme0n1p1 -L jtx-system
    mkfs.vfat -F32 /dev/nvme0n1p1 -n JTX-EFI
    mount LABEL=jtx-system /mnt
    btrfs subvolume create /mnt/arch
    btrfs subvolume create /mnt/arch/root
    btrfs subvolume create /mnt/arch/home
    umount -R /mnt

# mount the partitions in the right place

    mount LABEL=jtx-system /mnt -osubvol=/arch/root
    mkdir -p /mnt/home
    mkdir -p /mnt/boot/efi
    mount LABEL=jtx-system /mnt -osubvol=/arch/root
    mount LABEL=JTX-EFI /mnt/boot/efi

# enable pararell downloads

    nvim /etc/pacman.conf
    # enable parallel downloads
    # umcomment the line

# install the base system

    pacstrap /mnt base linux linux-firmware

# generate the fstab file

    genfstab -U /mnt >> /mnt/etc/fstab

# chroot in the new system

    arch-chroot /mnt

# install neovim

    sudo pacman -S neovim

# enable pararell downloads in new installation

    nvim /etc/pacman.conf
    # enable parallel downloads
    # umcomment the line

# locale config

    ln -sf /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime
    hwclock –systohc

    nvim /etc/locale.gen
    # uncoment en_US.UTF-8
    # uncoment es_AR.UTF-8

    locale-gen

    nvim /etc/locale.conf
    # LANG=en_US.UTF-8

# network configuration

    pacman -S networkmanager ntp
    systemctl enable NetworkManager
    nvim /etc/hostname
    # jtx-arh

# install the bootloader

    pacman -S grub efibootmgr amd-ucode 

    grub-install –target=x86_64-efi –efi-directory=/boot/efi –bootloader-id=Arch-Grub
    grub-mkconfig -o /boot/grub/grub/cfg

# install & config sudo

    pacman -S sudo
    nvim /etc/sudoers
    # uncoment
    # %wheel ALL=(ALL:ALL) ALL

# set the password & user

    passwd

    useradd -m -G whell -s /bin/bash jotix
    passwd jotix

# unmout & reboot the system

    pacman -S git p7zip openssh

    systemctl enable fstrim.timer
    exit

    umount -R /mnt
    reboot

# configuring the new system

    # jotix-install.sh
    cd ~
    git clone git@gitlab.com:jujodeve/arch-config.git
    cd arch-config
    ./link-dotfiles.sh
    cd arch-install
    ./packages-install.sh
    reboot

# final config

install the necesary scripts from arch-config/arch-install

