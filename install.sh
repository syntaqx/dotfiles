#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

# TODO:
exit

# Linux
git config --global credential.helper cache

# macOS
git credential-osxkeychain
git config --global credential.helper osxkeychain
