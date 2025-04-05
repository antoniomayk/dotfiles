#!/usr/bin/env bash

set -euo pipefail

check_go() {
    if ! command -v go &> /dev/null; then
        echo "Error: go is not installed. Please install golang first." >&2
        exit 1
    fi
}

install_lazydocker() {
    echo "Installing lazydocker..."
    if ! go install github.com/jesseduffield/lazydocker@latest; then
        echo "Error: Failed to install lazydocker." >&2
        exit 1
    fi
    echo "lazydocker installed successfully."
}

main() {
    check_go
    install_lazydocker
}

main
