#!/usr/bin/env bash

###########################################################
# NETWORK
###########################################################

echo -e "$(
	cat <<-EOF
		# This file describes the network interfaces available on your system\n
		# and how to activate them. For more information, see interfaces(5).\n

		source /etc/network/interfaces.d/*
	EOF
)" | sudo tee /etc/network/interfaces

###########################################################
# REPOSITORIES
###########################################################

sudo apt install curl gnupg nala

echo -e "$(
	cat <<-EOF
		deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware\n
		deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware\n

		deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware\n
		deb-src http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware\n

		deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware\n
		deb-src http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware\n

		deb http://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware\n
		deb-src http://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware\n
	EOF
)" | sudo tee /etc/apt/sources.list

echo 'deb http://packages.linuxmint.com faye main upstream import backport' | sudo tee /etc/apt/sources.list.d/linuxmint.list
curl -fsSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xA6616109451BBBF2' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/linuxmint.gpg >/dev/null

echo 'deb https://packages.adoptium.net/artifactory/deb bookworm main' | sudo tee /etc/apt/sources.list.d/adoptium.list
curl -fsSL 'https://packages.adoptium.net/artifactory/api/gpg/key/public' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg >/dev/null

echo 'deb http://download.opensuse.org/repositories/home:/justkidding/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/home:justkidding.list
curl -fsSL 'https://download.opensuse.org/repositories/home:justkidding/Debian_12/Release.key' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_justkidding.gpg >/dev/null

echo 'deb https://download.vscodium.com/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
curl -fsSL 'https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg >/dev/null

sudo apt update

###########################################################
# PKGs
###########################################################

BROWSER='firefox'
CLI='dconf-cli gettext bat fd-find exa xclip trash-cli neofetch fzf zoxide tree unrar unzip zip curl wget'
CONTAINERIZATION='docker docker-compose'
CPP='build-essential clang cmake ninja-build ccache'
DOCS='tldr man-db scdoc'
EDITORS='codium sublime-text'
FONTS='fonts-liberation fonts-jetbrains-mono fonts-firacode fonts-droid-fallback fonts-noto fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji fonts-noto-extra'
GREETER='lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings'
ICONS='papirus-icon-theme mint-l-icons'
IMAGE='pix xviewer'
JAVA='temurin-8-jdk temurin-17-jdk temurin-21-jdk gradle maven'
JAVASCRIPT='npm'
PAINT='drawing'
PYTHON='python3-venv'
READER='xreader'
SCM='git git-lfs'
SHELLS='fish'
TERMINAL="alacritty ueberzugpp tmux tmux-plugin-manager"
THEMES_CURSOR='mint-cursor-themes'
THEMES_GTK='mint-l-theme'
TUI='ranger'
VIDEO='xplayer celluloid'
WALLPAPERS='mint-backgrounds-vanessa mint-backgrounds-vera mint-backgrounds-victoria mint-backgrounds-wilma'
WINDOW_MANAGER='cinnamon'

###########################################################
# APT
###########################################################

sudo apt install $BROWSER $CLI $CONTAINERIZATI $CPP $DOCS $EDITORS $GREETER $ICONS $IMAGE $JAVA $JAVASCRIPT $PAINT $PYTHON $READER $SCM $SHELLS $TERMINAL $THEMES_CURSOR $THEMES_GTK $TUI $VIDEO $WALLPAPERS $WINDOW_MANAGER

sudo apt remove zutty

###########################################################
# CUSTOM SCRIPTS
###########################################################

CWD=$(pwd)

bash $CWD/bottom.sh
bash $CWD/jetbrains_mono.sh
bash $CWD/lazydocker.sh
bash $CWD/lazygit.sh
bash $CWD/neovim.sh
bash $CWD/ripgrep.sh

cd $(pwd)

###########################################################
# CINNAMON
###########################################################

sudo update-alternatives --install /usr/bin/xterm xterm /usr/bin/alacritty 50

dconf write /org/cinnamon/theme/name "'Mint-L-Dark-Grey'"
dconf write /org/cinnamon/desktop/interface/gtk-theme "'Mint-L-Dark-Grey'"
dconf write /org/cinnamon/desktop/interface/icon-theme "'Papirus-Dark'"
dconf write /org/cinnamon/desktop/interface/cursor-theme "'Bibata-Modern-Classic'"
dconf write /org/cinnamon/desktop/interface/font-name "'JetBrainsMono Nerd Font Medium 10'"
dconf write /org/cinnamon/desktop/wm/preferences/titlebar-font "'JetBrainsMono Nerd Font Medium 10'"
dconf write /org/cinnamon/desktop/wm/preferences/theme "'Mint-L-Dark-Grey'"

dconf write /x/dm/slick-greeter/cursor-theme-name "'Bibata-Modern-Classic'"
dconf write /x/dm/slick-greeter/icon-theme-name "'Mint-L-Dark-Grey'"
dconf write /x/dm/slick-greeter/theme-name "'Mint-L-Dark-Grey'"
dconf write /x/dm/slick-greeter/font-name "'JetBrainsMono Nerd Font Medium 10'"

dconf write /org/gnome/desktop/interface/font-name "'JetBrainsMono Nerd Font Medium 10'"
dconf write /org/gnome/desktop/interface/document-font-name "'JetBrainsMono Nerd Font Medium 10'"
dconf write /org/gnome/desktop/interface/monospace-font-name "'JetBrainsMono Nerd Font Medium 10'"

dconf write /org/nemo/desktop/font "'JetBrainsMono Nerd Font Medium 10'"

dconf write /org/x/apps/portal/color-scheme "'prefer-dark'"

dconf write /org/cinnamon/hotcorner-layout "['expo:true:0', 'scale:true:0', 'scale:false:0', 'desktop:true:0']"

dconf write /org/cinnamon/desktop/background/picture-uri "'file:///usr/share/backgrounds/linuxmint-wilma/meiying_body_of_water.jpg'"
dconf write /org/cinnamon/enabled-applets "['panel1:left:0:menu@cinnamon.org:0', 'panel1:left:1:separator@cinnamon.org:1', 'panel1:left:3:grouped-window-list@cinnamon.org:2', 'panel1:right:1:systray@cinnamon.org:3', 'panel1:right:2:xapp-status@cinnamon.org:4', 'panel1:right:3:notifications@cinnamon.org:5', 'panel1:right:4:printers@cinnamon.org:6', 'panel1:right:6:keyboard@cinnamon.org:8', 'panel1:right:7:favorites@cinnamon.org:9', 'panel1:right:8:network@cinnamon.org:10', 'panel1:right:9:sound@cinnamon.org:11', 'panel1:right:10:power@cinnamon.org:12', 'panel1:right:11:calendar@cinnamon.org:13', 'panel1:right:12:cornerbar@cinnamon.org:14', 'panel1:left:2:workspace-switcher@cinnamon.org:15']"

cinnamon --replace >/dev/null 2>&1 &
disown

###########################################################
# LIGHTDM
###########################################################

echo -e "$(
	cat <<-EOF
		[greeter]\n
		background = /usr/share/backgrounds/linuxmint-wilma/meiying_body_of_water.jpg\n
		theme-name = Mint-L-Dark-Grey\n
		icon-theme-name = Papirus-Light\n
		font-name = JetBrainsMono Nerd Font Medium 10
	EOF
)" | sudo tee /etc/lightdm/lightdm-gtk-greeter.conf

###########################################################
# ALIASES
###########################################################

echo "$(
	cat <<-EOF
		alias -s b   "bat"
		alias -s l   "eza"
		alias -s la  "exa -a"
		alias -s ll  "exa -l"
		alias -s lla "exa -la"
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

rm -rf "$HOME/.config/bat" && ln -s "$HOME/Projects/dotfiles/bat" "$HOME/.config/bat"
rm -rf "$HOME/.config/alacritty" && ln -s "$HOME/Projects/dotfiles/alacritty" "$HOME/.config/alacritty"
rm -rf "$HOME/.config/nvim" && ln -s "$HOME/Projects/dotfiles/nvim" "$HOME/.config/nvim"
rm -rf "$HOME/.config/tmux" && ln -s "$HOME/Projects/dotfiles/tmux" "$HOME/.config/tmux"
