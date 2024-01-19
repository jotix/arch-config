### joti's arch linux system install
### execute this script after base-install.sh & chroot to the new install


### CHANGE DEFAULTS PASSWORD BEFORE THE INSTALLATION IS COMPLETE
HOSTNAME=jtx-arch
ROOTPASSWD=pass
USERNAME=jotix
USERPASSWD=pass
###

### localtime
ln -sf /usr/share/zoneinfo/America/Buenos_Aires /etc/localtime
hwclock --systohc

### pacman.conf
COL=Color
DOW="ParallelDownloads = 5"
sed -i "s/#$COL/$COL/g" /etc/pacman.conf
sed -i "s/#$DOW/$DOW/g" /etc/pacman.conf

### locale
EN_US=en_US.UTF-8
ES_AR=es_AR.UTF-8
sed -i "s/#$EN_US/$EN_US/g" /etc/locale.gen
sed -i "s/#$ES_AR/$ES_AR/g" /etc/locale.gen
locale-gen

echo 'LANG=en_US.UTF-8
LC_NUMERIC=es_AR.UTF-8
LC_TIME=es_AR.UTF-8
LC_MONETARY=es_AR.UTF-8
LC_PAPER=es_AR.UTF-8
LC_MEASUREMENT=es_AR.UTF-8' > /etc/locale.conf

### hostname
echo $HOSTNAME > /etc/hostname

### install packages
pacman -S grub efibootmgr sudo networkmanager ntp unzip amd-ucode dosfstools ntfs-3g

### bootloader
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch-Grub
grub-mkconfig -o /boot/grub/grub.cfg

### passwords
echo root:$ROOTPASSWD | chpasswd root
SUDOERS="%wheel ALL=(ALL:ALL) ALL"
sed -i "s/# $SUDOERS/$SUDOERS/g" /etc/sudoers
useradd -m -G wheel -s /bin/bash $USERNAME
echo $USERNAME:$USERPASSWD | chpasswd jotix

### starting services
systemctl enable NetworkManager
systemctl enable ntpdate
systemctl enable fstrim.timer

echo ---------------------------------------------
echo REMEMBER: 
echo CHANGE THE DEFAULTS PASSWORD NOW !!!
echo ---------------------------------------------
echo After that run the script packages-install.sh
echo ---------------------------------------------
