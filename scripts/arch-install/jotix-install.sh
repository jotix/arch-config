#!/bin/bash

### jotix´s user space install
### run this script after installing the complete system and
### after install the gpg keys for acces the github repos

####### copy jotix credentials #################################################

sudo mkdir -p /mnt/Ventoy
sudo mount LABEL=Ventoy /mnt/Ventoy
cd /mnt/Ventoy/jotix
chmod +x jotix-install.sh
jotix-install.sh
cd $HOME

####### dotfiles ###############################################################

#config() {
#  git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
#}

#cd $HOME
#git clone --bare git@github.com:jotix/dotfiles.git $HOME/.dotfiles

### make copy af existing files
#mkdir -p $HOME/.dotfiles-backup
#config checkout 2>&1 | grep -E "\s+\." | xargs -I '{}' mv -v '{}' $HOME/.dotfiles-backup

#config checkout

#config config --local status.showUntrackedFiles no

####### password-store #########################################################

git clone git@github.com:jotix/.password-store.git ~/.password-store

########## QMK #################################################################

git clone git@github.com:jotix/qmk_firmware.git
cd qmk_firmware
git remote add upstream https://github.com/qmk/qmk_firmware.git
sudo cp util/udev/50-qmk.rules /etc/udev/rules.d/50-qmk.rules
qmk setup
cd $HOME

####### vial udev rules ########################################################

#export USER_GID=`id -g`; sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/92-viia.rules && udevadm control --reload && udevadm trigger'

####### syncthing ##############################################################

#sudo pacman -S syncthing
#systemctl enable syncthing.service --user
#systemctl start syncthing.service --user

####### powerline-go ###########################################################

sudo pacman -S go
go install github.com/justjanne/powerline-go@latest
git clone https://aur.archlinux.org/powerline-go.git

############### Flatpaks #######################################################

flatpak install com.google.Chrome
flatpak install com.spotify.Client
flatpak install com.valvesoftware.Steam
flatpak override --filesystem=/home/jotix/Steam com.valvesoftware.Steam --user
