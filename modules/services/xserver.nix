{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [
      xterm
    ];
    exportConfiguration = true;
    videoDrivers = [ "nvidia" ];
    desktopManager.cinnamon.enable = true;
    displayManager.lightdm = {
      enable = true;
      greeters.slick.enable = false;
      greeters.gtk = {
        enable = true;
        theme = {
          name = "Mint-Y-Dark-Grey";
        };
        iconTheme = {
          name = "Papirus-Dark";
        };
        extraConfig = ''
          font-name = JetBrainsMono Nerd Font 10
        '';
      };
    };
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
