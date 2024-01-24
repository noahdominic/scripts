#!/bin/sh

install_zsh(){
    echo "Installing zsh>>> Installing ZSH automatically..."

    # Check if ZSH is already installed
    if command -v zsh >/dev/null 2>&1; then
        echo "Installing zsh>>> ZSH is already installed on your system."
        return
    fi

    # Check the operating system
    os=$(uname -s)

    case "$os" in
        Linux*)
            # Check if the system is Ubuntu/Debian/Linux Mint/Pop_OS!
            if command -v apt-get >/dev/null 2>&1; then
                echo "Installing zsh>>> Detected DEB-based system. Installing ZSH with APT..."
                sudo apt-get update
                sudo apt-get install -y zsh
                return
            fi

            # Check if the system is Fedora/RHEL/CentOS Stream/Rocky Linux/Alma Linux
            if command -v dnf >/dev/null 2>&1; then
                echo "Installing zsh>>> Detected RPM-based system. Installing ZSH with DNF..."
                sudo dnf install -y zsh
                return
            fi

            # Check if sys is Alpine-based
            if command -v apk >/dev/null 2>&1; then
                echo "Installing zsh>>> Detected Alpine Linux. Installing ZSH wtih APK..."
                doas apk add zsh
                return
            fi

            # Add more Linux distributions here if needed

            ;;
        Darwin*)
            # Check if Homebrew is installed
            if command -v brew >/dev/null 2>&1; then
                echo "Installing zsh>>> Detected macOS. Installing ZSH using Homebrew..."
                brew install zsh
                return
            fi
            ;;
        FreeBSD*)
            echo "Installing zsh>>> Detected FreeBSD. Installing ZSH..."
            sudo pkg install -y zsh
            return
            ;;
        OpenBSD*)
            echo "Installing zsh>>> Detected OpenBSD. Installing ZSH..."
            doas pkg_add zsh
            return
            ;;
    esac

    # If none of the supported operating systems matched or installation encountered complications
    echo "Installing zsh>>> Uh-oh.  We encountered an error when trying to install ZSH.  Please repair or install ZSH manually."
    exit 1
}

download_zsh_extensions(){
    if ! command -v git >/dev/null 2>&1; then
        echo "You don't seem to have 'git' installed. Please install it as it is required for downloading extensions."
        exit 1
    fi

    echo ""
    echo ""
    echo "Downloading extensions>>> Now downloading extensions..."

    extension_dir="$HOME/.zsh"
    mkdir -p "$extension_dir"
    cd "$extension_dir" || exit

    set -- "https://github.com/zsh-users/zsh-autosuggestions.git" "https://github.com/zsh-users/zsh-syntax-highlighting.git"
    total=2

    for url in "$@"; do
        extension=$(basename "$url" ".git")

        echo ""
        echo "Downloading extensions>>> Downloading $extension..."

        if [ ! -d "$extension_dir/$extension" ]; then
            git clone "$url"
            echo "Downloading extensions>>> Downloaded!"
        else
            echo "Downloading extensions>>> $extension already installed."
        fi
    done
    cd -
}

symlink_zshrc() {
    BASEDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

    echo ""
    echo ""
    echo "Symlinking configs>>> Symlinking ${BASEDIR}/.zshrc to ~/.zshrc ..."

    if [ -f "$HOME/.zshrc" ]; then
        echo "Symlinking configs>>> There is an existing '.zshrc' file in $HOME."

        # Provide options to the user
        echo "Symlinking configs>>> Please choose an action:"
        echo "Symlinking configs>>> 1. Overwrite the existing '.zshrc' file"
        echo "Symlinking configs>>> 2. Rename the existing '.zshrc' file to '.zshrc_previous'"
        echo "Symlinking configs>>> 3. Cancel the symlinking"
        printf "Enter the option number: "
        read -r choice

        case $choice in
            1)
                ln -sf "${BASEDIR}/.zshrc" "$HOME/.zshrc"
                echo "Symlinking configs: Overwrote the existing '.zshrc' file."
                ;;
            2)
                # Check if .zshrc_previous exists
                if [ -f "$HOME/.zshrc_previous" ]; then
                    # Find the next available number for the parentheses
                    count=1
                    while [ -f "$HOME/.zshrc_previous ($count)" ]; do
                        count=$((count + 1))
                    done
                    # Rename the existing .zshrc_previous with the next available number
                    mv "$HOME/.zshrc_previous" "$HOME/.zshrc_previous ($count)"
                    echo "Symlinking configs>>> Renamed the existing '.zshrc_previous' to '.zshrc_previous ($count)'"
                fi
                mv "$HOME/.zshrc" "$HOME/.zshrc_previous"
                ln -s "${BASEDIR}/.zshrc" "$HOME/.zshrc"
                echo "Symlinking configs>>> Renamed the existing '.zshrc' to '.zshrc_previous' and created a new symlink."
                ;;
            *)
                echo "Symlinking configs>>> Cancelled the symlinking."
                exit 0
                ;;
        esac
    else
        ln -s "${BASEDIR}/.zshrc" "$HOME/.zshrc"
        echo "Symlinking configs>>> Symlink done!"
    fi

}

install_zsh
download_zsh_extensions
symlink_zshrc
echo ""
echo ""
echo "ZSH is now configured!"
