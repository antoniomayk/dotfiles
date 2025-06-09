{
  lib,
  pkgs,
  theme,
  ...
}:

{
  gtk = {
    enable = true;
    font = {
      name = theme.font;
      size = lib.strings.toIntBase10 theme.font-size;
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = {
      package = pkgs.mint-themes;
      name = "Mint-Y-Dark-Grey";
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
}
