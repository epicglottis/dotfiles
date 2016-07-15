# bashrc

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

####################
# Common
####################
# Use URxvt:
export LANG=en_US.UTF-8
export TERM=rxvt-unicode

# Cursor should be a steady underline
echo -e -n "\x1b[\x34 q"

# Redo line wraps after resizing.
shopt -s checkwinsize

# Make less more friendly for non-text input files.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable programmable completion features.
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


####################
# TMUX
####################
# Fix tmux vim colors.
alias tmux="TERM=screen-256color-bce tmux"


####################
# BASH HISTORY
####################
# Don't put duplicate lines in the history.
HISTCONTROL=ignoredups:ignorespace
# Append to the history file, don't overwrite it.
shopt -s histappend
# Unlimited number of commands to remember.
HISTSIZE=
# Unlimited number of lines to write.
HISTFILESIZE=
# Add timestamps to bash_history:
export HISTTIMEFORMAT="%F %T "


####################
# PROMPT
####################
# Use StalkR's super fancy prompt. Available on github:
# https://github.com/StalkR/misc/blob/master/bash/ps1
source ~/.ps1


####################
# COLOR YOUR WORLD
####################
# Enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Less colors for man pages.
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
export LESS=" -R "
export LESSOPEN="| ~/scripts/.lessfilter.sh %s"
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)


####################
# ALIAS DEFINITIONS
####################
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias ll='ls -harlotF'
alias pps='ps awwfux'
alias ddf='df -Tha --total'
alias ddu='du -ach | sort -h'


####################
# BINDS
####################
# ^p check for partial match in history
bind -m vi-insert "\C-p":dynamic-complete-history
# ^n cycle through the list of partial matches
bind -m vi-insert "\C-n":menu-complete
# ^l clear screen
bind -m vi-insert "\C-l":clear-screen


####################
# EXPORTS
####################
export GOPATH=$HOME/gopath                                                                            
export PATH=$PATH:$GOPATH:$GOPATH/bin
export EDITOR='vim'
export PATH=$PATH:/home/$(whoami)/scripts
