# fmt: off
palette = {
    "catppuccin": {
        "latte": {
            "rosewater"     : "#6F6F6F",
            "flamingo"      : "#6F6F6F",
            "pink"          : "#6D6D6D",
            "mauve"         : "#1D1D1D",
            "red"           : "#000000",
            "maroon"        : "#2C2C2C",
            "peach"         : "#000000",
            "yellow"        : "#000000",
            "green"         : "#0A0A0A",
            "teal"          : "#000000",
            "sky"           : "#000000",
            "sapphire"      : "#000000",
            "blue"          : "#000000",
            "lavender"      : "#676767",
            "text"          : "#363636",
            "subtext_1"     : "#4B4B4B",
            "subtext_0"     : "#5F5F5F",
            "overlay_2"     : "#747474",
            "overlay_1"     : "#898989",
            "overlay_0"     : "#9E9E9E",
            "surface_2"     : "#B3B3B3",
            "surface_1"     : "#C8C8C8",
            "surface_0"     : "#DDDDDD",
            "base"          : "#FFFFFF",
            "mantle"        : "#FFFFFF",
            "crust"         : "#F2F2F2",
        },
        "frappe": {
            "rosewater"    : "#E1E1E1",
            "flamingo"     : "#CBCBCB",
            "pink"         : "#C3C3C3",
            "mauve"        : "#A1A1A1",
            "red"          : "#7C7C7C",
            "maroon"       : "#9A9A9A",
            "peach"        : "#6D6D6D",
            "yellow"       : "#8F8F8F",
            "green"        : "#858585",
            "teal"         : "#7B7B7B",
            "sky"          : "#9A9A9A",
            "sapphire"     : "#808080",
            "blue"         : "#898989",
            "lavender"     : "#C5C5C5",
            "text"         : "#D5D5D5",
            "subtext_1"    : "#BFBFBF",
            "subtext_0"    : "#AAAAAA",
            "overlay_2"    : "#949494",
            "overlay_1"    : "#7E7E7E",
            "overlay_0"    : "#696969",
            "surface_2"    : "#525252",
            "surface_1"    : "#3C3C3C",
            "surface_0"    : "#272727",
            "base"         : "#111111",
            "mantle"       : "#080808",
            "crust"        : "#000000",
        },
        "macchiato": {
            "rosewater" : "#EAEAEA",
            "flamingo"  : "#D5D5D5",
            "pink"      : "#C9C9C9",
            "mauve"     : "#A3A3A3",
            "red"       : "#838383",
            "maroon"    : "#9A9A9A",
            "peach"     : "#787878",
            "yellow"    : "#A2A2A2",
            "green"     : "#959595",
            "teal"      : "#888888",
            "sky"       : "#909090",
            "sapphire"  : "#767676",
            "blue"      : "#878787",
            "lavender"  : "#C2C2C2",
            "text"      : "#DADADA",
            "subtext_1" : "#C3C3C3",
            "subtext_0" : "#AAAAAA",
            "overlay_2" : "#929292",
            "overlay_1" : "#7A7A7A",
            "overlay_0" : "#626262",
            "surface_2" : "#494949",
            "surface_1" : "#323232",
            "surface_0" : "#191919",
            "base"      : "#010101",
            "mantle"    : "#000000",
            "crust"     : "#000000",
        },
        "mocha": {
            "rosewater"     : "#F2F2F2",
            "flamingo"      : "#DEDEDE",
            "pink"          : "#D0D0D0",
            "mauve"         : "#ABABAB",
            "red"           : "#888888",
            "maroon"        : "#A3A3A3",
            "peach"         : "#838383",
            "yellow"        : "#B7B7B7",
            "green"         : "#A5A5A5",
            "teal"          : "#949494",
            "sky"           : "#858585",
            "sapphire"      : "#6A6A6A",
            "blue"          : "#858585",
            "lavender"      : "#BEBEBE",
            "text"          : "#DEDEDE",
            "subtext_1"     : "#C5C5C5",
            "subtext_0"     : "#ABABAB",
            "overlay_2"     : "#929292",
            "overlay_1"     : "#787878",
            "overlay_0"     : "#5F5F5F",
            "surface_2"     : "#454545",
            "surface_1"     : "#2C2C2C",
            "surface_0"     : "#121212",
            "base"          : "#000000",
            "mantle"        : "#000000",
            "crust"         : "#000000",
        },
    },
}
# fmt: on


def light_theme(name: str):
    return {
        "catppuccin": {
            "layouts": {
                "border_focus": palette["catppuccin"][name]["overlay_0"],
                "border_normal": palette["catppuccin"][name]["overlay_2"],
            },
            "screen": {
                "background": palette["catppuccin"][name]["base"],
                "border": palette["catppuccin"][name]["base"],
            },
            "widget": {
                "defaults": {
                    "background": palette["catppuccin"][name]["mauve"],
                    "foreground": palette["catppuccin"][name]["base"],
                },
                "group_box": {
                    "this_current_screen_border": palette["catppuccin"][name][
                        "subtext_0"
                    ],
                    "active": palette["catppuccin"][name]["base"],
                    "inactive": palette["catppuccin"][name]["surface_2"],
                    "background": palette["catppuccin"][name]["mauve"],
                },
            },
        },
    }


def dark_theme(name: str):
    return {
        "catppuccin": {
            "layouts": {
                "border_focus": palette["catppuccin"][name]["overlay_2"],
                "border_normal": palette["catppuccin"][name]["overlay_0"],
            },
            "screen": {
                "background": palette["catppuccin"][name]["base"],
                "border": palette["catppuccin"][name]["base"],
            },
            "widget": {
                "defaults": {
                    "background": palette["catppuccin"][name]["rosewater"],
                    "foreground": palette["catppuccin"][name]["base"],
                },
                "group_box": {
                    "this_current_screen_border": palette["catppuccin"][name][
                        "subtext_1"
                    ],
                    "active": palette["catppuccin"][name]["base"],
                    "inactive": palette["catppuccin"][name]["overlay_1"],
                    "background": palette["catppuccin"][name]["rosewater"],
                },
            },
        },
    }


colors = light_theme("latte")["catppuccin"]
