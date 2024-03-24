########## QMK #################################################################

sudo pacman -S qmk

cd $HOME
git clone https://github.com/qmk/qmk_firmware.git
cd qmk_firmware

sudo cp util/udev/50-qmk.rules /etc/udev/rules.d/50-qmk.rules

qmk setup

cd $HOME

