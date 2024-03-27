#!/bin/sh

### jotix´s user space install
### run this script after installing the complete system and
### after install the gpg keys for acces the github repos

####### changing repo to arch-config ###########################################

7z x -y jotix.7z -o$HOME/
cd $HOME/arch-config
git remote remove origin
git remote add origin git@github.com:jotix/arch-config.git

####### powerline-go ###########################################################

sudo pacman -S go
go install github.com/justjanne/powerline-go@latest

############### Flatpaks #######################################################

flatpak install com.google.Chrome
flatpak install com.spotify.Client
flatpak install com.valvesoftware.Steam
flatpak override --filesystem=/mnt/jtx-ssd com.valvesoftware.Steam --user
flatpak override --filesystem=/mnt/jtx-nvme com.valvesoftware.Steam --user

######## KDE applications ######################################################

sudo pacman -S kde-applications
