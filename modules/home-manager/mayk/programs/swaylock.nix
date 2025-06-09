{
  pkgs,
  theme,
  ...
}:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      color = theme.colors.bg;
      clock = true;
      timestr = "%Hh %Mm %Ss";
      datestr = "%b-%d-%Y";
      daemonize = true;
      font = theme.font;
      font-size = 24;
      show-failed-attempts = true;
      indicator-idle-visible = false;
      indicator-radius = 256;
      indicator-thickness = 24;
      bs-hl-color = theme.colors.inn;
      caps-lock-bs-hl-color = theme.colors.inn;
      caps-lock-key-hl-color = theme.colors.fg;
      key-hl-color = theme.colors.fg;
      layout-text-color = theme.colors.fg;
      text-color = theme.colors.fg;
      text-clear-color = theme.colors.inn;
      text-caps-lock-color = theme.colors.warn;
      text-ver-color = theme.colors.inn;
      text-wrong-color = theme.colors.urgt;
      ring-color = theme.colors.ufoc;
      ring-clear-color = theme.colors.inn;
      ring-caps-lock-color = theme.colors.warn;
      ring-ver-color = theme.colors.inn;
      ring-wrong-color = theme.colors.urgt;
      inside-color = "00000000";
      inside-clear-color = "00000000";
      inside-caps-lock-color = "00000000";
      inside-ver-color = "00000000";
      inside-wrong-color = "00000000";
      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      separator-color = "00000000";
      layout-bg-color = "00000000";
      layout-border-color = "00000000";
    };
  };
}
