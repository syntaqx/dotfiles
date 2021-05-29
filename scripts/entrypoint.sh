#!/usr/bin/env bash
set -ex

echo "🚧 Bootstrapping is WIP"

sed -i "s/;extension=openssl/extension=openssl/" ~/scoop/apps/php/current/cli/php.ini
