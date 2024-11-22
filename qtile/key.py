import os

from libqtile.config import Key
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from helper import decrease_master_volume, increase_master_volume, toggle_master_volume


# fmt: off
def keys(mod):
    return [
        Key([mod],              "h",                    lazy.layout.left(),                                                                     desc="Move focus to left"),
        Key([mod],              "l",                    lazy.layout.right(),                                                                    desc="Move focus to right"),
        Key([mod],              "j",                    lazy.layout.down(),                                                                     desc="Move focus down"),
        Key([mod],              "k",                    lazy.layout.up(),                                                                       desc="Move focus up"),
        Key([mod],              "space",                lazy.layout.next(),                                                                     desc="Move window focus to other window"),
        Key([mod, "shift"],     "h",                    lazy.layout.shuffle_left(),                                                             desc="Move window to the left"),
        Key([mod, "shift"],     "l",                    lazy.layout.shuffle_right(),                                                            desc="Move window to the right"),
        Key([mod, "shift"],     "j",                    lazy.layout.shuffle_down(),                                                             desc="Move window down"),
        Key([mod, "shift"],     "k",                    lazy.layout.shuffle_up(),                                                               desc="Move window up"),
        Key([mod, "control"],   "h",                    lazy.layout.grow_left(),                                                                desc="Grow window to the left"),
        Key([mod, "control"],   "l",                    lazy.layout.grow_right(),                                                               desc="Grow window to the right"),
        Key([mod, "control"],   "j",                    lazy.layout.grow_down(),                                                                desc="Grow window down"),
        Key([mod, "control"],   "k",                    lazy.layout.grow_up(),                                                                  desc="Grow window up"),
        Key([mod],              "n",                    lazy.layout.normalize(),                                                                desc="Reset all window sizes"),
        Key([mod, "shift"],     "Return",               lazy.layout.toggle_split(),                                                             desc="Toggle between split and unsplit sides of stack"),
        Key([mod],              "Return",               lazy.spawn(guess_terminal()),                                                           desc="Launch terminal"),
        Key([mod],              "Tab",                  lazy.next_layout(),                                                                     desc="Toggle between layouts"),
        Key([mod],              "w",                    lazy.window.kill(),                                                                     desc="Kill focused window"),
        Key([mod],              "f",                    lazy.window.toggle_fullscreen(),                                                        desc="Toggle fullscreen on the focused window"),
        Key([mod],              "t",                    lazy.window.toggle_floating(),                                                          desc="Toggle floating on the focused window"),
        Key([mod, "control"],   "r",                    lazy.reload_config(),                                                                   desc="Reload the config"),
        Key([mod],              "q",                    lazy.spawn(os.environ['HOME'] + "/.config/rofi/applets/bin/web_search.sh"),             desc="Web Search"),
        Key([mod, "control"],   "q",                    lazy.spawn(os.environ['HOME'] + "/.config/rofi/applets/bin/powermenu.sh"),              desc="Shutdown Qtile"),
        Key([mod, "control"],   "slash",                lazy.hide_show_bar(),                                                                   desc="Hides the bar"),
        Key([mod, "control"],   "backslash",            lazy.spawn("light-locker-command -l"),                                                  desc="Light Locker"),
        Key([mod],              "r",                    lazy.spawn(os.environ['HOME'] + "/.config/rofi/launchers/type-1/launcher.sh"),          desc="Spawn a command using a prompt widget"),
        Key([mod],              "e",                    lazy.spawn("thunar"),                                                                   desc="Launch [E]xplorer"),
        Key([mod],              "b",                    lazy.spawn("vivaldi"),                                                                  desc="Launch [B]rowser"),
        Key([mod],              "d",                    lazy.spawn("discord"),                                                                  desc="Launch [D]iscord"),
        Key([mod],              "o",                    lazy.spawn("obs"),                                                                      desc="Launch [O]BS"),
        Key([mod],              "s",                    lazy.spawn("obsidian"),                                                                 desc="Launch Obsi[d]ian"),
        Key([mod],              "i",                    lazy.spawn("insomnia"),                                                                 desc="Launch [I]nsomnia"),
        Key([mod],              "y",                    lazy.spawn("youtube-music"),                                                            desc="Launch [Y]outube Music"),
        Key([],                 "XF86AudioLowerVolume", decrease_master_volume,                                                                 desc="Lower Volume by 5%"),
        Key([],                 "XF86AudioRaiseVolume", increase_master_volume,                                                                 desc="Raise Volume by 5%"),
        Key([],                 "XF86AudioMute",        toggle_master_volume,                                                                   desc="Mute/Unmute Volume"),
        Key([],                 "XF86AudioPlay",        lazy.spawn("playerctl play-pause"),                                                     desc="Play/Pause player"),
        Key([],                 "XF86AudioNext",        lazy.spawn("playerctl next"),                                                           desc="Skip to next"),
        Key([],                 "XF86AudioPrev",        lazy.spawn("playerctl previous"),                                                       desc="Skip to previous"),
        Key([],                 "Print",                lazy.spawn(os.environ['HOME'] + "/.config/rofi/applets/bin/screenshot.sh"),             desc="Print Screen"),
    ]
# fmt: on
