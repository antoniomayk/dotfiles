import subprocess

from libqtile.lazy import lazy


@lazy.function
def increase_master_volume(qtile):
    subprocess.run(["amixer", "sset", "Master", "5%+"])
    volume = (
        subprocess.check_output(
            "amixer get Master | grep -o -m 1 '[0-9]\\+%' | tr -d '%'", shell=True
        )
        .decode("utf-8")
        .strip()
    )

    subprocess.run(["notify-send", f"[Master]: {volume}%"])


@lazy.function
def decrease_master_volume(qtile):
    subprocess.run(["amixer", "sset", "Master", "5%-"])
    volume = (
        subprocess.check_output(
            "amixer get Master | grep -o -m 1 '[0-9]\\+%' | tr -d '%'", shell=True
        )
        .decode("utf-8")
        .strip()
    )
    subprocess.run(["notify-send", f"[Master]: {volume}%"])


@lazy.function
def toggle_master_volume(qtile):
    subprocess.run(["amixer", "sset", "Master", "1+", "toggle"])
    volume = (
        subprocess.check_output(
            "amixer sget Master | grep -o '\[on\]\|\[off\]' | head -1", shell=True
        )
        .decode("utf-8")
        .strip()
    )
    subprocess.run(["notify-send", f"[Master]: {volume}"])
