#!/usr/bin/env bash

flatpak install com.google.Chrome

flatpak override --user --filesystem=~/.local/share/applications --filesystem=~/.local/share/icons com.google.Chrome
