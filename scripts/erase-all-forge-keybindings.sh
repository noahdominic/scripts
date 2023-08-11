#!/bin/sh

# This is for the Forge extension (forge@jmmaranan.com).
# I have not tested this for any other operating system
# other than Fedora 38 Workstation.
#
# Please use at your discretion.

SCHEMADIR="$HOME/.local/share/gnome-shell/extensions/forge@jmmaranan.com/schemas"
SCHEMA="org.gnome.shell.extensions.forge.keybindings"
KEYS=$(gsettings --schemadir $SCHEMADIR list-keys $SCHEMA)

for key in $KEYS; do
        gsettings --schemadir $SCHEMADIR set $SCHEMA $key '[]'
done

echo "Erased all keybindings for forge!"
