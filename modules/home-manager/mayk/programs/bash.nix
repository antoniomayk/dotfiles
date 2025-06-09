{ palette, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [
      "ignoredups"
      "erasedups"
    ];
    historyIgnore = [
      "ls"
      "cd"
      "exit"
    ];
    shellOptions = [
      "histappend"
      "checkwinsize"
      "extglob"
      "globstar"
      "checkjobs"
    ];
    initExtra = ''
      PS1='\[\e[0;92m\]\u\[\e[0m\]@\[\e[0;95m\]\h \[\e[0m\]on \[\e[0;94m\]\w\n\[\e[0;93m\]λ \[\e[0m\]'
      export FZF_DEFAULT_OPTS='--color bg+:${palette.gruvbox._00} --color bg:${palette.gruvbox._00} --color spinner:${palette.gruvbox._12} --color hl:${palette.gruvbox._12} --color fg:${palette.gruvbox._12} --color header:${palette.gruvbox._12} --color info:${palette.gruvbox._10} --color pointer:${palette.gruvbox._9} --color marker:${palette.gruvbox._12} --color fg+:${palette.gruvbox._12} --color prompt:${palette.gruvbox._12} --color hl+:${palette.gruvbox._12} --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> " --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'
    '';
    shellAliases = {
      b = "bat";
      clear = ''
        clear &&
          rm -rf \
            "$HOME"/.bash_history \
            "$HOME"/.java \
            "$HOME"/.lesshst \
            "$HOME"/.nv \
            "$HOME"/.wget-hsts \
            "$HOME"/.xsession-errors* &&
          history -c'';
      la = "exa -a";
      ll = "exa -la";
      ls = "exa";
      nv = "neovide --fork";
      nixs = "sudo nixos-rebuild switch";
      nixb = "sudo nixos-rebuild boot";
      ".." = "cd ..";
    };
  };
}
