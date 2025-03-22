#!/usr/bin/env bash

CONFIG_PATH=$HOME/arch-config
SCRIPTS_PATH=$CONFIG_PATH/scripts

if [[ -b "/dev/disk/by-label/Ventoy" ]]; then
    sudo mkdir -p /mnt/Ventoy
    sudo mount LABEL=Ventoy /mnt/Ventoy
    tar -xf /mnt/Ventoy/jotix/jotix.tar.xz -C $HOME
    tar -xf /mnt/Ventoy/jotix/mozilla.tar.xz -C $HOME
else
    echo "Mount the disk Ventoy in /mnt/Ventoy"
    exit
fi

git clone git@github.com:jotix/arch-config.git $CONFIG_PATH

### link-dotfiles
$CONFIG_PATH/link-dotfiles.sh

# gnome extension manager
$SCRIPTS_PATH/extension-manager-install.sh

# gnome-settings
$SCRIPTS_PATH/gnome-settings.sh

# printers
$SCRIPTS_PATH/printers-install.sh

# virtualization
$SCRIPTS_PATH/virt-install.sh

# steam
$SCRIPTS_PATH/steam-install.sh

# udev rules
$SCRIPTS_PATH/udev-rules-install.sh

