#!/usr/bin/env bash

PACKAGES="
exfatprogs
ntfs-3g
dosfstools
btrfs-progs
xorg
xorg-xinit
xorg-xrandr
xf86-video-amdgpu
vulkan-radeon
pipewire
xfce4
xfce4-goodies
unzip
p7zip
emacs
libvterm
libtool
base-devel
cmake
bluez
bluez-utils
exa
bat
fastfetch
git
firefox
ttf-jetbrains-mono
"

sudo pacman -S --needed --noconfirm $PACKAGES
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

