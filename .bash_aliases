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
