#!/usr/bin/env bash

set -euo pipefail

VIM_PACK="$HOME/.vim/pack/plugins/start"
VIM_PLUGINS=(
    'https://github.com/morhetz/gruvbox.git'
)

main() {
    mkdir -p $VIM_PACK

    for plugin_url in "${VIM_PLUGINS[@]}"; do

        plugin_name=$(basename "$plugin_url" .git)
        plugin_target_path="$VIM_PACK/$plugin_name"

        echo "Downloading plugin: $plugin_name from $plugin_url to $plugin_target_path..."

        git clone "$plugin_url" "$plugin_target_path"

        if [ $? -eq 0 ]; then
            echo "Successfully downloaded $plugin_name"
        else
            echo "Error downloading $plugin_name"
        fi
    done
}

main
