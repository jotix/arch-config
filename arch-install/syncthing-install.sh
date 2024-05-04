#!/usr/bin/env bash

### syncthing
sudo pacman -S --noconfirm --needed syncthing
systemctl enable syncthing.service --user
systemctl start syncthing.service --user


