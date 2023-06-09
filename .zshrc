# Created by Noah Dominic <github.com/noahdominic>

# Enable colourised output for CLI
export CLICOLOR=1

# ZSH plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
setopt autocd

# Lines forring zsh histories
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# PS1 for ZSH
function parse_git_branch () {
    # git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)\ /'
}
setopt PROMPT_SUBST
PROMPT='%F{green}%B%n@%m%b%f %~ %F{cyan}$(parse_git_branch)%f%# '

# Path env var
export PATH=$HOME/scripts:$HOME/bin:$PATH

# Functions for general convenience
# Make a new dir $name and cd into $name
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
# Switch file names, so A.ext becomes B.ext and B.ext becomes A.ext
switch ()
{
    local file1="$1"
    local file2="$2"
    local temp_file="temp_file_$RANDOM"
    mv "$file1" "$temp_file"
    mv "$file2" "$file1"
    mv "$temp_file" "$file2"
}

# Aliases for general convenience
# Open .zshrc on nano THEN automatically load it
alias zshrc='nano ~/.zshrc && source ~/.zshrc'
# Shortcut aliases for LIST
alias ll='ls -lGh'
alias la='ls -lahG'
# macOS-isms
if command -v xdg-open >/dev/null 2>&1; then
    alias open='xdg-open'
fi
# Windows-isms
alias cls='clear'
# Aliases for Linux/GNOME
if command -v gnome-text-editor >/dev/null 2>&1; then
    alias gte='gnome-text-editor'
fi
# Fix for common typos
alias 'cd..'='cd ..'
# Aliases for journaling

# Aliases for Jekyll [JEKYLL REQUIRED]
type jekyll >/dev/null 2>&1 && alias 'bejs'='bundle exec jekyll serve'
# Aliases for make & CMake [MAKE & CMAKE REQUIRED]
alias cmake-build='cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug'
# Aliases for git [GIT REQUIRED]
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
alias gco='git checkout'
alias gcheckout='git checkout'
alias grebase='git rebase'
alias gmerge='git merge'

# Aliases for cargo
type cargo >/dev/null 2>&1 && alias ccheck="cargo check"
type cargo >/dev/null 2>&1 && alias crun="cargo run"

# Prerequisite configs for Jekyll
export GEM_HOME='~/gems'
export PATH=$HOME/gems/bin:/home/noahdominic/.cargo/bin:$PATH

# Keybindings
bindkey "^[[3~"   delete-char
bindkey "^[[H"    beginning-of-line
bindkey "^[[F"    end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

