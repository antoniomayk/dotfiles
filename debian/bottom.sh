#!/usr/bin/env bash

CURRENT_VERSION=$(btm --version | awk '{print $2}')

BOTTOM_VERSION=$(curl -s "https://api.github.com/repos/ClementTsang/bottom/releases/latest" | grep -Po '"tag_name": *"\K[^"]*')
BOTTOM_DIR=$(mktemp -d)

if [ "$CURRENT_VERSION" != "$BOTTOM_VERSION" ]; then
  cd ${BOTTOM_DIR} &&
    curl -LO https://github.com/ClementTsang/bottom/releases/download/${BOTTOM_VERSION}/bottom_${BOTTOM_VERSION}-1_amd64.deb &&
    sudo dpkg -i bottom_${BOTTOM_VERSION}-1_amd64.deb
else
  echo "Newest version of bottom already installed ${BOTTOM_VERSION}"
fi
