#!/bin/sh

# Setup home folder
mkdir $HOME/dev
mkdir $HOME/Documents
mkdir $HOME/Downloads

# Install text editors
pkg install vim --yes
pkg install nano --yes

# Install dev tools
pkg install cmake --yes
pkg install rust --yes
pkg install python --yes
pkg install editors/vscode --yes

