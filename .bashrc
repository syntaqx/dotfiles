#!/usr/bin/env bash
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in *i*) ;; *) return;; esac

# Ensure LANG is provided
export LANG=${LANG:-$(exec /usr/bin/locale -uU)}
export LANGUAGE="$LANG"
export LC_ALL="$LANG"
export LC_CTYPE="$LANG"

# Prioritize Windows OpenSSH in the $PATH
export PATH="/c/Windows/System32/OpenSSH:$PATH"

# Add bin path in the home directory ontop of the PATH variable
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Terminal colours set in DIR_COLORS
eval "$(dircolors -b /etc/DIR_COLORS)"

# shellcheck source=.aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"
