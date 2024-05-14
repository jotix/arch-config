#!/usr/bin/env bash

sudo pacman -S --needed --noconfirm cups ghostscript
sudo systemctl start cups.service
sudo systemctl enable cups.service

sudo pacman -U --noconfirm ./printer-drivers/brother-hl1200-3.0.1-1-x86_64.pkg.tar.zst ./printer-drivers/zijiang-pos58-driver-1.0-2-x86_64.pkg.tar.zst
