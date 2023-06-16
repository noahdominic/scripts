#!/bin/sh

SCHEMADIR="$HOME/.local/share/gnome-shell/extensions/forge@jmmaranan.com/schemas"
SCHEMA="org.gnome.shell.extensions.forge.keybindings"
KEYS=$(gsettings --schemadir $SCHEMADIR list-keys $SCHEMA)

for key in $KEYS; do
        gsettings --schemadir $SCHEMADIR set $SCHEMA $key '[]'
done

echo "Erased all keybindings for forge!"
