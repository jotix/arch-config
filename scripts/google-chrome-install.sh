#!/usr/bin/env bash

mkdir -p /home/jotix/workspace
cd /home/jotix/workspace

git clone https://aur.archlinux.org/google-chrome.git

cd google-chrome
makepkg -s

sudo pacman -U *.zst
cd
