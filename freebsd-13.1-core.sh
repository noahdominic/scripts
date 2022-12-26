#!/bin/sh

# Setup home folder
mkdir $HOME/dev
mkdir $HOME/Documents
mkdir $HOME/Downloads

# Setup ZSH
pkg install zsh
chsh -s $(which zsh)

# Install text editors
pkg install -y vim
pkg install -y nano

# Install dev tools
pkg install -y cmake
pkg install -y rust
pkg install -y python
pkg install -y editors/vscode

