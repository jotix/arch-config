########## QMK #################################################################

sudo pacman -S qmk

cd $HOME
git clone git@github.com:jotix/qmk_firmware.git
cd qmk_firmware
git remote add upstream https://github.com/qmk/qmk_firmware.git
sudo cp util/udev/50-qmk.rules /etc/udev/rules.d/50-qmk.rules
qmk setup
cd $HOME

