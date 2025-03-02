#!/usr/bin/env bash

### printer drivers
sudo pacman -U --noconfirm ./printer-drivers/*.zst

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

