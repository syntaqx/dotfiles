#!/usr/bin/env bash

# Configure Vagrant for WSL
export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"

# Windows Access
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"

# Other useful WSL related environment variables:
# VAGRANT_WSL_WINDOWS_ACCESS_USER - Override current Windows username
# VAGRANT_WSL_DISABLE_VAGRANT_HOME - Do not modify the VAGRANT_HOME variable
# VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH - Custom Windows system home path

# A docker daemon cannot be run inside the Windows Subsystem for Linux. However,
# the daemon can be run on Windows and accessed by Vagrant while running in the
# WSL.
#
# Once Docker is initialized and running on Windows, export the following
# environment variable to give Vagrant access.
export DOCKER_HOST=unix:///var/run/docker.sock # tcp://127.0.0.1:2375
