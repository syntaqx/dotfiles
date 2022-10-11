#!/usr/bin/env bash

# --show-control-chars: help showing Korean or accented characters
alias ls='ls -F --color=auto --show-control-chars'
alias ll='ls -l'

# The following are known to require a Win32 Console for interactive usage, so
# we'll alias them with a `winpty` wrapper when run in `mintty`.
case "$TERM" in xterm*)
  for name in node ipython php php5 psql python2.7
  do
    case "$(type -p "$name".exe 2>/dev/null)" in ''|/usr/bin*) continue;;
    esac
    alias $name="winpty $name.exe"
  done
  ;;
esac

# git aliases
# ===========

alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'

# Remove `+` and `-` from start of diff lines; just rely upon color.
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'

alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gcb='git copy-branch-name'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gac='git add -A && git commit -m'
alias ge='git-edit-new'
