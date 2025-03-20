#!/usr/bin/env bash

flatpak install com.google.Chrome

flatpak override --user --filesystem=~/.local/share/applications:create --filesystem=~/.local/share/icons:create com.google.Chrome

