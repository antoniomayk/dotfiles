#!/usr/bin/env bash

set -euo pipefail

RUSTUP_INIT_SCRIPT=$(mktemp)

cleanup() {
    rm -f "$RUSTUP_INIT_SCRIPT"
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
    if command -v rustup &> /dev/null; then
        echo "Rustup is already installed. Updating..."
        rustup update
    fi

    check_dependencies curl
        
    echo "Downloading Rustup init script..."
    if ! curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o "$RUSTUP_INIT_SCRIPT"; then
        echo "Error: Failed to download Rustup init script." >&2
        exit 1
    fi
        
    echo "Installing rustup..."
    if ! sh "$RUSTUP_INIT_SCRIPT" -y; then
        echo "Error: Failed to install Rustup." >&2
        exit 1
    fi

    echo "Rustup installation/update completed successfully."
}

main
