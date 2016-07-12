#!/bin/bash
# Adapted from https://github.com/StalkR/misc/blob/master/bash/ps1

# Return the mount type of given directory (default current).
mount_type() {
  local RESULT DIR LEN DEV ON TYPE OTHER
  RESULT=""
  if [[ -n "$1" ]]; then
    pushd "$1" >/dev/null || return 1
    DIR=$(pwd -P)
    popd >/dev/null 2>&1
  else
    DIR=$(pwd -P 2>/dev/null) || return 1
  fi
  LEN=0
  while read DEV ON TYPE OTHER; do
    if [[ "${DIR:0:${#ON}}" = "$ON" ]] && [[ ${#ON} -gt $LEN ]]; then
      RESULT=$TYPE
      LEN=${#ON}
    fi
  done < /proc/mounts
  echo "$RESULT"
}

# Prompt
_ps1() {
  local BLACK LBLACK RED LRED GREEN LGREEN YELLOW LYELLOW \
    BLUE LBLUE PURPLE LPURPLE CYAN LCYAN NONE DATE P GITOPT BGREEN
  # Colors (use echo -e to display)
  BLACK='\e[0;30m';  LBLACK='\e[1;30m'; RED='\e[0;31m';    LRED='\e[1;31m';
  GREEN='\e[0;32m';  LGREEN='\e[1;32m'; YELLOW='\e[0;33m'; LYELLOW='\e[1;33m';
  BLUE='\e[0;34m';   LBLUE='\e[1;34m';  PURPLE='\e[0;35m'; LPURPLE='\e[1;35m';
  CYAN='\e[0;36m';   LCYAN='\e[1;36m';  NONE='\e[0m';      BGREEN='\e[01;32m';

  # Enclose non-printing characters with \[ and \]
  # to tell bash they don't take up any space
  RETCODE="\[$CYAN\]\$? "
  DATE="\[$BLUE\]\D{%Y-%m-%d %H:%M:%S}"
  
  # TODO: Add a cute unicode symbol instead of @ :)
  P="\[$BGREEN\]\u\[$BGREEN\]\[$NONE\]@\[$LBLUE\]\h\[$NONE\]:"

  # Partial path if in clients directory:
  CLIENTDIR="~/src/"
  P="$P\[$LBLUE\]\w"

  # Show git branch + status
  P="$P\$(_ps1_git)"

  # End of prompt
  P="$P\[$NONE\]\n]"

  # Only set title for capable terminals
  case "$TERM" in
    xterm*|rxvt*|screen*) P="\[\e]0;\u@\h \w\a\]$P";;
    *) P="$P";;
  esac

  echo "$P"
}

_ps1_git() {
  local BLACK LBLACK RED LRED GREEN LGREEN YELLOW LYELLOW \
    BLUE LBLUE PURPLE LPURPLE CYAN LCYAN NONE \
    mtype gitdir gitopt current branch stash
  # Colors (use echo -e to display)
  BLACK='\e[0;30m';  LBLACK='\e[1;30m'; RED='\e[0;31m';    LRED='\e[1;31m';
  GREEN='\e[0;32m';  LGREEN='\e[1;32m'; YELLOW='\e[0;33m'; LYELLOW='\e[1;33m';
  BLUE='\e[0;34m';   LBLUE='\e[1;34m';  PURPLE='\e[0;35m'; LPURPLE='\e[1;35m';
  CYAN='\e[0;36m';   LCYAN='\e[1;36m';  NONE='\e[0m';

  mtype=$(mount_type)
  case "$mtype" in
    nfs|fuse.sshfs)
      echo -e " ${PURPLE}no-git:$RED$mtype"
      return ;;
  esac

  # Find .git directory in upper hierarchy.
  gitdir=$PWD
  while [[ ! -d "$gitdir/.git/refs/heads" ]]; do
    [[ $gitdir == "/" ]] && return
    gitdir=$(dirname "$gitdir")
  done

  # Warn if stuff to commit.
  case "$(git --version)" in
    "git version 1.5."*) gitopt="-u" ;; # -uno not supported in this version
    *) gitopt="-uno"
  esac
  if git status $gitopt | grep -q "modified:\|new file:"; then
    echo -ne " ${PURPLE}git:$RED"
  else
    echo -ne " ${PURPLE}git:$LPURPLE"
  fi

  # Display current branch.
  current=$(< "$gitdir/.git/HEAD")
  current=${current#ref: }
  current=${current#refs/heads/}
  echo -n "$current"

  # Display other branches.
  echo -ne "$PURPLE"
  for branch in $(ls "$gitdir/.git/refs/heads"); do
    [[ "$branch" = "$current" ]] && continue
    echo -n " $branch"
  done

  # Show stash if anything.
  if [[ -f "$gitdir/.git/logs/refs/stash" ]]; then
    stash=$(wc -l < "$gitdir/.git/logs/refs/stash")
    echo -ne " ${LBLUE}stash($stash)"
  fi
  echo -ne "$NONE"
}

# Prompt: definition
PS1=$(_ps1)

# Save bash history after every command
PROMPT_COMMAND="history -a"
