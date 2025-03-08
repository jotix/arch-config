#!/usr/bin/env bash

if [[ -b "/dev/disk/by-label/Ventoy" ]]; then
    sudo mkdir -p /mnt/Ventoy
    sudo mount LABEL=Ventoy /mnt/Ventoy
    tar -xf /mnt/Ventoy/jotix/jotix.tar.xz -C /home/jotix
    tar -xf /mnt/Ventoy/jotix/google-chrome.tar.xz -C /home/jotix/.config
fi

git clone git@github.com:jotix/arch-config.git $HOME/arch-config

if [ ! -d /home/jotix/arch-config ] ; then
    echo INSTALL JOTIX KEY !!
    exit
fi

### link-dotfiles
/home/jotix/arch-config/link-dotfiles.sh 

### other install scripts
# printers
/home/jotix/arch-config/scripts/printers-install.sh
# google-chrome AUR
/home/jotix/arch-config/scripts/google-chrome-install.sh
# DT colorscript
/home/jotix/arch-config/scripts/shell-color-scripts-install.sh
# virtualization
/home/jotix/arch-config/scripts/virt-install.sh
# steam
/home/jotix/arch-config/scripts/steam-install.sh
# gnome extension manager
/home/jotix/arch-config/scripts/extension-manager-install.sh

