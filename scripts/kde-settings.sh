
#!/usr/bin/env bash

### kdeglobals
kwriteconfig6 --file kdeglobals --group KDE --key LookAndFeelPackage org.kde.breezedark.desktop
kwriteconfig6 --file kdeglobals --group KDE --key SingleClick true

### plasma-localerc
kwriteconfig6 --file plasma-localerc --group Formats --key LANG en_US.UTF-8
kwriteconfig6 --file plasma-localerc --group Formats --key LC_ADDRESS es_AR.UTF-8
kwriteconfig6 --file plasma-localerc --group Formats --key LC_MEASUREMENT es_AR.UTF-8
kwriteconfig6 --file plasma-localerc --group Formats --key LC_MONETARY es_AR.UTF-8
kwriteconfig6 --file plasma-localerc --group Formats --key LC_NAME es_AR.UTF-8
kwriteconfig6 --file plasma-localerc --group Formats --key LC_NUMERIC es_AR.UTF-8
kwriteconfig6 --file plasma-localerc --group Formats --key LC_PAPER es_AR.UTF-8
kwriteconfig6 --file plasma-localerc --group Formats --key LC_TELEPHONE es_AR.UTF-8
kwriteconfig6 --file plasma-localerc --group Formats --key LC_TIME es_AR.UTF-8

### kxkbrc
kwriteconfig6 --file kxkbrc --group Layouts --key LayoutList us
kwriteconfig6 --file kxkbrc --group Layouts --key Use --type bool true
kwriteconfig6 --file kxkbrc --group Layouts --key VariantList altgr-intl

### plasmashellrc
kwriteconfig6 --file plasmashellrc --group PlasmaViews --group "Panel 2" --key floating 1
kwriteconfig6 --file plasmashellrc --group PlasmaViews --group "Panel 2" --key panelLengthMode 1
kwriteconfig6 --file plasmashellrc --group PlasmaViews --group "Panel 2" --key panelVisibility 2
kwriteconfig6 --file plasmashellrc --group PlasmaViews --group "Panel 2" --group Defaults --key thickness 56

### powerdevilrc
kwriteconfig6 --file powerdevilrc --group AC --group SuspendAndShutdown --key AutoSuspendAction 0

### konsolerc
kwriteconfig6 --file konsolerc --key MenuBar Disabled
kwriteconfig6 --file konsolerc --group "Desktop Entry" --key DefaultProfile jotix.profile

