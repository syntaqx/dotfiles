#!/usr/bin/env bash
# shellcheck disable=SC1091
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in *i*) ;; *) return;; esac

# Ensure LANG (and its variants) is set as expected
export LANG="en_US.UTF-8"
export LANGUAGE="$LANG"
export LC_ALL="$LANG"
export LC_CTYPE="$LANG"

# Prioritize Windows OpenSSH in the $PATH
export PATH="/c/Windows/System32/OpenSSH:$PATH"

# Add bin path in the home directory ontop of the PATH variable
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Terminal colours set in DIR_COLORS
# eval "$(dircolors -b /etc/DIR_COLORS)"

if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
  GIT_PROMPT_ONLY_IN_REPO=1
  source "$HOME/.bash-git-prompt/gitprompt.sh"
fi

if [[ -f "$HOME/.aliases" ]]; then
  source "$HOME/.aliases"
fi
