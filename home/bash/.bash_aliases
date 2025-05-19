clear_history() {
    clear &&
        rm -rf \
            "$HOME"/.bash_history \
            "$HOME"/.dart-tool \
            "$HOME"/.dartServer \
            "$HOME"/.dotnet \
            "$HOME"/.dmrc \
            "$HOME"/.emulator_console_auth_token \
            "$HOME"/.emulator_console_auth_token \
            "$HOME"/.flutter \
            "$HOME"/.flutter-devtools \
            "$HOME"/.gk \
            "$HOME"/.java \
            "$HOME"/.lemminx \
            "$HOME"/.lesshst \
            "$HOME"/.nv \
            "$HOME"/.redhat \
            "$HOME"/.sonar \
            "$HOME"/.sonarlint \
            "$HOME"/.sudo_as_admin_successful \
            "$HOME"/.viminfo \
            "$HOME"/.wget-hsts \
            "$HOME"/.xsession-errors* &&
        history -c &&
        printf '\033[2J\033[3J\033[1;1H'
}

alias cat="batcat --theme=gruvbox-dark"
alias bat="batcat --theme=gruvbox-dark"
alias ls="exa"
alias la="exa -a"
alias ll="exa -la"
alias fzf="fzf --ansi --color=16"

alias clear=clear_history
