#!/usr/bin/env bash
set -xe

sudo apt-get update
sudo apt-get -qqy upgrade

sudo apt-get install -qqy software-properties-common
sudo apt-get install -qqy ca-certificates gcc gnupg2 curl wget git

