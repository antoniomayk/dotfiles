#!/usr/bin/env bash

set -euo pipefail

check_cargo() {
    if ! command -v cargo &> /dev/null; then
        echo "Error: cargo is not installed. Please install Rust and cargo first." >&2
        exit 1
    fi
}

install_bottom() {
    echo "Installing bottom..."
    if ! cargo install bottom; then
        echo "Error: Failed to install bottom." >&2
        exit 1
    fi
    echo "bottom installed successfully."
}

main() {
    check_cargo
    install_bottom
}

main
