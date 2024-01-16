#!/bin/sh

install_git(){
    echo "Installing Git>>> Installing Git automatically..."

    # Check if Git is already installed
    if command -v git >/dev/null 2>&1; then
        echo "Installing Git>>> Git is already installed on your system."
        return
    fi

    # Check the operating system
    os=$(uname -s)

    case "$os" in
        Linux*)
            # Check if the system is Ubuntu/Debian/Linux Mint/Pop_OS!
            if command -v apt-get >/dev/null 2>&1; then
                echo "Installing Git>>> Detected DEB-based system. Installing Git with APT..."
                sudo apt-get update
                sudo apt-get install -y git
                return
            fi

            # Check if the system is Fedora/RHEL/CentOS Stream/Rocky Linux/Alma Linux
            if command -v dnf >/dev/null 2>&1; then
                echo "Installing Git>>> Detected RPM-based system. Installing Git with DNF..."
                sudo dnf install -y git
                return
            fi

            # Check if sys is Alpine-based
            if command -v apk >/dev/null 2>&1; then
                echo "Installing Git>>> Detected Alpine Linux. Installing Git wtih APK..."
                doas apk add git
                return
            fi

            # Add more Linux distributions here if needed

            ;;
        Darwin*)
            # Check if Homebrew is installed
            if command -v brew >/dev/null 2>&1; then
                echo "Installing Git>>> Detected macOS. Installing Git using Homebrew..."
                brew install git
                return
            fi
            ;;
        FreeBSD*)
            echo "Installing Git>>> Detected FreeBSD. Installing Git..."
            sudo pkg update
            sudo pkg install -y git
            return
            ;;
        OpenBSD*)
            echo "Installing Git>>> Detected OpenBSD. Installing Git..."
            doas pkg_add git
            return
            ;;
    esac

    # If none of the supported operating systems matched or installation encountered complications
    echo "Installing Git>>> Uh-oh.  We encountered an error when trying to install Git.  Please repair or install Git manually."
    exit 1
}

install_git && (git config --global user.email noahdmnc@gmail.com; git config --global user.name noahdominic)
