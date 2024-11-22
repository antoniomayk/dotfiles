from libqtile import layout
from libqtile.config import Match

from color import colors


def layouts():
    return [
        layout.Max(
            margin=8,
            border_width=0,
            border_focus=colors["layouts"]["border_focus"],
            border_normal=colors["layouts"]["border_normal"],
        ),
        layout.Columns(
            border_width=4,
            border_focus=colors["layouts"]["border_focus"],
            border_focus_stack=colors["layouts"]["border_focus"],
            border_normal=colors["layouts"]["border_normal"],
            border_normal_stack=colors["layouts"]["border_normal"],
            border_on_single=True,
            margin=8,
            margin_on_single=8,
        ),
    ]


def floating_layout():
    return layout.Floating(
        border_width=4,
        border_focus=colors["layouts"]["border_focus"],
        border_normal=colors["layouts"]["border_normal"],
        float_rules=[
            # Run the utility of `xprop` to see the wm class and name of an X client.
            *layout.Floating.default_float_rules,
            Match(wm_class="confirmreset"),  # gitk
            Match(wm_class="makebranch"),  # gitk
            Match(wm_class="maketag"),  # gitk
            Match(wm_class="ssh-askpass"),  # ssh-askpass
            Match(title="branchdialog"),  # gitk
            Match(title="pinentry"),  # GPG key password entry
        ],
    )
