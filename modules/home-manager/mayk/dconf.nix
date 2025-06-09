{ theme, ... }:

{
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
    "x/dm/slick-greeter" = {
      cursor-theme-name = "Adwaita";
      icon-theme-name = "Papirus-Dark";
      theme-name = "Mint-Y-Dark-Grey";
      font-name = "${theme.font} ${theme.font-size}";
    };
    "org/gnome/desktop/interface" = {
      font-name = "${theme.font} ${theme.font-size}";
      document-font-name = "${theme.font} ${theme.font-size}";
      monospace-font-name = "${theme.font} ${theme.font-size}";
    };
    "org/x/apps/portal" = {
      color-scheme = "prefer-dark";
    };
    "org/nemo/desktop" = {
      font = "${theme.font} ${theme.font-size}";
    };
    "org/cinnamon" = {
      enabled-applets = [
        "panel1:left:0:menu@cinnamon.org:181"
        "panel1:left:1:separator@cinnamon.org:182"
        "panel1:left:2:grouped-window-list@cinnamon.org:183"
        "panel1:right:2:systray@cinnamon.org:184"
        "panel1:right:3:xapp-status@cinnamon.org:185"
        "panel1:right:5:notifications@cinnamon.org:186"
        "panel1:right:6:printers@cinnamon.org:187"
        "panel1:right:7:removable-drives@cinnamon.org:188"
        "panel1:right:8:keyboard@cinnamon.org:189"
        "panel1:right:9:favorites@cinnamon.org:190"
        "panel1:right:10:network@cinnamon.org:191"
        "panel1:right:11:sound@cinnamon.org:192"
        "panel1:right:12:power@cinnamon.org:193"
        "panel1:right:14:calendar@cinnamon.org:194"
        "panel1:right:15:cornerbar@cinnamon.org:195"
        "panel1:right:4:separator@cinnamon.org:196"
        "panel1:right:1:separator@cinnamon.org:197"
        "panel1:right:13:separator@cinnamon.org:198"
      ];
      hotcorner-layout = [
        "expo:true:0"
        "scale:true:0"
        "scale:false:0"
        "desktop:true:0"
      ];
      panel-zone-symbolic-icon-sizes = "[{\"panelId\": 1, \"left\": 28, \"center\": 28, \"right\": 16}]";
      panel-zone-icon-sizes = "[{\"panelId\": 1, \"left\": 0, \"center\": 0, \"right\": 16}]";
    };
    "org/cinnamon/desktop/interface" = {
      gtk-theme = "Mint-Y-Dark-Grey";
      icon-theme = "Papirus-Dark";
      cursor-theme = "Adwaita";
      font-name = "${theme.font} ${theme.font-size}";
    };
    "org/cinnamon/theme" = {
      name = "Mint-Y-Dark-Grey";
    };
    "org/cinnamon/desktop/wm/preferences" = {
      titlebar-font = "${theme.font} ${theme.font-size}";
      theme = "Mint-Y-Dark-Grey";
      button-layout = ":minimize,maximize,close";
    };
    "org/cinnamon/desktop/background" = {
      picture-uri = "file://${./config/wallpaper/16.jpeg}";
    };
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "ghostty";
      exec-arg = "--working-directory";
    };
  };
}
