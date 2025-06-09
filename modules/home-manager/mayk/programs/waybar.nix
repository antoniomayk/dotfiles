{ theme, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "bottom";
        spacing = theme.padding;
        margin = "0px ${builtins.toString theme.margin}px ${builtins.toString theme.margin}px ${builtins.toString theme.margin}px";
        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "tray"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "sway/language"
          "network"
          "bluetooth"
          "pulseaudio"
        ];
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}";
        };
        "sway/mode" = {
          "max-length" = 50;
        };
        "sway/language" = {
          format = "󰌌  {}";
          on-click = "swaymsg input type:keyboard xkb_switch_layout next";
        };
        clock = {
          interval = 1;
          timezone = "America/Sao_Paulo";
          format = "{:%a %d-%m-%Y %I:%M %p}";
          tooltip = false;
        };
        tray = {
          icon-size = 16;
          spacing = theme.padding * 4;
        };
        network = {
          format-wifi = "<span color='${theme.colors.fg}'>󰖩  </span>{essid}";
          format-ethernet = "<span color='${theme.colors.fg}'>󰈁 </span>Wired";
          format-linked = "<span color='${theme.colors.fg}'>󰈁 </span>{ifname} (No IP)";
          format-disconnected = "<span color='${theme.colors.urgt}'>󰈂 </span>Disconnected";
          format-alt = "<span color='${theme.colors.fg}'>󰖩  </span>{signalStrength}%";
          interval = 1;
        };
        bluetooth = {
          format = "<span color='${theme.colors.fg}'>󰂯  </span>{status}";
          format-connected = "<span color='${theme.colors.fg}'>󰂯  </span>{device_alias}";
          format-connected-battery = "<span color='${theme.colors.fg}'>󰂯  </span>{device_alias}";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };
        pulseaudio = {
          format = "<span color='${theme.colors.fg}'>{icon}</span>{volume}%";
          format-muted = "<span color='${theme.colors.urgt}'>󰖁 </span>0%";
          format-icons = {
            default = [
              "<span color='${theme.colors.fg}'>󰕾  </span>"
            ];
          };
          on-click-right = "pavucontrol -t 3";
          on-click = "pactl -- set-sink-mute 0 toggle";
        };
      };
    };
    style = ''
      *
      {
        font-family: "${theme.font}";
        font-size: 14px;
        font-weight: 600;
      }

      #bluetooth,
      #bluetooth:hover,
      #clock,
      #clock:hover,
      #language,
      #language:hover,
      #mode,
      #network,
      #network:hover,
      #pulseaudio,
      #pulseaudio:hover,
      #tray
      {
        background-color: ${theme.colors.bg};
        /* border: ${builtins.toString theme.border-size}px solid ${theme.colors.afoc}; */
        border-radius: ${builtins.toString theme.border-radius}px;
        padding: ${builtins.toString theme.padding}px ${builtins.toString (theme.padding * 3)}px;
      }

      #pulseaudio.muted
      {
        color: ${theme.colors.urgt};
      }

      tooltip
      {
        background-color: ${theme.colors.bg};
        /* border: ${builtins.toString theme.border-size}px solid ${theme.colors.afoc}; */
        border-radius: ${builtins.toString theme.border-radius}px;
      }

      tooltip label
      {
        color: ${theme.colors.fg};
      }

      #waybar
      {
        background-color: rgba(0, 0, 0, 255);
        color: ${theme.colors.fg};
      }

      #workspaces
      {
        background-color: ${theme.colors.bg};
        border-radius: ${builtins.toString theme.border-radius}px;
        /* border: ${builtins.toString theme.border-size}px solid ${theme.colors.afoc}; */
      }

      #workspaces button
      {
        background-color: ${theme.colors.bg};
        border-radius: ${builtins.toString theme.border-radius}px;
        /* border: ${builtins.toString theme.border-size}px; */
        color: ${theme.colors.ifoc};
      }

      #workspaces button.urgent
      {
        color: ${theme.colors.urgt};
      }

      #workspaces button.visible
      {
        color: ${theme.colors.fg};
      }
    '';
  };
}
