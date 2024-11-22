import os
import subprocess

from libqtile import bar
from libqtile.config import Screen
from libqtile.lazy import lazy
from qtile_extras import widget
from qtile_extras.popup.templates.mpris2 import DEFAULT_LAYOUT
from qtile_extras.widget.decorations import RectDecoration

from color import colors


def screen_0():
    return Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=2),
                widget.TextBox(
                    fmt="",
                    padding=8,
                    mouse_callbacks={
                        "Button1": lazy.spawn(
                            os.environ["HOME"] + "/.config/rofi/applets/bin/apps.sh"
                        ),
                    },
                    foreground=colors["widget"]["defaults"]["foreground"],
                    decorations=[
                        RectDecoration(
                            colour=colors["widget"]["defaults"]["background"],
                            radius=4,
                            filled=True,
                            padding_y=2,
                            group=True,
                            extrawidth=4,
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.GroupBox(
                    this_current_screen_border=colors["widget"]["group_box"][
                        "this_current_screen_border"
                    ],
                    active=colors["widget"]["group_box"]["active"],
                    inactive=colors["widget"]["group_box"]["inactive"],
                    highlight_method="block",
                    rounded=True,
                    margin_x=4,
                    padding=2,
                    hide_unused=True,
                    fmt="{}",
                    decorations=[
                        RectDecoration(
                            colour=colors["widget"]["group_box"]["background"],
                            radius=4,
                            filled=True,
                            padding_y=2,
                            group=True,
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.WindowCount(
                    fmt="  {} /",
                    foreground=colors["widget"]["defaults"]["background"],
                ),
                widget.WindowName(
                    max_chars=64,
                    foreground=colors["widget"]["defaults"]["background"],
                ),
                widget.Spacer(length=8),
                widget.WidgetBox(  # Systray
                    [
                        widget.Systray(
                            icon_size=16,
                            padding=16,
                            decorations=[
                                RectDecoration(
                                    colour=colors["widget"]["defaults"]["background"],
                                    radius=4,
                                    filled=True,
                                    padding_y=2,
                                    group=True,
                                    extrawidth=16,
                                )
                            ],
                        ),
                        widget.Spacer(length=8),
                    ],
                    close_button_location="right",
                    foreground=colors["widget"]["defaults"]["foreground"],
                    text_closed=" ",
                    text_open=" ",
                    decorations=[
                        RectDecoration(
                            colour=colors["widget"]["defaults"]["background"],
                            radius=4,
                            filled=True,
                            padding_y=2,
                            group=True,
                            extrawidth=10,
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.WidgetBox(  # Audio
                    [
                        widget.Mpris2(
                            poll_interval=1.0,
                            padding=8,
                            margin=8,
                            foreground=colors["widget"]["defaults"]["foreground"],
                            display_metadata=["xesam:title", "xesam:artist"],
                            fmt=" {} ",
                            paused_text=" {track}",
                            playing_text=" {track}",
                            max_chars=32,
                            no_metadata_text="Unknown",
                            scroll_chars=8,
                            popup_layout=DEFAULT_LAYOUT,
                            decorations=[
                                RectDecoration(
                                    colour=colors["widget"]["defaults"]["background"],
                                    radius=4,
                                    filled=True,
                                    padding_y=2,
                                    group=True,
                                )
                            ],
                        ),
                        widget.Spacer(length=8),
                        widget.Volume(
                            step=1,
                            fmt=" {} ",
                            mute_format=" ",
                            unmute_format="  {volume}%",
                            channel="Capture",
                            foreground=colors["widget"]["defaults"]["foreground"],
                            decorations=[
                                RectDecoration(
                                    colour=colors["widget"]["defaults"]["background"],
                                    radius=4,
                                    filled=True,
                                    padding_y=2,
                                    group=True,
                                )
                            ],
                        ),
                        widget.Spacer(length=8),
                        widget.Volume(
                            step=1,
                            fmt=" {} ",
                            mute_format=" ",
                            unmute_format="  {volume}%",
                            channel="Master",
                            foreground=colors["widget"]["defaults"]["foreground"],
                            decorations=[
                                RectDecoration(
                                    colour=colors["widget"]["defaults"]["background"],
                                    radius=4,
                                    filled=True,
                                    padding_y=2,
                                    group=True,
                                )
                            ],
                        ),
                        widget.Spacer(length=8),
                    ],
                    close_button_location="right",
                    foreground=colors["widget"]["defaults"]["foreground"],
                    text_closed=" ",
                    text_open=" ",
                    decorations=[
                        RectDecoration(
                            colour=colors["widget"]["defaults"]["background"],
                            radius=4,
                            filled=True,
                            padding_y=2,
                            group=True,
                            extrawidth=12,
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.WidgetBox(  # Connectivity
                    [
                        widget.Bluetooth(
                            default_text=" {num_connected_devices}",
                            device_format="󰾰 {name}{battery_level} [{symbol}]",
                            adapter_format="󰠿 {name} [{powered}{discovery}]",
                            fmt=" {} ",
                            foreground=colors["widget"]["defaults"]["foreground"],
                            decorations=[
                                RectDecoration(
                                    colour=colors["widget"]["defaults"]["background"],
                                    radius=4,
                                    filled=True,
                                    padding_y=2,
                                    group=True,
                                )
                            ],
                        ),
                        widget.Spacer(length=8),
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
                            fmt=" 󰖂  {} ",
                            foreground=colors["widget"]["defaults"]["foreground"],
                            decorations=[
                                RectDecoration(
                                    colour=colors["widget"]["defaults"]["background"],
                                    radius=4,
                                    filled=True,
                                    padding_y=2,
                                    group=True,
                                )
                            ],
                        ),
                        widget.Spacer(length=8),
                        widget.Wlan(
                            fmt="   {} ",
                            format="{essid} {percent:2.0%}",
                            foreground=colors["widget"]["defaults"]["foreground"],
                            decorations=[
                                RectDecoration(
                                    colour=colors["widget"]["defaults"]["background"],
                                    radius=4,
                                    filled=True,
                                    padding_y=2,
                                    group=True,
                                )
                            ],
                        ),
                        widget.Net(
                            fmt="/  {} ",
                            interface="wlan0",
                            foreground=colors["widget"]["defaults"]["foreground"],
                            decorations=[
                                RectDecoration(
                                    colour=colors["widget"]["defaults"]["background"],
                                    radius=4,
                                    filled=True,
                                    padding_y=2,
                                    group=True,
                                )
                            ],
                        ),
                        widget.Spacer(length=8),
                        widget.Net(
                            fmt=" {} ",
                            interface="enp3s0",
                            foreground=colors["widget"]["defaults"]["foreground"],
                            decorations=[
                                RectDecoration(
                                    colour=colors["widget"]["defaults"]["background"],
                                    radius=4,
                                    filled=True,
                                    padding_y=2,
                                    group=True,
                                )
                            ],
                        ),
                        widget.Spacer(length=8),
                    ],
                    foreground=colors["widget"]["defaults"]["foreground"],
                    close_button_location="right",
                    text_closed=" ",
                    text_open=" ",
                    decorations=[
                        RectDecoration(
                            colour=colors["widget"]["defaults"]["background"],
                            radius=4,
                            filled=True,
                            padding_y=2,
                            group=True,
                            extrawidth=14,
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.KeyboardLayout(
                    fmt=" 󰌌  {} ",
                    foreground=colors["widget"]["defaults"]["foreground"],
                    decorations=[
                        RectDecoration(
                            colour=colors["widget"]["defaults"]["background"],
                            radius=4,
                            filled=True,
                            padding_y=2,
                            group=True,
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.Clock(
                    foreground=colors["widget"]["defaults"]["foreground"],
                    fmt=" {} ",
                    format="  %A, %B %d, %Y %H:%M:%S",
                    decorations=[
                        RectDecoration(
                            colour=colors["widget"]["defaults"]["background"],
                            radius=4,
                            filled=True,
                            padding_y=2,
                            group=True,
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.TextBox(
                    fmt="",
                    padding=8,
                    mouse_callbacks={
                        "Button1": lazy.spawn(
                            os.environ["HOME"]
                            + "/.config/rofi/applets/bin/powermenu.sh"
                        ),
                    },
                    foreground=colors["widget"]["defaults"]["foreground"],
                    decorations=[
                        RectDecoration(
                            colour=colors["widget"]["defaults"]["background"],
                            radius=4,
                            filled=True,
                            padding_y=2,
                            group=True,
                            extrawidth=4,
                        )
                    ],
                ),
                widget.Spacer(length=2),
            ],
            32,
            margin=[8, 8, 0, 8],
            background=colors["screen"]["background"],
            border_width=4,
            border_color=colors["screen"]["border"],
        ),
    )


def screen_1():
    return Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=2),
                widget.TextBox(
                    fmt="",
                    padding=8,
                    mouse_callbacks={
                        "Button1": lazy.spawn(
                            os.environ["HOME"] + "/.config/rofi/applets/bin/apps.sh"
                        ),
                    },
                    foreground=colors["widget"]["defaults"]["foreground"],
                    decorations=[
                        RectDecoration(
                            colour=colors["widget"]["defaults"]["background"],
                            radius=4,
                            filled=True,
                            padding_y=2,
                            group=True,
                            extrawidth=4,
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.GroupBox(
                    this_current_screen_border=colors["widget"]["group_box"][
                        "this_current_screen_border"
                    ],
                    active=colors["widget"]["group_box"]["active"],
                    inactive=colors["widget"]["group_box"]["inactive"],
                    highlight_method="block",
                    rounded=True,
                    margin_x=4,
                    padding=2,
                    hide_unused=True,
                    fmt="{}",
                    decorations=[
                        RectDecoration(
                            colour=colors["widget"]["group_box"]["background"],
                            radius=4,
                            filled=True,
                            padding_y=2,
                            group=True,
                        )
                    ],
                ),
                widget.Spacer(length=8),
                widget.WindowCount(
                    fmt="  {} /",
                    foreground=colors["widget"]["defaults"]["background"],
                ),
                widget.WindowName(
                    max_chars=64,
                    foreground=colors["widget"]["defaults"]["background"],
                ),
                widget.Spacer(length=8),
                widget.TextBox(
                    fmt="",
                    padding=8,
                    mouse_callbacks={
                        "Button1": lazy.spawn(
                            os.environ["HOME"]
                            + "/.config/rofi/applets/bin/powermenu.sh"
                        ),
                    },
                    foreground=colors["widget"]["defaults"]["foreground"],
                    decorations=[
                        RectDecoration(
                            colour=colors["widget"]["defaults"]["background"],
                            radius=4,
                            filled=True,
                            padding_y=2,
                            group=True,
                            extrawidth=4,
                        )
                    ],
                ),
                widget.Spacer(length=2),
            ],
            32,
            margin=[8, 8, 0, 8],
            background=colors["screen"]["background"],
            border_width=4,
            border_color=colors["screen"]["border"],
        ),
    )

