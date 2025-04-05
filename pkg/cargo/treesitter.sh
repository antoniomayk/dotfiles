#!/usr/bin/env bash

set -euo pipefail

check_cargo() {
    if ! command -v cargo &> /dev/null; then
        echo "Error: cargo is not installed. Please install Rust and cargo first." >&2
        exit 1
    fi
}

install_treesitter() {
    echo "Installing tree-sitter-cli..."
    if ! cargo install tree-sitter-cli; then
        echo "Error: Failed to install tree-sitter-cli." >&2
        exit 1
    fi
    echo "tree-sitter-cli installed successfully."
}

main() {
    check_cargo
    install_treesitter
}

main
