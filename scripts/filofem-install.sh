#!/usr/bin/env bash

if [[ $USERNAME != "filofem" ]];then
    echo "This is a filofem user config script, do not run it in other user!"
    exit
fi

if [[ ! -d "/mnt/Ventoy/filofem" ]]; then
    echo "Mount the disk Ventoy in /mnt/Ventoy"
    exit
fi

### chrome config
tar -xf /mnt/Ventoy/filofem/google-chrome.tar.xz -C $HOME/.config
flatpak override --user --filesystem=~/.local/share/applications:create --filesystem=~/.local/share/icons:create com.google.Chrome

### gnome settings
dconf write /org/gtk/gtk4/settings/file-chooser/sort-directories-first true
dconf write /org/gnome/nautilus/icon-view/default-zoom-level "'small'"
dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-type "'nothing'"
dconf write /org/gnome/desktop/session/idle-delay 'uint32 480'
dconf write /org/gnome/desktop/screensaver/lock-enabled false
dconf write /org/gnome/desktop/notifications/show-banners false
dconf write /org/gnome/desktop/wm/preferences/button-layout "'appmenu:minimize,maximize,close'"
dconf write /org/gnome/Console/last-window-size '(1200, 900)'
dconf write /org/gnome/shell/favorite-apps "[
  'com.google.Chrome.flextop.chrome-knipfmibhjlpioflafbpemngnoncknab-Default.desktop',
  'com.google.Chrome.desktop',
  'org.gnome.Calculator.desktop'
]"

dconf write /org/gnome/shell/enabled-extensions "[
  'dash-to-dock@micxgx.gmail.com',
  'apps-menu@gnome-shell-extensions.gcampax.github.com',
  'tiling-assistant@leleat-on-github'
]"

dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'us+altgr-intl')]"

