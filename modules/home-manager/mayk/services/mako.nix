{ pkgs, theme, ... }:

{
  services.mako = {
    enable = true;
    settings = {
      actions = true;
      anchor = "top-right";
      background-color = "${theme.colors.bg}";
      border-color = "${theme.colors.ifoc}";
      text-color = "${theme.colors.fg}";
      progress-color = "${theme.colors.inn}";
      border-size = theme.border-size;
      border-radius = theme.border-radius;
      default-timeout = 10000;
      font = theme.font + " " + theme.font-size;
      height = 100;
      width = 300;
      icons = true;
      icon-path = "${pkgs.papirus-icon-theme}";
      ignore-timeout = false;
      layer = "top";
      margin = theme.margin * 2;
      markup = true;
      "actionable=true" = {
        anchor = "top-right";
      };
    };
  };
}
