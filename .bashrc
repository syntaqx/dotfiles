#!/usr/bin/env bash
# ~/.bashrc: executed by bash(1) for non-login shells.

# shellcheck disable=SC1091

# If not running interactively, don't do anything
case $- in *i*) ;; *) return;; esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set the editor to VSCode
export EDITOR='code'

# Ensure LANG (and its variants) is set as expected
export LANG="en_US.UTF-8"
export LANGUAGE="$LANG"
export LC_ALL="$LANG"
export LC_CTYPE="$LANG"

# Prioritize Windows OpenSSH in the $PATH
export PATH="/c/Windows/System32/OpenSSH:$PATH"

# Add bin path in the home directory ontop of the PATH variable
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

# Terminal colours set in DIR_COLORS
# eval "$(dircolors -b /etc/DIR_COLORS)"

if [[ -f "$HOME/.bash_aliases" ]]; then
  . "$HOME/.bash_aliases"
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

GOPATH=$(go env GOPATH)

export GOPATH="$GOPATH"
export PATH="$GOPATH/bin:$PATH"
