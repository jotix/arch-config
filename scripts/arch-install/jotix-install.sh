#!/bin/bash

### jotix´s user space install
### run this script after installing the complete system and
### after install the gpg keys for acces the github repos

####### changing repo to arch-config ###########################################

cd $HOME/arch-config
git remote remove origin
git remote add origin git@github.com:jotix/arch-config.git

########## QMK #################################################################

cd $HOME
git clone git@github.com:jotix/qmk_firmware.git
cd qmk_firmware
git remote add upstream https://github.com/qmk/qmk_firmware.git
sudo cp util/udev/50-qmk.rules /etc/udev/rules.d/50-qmk.rules
qmk setup
cd $HOME

####### powerline-go ###########################################################

sudo pacman -S go
go install github.com/justjanne/powerline-go@latest

############### Flatpaks #######################################################

flatpak install com.spotify.Client
flatpak install com.valvesoftware.Steam
flatpak override --filesystem=/mnt/jtx-ssd com.valvesoftware.Steam --user
flatpak override --filesystem=/mnt/jtx-nvme com.valvesoftware.Steam --user

######## KDE applications ######################################################

#sudo pacman -S kde-applications

