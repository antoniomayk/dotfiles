if status is-interactive
# Commands to run in interactive sessions can go here
end

set fish_greeting

zoxide init fish | source

# Golang

go env -w GOPATH=$HOME/.go

if set -q GOPATH
set -x GOPATH $HOME/.go
end

if not contains "$HOME/.go/bin" $PATH
set -x PATH "$HOME/.go/bin" $PATH
end

# Rust

if not contains "$HOME/.cargo/bin" $PATH
set -x PATH "$HOME/.cargo/bin" $PATH
end

# Android

if not contains "$HOME/Android/Sdk/cmdline-tools/latest/bin" $PATH
set -x PATH "$HOME/Android/Sdk/cmdline-tools/latest/bin" $PATH
end

if not contains "$HOME/Android/Sdk/emulator" $PATH
set -x PATH "$HOME/Android/Sdk/emulator" $PATH
end

if not contains "$HOME/Android/Sdk/flutter/bin" $PATH
set -x PATH "$HOME/Android/Sdk/flutter/bin" $PATH
end
