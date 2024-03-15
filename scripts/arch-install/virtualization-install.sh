
### libvirt config
sudo pacman -S libvirt iptables-nft dnsmasq dmidecode virt-manager qemu-full
sudo usermod -a -G libvirt jotix
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

