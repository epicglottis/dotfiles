# bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# HISTORY
HISTCONTROL=ignoredups:ignorespace   # Don't add duplicate lines in the history
shopt -s histappend                  # Append to the history file, don't overwrite it
export HISTTIMEFORMAT="%F %T "       # Add timestamps to bash_history:
HISTSIZE=10000                       # Moar history!
HISTFILESIZE=20000

# Check window size after each command and update the values of LINES and COLUMNS
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Enable color support of ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # WARNING: enabling this can cause multi-second delays due to NFS latency
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Fix tmux vim colors:
alias tmux="TERM=screen-256color-bce tmux"

export EDITOR='vim'
export PATH=$PATH:/home/$(whoami)/scripts

# less colors for man pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# less highlighting
# DEPENDENCY: $ sudo apt-get install python-pygments
export LESS=" -R "
export LESSOPEN="| ~/scripts/.lessfilter.sh %s"

# Use vi mode:
# h	  Move cursor left
# l	  Move cursor right
# A	  Move cursor to end of line and put in insert mode
# 0	  (zero) Move cursor to beginning of line (doesn't put in insert mode) 
# i	  Put into insert mode at current position
# a	  Put into insert mode after current position
# dd  Delete line (saved for pasting)
# D	  Delete text after current cursor position (saved for pasting)
# p	  Paste text that was deleted
# j	  Move up through history commands
# k	  Move down through history commands
# u	  Undo
set -o vi
set editing-mode vi
set keymap vi
set meta-flag on
set input-meta on
set convert-meta on
set output-meta on

bind -m vi-insert "\C-p":dynamic-complete-history   # ^p check for partial match in history
bind -m vi-insert "\C-n":menu-complete              # ^n cycle through the list of partial matches
bind -m vi-insert "\C-l":clear-screen               # ^l clear screen

# Set a super fancy prompt
source ~/.ps1
