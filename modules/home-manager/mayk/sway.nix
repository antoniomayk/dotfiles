{ pkgs, theme, ... }:

{
  wayland.windowManager.sway =
    let
      mod = "Mod4";
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      term = "ghostty";
      menu = "'rofi -modi drun,run -show drun'";
      i3_gaps_outer = 0;
      ws1 = "1";
      ws2 = "2";
      ws3 = "3";
      ws4 = "4";
      ws5 = "5";
      ws6 = "6";
      ws7 = "7";
      ws8 = "8";
      ws9 = "9";
      ws10 = "10";
    in
    {
      enable = true;
      extraOptions = [
        "--unsupported-gpu"
      ];
      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland-egl
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
      config = {
        modifier = mod;
        terminal = term;
        menu = menu;
        left = left;
        down = down;
        up = up;
        right = right;
        fonts = {
          names = [ theme.font ];
          style = "SemiBold";
          size = theme.font-size;
        };
        gaps = {
          inner = theme.margin;
          outer = i3_gaps_outer;
          smartGaps = false;
        };
        window = {
          border = theme.border-size;
          commands = [
            {
              criteria = {
                all = true;
              };
              command = "title_window_icon off";
            }
          ];
          titlebar = false;
        };
        floating = {
          modifier = mod;
        };
        colors = {
          background = theme.colors.bg;
          focused = {
            border = theme.colors.afoc;
            background = theme.colors.afoc;
            text = theme.colors.bg;
            indicator = theme.colors.inn;
            childBorder = theme.colors.afoc;
          };
          focusedInactive = {
            border = theme.colors.ifoc;
            background = theme.colors.ifoc;
            text = theme.colors.bg;
            indicator = theme.colors.inn;
            childBorder = theme.colors.ifoc;
          };
          unfocused = {
            border = theme.colors.ufoc;
            background = theme.colors.ufoc;
            text = theme.colors.fg;
            indicator = theme.colors.inn;
            childBorder = theme.colors.ufoc;
          };
          urgent = {
            border = theme.colors.urgt;
            background = theme.colors.urgt;
            text = theme.colors.fg;
            indicator = theme.colors.inn;
            childBorder = theme.colors.urgt;
          };
          placeholder = {
            border = theme.colors.phol;
            background = theme.colors.phol;
            text = theme.colors.fg;
            indicator = theme.colors.inn;
            childBorder = theme.colors.phol;
          };
        };
        keybindings = {
          "${mod}+m" = "bar mode toggle";
          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+r" = "restart";
          "${mod}+Shift+e" = "exec swaynag -f '${
            theme.font + " " + theme.font-size
          }' -t warning -m ' Exit request detected' -B 'Yes, exit sway' 'swaymsg exit'";
          "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 5%-";
          "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set 5%+";
          "Print" = "exec grim";
          "${mod}+Return" = "exec ${term}";
          "${mod}+Shift+q" = "kill";
          "${mod}+d" = "exec ${menu}";
          "${mod}+${left}" = "focus left";
          "${mod}+${down}" = "focus down";
          "${mod}+${up}" = "focus up";
          "${mod}+${right}" = "focus right";
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+p" = "focus parent";
          "${mod}+n" = "focus child";
          "${mod}+Shift+${left}" = "move left";
          "${mod}+Shift+${down}" = "move down";
          "${mod}+Shift+${up}" = "move up";
          "${mod}+Shift+${right}" = "move right";
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";
          "${mod}+r" = "split h";
          "${mod}+b" = "split v";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+1" = "workspace number ${ws1}";
          "${mod}+2" = "workspace number ${ws2}";
          "${mod}+3" = "workspace number ${ws3}";
          "${mod}+4" = "workspace number ${ws4}";
          "${mod}+5" = "workspace number ${ws5}";
          "${mod}+6" = "workspace number ${ws6}";
          "${mod}+7" = "workspace number ${ws7}";
          "${mod}+8" = "workspace number ${ws8}";
          "${mod}+9" = "workspace number ${ws9}";
          "${mod}+0" = "workspace number ${ws10}";
          "${mod}+Shift+1" = "move container to workspace number ${ws1}";
          "${mod}+Shift+2" = "move container to workspace number ${ws2}";
          "${mod}+Shift+3" = "move container to workspace number ${ws3}";
          "${mod}+Shift+4" = "move container to workspace number ${ws4}";
          "${mod}+Shift+5" = "move container to workspace number ${ws5}";
          "${mod}+Shift+6" = "move container to workspace number ${ws6}";
          "${mod}+Shift+7" = "move container to workspace number ${ws7}";
          "${mod}+Shift+8" = "move container to workspace number ${ws8}";
          "${mod}+Shift+9" = "move container to workspace number ${ws9}";
          "${mod}+Shift+0" = "move container to workspace number ${ws10}";
          "${mod}+g" = "mode resize";
        };
        defaultWorkspace = "workspace number ${ws1}";
        modes = {
          resize = {
            "${left}" = "resize shrink width 1 px or 1 ppt";
            "${down}" = "resize grow height 1 px or 1 ppt";
            "${up}" = "resize shrink height 1 px or 1 ppt";
            "${right}" = "resize grow width 1 px or 1 ppt";
            "Left" = "resize shrink width 1 px or 1 ppt";
            "Down" = "resize grow height 1 px or 1 ppt";
            "Up" = "resize shrink height 1 px or 1 ppt";
            "Right" = "resize grow width 1 px or 1 ppt";
            "Return" = "mode default";
            "Escape" = "mode default";
            "${mod}+r" = "mode default";
          };
        };
        startup = [
          { command = "swaybg -m fill -i ${./config/wallpaper/16.jpeg}"; }
          { command = "discord --start-minimized"; }
          { command = "youtube-music"; }
          { command = "vivaldi"; }
          { command = "ghostty"; }
          {
            command = "systemctl --user restart kanshi.service";
            always = true;
          }
        ];
        bars = [
          {
            command = "${pkgs.waybar}/bin/waybar";
          }
        ];
      };
      checkConfig = false;
      extraConfig = ''
        title_align center
        for_window [instance="vivaldi-stable"] move container to workspace number 1
        for_window [instance="com.github.th_ch.youtube_music"] move container to workspace number 10
        for_window [app_id="com.mitchellh.ghostty"] move container to workspace number 2
        input * {
            xkb_layout "us,br"
            xkb_options "grp:win_space_toggle"
        }
      '';
    };
}
