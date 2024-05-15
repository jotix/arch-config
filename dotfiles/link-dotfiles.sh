#!/usr/bin/env bash

# drwxr-xr-x     - jotix 15 May 09:12   .
# drwxr-xr-x     - jotix 15 May 09:05  ├──  .config
# drwxr-xr-x     - jotix 15 May 09:05  │  ├──  git
# .rw-r--r--    83 jotix 15 May 09:05  │  │  └──  config
# drwxr-xr-x     - jotix 15 May 09:05  │  ├──  helix
# .rw-r--r--   169 jotix 15 May 09:05  │  │  └──  config.toml
# drwxr-xr-x     - jotix 15 May 09:04  │  ├──  hypr
# .rw-r--r--  1.5k jotix 15 May 09:04  │  │  ├──  hypridle.conf
# .rw-r--r--  4.5k jotix 15 May 09:04  │  │  ├──  hyprland.conf
# .rw-r--r--  1.7k jotix 15 May 09:04  │  │  ├──  hyprlock.conf
# .rw-r--r--    91 jotix 15 May 09:04  │  │  └──  hyprpaper.conf
# drwxr-xr-x     - jotix 15 May 09:05  │  ├──  kitty
# .rw-r--r--   330 jotix 15 May 09:05  │  │  └──  kitty.conf
# drwxr-xr-x     - jotix 15 May 09:05  │  ├──  nvim
# .rw-r--r--  4.3k jotix 15 May 09:05  │  │  └──  init.lua
# drwxr-xr-x     - jotix 15 May 09:04  │  └──  waybar
# .rw-r--r--  2.1k jotix 15 May 09:04  │     ├──  config
# .rw-r--r--  3.4k jotix 15 May 09:04  │     └──  style.css
# drwxr-xr-x     - jotix 15 May 09:07  ├──  .emacs.d
# drwxr-xr-x     - jotix 15 May 09:07  │  ├──  eshell
# .rw-r--r--   187 jotix 15 May 09:07  │  │  ├──  alias
# .rw-r--r--    19 jotix 15 May 09:07  │  │  └── 󱆃 profile
# .rw-r--r--   17k jotix 15 May 09:07  │  ├──  emacs-config.org
# .rw-r--r--  1.6k jotix 15 May 09:06  │  ├──  exwm.el
# .rw-r--r--  2.2k jotix 15 May 09:06  │  ├──  exwm.org
# .rw-r--r--   13k jotix 15 May 09:06  │  └──  init.el
# drwxr-xr-x     - jotix 15 May 09:05  ├──  .local
# drwxr-xr-x     - jotix 15 May 09:05  │  └──  share
# .rw-r--r--   801 jotix 15 May 09:05  │     └──  digikam
# .rw-r--r--  1.0k jotix 15 May 09:05  ├── 󱆃 .bashrc
# .rw-r--r--    37 jotix 15 May 09:11  ├──  .stow-local-ignore
# .rw-r--r--   220 jotix 15 May 09:05  ├──  .xinitrc
# .rwxr-xr-x   502 jotix 15 May 09:12  └──  stow-dotfiles.sh

# DOTFILES="
# .config
# "
# for file in ./.*
# do
#     echo $file
#     #whatever you need with "$file"
# done
BACKUP_DIR=$HOME/.dotfiles-backup
mkdir -p $BACKUP_DIR

process-file() {
    FILE=$(echo "$@" | sed 's/^..//')
    ORIGIN=$PWD/$FILE
    DESTINY=$HOME/$FILE
    BACKUP=$BACKUP_DIR/$(echo $FILE | sed -r 's/[/]+/_/g')
    if [ -f $DESTINY ]; then
	mv $DESTINY $BACKUP
    fi
    if [ -f $FILE ]; then # ask for file exists to skip folders
	ln -sf $ORIGIN $DESTINY
    fi
}

find . | while read -r file; do  process-file $file; done

rm $HOME/link-dotfiles.sh 
