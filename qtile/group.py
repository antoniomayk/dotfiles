from libqtile.config import DropDown, Group, Key, ScratchPad
from libqtile.lazy import lazy


def groups(mod, keys):
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

    return groups


# fmt: off
def scrachtpads(mod, keys):
    keys.extend([
        Key([mod, "control"], "Return", lazy.group["scratchpad"].dropdown_toggle("alacritty")),
        Key([mod, "control"], "p",      lazy.group["scratchpad"].dropdown_toggle("pulsemixer")),
        Key([mod, "control"], "m",      lazy.group["scratchpad"].dropdown_toggle("btm")),
        Key([mod, "control"], "e",      lazy.group["scratchpad"].dropdown_toggle("ranger")),
        Key([mod, "control"], "u",      lazy.group["scratchpad"].dropdown_toggle("bluetui")),
        Key([mod, "control"], "v",      lazy.group["scratchpad"].dropdown_toggle("nvim")),
    ])

    return [
        ScratchPad(
            "scratchpad",
            [
                DropDown("alacritty",  "alacritty",               y=0.1, width=0.8, height=0.8, opacity=1.0, on_focus_lost_hide=True),
                DropDown("pulsemixer", "alacritty -e pulsemixer", y=0.1, width=0.8, height=0.8, opacity=1.0, on_focus_lost_hide=True),
                DropDown("btm",        "alacritty -e btm",        y=0.1, width=0.8, height=0.8, opacity=1.0, on_focus_lost_hide=True),
                DropDown("ranger",     "alacritty -e ranger",     y=0.1, width=0.8, height=0.8, opacity=1.0, on_focus_lost_hide=True),
                DropDown("bluetui",    "alacritty -e bluetui",    y=0.1, width=0.8, height=0.8, opacity=1.0, on_focus_lost_hide=True),
                DropDown("nvim",       "alacritty -e nvim",       y=0.1, width=0.8, height=0.8, opacity=1.0, on_focus_lost_hide=True),
            ],
        )
    ]
# fmt: on
