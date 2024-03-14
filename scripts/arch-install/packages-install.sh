PACKAGES="
xf86-video-amdgpu
vulkan-radeon 
mesa
pipewire pipewire-alsa 
pipewire-pulse
base-devel 
cmake 
man-db 
man-pages 
less
ntfs-3g 
bat 
exa 
neofetch 
bash-completion
pass 
gnupg 
openssh 
wl-clipboard 
flatpak 
gst-libav
firefox 
libreoffice  
gimp 
mpv 
live-media
zip 
p7zip 
gparted 
powerline-fonts
ttf-ubuntu-font-family 
ttf-font-awesome 
ttf-roboto
nerd-fonts 
ttf-firacode-nerd 
ttf-jetbrains-mono 
ttf-jetbrains-mono-nerd
kitty
lazygit 
python-lsp-server
emacs
stow
go
plasma
"

DISPLAYMANAGER="sddm"

### install packages
pacman -S --noconfirm --needed --overwrite \* $PACKAGES
if [ $? -ne 0 ]; then
  echo "Ocurrio in error instalando los paquetes."
  exit 1
fi

### display manager
systemctl enable $DISPLAYMANAGER

### libvirt config
pacman -S libvirt iptables-nft dnsmasq dmidecode virt-manager qemu-full
usermod -a -G libvirt jotix
systemctl enable libvirtd.service
systemctl start libvirtd.service

### copy arch-config
cd /root/arch-config
git remote remove
cp -rv /root/arch-config /home/jotix/arch-config
chown -R jotix /home/jotix/arch-config

echo "

Execute the commands:
> exit
> swapoff /mnt/mnt/swap/swapfile
> umount -R /mnt
> reboot

Login with jotix user
Copy the jotix keys
> cd /home/jotix/arch-install
> ./jotix-install.sh"
