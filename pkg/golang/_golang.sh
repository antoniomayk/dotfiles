#!/usr/bin/env bash

set -euo pipefail

GOLANG_VERSION="1.23.5.linux-amd64"
GOLANG_TAR_FILE=$(mktemp)

cleanup() {
    if [[ -f "${GOLANG_TAR_FILE}" ]]; then
        rm -f "${GOLANG_TAR_FILE}"
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

download_golang() {
    curl -Lso "${GOLANG_TAR_FILE}" "https://golang.org/dl/go${GOLANG_VERSION}.tar.gz"
    if [[ $? -eq 0 ]]; then
        echo "Golang downloaded successfully"
    else
        echo "Failed to download Golang"
        exit 1
    fi
}

install_golang() {
    tar -xzf "${GOLANG_TAR_FILE}" -C /usr/local/
    mkdir -p $HOME/.golang
    /usr/local/go/bin/go env -w GOPATH=$HOME/.golang
    echo "Golang installed successfully"
}

main() {
    check_dependencies curl tar

    if ! command -v go &> /dev/null; then
        download_golang
    fi

    install_golang
}

main
