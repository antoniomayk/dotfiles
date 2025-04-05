#!/usr/bin/env bash

set -euo pipefail

NEOVIM_DIR=$(mktemp -d)

cleanup() {
    if [[ -d "${NEOVIM_DIR}" ]]; then
        rm -rf "${NEOVIM_DIR}"
    fi
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
    check_dependencies curl git make cpack dpkg

    echo "Checking latest Neovim version..."
    local latest_version=$(curl -s "https://api.github.com/repos/neovim/neovim/releases/latest" | grep -Po '"tag_name": *"\K[^"]*')
    local current_version=$(command -v nvim >/dev/null && nvim --version | awk '{print $2; exit}' || echo "")

    if [[ "${current_version}" != "${latest_version}" ]]; then
        if ! [[ "${current_version}" ]]; then
            echo "Installing Neovim ${latest_version}..."
        else
            echo "Updating Neovim from ${current_version} to ${latest_version}..."
        fi

        echo "Cloning Neovim repository..."
        cd "${NEOVIM_DIR}"
        if ! git clone --depth 1 --branch "${latest_version}" https://github.com/neovim/neovim &> /dev/null; then
            echo "Error: Failed to clone Neovim repository." >&2
            exit 1
        fi

        echo "Building Neovim..."
        cd neovim
        if ! make CMAKE_BUILD_TYPE=RelWithDebInfo &> /dev/null; then
            echo "Error: Failed to build Neovim." >&2
            exit 1
        fi

        echo "Packaging nvim-linux-x86_64.deb..."
        cd build
        if ! cpack -G DEB &> /dev/null; then
            echo "Error: Failed to package Neovim." >&2
            exit 1
        fi

        echo "Installing nvim-linux-x86_64.deb..."
        if sudo dpkg -i nvim-linux-x86_64.deb &> /dev/null; then
            echo "Neovim ${latest_version} installation successful."
        else
            echo "Error: Failed to install Neovim package." >&2
            exit 1
        fi
    else
        echo "Latest version of Neovim already installed [${latest_version}]"
    fi
}

main
