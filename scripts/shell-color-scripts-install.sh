#!/usr/bin/env bash

mkdir -p /home/jotix/workspace
cd /home/jotix/workspace

git clone https://aur.archlinux.org/shell-color-scripts-git.git

cd shell-color-scripts-git
makepkg -s

sudo pacman -U *.zst
cd
