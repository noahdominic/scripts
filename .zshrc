# Created by Noah Dominic <github.com/noahdominic>

# Note: This version was created for a workstation running on Fedora 36. 
#       Things may need to be modified to fit your system.

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
export PATH=$HOME/bin:$PATH

# Functions for general convenience
# Make a new dir $name and cd into $name
mkcd ()
{
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
alias ls='ls -G'
alias ll='ls -lGh'
alias la='ls -lahG'
# Windows-isms
alias cls='clear'
# Fix for common typos
alias 'cd..'='cd ..'
# Aliases for journaling
alias journal='cd ~/journal/'
alias today="echo $(date +'%Y/%m/%d')"
alias inittoday=~/journal/inittoday
alias nanotoday="nano ~/journal/$(today)"
alias gedittoday="gnome-text-editor ~/journal/$(today)"
alias vimtoday="vim ~/journal/$(today)"
alias showtoday="cat ~/journal/$(today)"
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
gitRebaseAll() {
  if [[ $# -eq 0 ]]; then
    echo "gitRebaseAll - Rebase multiple branches into the current branch"
    echo "Usage: gitRebaseAll branch1 [branch2 ...]"
    return 0
  fi

  current_branch=$(git rev-parse --abbrev-ref HEAD)
  for branch in "$@"; do
    echo "Rebasing branch '$branch' into '$current_branch'"
    git checkout "$branch" && git rebase "$current_branch"
  done

  git checkout "$current_branch"
}

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

backup() {
    original_path="$1"
    archive_path="$2"

    tar --sort='name' -cvf - "$original_path" | xz -9zve -T0 > "$archive_path"
}
