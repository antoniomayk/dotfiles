#!/usr/bin/env bash

set -euo pipefail

MINT_L_THEME_VERSION="1.9.8"
MINT_L_THEME_DEB=$(mktemp)

cleanup() {
    rm -f "$MINT_L_THEME_DEB"
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

download_mint_l_theme() {
    echo "Downloading Mint-L-Theme package..."
    if ! curl -Lso "$MINT_L_THEME_DEB" "http://packages.linuxmint.com/pool/main/m/mint-l-theme/mint-l-theme_${MINT_L_THEME_VERSION}_all.deb"; then
        echo "Error: Failed to download Mint-L-Theme package." >&2
        exit 1
    fi
}

install_mint_l_theme() {
    echo "Installing Mint-L-Theme package..."
    if ! sudo dpkg -i "$MINT_L_THEME_DEB"; then
        echo "Error: Failed to install Mint-L-Theme package." >&2
        echo "Attempting to fix broken dependencies..." >&2
        if ! sudo apt-get install -f -y; then
            echo "Error: Failed to fix dependencies. Please install the package manually." >&2
            exit 1
        fi
    fi
}

main() {
    check_dependencies curl dpkg sudo
    download_mint_l_theme
    install_mint_l_theme

    echo "Mint-L-Theme installation completed successfully."
}

main
