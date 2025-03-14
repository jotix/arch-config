#!/usr/bin/env bash

CONFIG_DIR=$HOME/arch-config
SCRIPTS_DIR=$CONFIG_DIR/scripts

if [[ -b "/dev/disk/by-label/Ventoy" ]]; then
    sudo mkdir -p /mnt/Ventoy
    sudo mount LABEL=Ventoy /mnt/Ventoy
    tar -xf /mnt/Ventoy/jotix/jotix.tar.xz -C $HOME
    tar -xf /mnt/Ventoy/jotix/google-chrome.tar.xz -C $HOME/.config
fi

git clone git@github.com:jotix/arch-config.git $CONFIG_DIR

if [ ! -d $HOME/arch-config ] ; then
    echo INSTALL JOTIX KEY !!
    exit
fi

### link-dotfiles
$CONFIG_DIR/link-dotfiles.sh 

### other install scripts
# printers
$SCRIPTS_DIR/printers-install.sh
# google-chrome AUR
$SCRIPTS_DIR/google-chrome-install.sh
# DT colorscript
$SCRIPTS_DIR/shell-color-scripts-install.sh
# virtualization
$SCRIPTS_DIR/virt-install.sh
# steam
$SCRIPTS_DIR/steam-install.sh
# gnome extension manager
$SCRIPTS_DIR/extension-manager-install.sh
# gnome settings
$SCRIPTS_DIR/gnome-settings.sh
