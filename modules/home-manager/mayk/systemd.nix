{ pkgs, ... }:

{
  systemd.user = {
    services.gnome-dconf-apply = {
      Unit = {
        Description = "Disable WM button-layout";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        ConditionEnvironment = "XDG_CURRENT_DESKTOP=GNOME";
      };
      Service = {
        Type = "oneshot";
        ExecStart = ''${pkgs.dconf}/bin/dconf write /org/gnome/desktop/wm/preferences/button-layout "':minimize,maximize,close'"'';
        RemainAfterExit = "no";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    services.sway-dconf-apply = {
      Unit = {
        Description = "Disable WM button-layout";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        ConditionEnvironment = "XDG_CURRENT_DESKTOP=sway";
      };
      Service = {
        Type = "oneshot";
        ExecStart = ''${pkgs.dconf}/bin/dconf write /org/gnome/desktop/wm/preferences/button-layout "' '" '';
        RemainAfterExit = "no";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
