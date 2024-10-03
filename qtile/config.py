import os
import subprocess

from libqtile import bar, hook, layout
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration

from color import colors

###############################
# HOOKS                       #
###############################


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser(
        "~/.config/qtile/autostart.sh"
    )  # path to my script, under my user directory
    subprocess.call([home])


###############################
# MAPPINGS                    #
###############################

mod = "mod4"

# fmt: off
keys = [
    Key([mod],              "h",      lazy.layout.left(),                 desc="Move focus to left"),
    Key([mod],              "l",      lazy.layout.right(),                desc="Move focus to right"),
    Key([mod],              "j",      lazy.layout.down(),                 desc="Move focus down"),
    Key([mod],              "k",      lazy.layout.up(),                   desc="Move focus up"),
    Key([mod],              "space",  lazy.layout.next(),                 desc="Move window focus to other window"),
    Key([mod, "shift"],     "h",      lazy.layout.shuffle_left(),         desc="Move window to the left"),
    Key([mod, "shift"],     "l",      lazy.layout.shuffle_right(),        desc="Move window to the right"),
    Key([mod, "shift"],     "j",      lazy.layout.shuffle_down(),         desc="Move window down"),
    Key([mod, "shift"],     "k",      lazy.layout.shuffle_up(),           desc="Move window up"),
    Key([mod, "control"],   "h",      lazy.layout.grow_left(),            desc="Grow window to the left"),
    Key([mod, "control"],   "l",      lazy.layout.grow_right(),           desc="Grow window to the right"),
    Key([mod, "control"],   "j",      lazy.layout.grow_down(),            desc="Grow window down"),
    Key([mod, "control"],   "k",      lazy.layout.grow_up(),              desc="Grow window up"),
    Key([mod],              "n",      lazy.layout.normalize(),            desc="Reset all window sizes"),
    Key([mod, "shift"],     "Return", lazy.layout.toggle_split(),         desc="Toggle between split and unsplit sides of stack"),
    Key([mod],              "Return", lazy.spawn(guess_terminal()),       desc="Launch terminal"),
    Key([mod],              "Tab",    lazy.next_layout(),                 desc="Toggle between layouts"),
    Key([mod],              "w",      lazy.window.kill(),                 desc="Kill focused window"),
    Key([mod],              "f",      lazy.window.toggle_fullscreen(),    desc="Toggle fullscreen on the focused window"),
    Key([mod],              "t",      lazy.window.toggle_floating(),      desc="Toggle floating on the focused window"),
    Key([mod, "control"],   "r",      lazy.reload_config(),               desc="Reload the config"),
    Key([mod, "control"],   "q",      lazy.shutdown(),                    desc="Shutdown Qtile"),
    Key([mod],              "r",      lazy.spawncmd(),                    desc="Spawn a command using a prompt widget"),
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
        border_focus=colors["magenta"],
        border_focus_stack=colors["magenta"],
        border_normal=colors["fg_gutter"],
        border_normal_stack=colors["fg_gutter"],
        border_on_single=True,
        margin=4,
        margin_on_single=4,
    ),
    layout.Max(
        margin=4,
        border_width=2,
        border_focus=colors["magenta"],
        border_normal=colors["fg_gutter"],
    ),
]

###############################
# DEFAULTS                    #
###############################

widget_defaults = dict(
    font="CaskaydiaCove Nerd Font SemiBold",
    fontsize=12,
    padding=4,
    foreground=colors["fg"],
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
                # widget.Sep(
                #     foreground=colors["fg_gutter"],
                #     padding=10,
                #     linewidth=2,
                #     size_percent=80,
                # ),
                widget.GroupBox(
                    active=colors["fg_gutter"],
                    highlight_method="text",
                    rounded=False,
                    borderwidth=2,
                    this_current_screen_border=colors["magenta"],
                    hide_unused=True,
                    fmt="{}",
                ),
                widget.Sep(
                    foreground=colors["fg_gutter"],
                    padding=10,
                    linewidth=2,
                    size_percent=80,
                ),
                widget.WindowName(),
                widget.Prompt(),
                widget.Systray(),
                widget.Sep(
                    foreground=colors["fg_gutter"],
                    padding=10,
                    linewidth=2,
                    size_percent=80,
                ),
                widget.CPU(
                    format="  Cpu: {load_percent}%",
                    foreground=colors["orange"],
                    decorations=[
                        BorderDecoration(
                            colour=colors["orange"], border_width=[0, 0, 2, 0]
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.Memory(
                    format="{MemUsed: .0f}{mm}",
                    fmt="  Mem: {} used",
                    foreground=colors["cyan"],
                    decorations=[
                        BorderDecoration(
                            colour=colors["cyan"], border_width=[0, 0, 2, 0]
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.DF(
                    visible_on_warn=False,
                    partition="/",
                    format="{uf}{m} free",
                    fmt="  Disk: {}",
                    foreground=colors["yellow"],
                    decorations=[
                        BorderDecoration(
                            colour=colors["yellow"], border_width=[0, 0, 2, 0]
                        )
                    ],
                ),
                widget.Sep(
                    foreground=colors["fg_gutter"],
                    padding=10,
                    linewidth=2,
                    size_percent=80,
                ),
                widget.Bluetooth(
                    default_text=" {num_connected_devices}",
                    device_format="󰾰 {name}{battery_level} [{symbol}]",
                    adapter_format="󰠿 {name} [{powered}{discovery}]",
                    fmt="{}",
                    foreground=colors["blue"],
                    decorations=[
                        BorderDecoration(
                            colour=colors["blue"], border_width=[0, 0, 2, 0]
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.Volume(
                    step=1,
                    fmt="  {}",
                    foreground=colors["blue"],
                    decorations=[
                        BorderDecoration(
                            colour=colors["blue"], border_width=[0, 0, 2, 0]
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.KeyboardLayout(
                    fmt="󰌌 {}",
                    foreground=colors["blue"],
                    decorations=[
                        BorderDecoration(
                            colour=colors["blue"], border_width=[0, 0, 2, 0]
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.Wlan(
                    fmt="  {}",
                    format="{essid} {percent:2.0%}",
                    foreground=colors["blue"],
                    decorations=[
                        BorderDecoration(
                            colour=colors["blue"], border_width=[0, 0, 2, 0]
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.Clock(
                    format="  %a, %b %d - %H:%M",
                    foreground=colors["blue"],
                    decorations=[
                        BorderDecoration(
                            colour=colors["blue"], border_width=[0, 0, 2, 0]
                        )
                    ],
                ),
                # widget.Sep(
                #     foreground=colors["fg_gutter"],
                #     padding=10,
                #     linewidth=2,
                #     size_percent=80,
                # ),
                # widget.QuickExit(
                #     default_text="  Shutdown",
                #     countdown_format=" {} Seconds",
                #     fmt="{}",
                #     foreground=colors["red"],
                #     decorations=[
                #         BorderDecoration(
                #             colour=colors["red"], border_width=[0, 0, 2, 0]
                #         )
                #     ],
                # ),
                # widget.Sep(
                #     foreground=colors["fg_gutter"],
                #     padding=10,
                #     linewidth=2,
                #     size_percent=80,
                # ),
                widget.Spacer(length=8),
            ],
            32,
            margin=0,
            background=colors["bg"],
            # border_width=2,
            # border_color=colors["white"],
        ),
        wallpaper="~/.config/qtile/background.jpg",
        wallpaper_mode="stretch",
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

auto_fullscreen = False

focus_on_window_activation = "smart"

reconfigure_screens = True

auto_minimize = True

wmname = "LG3D"
