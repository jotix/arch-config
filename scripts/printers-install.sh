#!/usr/bin/env bash

### install printer drivers & add printers to cups

sudo pacman -U --noconfirm /home/jotix/arch-config/scripts/printer-drivers/*.zst

sudo lpadmin -p XP-58 -E -v 'usb://Printer-58/USB%20Printing%20Support?serial=?' -m xprinterpos/POS-58.ppd

if [[ $HOSTNAME == "ffm-arch" ]]; then
    sudo lpadmin -p Brother-HL1212W -E -v  "ipp://192.168.0.7/ipp/port1" -m brother-HL1200-cups-en.ppd 
fi

