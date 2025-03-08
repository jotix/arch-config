#!/usr/bin/env bash

DOTFILES_DIR=/home/jotix/arch-config/dotfiles

HOME_DIR=/home/jotix

process-file() {

    FILE=$1
    DIR=$2
    FILE_RELATIVE=$(echo $FILE | sed "s,$2,,g")
    DESTINY=$HOME_DIR$FILE_RELATIVE

    CMD=""

    [[ -d $FILE ]] && [[ ! -d $DESTINY ]] && mkdir -p $DESTINY

    [[ -f $DESTINY ]] && mv $DESTINY $DESTINY.backup

    [[ -f $FILE ]] && echo procesing $DESTINY && ln -sf $FILE $DESTINY
    
}

find $DOTFILES_DIR | while read -r file; do  process-file $file $DOTFILES_DIR; done

