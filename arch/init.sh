#!/bin/bash

###########################################################
# FUNCTIONS
###########################################################

has_command() {
	command -v "$1" >/dev/null 2>&1
}

is_nvidia() {
	lspci | grep -I "NVIDIA" >/dev/null 2>&1
}

###########################################################
# PKGs
###########################################################

WIRELES="iw"
VPN="nordvpn-bin"
SCREEN_LOCKER="light-locker"
PAINT="krita inkscape"
COMMUNICATION="discord"
MUSIC_PLAYER="sox ncmpcpp youtube-music-bin"
SOUND="alsa-utils pulsemixer playerctl mpc ffmpeg"
IMAGE_VIEWER="feh viewnior"
SCREENSHOT="flameshot maim"
READER="zathura zathura-pdf-mupdf"
DOCS="man man-pages tldr obsidian"
NOTIFICATIONS="dunst"
UTILITIES="bat bottom eza fd ripgrep xclip xdg-user-dirs trash-cli neofetch lsb-release fzf zoxide tree tree-sitter-cli xdotool xorg-xrandr arandr unrar unzip zip"
TERMINAL="alacritty ueberzug tmux tmux-plugin-manager"
FILE_EXPLORER="ranger thunar tumbler ffmpegthumbnailer"
BROWSER="vivaldi zen-browser-bin"
CPP="clang cmake ninja ccache"
JAVA="jdk17-openjdk jdk21-openjdk gradle maven"
SCALA="sbt scalafmt bloop"
TYPESCRIPT="npm deno"
ZIP="zip zls"
SCM="git git-lfs lazygit"
VIRTUALIZATION="docker docker-compose lazydocker"
SHELLS="fish nix"
FONTS="ttf-jetbrains-mono-nerd ttf-liberation ttf-monaco ttf-droid noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra"
QTILE="qtile qtile-extras-git"
QTILE_COMPOSITOR="picom"
QTILE_DEPEDENCIES="python-iwlib python-dbus-next python-psutil"
GTK="lxappearance-gtk3"
ICONS="papirus-icon-theme"
THEMES="yaru-colors-gtk-theme"
WALLPAPERS="nitrogen"
SYS_MONITOR="conky"
BLUETOOTH="bluez bluez-utils bluetui"
NVIDIA="nvidia nvidia-utils nvidia-settings cuda-tools mesa-utils"

###########################################################
# PIKAUR
###########################################################

if ! has_command pikaur; then
	cd "$(mktemp -d)" &&
		sudo pacman -S --needed base-devel git &&
		git clone 'https://aur.archlinux.org/pikaur.git' &&
		cd pikaur &&
		makepkg -fsri &&
		cd "$HOME"
fi

pikaur -S --needed $WIRELES $VPN $SCREEN_LOCKER $PAINT $COMMUNICATION $MUSIC_PLAYER $SOUND $IMAGE_VIEWER $SCREENSHOT $READER $DOCS $NOTIFICATIONS $UTILITIES $TERMINAL $FILE_EXPLORER $BROWSER $CPP $JAVA $SCALA $TYPESCRIPT $ZIP $SCM $VIRTUALIZATION $SHELLS $FONTS $QTILE $QTILE_COMPOSITOR $QTILE_DEPEDENCIES $GTK $ICONS $THEMES $WALLPAPERS $SYS_MONITOR $BLUETOOTH $NVIDIA

###########################################################
# USERMOD & GROUPADD
###########################################################

sudo groupadd -r nordvpn
sudo gpasswd -a "$USER" nordvpn
sudo usermod -aG nordvpn "$USER"

sudo usermod -aG docker "$USER"

sudo usermod -aG nix-users "$USER"

###########################################################
# SERVICES
###########################################################

sudo systemctl enable iwd
sudo systemctl start iwd

sudo systemctl enable nordvpnd
sudo systemctl start nordvpnd

sudo systemctl enable docker
sudo systemctl start docker

sudo systemctl enable nix-daemon
sudo systemctl start nix-daemon

sudo systemctl enable bluetooth
sudo systemctl start bluetooth

###########################################################
# NIX
###########################################################

nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update

###########################################################
# NVIDIA
###########################################################

if is_nvidia; then
	sudo mkinitcpio -p linux
	echo "set -Ux LD_LIBRARY_PATH /opt/cuda/lib64" | fish -c "source -"
	echo "fish_add_path /opt/cuda/bin" | fish -c "source -"
fi

###########################################################
# ALIASES
###########################################################

echo "$(
	cat <<-EOF
		alias -s b   "bat"
		alias -s l   "eza"
		alias -s la  "eza -a"
		alias -s ll  "eza -l"
		alias -s lla "eza -la"
		alias -s r   "rm -r"
		alias -s rf  "rm -rf"
		alias -s clear   "clear && rm $HOME/.bash_history && builtin history clear && history -c && printf '\033[2J\033[3J\033[1;1H'"
	EOF
)" | fish -c "source -"

###########################################################
# COLORS
###########################################################

echo "$(
	cat <<-EOF
		set -U fish_color_autosuggestion brblack
		set -U fish_color_cancel -r
		set -U fish_color_command brgreen
		set -U fish_color_comment brmagenta
		set -U fish_color_cwd green
		set -U fish_color_cwd_root red
		set -U fish_color_end brmagenta
		set -U fish_color_error brred
		set -U fish_color_escape brcyan
		set -U fish_color_history_current --bold
		set -U fish_color_host normal
		set -U fish_color_match --background=brblue
		set -U fish_color_normal normal
		set -U fish_color_operator cyan
		set -U fish_color_param brblue
		set -U fish_color_quote yellow
		set -U fish_color_redirection bryellow
		set -U fish_color_search_match bryellow --background=brblack
		set -U fish_color_selection white --bold --background=brblack
		set -U fish_color_status red
		set -U fish_color_user brgreen
		set -U fish_color_valid_path --underline
		set -U fish_pager_color_completion normal
		set -U fish_pager_color_description yellow
		set -U fish_pager_color_prefix white --bold --underline
		set -U fish_pager_color_progress brwhite --background=cyan
	EOF
)" | fish -c "source -"

#------------------------------------------------------------
# CREATE CONFIG FOLDERS
#------------------------------------------------------------

rm -rf "$HOME/.config/tmux" && ln -s "$HOME/Projects/dotfiles/tmux" "$HOME/.config/tmux"
rm -rf "$HOME/.config/nvim" && ln -s "$HOME/Projects/dotfiles/nvim" "$HOME/.config/nvim"
rm -rf "$HOME/.config/bottom" && ln -s "$HOME/Projects/dotfiles/bottom" "$HOME/.config/bottom"
rm -rf "$HOME/.config/bat" && ln -s "$HOME/Projects/dotfiles/bat" "$HOME/.config/bat"
rm -rf "$HOME/.config/alacritty" && ln -s "$HOME/Projects/dotfiles/alacritty" "$HOME/.config/alacritty"
rm -rf "$HOME/.config/qtile" && ln -s "$HOME/Projects/dotfiles/qtile" "$HOME/.config/qtile"
rm -rf "$HOME/.config/picom" && ln -s "$HOME/Projects/dotfiles/picom" "$HOME/.config/picom"
rm -rf "$HOME/.config/conky" && ln -s "$HOME/Projects/dotfiles/conky" "$HOME/.config/conky"
rm -rf "$HOME/.config/rofi" && ln -s "$HOME/Projects/dotfiles/rofi" "$HOME/.config/rofi"
rm -rf "$HOME/.config/dunst" && ln -s "$HOME/Projects/dotfiles/dunst" "$HOME/.config/dunst"
