#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return


#				Imports
# Color Variables for ANSI Escape Codes
source ~/.bash/config/color_variables


#               PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"


#				Functions
# Necessary to include Git branch in the Terminal
parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
# Find and Kill process by name
killit() {
    ps aux | grep "$1" | grep -v "grep" | awk '{print $2}' | xargs kill -9
}
# Add to PATH
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}
# Extract any archive
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
# Make and Change Directory in one command
mkcd() {
    mkdir -p "$1" && cd "$1"
}


#				Terminal
# Current Terminal
PS1="\e[1;33;49m\u@meow\[\033[00m\]:\[\033[01;34m\]\w\[$Purple\$(parse_git_branch)\[\033[00m\][$(echo $?)]\$ \n> "

# Template term with git branch
#PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m
#\]:\[\033[01;34m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ \n> " 


#				Miscellaneous
# Terminal issues with SSH
# When kitty is used to ssh into a remote that does not have its terminfo, various issues can occur. 
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
# Show time in term
export PROMPT_COMMAND="echo -n \[\$(date +%H:%M:%S)\]\ "
# Larger history
export HISTSIZE=10000
export HISTFILESIZE=20000
# Don't store duplicates and ignore certain commands
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="ls:cd:exit:clear:history"
# Append to history, don't overwrite
shopt -s histappend
# Enable drectory colors
eval "$(dircolors -b)"
# Case-insensitive tab completion
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"



# AutoJump requirement
[[ -s /home/sqrtyracc/.autojump/etc/profile.d/autojump.sh ]] && source /home/sqrtyracc/.autojump/etc/profile.d/autojump.sh



#				Aliases
# Prints helpful Bash commands
alias ch='echo "ll | la | l | grep | cl | r | ex | cp | mv | rm | dl | dc | dk | sbrc | df | du | killit <process_name>"'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cl='clear'
alias r='reset'
alias ex='exit'
alias reboot='sudo systemctl reboot'
alias shutdown='sudo systemctl poweroff'
alias update='sudo pacman -Syu && sudo flatpak update'
# SASS Commands
alias swatch='sass --watch ./src/sass/main.scss:./public/styles/style.css'
# Confirm before overwriting
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
# Up directory shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# Common directories
alias dl='cd ~/Downloads'
alias dc='cd ~/Documents'
alias dk='cd ~/Desktop'
alias cds='cd ~/Documents/coding-school35'
# Refresh working term after ~/.bashrc change
alias sbrc='source ~/.bashrc'
# Human-readable sizes
alias df='df -h'
alias du='du -h'
