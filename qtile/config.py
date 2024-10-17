import os
import subprocess

from color import colors
from libqtile import bar, hook, layout
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from qtile_extras import widget
from qtile_extras.popup.templates.mpris2 import DEFAULT_LAYOUT
from qtile_extras.widget.decorations import BorderDecoration

###############################
# HOOKS                       #
###############################


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call([home])


###############################
# MAPPINGS                    #
###############################

mod = "mod4"

# fmt: off
keys = [
    Key([mod],              "h",      lazy.layout.left(),                       desc="Move focus to left"),
    Key([mod],              "l",      lazy.layout.right(),                      desc="Move focus to right"),
    Key([mod],              "j",      lazy.layout.down(),                       desc="Move focus down"),
    Key([mod],              "k",      lazy.layout.up(),                         desc="Move focus up"),
    Key([mod],              "space",  lazy.layout.next(),                       desc="Move window focus to other window"),
    Key([mod, "shift"],     "h",      lazy.layout.shuffle_left(),               desc="Move window to the left"),
    Key([mod, "shift"],     "l",      lazy.layout.shuffle_right(),              desc="Move window to the right"),
    Key([mod, "shift"],     "j",      lazy.layout.shuffle_down(),               desc="Move window down"),
    Key([mod, "shift"],     "k",      lazy.layout.shuffle_up(),                 desc="Move window up"),
    Key([mod, "control"],   "h",      lazy.layout.grow_left(),                  desc="Grow window to the left"),
    Key([mod, "control"],   "l",      lazy.layout.grow_right(),                 desc="Grow window to the right"),
    Key([mod, "control"],   "j",      lazy.layout.grow_down(),                  desc="Grow window down"),
    Key([mod, "control"],   "k",      lazy.layout.grow_up(),                    desc="Grow window up"),
    Key([mod],              "n",      lazy.layout.normalize(),                  desc="Reset all window sizes"),
    Key([mod, "shift"],     "Return", lazy.layout.toggle_split(),               desc="Toggle between split and unsplit sides of stack"),
    Key([mod],              "Return", lazy.spawn(guess_terminal()),             desc="Launch terminal"),
    Key([mod],              "Tab",    lazy.next_layout(),                       desc="Toggle between layouts"),
    Key([mod],              "w",      lazy.window.kill(),                       desc="Kill focused window"),
    Key([mod],              "f",      lazy.window.toggle_fullscreen(),          desc="Toggle fullscreen on the focused window"),
    Key([mod],              "t",      lazy.window.toggle_floating(),            desc="Toggle floating on the focused window"),
    Key([mod, "control"],   "r",      lazy.reload_config(),                     desc="Reload the config"),
    Key([mod, "control"],   "q",      lazy.shutdown(),                          desc="Shutdown Qtile"),
    Key([mod],              "r",      lazy.spawncmd(),                          desc="Spawn a command using a prompt widget"),
    Key([mod],              "p",      lazy.spawn("alacritty -e pulsemixer"),    desc="Launch [P]ulsemixer"),
    Key([mod],              "m",      lazy.spawn("alacritty -e btm"),           desc="Launch [M]onitor"),
    Key([mod],              "b",      lazy.spawn("vivaldi"),                    desc="Launch [B]rowser"),
    Key([mod],              "d",      lazy.spawn("discord"),                    desc="Launch [D]iscord"),
    Key([mod],              "v",      lazy.spawn("nv"),                         desc="Launch Neo[V]im"),
    Key([mod],              "e",      lazy.spawn("alacritty -e ranger"),        desc="Launch File [E]xplorer"),
    Key([mod],              "u",      lazy.spawn("alacritty -e bluetui"),       desc="Launch Bl[u]etooth"),
    Key([mod],              "o",      lazy.spawn("obs"),                        desc="Launch [O]BS"),
    Key([mod],              "s",      lazy.spawn("obsidian"),                   desc="Launch Obsi[d]ian"),
    Key([mod],              "i",      lazy.spawn("insomnia"),                   desc="Launch [I]nsomnia"),
    Key([mod],              "y",      lazy.spawn("youtube-music"),              desc="Launch [Y]outube Music"),
    # Media Keys
    Key([],                 "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 5%-"),         desc="Lower Volume by 5%"),
    Key([],                 "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 5%+"),         desc="Raise Volume by 5%"),
    Key([],                 "XF86AudioMute",        lazy.spawn("amixer sset Master 1+ toggle"),   desc="Mute/Unmute Volume"),
    Key([],                 "XF86AudioPlay",        lazy.spawn("playerctl play-pause"),           desc="Play/Pause player"),
    Key([],                 "XF86AudioNext",        lazy.spawn("playerctl next"),                 desc="Skip to next"),
    Key([],                 "XF86AudioPrev",        lazy.spawn("playerctl previous"),             desc="Skip to previous"),
]
# fmt: on

