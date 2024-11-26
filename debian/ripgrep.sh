#!/usr/bin/env bash

CURRENT_VERSION=$(rg --version | awk '{print $2}' | head -1)

RIPGREP_VERSION=$(curl -s "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | grep -Po '"tag_name": *"\K[^"]*')
RIPGREP_DIR=$(mktemp -d)

if [ "$CURRENT_VERSION" != "$RIPGREP_VERSION" ]; then
  cd ${RIPGREP_DIR} &&
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep_${RIPGREP_VERSION}-1_amd64.deb &&
    sudo dpkg -i ripgrep_${RIPGREP_VERSION}-1_amd64.deb
else
  echo "Latest version of ripgrep installed [${RIPGREP_VERSION}]"
fi
