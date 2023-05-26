# Created by Noah Dominic <github.com/noahdominic>

# Note: This version was created for a workstation running on Fedora 36. 
#       Things may need to be modified to fit your system.

# ZSH plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
setopt autocd

# Aliases for general convenience
# Run previous command as `sudo`
	alias please='sudo $(fc -ln -1)'
# Open /usr/share/fonts on nautilus as sudo
	alias opensysfonts='sudo nautilus /usr/share/fonts'
# Open .zshrc on nano THEN automatically load it
	alias zshrc='nano ~/.zshrc && source ~/.zshrc'
# Refrash user and system font caches
	alias refreshfontcaches='fc-cache -fv && sudo fc-cache -fv'	
# Load gnome-text-editor as gedit
	alias gedit='gnome-text-editor'
# Shortcut aliases for LIST
	alias ls='ls --group-directories-first --color=auto'
	alias lh='ls -lh'
	alias la='lh -a'
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
# Windows-isms
	alias cls='clear'
# Fix for common typos
	alias 'cd..'='cd ..'
# Aliases for special directories
	alias journal='cd ~/journal/'
	alias dev='cd ~/dev/'
# Aliases for journaling
	alias today="echo $(date +'%Y/%m/%d')"
	alias inittoday=~/journal/inittoday
	alias nanotoday="nano ~/journal/$(today)"
	alias gedittoday="gnome-text-editor ~/journal/$(today)"
	alias vimtoday="vim ~/journal/$(today)"
	alias showtoday="cat ~/journal/$(today)"
# Aliases for scripts in $HOME/scripts
	alias find-all-liberation-fonts="$HOME/scripts/find-all-liberation-fonts.sh"
	alias delete-all-liberation-fonts="$HOME/scripts/delete-all-liberation-fonts.sh"
# Aliases for Jekyll [JEKYLL REQUIRED]
	alias 'bejs'='bundle exec jekyll serve'
# Aliases for TeX & related software [TEX REQUIRED]
	alias tectonic-build='tectonic main.tex -o out/'
# Aliases for make & CMake [MAKE & CMAKE REQUIRED]
	alias cmake-build='cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug'
# Aliases for git [GIT REQUIRED]
	alias ga='git add'
	alias gadd='git add'
	alias gc='git commit'
	alias gcommit='git commit'
	alias gcm='gc -m'
	alias gp='git push'
	alias gpush='git push'
	alias gstat='git status'
	alias ghash='git hash-object -w'
	alias gundo='git reset HEAD~'
	alias gco='git checkout'
	alias gcheckout='git checkout'
	alias grebase='git rebase'
	alias gmerge='git merge'
gitRebaseAll()
{
# Check if at least one argument is provided
if [ $# -lt 1 ]; then
  echo "Usage: gitrebasetocurrentbranch branch1 [branch2 ...]"
  exit 1
fi
# Loop over the arguments (branch names)
for branch in "$@"; do
  # Checkout the branch
  git checkout "$branch" && git rebase playground
done

# Return to the original branch
git checkout playground
}
# Aliases for cargo
	alias ccheck="cargo check"
	alias crun="cargo run"

# Lines forring zsh histories
	HISTFILE=~/.zsh_histfile
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

# Prerequisite configs for Jekyll
	export GEM_HOME='~/gems'
	export PATH=$HOME/gems/bin:/home/noahdominic/.cargo/bin:$PATH

# Keybindings
	bindkey "^[[3~"	delete-char
	bindkey "^[[H"	beginning-of-line
	bindkey "^[[F"	end-of-line
	bindkey "^[[1;5C" forward-word
	bindkey "^[[1;5D" backward-word

function download-playlist() {
    if [[ -n "$1" ]]; then
        touch ./files.txt;
        counter=1;
        while read line; do
            if [[ "$line" == "http"* ]]; then
                curl --silent -o ${counter}.mp4 "$line";
                echo "file ${counter}.mp4" >> ./files.txt;
                ((counter++));
            fi;
        done < "$1";
        ffmpeg -f concat -safe 0 -i ./files.txt -codec copy output.mp4;
    else
        echo 'Usage: download-playlist <file.m3u8>';
    fi
}

backup() {
    original_path="$1"
    archive_path="$2"

    tar --sort='name' -cvf - "$original_path" | xz -9zve -T0 > "$archive_path"
}
