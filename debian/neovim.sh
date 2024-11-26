#!/usr/bin/env bash

CURRENT_VERSION=$(nvim --version | awk '{print $2}' | head -1)

NEOVIM_VERSION=$(curl -s "https://api.github.com/repos/neovim/neovim/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
NEOVIM_DIR=$(mktemp -d)

if [ "$CURRENT_VERSION" != "v$NEOVIM_VERSION" ]; then
  cd ${NEOVIM_DIR} &&
    git clone --depth 1 --branch v${NEOVIM_VERSION} https://github.com/neovim/neovim &&
    cd neovim &&
    make CMAKE_BUILD_TYPE=RelWithDebInfo &&
    cd build &&
    cpack -G DEB &&
    sudo dpkg -i nvim-linux64.deb
else
  echo "Latest version of neovim installed [${NEOVIM_VERSION}]"
fi
