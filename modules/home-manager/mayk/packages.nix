{ pkgs, ... }:

{
  home.packages = with pkgs; [
    anytype
    ascii-draw
    bat
    brave
    discord
    distrobox
    docker-compose
    eza
    fd
    fzf
    gaphor
    gcolor3
    ghostty
    # gimp3
    git
    git-lfs
    grim
    insomnia
    # krita
    lazydocker
    lazygit
    lshw
    neofetch
    obsidian
    papirus-icon-theme
    xbindkeys
    pavucontrol
    pciutils
    pulseaudio
    qemu
    resources
    ripgrep
    tldr
    unrar
    unzip
    virt-manager
    vivaldi
    vivaldi-ffmpeg-codecs
    wget
    wike
    xclip
    youtube-music
    zip
    dconf-editor
  ];
}
