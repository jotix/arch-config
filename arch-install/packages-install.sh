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
vulkan
vulkan-radeon
pipewire
xfce4
xfce4-goodies
unzip
p7zip
emacs
"

sudo pacman -S --needed --noconfirm $PACKAGES
