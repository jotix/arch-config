#!/usr/bin/env bash

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
