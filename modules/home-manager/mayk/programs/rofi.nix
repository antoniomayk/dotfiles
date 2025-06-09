{ pkgs, theme, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,run,filebrowser,window";
      case-sensitive = false;
      cycle = true;
      filter = "";
      scroll-method = 0;
      normalize-match = true;
      show-icons = false;
      icon-theme = "Papirus Dark";
      steal-focus = false;
      matching = "normal";
      tokenize = true;
      ssh-client = "ssh";
      ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
      parse-hosts = true;
      parse-known-hosts = true;
      drun-categories = "";
      drun-match-fields = "name,generic,exec,categories,keywords";
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
      drun-show-actions = false;
      drun-url-launcher = "xdg-open";
      drun-use-desktop-cache = false;
      drun-reload-desktop-cache = false;
      run-command = "{cmd}";
      run-list-command = "";
      run-shell-command = "{terminal} -e {cmd}";
      window-match-fields = "title,class,role,name,desktop";
      window-command = "wmctrl -i -R {window}";
      window-format = "{w} - {c} - {t:0}";
      window-thumbnail = false;
      combi-modi = "window,run";
      combi-hide-mode-prefix = false;
      combi-display-format = "{mode} {text}";
      disable-history = false;
      sorting-method = "normal";
      max-history-size = 25;
      display-window = "Windows";
      display-windowcd = "Window CD";
      display-run = "Run";
      display-ssh = "SSH";
      display-drun = "Apps";
      display-combi = "Combi";
      display-keys = "Keys";
      display-filebrowser = "Files";
      terminal = "ghostty";
      font = "${theme.font} ${theme.font-size}";
      sort = false;
      threads = 0;
      click-to-exit = true;
    };
    theme =
      let
        mkLiteral = value: {
          _type = "literal";
          inherit value;
        };
      in
      {
        "*" = {
          active-background = mkLiteral "${theme.colors.bg}";
          active-foreground = mkLiteral "${theme.colors.afoc}";
          alternate-active-background = mkLiteral "${theme.colors.bg}";
          alternate-active-foreground = mkLiteral "@active-foreground";
          alternate-normal-background = mkLiteral "${theme.colors.bg}";
          alternate-normal-foreground = mkLiteral "@foreground";
          alternate-urgent-background = mkLiteral "${theme.colors.bg}";
          alternate-urgent-foreground = mkLiteral "@urgent-foreground";
          background = mkLiteral "${theme.colors.bg}";
          background-color = mkLiteral "${theme.colors.bg}";
          border-color = mkLiteral "${theme.colors.ifoc}";
          foreground = mkLiteral "${theme.colors.fg}";
          normal-background = mkLiteral "${theme.colors.bg}";
          normal-foreground = mkLiteral "@foreground";
          selected-active-background = mkLiteral "${theme.colors.afoc}";
          selected-active-foreground = mkLiteral "${theme.colors.bg}";
          selected-normal-background = mkLiteral "${theme.colors.afoc}";
          selected-normal-foreground = mkLiteral "${theme.colors.bg}";
          selected-urgent-background = mkLiteral "${theme.colors.urgt}";
          selected-urgent-foreground = mkLiteral "${theme.colors.bg}";
          separatorcolor = mkLiteral "${theme.colors.ifoc}";
          spacing = mkLiteral "0";
          urgent-background = mkLiteral "${theme.colors.bg}";
          urgent-foreground = mkLiteral "${theme.colors.urgt}";
        };
        "window" = {
          background-color = mkLiteral "@background";
          border = theme.border-size;
          border-radius = theme.border-radius;
          padding = 0;
        };
        "mainbox" = {
          border = 0;
          padding = 0;
        };
        "message" = {
          border = mkLiteral "0px 0px 0px";
          border-color = mkLiteral "@separatorcolor";
          padding = mkLiteral "0px";
        };
        "textbox" = {
          text-color = mkLiteral "@foreground";
        };
        "listview" = {
          fixed-height = 0;
          border = mkLiteral "0px";
          border-color = mkLiteral "@separatorcolor";
          spacing = mkLiteral "0px";
          scrollbar = true;
          padding = mkLiteral "0px";
        };
        "element" = {
          border = 0;
          padding = mkLiteral "8px";
        };
        "element-text" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };
        "element.normal.normal" = {
          background-color = mkLiteral "@normal-background";
          text-color = mkLiteral "@normal-foreground";
        };
        "element.normal.urgent" = {
          background-color = mkLiteral "@urgent-background";
          text-color = mkLiteral "@urgent-foreground";
        };
        "element.normal.active" = {
          background-color = mkLiteral "@active-background";
          text-color = mkLiteral "@active-foreground";
        };
        "element.selected.normal" = {
          background-color = mkLiteral "@selected-normal-background";
          text-color = mkLiteral "@selected-normal-foreground";
        };
        "element.selected.urgent" = {
          background-color = mkLiteral "@selected-urgent-background";
          text-color = mkLiteral "@selected-urgent-foreground";
        };
        "element.selected.active" = {
          background-color = mkLiteral "@selected-active-background";
          text-color = mkLiteral "@selected-active-foreground";
        };
        "element.alternate.normal" = {
          background-color = mkLiteral "@alternate-normal-background";
          text-color = mkLiteral "@alternate-normal-foreground";
        };
        "element.alternate.urgent" = {
          background-color = mkLiteral "@alternate-urgent-background";
          text-color = mkLiteral "@alternate-urgent-foreground";
        };
        "element.alternate.active" = {
          background-color = mkLiteral "@alternate-active-background";
          text-color = mkLiteral "@alternate-active-foreground";
        };
        "scrollbar" = {
          width = mkLiteral "0px";
          border = 0;
          handle-width = mkLiteral "0px";
          padding = 0;
        };
        "mode-switcher" = {
          border = mkLiteral "0px";
          border-color = mkLiteral "@separatorcolor";
        };
        "button.selected" = {
          background-color = mkLiteral "@selected-normal-background";
          text-color = mkLiteral "@selected-normal-foreground";
        };
        "inputbar" = {
          spacing = 0;
          text-color = mkLiteral "@normal-foreground";
          padding = mkLiteral "8px";
          border = mkLiteral "0 0 ${builtins.toString theme.border-size}px 0";
          children = [
            "prompt"
            "textbox-prompt-colon"
            "entry"
            "case-indicator"
          ];
        };
        "case-indicator" = {
          spacing = 0;
          text-color = mkLiteral "@normal-foreground";
        };
        "entry" = {
          spacing = 0;
          text-color = mkLiteral "@normal-foreground";
        };
        "prompt" = {
          spacing = 0;
          text-color = mkLiteral "@normal-foreground";
        };
        "textbox-prompt-colon" = {
          expand = false;
          str = " λ ";
          margin = mkLiteral "0px";
          text-color = mkLiteral "@normal-foreground";
        };
      };
  };
}
