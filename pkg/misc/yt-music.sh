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
    echo "Checking latest YT Music version..."
    local latest_version=$(curl -s "https://api.github.com/repos/th-ch/youtube-music/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
    local package_name="youtube-music_${latest_version}_amd64.deb"

    echo "Downloading ${package_name} file..."
    if ! curl -Lo "$DEB_PKG" "https://github.com/th-ch/youtube-music/releases/download/v${latest_version}/${package_name}"; then
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
