# Load user-specific bash configuration if available

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

. "$HOME/.cargo/env"
