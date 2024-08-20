#!/usr/bin/env bash

PACKAGES="
exfatprogs
ntfs-3g
dosfstools
btrfs-progs
xf86-video-amdgpu
vulkan-radeon
unzip
emacs
libvterm
libtool
base-devel
gparted
cmake
bluez
bluez-utils
exa
bat
fastfetch
ttf-jetbrains-mono
nerd-fonts
pipewire
pipewire-alsa
pipewire-pulse
pavucontrol
ghostscript
git
lazygit
neovim
kitty
firefox
gimp
inkscape
libreoffice
plasma
kde-applications
"

sudo pacman -S --needed --noconfirm $PACKAGES
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

