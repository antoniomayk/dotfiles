import os
import subprocess

from libqtile import hook

from group import groups, scrachtpads
from key import keys
from layout import floating_layout, layouts
from mouse import mouse
from screen import screen_0, screen_1
from widget import widget_defaults


@hook.subscribe.startup_once
def autostart():
    subprocess.call([os.path.expanduser("~/.config/qtile/autostart.sh")])


# fmt: off
mod                        = "mod4"
keys                       = keys(mod)
groups                     = groups(mod, keys) + scrachtpads(mod, keys)
mouse                      = mouse(mod)
layouts                    = layouts()
widget_defaults            = widget_defaults()
extension_defaults         = widget_defaults.copy()
screens                    = [screen_0(), screen_1()]
dgroups_key_binder         = None
dgroups_app_rules          = []
wl_input_rules             = None
wl_xcursor_theme           = None
wl_xcursor_size            = 24
cursor_warp                = False
floats_kept_above          = True
floating_layout            = floating_layout()
follow_mouse_focus         = False
bring_front_click          = False
auto_fullscreen            = True
focus_on_window_activation = "focus"
reconfigure_screens        = True
auto_minimize              = True
wmname                     = "LG3D"
