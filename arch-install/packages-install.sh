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
xfce4
xfce4-goodies
unzip
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
firefox
ttf-jetbrains-mono
nerd-fonts
pipewire
pipewire-alsa
pipewire-pulse
pavucontrol
picom
"

sudo pacman -S --needed --noconfirm $PACKAGES
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