groups = [Group(i) for i in "1234567890"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

###############################
# LAYOUTS                     #
###############################

layouts = [
    layout.Columns(
        border_width=2,
        border_focus=colors["base"],
        border_focus_stack=colors["base"],
        border_normal=colors["crust"],
        border_normal_stack=colors["crust"],
        border_on_single=True,
        margin=8,
        margin_on_single=8,
    ),
    layout.Max(
        margin=8,
        border_width=2,
        border_focus=colors["base"],
        border_normal=colors["crust"],
    ),
]

###############################
# DEFAULTS                    #
###############################

widget_defaults = dict(
    # font="CaskaydiaCove Nerd Font SemiBold",
    font="JetBrainsMono Nerd Font SemiBold",
    fontsize=12,
    padding=4,
    foreground=colors["text"],
)

extension_defaults = widget_defaults.copy()


###############################
# SCREENS                     #
###############################

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=8),
                widget.GroupBox(
                    active=colors["surface_0"],
                    highlight_method="text",
                    rounded=False,
                    borderwidth=2,
                    this_current_screen_border=colors["mauve"],
                    hide_unused=True,
                    fmt="{}",
                    decorations=[
                        BorderDecoration(
                            colour=colors["mauve"],
                            border_width=[0, 0, 2, 0],
                        )
                    ],
                ),
                widget.Sep(
                    foreground=colors["surface_0"],
                    padding=10,
                    linewidth=2,
                    size_percent=50,
                ),
                widget.WindowCount(fmt="  {} /"),
                widget.WindowName(max_chars=64),
                widget.Prompt(),
                widget.Spacer(length=8),
                widget.Systray(
                    icon_size=16,
                    padding=16,
                    decorations=[
                        BorderDecoration(
                            colour=colors["rosewater"],
                            border_width=[0, 0, 2, 0],
                            extrawidth=15,
                        )
                    ],
                ),
                widget.Sep(
                    foreground=colors["surface_0"],
                    padding=10,
                    linewidth=2,
                    size_percent=50,
                ),
                widget.Volume(
                    step=1,
                    mute_format=" ",
                    unmute_format="  {volume}%",
                    channel="Capture",
                    foreground=colors["maroon"],
                    decorations=[
                        BorderDecoration(
                            colour=colors["maroon"],
                            border_width=[0, 0, 2, 0],
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.Volume(
                    step=1,
                    mute_format=" ",
                    unmute_format="  {volume}%",
                    channel="Master",
                    foreground=colors["maroon"],
                    decorations=[
                        BorderDecoration(
                            colour=colors["maroon"],
                            border_width=[0, 0, 2, 0],
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.Mpris2(
                    poll_interval=1.0,
                    padding=8,
                    margin=8,
                    foreground=colors["maroon"],
                    display_metadata=["xesam:title", "xesam:artist"],
                    paused_text=" {track}",
                    playing_text=" {track}",
                    max_chars=32,
                    no_metadata_text="Unknown",
                    scroll_chars=8,
                    popup_layout=DEFAULT_LAYOUT,
                    decorations=[
                        BorderDecoration(
                            colour=colors["maroon"], border_width=[0, 0, 2, 0]
                        )
                    ],
                ),
                widget.Sep(
                    foreground=colors["surface_0"],
                    padding=10,
                    linewidth=2,
                    size_percent=50,
                ),
                widget.KeyboardLayout(
                    fmt="󰌌 {}",
                    foreground=colors["yellow"],
                    decorations=[
                        BorderDecoration(
                            colour=colors["yellow"], border_width=[0, 0, 2, 0]
                        )
                    ],
                ),
                widget.Sep(
                    foreground=colors["surface_0"],
                    padding=10,
                    linewidth=2,
                    size_percent=50,
                ),
                widget.GenPollText(
                    update_interval=1,
                    func=lambda: subprocess.check_output(
                        """nordvpn status | awk -F': ' '/City:/ {city=$2} END {if (city == "") printf "Disconnected"; else printf "%s", city}'""",
                        shell=True,
                        text=True,
                    ),
                    mouse_callbacks={
                        "Button1": lazy.function(
                            lambda qtile: subprocess.run(
                                "nordvpn connect United_States", shell=True
                            )
                        ),
                        "Button3": lazy.function(
                            lambda qtile: subprocess.run(
                                "nordvpn disconnect", shell=True
                            )
                        ),
                    },
                    fmt="󰖂  {}",
                    foreground=colors["sky"],
                    decorations=[
                        BorderDecoration(
                            colour=colors["sky"], border_width=[0, 0, 2, 0]
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.Bluetooth(
                    default_text=" {num_connected_devices}",
                    device_format="󰾰 {name}{battery_level} [{symbol}]",
                    adapter_format="󰠿 {name} [{powered}{discovery}]",
                    fmt="{}",
                    foreground=colors["sky"],
                    decorations=[
                        BorderDecoration(
                            colour=colors["sky"], border_width=[0, 0, 2, 0]
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.Wlan(
                    fmt="  {}",
                    format="{essid} {percent:2.0%}",
                    foreground=colors["sky"],
                    decorations=[
                        BorderDecoration(
                            colour=colors["sky"], border_width=[0, 0, 2, 0]
                        )
                    ],
                ),
                widget.Spacer(length=8),
            ],
            32,
            margin=[8, 8, 0, 8],
            background=colors["base"],
            border_width=2,
            border_color=colors["base"],
        ),
    ),
]

###############################
# GLOBAL VARIABLES            #
###############################

dgroups_key_binder = None

dgroups_app_rules = []

wl_input_rules = None

wl_xcursor_theme = None

wl_xcursor_size = 24

cursor_warp = False

floats_kept_above = True

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

follow_mouse_focus = True

bring_front_click = False

auto_fullscreen = True

focus_on_window_activation = "smart"

reconfigure_screens = True

auto_minimize = True

wmname = "LG3D"
