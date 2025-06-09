{ pkgs, ... }:

{
  environment.cinnamon.excludePackages = with pkgs; [
    gnome-terminal
    hexchat
  ];

  environment.systemPackages = with pkgs; [
    mint-themes
    nerd-fonts.jetbrains-mono
    papirus-icon-theme
  ];

  environment.localBinInPath = true;
}
