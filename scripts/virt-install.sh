#!/usr/bin/env bash

### install & config libvirt
sudo pacman -S --noconfirm --ask=4 libvirt iptables-nft dnsmasq dmidecode virt-manager qemu-full
sudo usermod -a -G libvirt jotix

sudo systemctl enable libvirtd.service --now

