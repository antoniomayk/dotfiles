#!/usr/bin/env bash

FONT="JetBrainsMono Nerd Font"

JETBRAINSMONO_VERSION=$(curl -s "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
JETBRAINSMONO_DIR=$(mktemp -d)

if ! fc-list | grep -qi "$FONT"; then
  cd ${JETBRAINSMONO_DIR} &&
    curl -Lo JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v${JETBRAINSMONO_VERSION}/JetBrainsMono.zip &&
    unzip JetBrainsMono.zip &&
    sudo cp -r ${JETBRAINSMONO_DIR}/* /usr/local/share/fonts/ &&
    fc-cache -fv
else
  echo "Font '$FONT' already installed."
fi
