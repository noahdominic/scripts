#!/bin/sh

# Install X Windows System
pkg install -y xorg

# Install XFCE
pkg install -y xfce

# Install login client
pkg install -y slim slim-themes

# Enable dbus, hald, slim, sound
sysrc dbus_enable="YES"
sysrc hald_enable="YES"
sysrc slim_enable="YES"
sysrc sound_load="YES"
sysrc snd_hda_load="YES"

echo "exec startxfce4" >> $HOME/.xinitrc
