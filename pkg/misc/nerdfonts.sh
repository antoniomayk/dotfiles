#!/usr/bin/env bash

set -euo pipefail

FONT_VERSION="3.3.0"
FONT_NAME="JetBrainsMono"
FONT_ZIP=$(mktemp)
FONT_DIR="$HOME/.local/share/fonts"

cleanup() {
    rm -f "$FONT_ZIP"
}

trap cleanup EXIT

check_dependencies() {
    local missing_deps=()
    for cmd in "$@"; do
        if ! command -v "$cmd" &> /dev/null; then
            missing_deps+=("$cmd")
        fi
    done

    if [ ${#missing_deps[@]} -gt 0 ]; then
        echo "Error: The following dependencies are not installed: ${missing_deps[*]}" >&2
        echo "Please install them and try again." >&2
        exit 1
    fi
}

main() {
    if fc-list | grep -q 'JetBrainsMonoNL'; then
        echo "$FONT_NAME Nerd Font is already installed."
        exit 0
    fi

    check_dependencies curl unzip fc-cache fc-list

    echo "Downloading $FONT_NAME Nerd Font..."
    if ! curl -Lo "$FONT_ZIP" "https://github.com/ryanoasis/nerd-fonts/releases/download/v${FONT_VERSION}/${FONT_NAME}.zip"; then
        echo "Error: Failed to download $FONT_NAME Nerd Font." >&2
        exit 1
    fi
    
    echo "Installing $FONT_NAME Nerd Font..."
    mkdir -p "$FONT_DIR"
    if ! unzip -q "$FONT_ZIP" -d "$FONT_DIR"; then
        echo "Error: Failed to extract $FONT_NAME Nerd Font." >&2
        exit 1
    fi

    echo "Updating font cache..."
    if ! fc-cache -fv &> /dev/null; then
        echo "Warning: Failed to update font cache. You may need to do this manually." >&2
    fi

    echo "$FONT_NAME Nerd Font installation completed successfully."
    echo "You may need to restart your applications to use the new font."
}

main
