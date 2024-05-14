#!/usr/bin/env bash

PACKAGES="
exfatprogs
ntfs-3g
dosfstools
btrfs-progs
os-prober
xorg
xorg-xinit
xorg-xrandr
xf86-video-amdgpu
vulkan-radeon
xfce4
xfce4-goodies
pop-gtk-theme
pop-icon-theme
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
ghostscript
"

sudo pacman -S --needed --noconfirm $PACKAGES
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

