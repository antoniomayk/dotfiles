#!/usr/bin/env bash

set -euo pipefail

DEB_PKG=$(mktemp --suffix .deb)

cleanup() {
    if [[ -f "${DEB_PKG}" ]]; then
        rm -f "${DEB_PKG}"
    fi
}

trap cleanup EXIT

main() {
    local package_name="discord.deb"

    echo "Downloading ${package_name} file..."
    if ! curl -Lo "$DEB_PKG" "https://discord.com/api/download?platform=linux&format=deb"; then
        echo "Error: Failed to download ${package_name}" >&2
        exit 1
    fi

    echo "Installing ${package_name}..."
    if sudo dpkg -i $DEB_PKG &> /dev/null; then
        echo "${package_name} installation successful."
    else
        echo "Error: Failed to install ${package_name}." >&2
        exit 1
    fi
}

main
