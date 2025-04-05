#!/usr/bin/env bash

set -euo pipefail

check_go() {
    if ! command -v go &> /dev/null; then
        echo "Error: go is not installed. Please install golang first." >&2
        exit 1
    fi
}

install_lazygit() {
    echo "Installing lazygit..."
    if ! go install github.com/jesseduffield/lazygit@latest; then
        echo "Error: Failed to install lazygit." >&2
        exit 1
    fi
    echo "lazygit installed successfully."
}

main() {
    check_go
    install_lazygit
}

main
