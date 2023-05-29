#!/bin/zsh

echo "Symlinking ./.zshrc to ~/.zshrc"

if [ ! -f $HOME/.zshrc ]; then
        ln -s $(pwd)/.zshrc $HOME/.zshrc
        echo "Symlink done!"
else
        echo "There is an existing \`.zshrc\` file in $HOME.  If you want to use this config file, please remove it.  Script will exit after this line."
        exit 1
fi

echo ""

echo "Now downloading extensions..."
TOTAL=2

if (( $+commands[git] ))
then
        mkdir -p ~/.zsh
        cd ~/.zsh
        
        echo "[1/$TOTAL] Downloading zsh-autosuggestions..."
        if [ ! -f $(pwd)/zsh-autosuggestions/zsh-autosuggestions.zsh ];
        then
                git clone https://github.com/zsh-users/zsh-autosuggestions.git
                echo "[1/$TOTAL] Downloded!"
        else 
                echo "[1/$TOTAL] zsh-autosuggestions already installed."
        fi

        echo "[2/$TOTAL] Downloading zsh-syntax-highlighting..."
        if [ ! -f $(pwd)/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]
        then
                git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
                echo "[2/$TOTAL] Downloded!"
        else 
                echo "[2/$TOTAL] zsh-syntax-highlighting already installed."
        fi        
else 
        echo "This desktop doesn't seem have \`git\`.  Please install it."
fi

echo ""
echo "ZSH is now configured!"
