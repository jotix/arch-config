#!/usr/bin/env bash

if [[ -b "/dev/disk/by-label/Ventoy" ]]; then
    sudo mkdir -p /mnt/Ventoy
    sudo mount LABEL=Ventoy /mnt/Ventoy
    /mnt/Ventoy/jotix/jotix-install.sh
    cp -r /mnt/Ventoy/google-chrome /home/jotix/.config/
fi

git clone git@github.com:jotix/arch-config.git $HOME/arch-config

if [ ! -d /home/jotix/arch-config ] ; then
    echo INSTALL JOTIX KEY !!
    exit
fi

### printer drivers
sudo pacman -U --noconfirm /home/jotix/arch-config/scripts/printer-drivers/*.zst

### powerline-go
go install github.com/justjanne/powerline-go@latest

### gnome extension manager
flatpak install flathub com.mattjakeman.ExtensionManager

### steam
flatpak install com.valvesoftware.Steam
flatpak override --filesystem=/mnt/jtx-ssd com.valvesoftware.Steam --user

### minion
# flatpak install gg.minion.Minion
# flatpak override --filesystem=/mnt/jtx-ssd gg.minion.Minion --user
# flatpak override --filesystem=/home/jotix gg.minion.Minion --user

if [[ -b "/dev/disk/by-label/jtx-nvme" ]]; then
    flatpak override --filesystem=/mnt/jtx-nvme com.valvesoftware.Steam --user
    # flatpak override --filesystem=/mnt/jtx-nvme gg.minion.Minion --user
fi

cd ~/arch-config/dotfiles
./unstow.sh
stow .
cd

/home/jotix/arch-config/scripts/dconf-settings.sh

/home/jotix/arch-config/scripts/google-chrome-install.sh
