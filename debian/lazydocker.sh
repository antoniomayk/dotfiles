#!/usr/bin/env bash

CURRENT_VERSION=$(lazydocker --version | awk '/Version:/ {print $2}' | tail)

LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
LAZYDOCKER_DIR=$(mktemp -d)

if [ "$CURRENT_VERSION" != "$LAZYDOCKER_VERSION" ]; then
  cd ${LAZYDOCKER_DIR} &&
    curl -Lo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/download/v${LAZYDOCKER_VERSION}/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz" &&
    tar xf lazydocker.tar.gz lazydocker &&
    sudo install lazydocker -D -t /usr/local/bin/
else
  echo "Latest version of lazydocker installed [${LAZYDOCKER_VERSION}]"
fi
