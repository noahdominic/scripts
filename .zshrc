
# Created by Noah Dominic <github.com/noahdominic>

# ================= #
# ZSH customisation #
# ================= #

## ZSH plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## ZSH histfiles
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

## ZSH prompt
function parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)\ /'
}
setopt PROMPT_SUBST
PROMPT='%F{green}%B%n@%m%b%f %~ %F{cyan}$(parse_git_branch)%f%# '

## ZSH keybindings
bindkey "^[[3~"   delete-char
bindkey "^[[H"    beginning-of-line
bindkey "^[[F"    end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word


# ============================================================================
# ENVIRONMENTAL VARIABLES 
# ============================================================================

## Path - mine
export PATH=$PATH:$HOME/scripts
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/Applications

## Path - 3rd party
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.deno/bin


# ============================================================================
# Functions 
# ============================================================================

## mkcd - Make a new dir $name and cd into $name
##
mkcd ()
{
    if [ $# -eq 0 ]; then
        echo "Error: No directory name provided."
        return 1
    elif [ $# -gt 1 ]; then
        echo "Error: Only one directory name can be provided."
        return 1
    fi

    mkdir -p -- "$1" &&
    cd -- "$1"
}

## mkfile - touch but better
##
mkfile() { mkdir -p "$(dirname "$1")" && touch "$1"; }

## switch - Switch file names, so A.ext becomes B.ext and B.ext becomes A.ext
##
switch ()
{
    local file1="$1"
    local file2="$2"
    local temp_file="temp_file_$RANDOM"
    mv "$file1" "$temp_file"
    mv "$file2" "$file1"
    mv "$temp_file" "$file2"
}

# ============================================================================
# Aliases - General
# ============================================================================

## Shortcut aliases for ls
alias ls='ls -p --color=auto'
alias ll='ls -lh'
alias la='ls -lah'

## macOS-isms
if command -v xdg-open >/dev/null 2>&1; then
    alias open='xdg-open'
fi

## Windows-isms
alias cls='clear'

## Open .zshrc on nano THEN automatically load it
alias zshrc='nano ~/.zshrc && source ~/.zshrc'

## NVIDIA aliases
alias nvidia-smi='watch --interval 0.6 nvidia-smi'

## Program preferences 
if command -v fastfetch >/dev/null 2>&1; then
    alias neofetch='fastfetch'
fi
if command -v gnome-text-editor >/dev/null 2>&1; then
    alias gte='gnome-text-editor'
fi
if command -v microsoft-edge >/dev/null 2>&1; then
    alias microsoft-edge="microsoft-edge --enable-features=UseOzonePlatform --ozone-platform=wayland"
fi

## Fix for common typos
alias 'cd..'='cd ..'


# ============================================================================
# Development - Proj Managemetn
# ============================================================================

## Git
alias ga='git add'
alias gadd='git add'
alias gc='git commit'
alias gcommit='git commit'
alias gcm='gc -m'
alias gcam='gc -am'
alias gpush='git push'
alias gstat='git status'
alias ghash='git hash-object -w'
alias gundo='git reset HEAD~'
alias gb='git branch'
alias gco='git checkout'
alias gcheckout='git checkout'
alias grebase='git rebase'
alias gmerge='git merge'


# ============================================================================
# Development - Software
# ============================================================================

## CMake
alias cmake-build='cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug'

## Rust/Cargo
type cargo >/dev/null 2>&1 && alias ccheck="cargo check"
type cargo >/dev/null 2>&1 && alias crun="cargo run"

## Python: PyEnv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv virtualenv-init -)"

## Python: Conda
__conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/noahdominic/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/noahdominic/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/noahdominic/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

## For GBA Dev
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=${DEVKITPRO}/devkitARM
export DEVKITPPC=${DEVKITPRO}/devkitPPC
export PATH=${DEVKITPRO}/tools/bin:$PATH
alias vgam="visualboyadvance-m"


# ============================================================================
# Development - Web
# ============================================================================

## NPM/PNPM
export PNPM_HOME="/home/noahdominic/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
alias pnpx='pnpm dlx'

## Jekyll
type jekyll >/dev/null 2>&1 && alias 'bejs'='bundle exec jekyll serve'
export GEM_HOME='~/gems'
export PATH=$PATH:$HOME/gems/bin:/home/noahdominic/.cargo/bin
