#!/usr/bin/env bash

CURRENT_VERSION=$(lazygit --version | grep -oP 'version=\K[0-9\.]+' | head -1)

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
LAZYGIT_DIR=$(mktemp -d)

if [ "$CURRENT_VERSION" != "$LAZYGIT_VERSION" ]; then
  cd ${LAZYGIT_DIR} &&
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" &&
    tar xf lazygit.tar.gz lazygit &&
    sudo install lazygit -D -t /usr/local/bin/
else
  echo "Latest version of lazygit installed [${LAZYGIT_VERSION}]"
fi
