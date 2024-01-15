#!/bin/bash

### jotix´s user space install
### run this script after installing the complete system and
### after install the gpg keys for acces the github repos


####### dotfiles #############################################################

config() {
  git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

cd $HOME
git clone --bare git@github.com:jotix/dotfiles.git $HOME/.dotfiles

### make copy af existing files
mkdir -p $HOME/.dotfiles-backup
config checkout 2>&1 | grep -E "\s+\." | xargs -I '{}' mv -v '{}' $HOME/.dotfiles-backup

config checkout

config config --local status.showUntrackedFiles no

####### password-store #########################################################

git clone git@github.com:jotix/password-store.git ~/.password-store

####### vial udev rules ########################################################

#export USER_GID=`id -g`; sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/92-viia.rules && udevadm control --reload && udevadm trigger'

####### syncthing ##############################################################

#sudo pacman -S syncthing
#systemctl enable syncthing.service --user
#systemctl start syncthing.service --user

############### AUR packages ###################################################

mkdir -p ~/Downloads/AUR
cd ~/Downloads/AUR

### DT's aur colorscripts
git clone https://aur.archlinux.org/shell-color-scripts.git
cd shell-color-scripts
makepkg -s
sudo pacman -U *x86_64.pkg.tar.zst

### powerline-go
cd ~/Downloads/AUR
git clone https://aur.archlinux.org/powerline-go.git
cd powerline-go
makepkg -s
sudo pacman -U *x86_64.pkg.tar.zst

### bach to home
cd ~

