#!/usr/bin/env bash

###########################################################
# HELPERS
###########################################################

SOURCE=${BASH_SOURCE[0]}

while [ -L "$SOURCE" ]; do
	DIR=$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)
	SOURCE=$(readlink "$SOURCE")
	[[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE
done

DIR=$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)

###########################################################
# NETWORK
###########################################################

echo -e "\e[32mConfiguring network...\e[0m"

echo -e "$(
	cat <<-EOF
		# This file describes the network interfaces available on your system
		# and how to activate them. For more information, see interfaces(5).

		source /etc/network/interfaces.d/*
	EOF
)" | sudo tee /etc/network/interfaces &>/dev/null

###########################################################
# REPOSITORIES
###########################################################

export DEBIAN_FRONTEND=noninteractive

echo -e "\e[32mInstalling (nala curl gnupg fasttrack-archive-keyring)\e[0m"

sudo apt install -y nala curl gnupg fasttrack-archive-keyring &>/dev/null

echo -e "\e[32mAdding new deb sources\e[0m"

echo -e "$(
	cat <<-EOF
		deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
		deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

		deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
		deb-src http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware

		deb http://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware
		deb-src http://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware

		deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware
		deb-src http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware

		deb https://fasttrack.debian.net/debian-fasttrack/ bookworm-fasttrack main contrib
		deb https://fasttrack.debian.net/debian-fasttrack/ bookworm-backports-staging main contrib
	EOF
)" | sudo tee /etc/apt/sources.list

echo -e "\e[32mDownloading & installing keyrings\e[0m"

echo 'deb http://ppa.launchpad.net/papirus/papirus/ubuntu jammy main' | sudo tee /etc/apt/sources.list.d/papirus-ppa.list
curl -fsSL 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9461999446FAF0DF770BFC9AE58A9D36647CAE7F' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/papirus-ppa.gpg >/dev/null

echo 'deb https://brave-browser-apt-release.s3.brave.com/ stable main' | sudo tee /etc/apt/sources.list.d/brave-browser.list
curl -fsSL 'https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/brave-browser-keyring.gpg >/dev/null

curl -fsSL 'https://repo.nordvpn.com/gpg/nordvpn_public.asc' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/nordvpn.gpg >/dev/null
echo 'deb https://repo.nordvpn.com/deb/nordvpn/debian stable main' | sudo tee /etc/apt/sources.list.d/nordvpn.list

###########################################################
# PKGs
###########################################################

FONTS='fonts-beng fonts-beng-extra fonts-deva fonts-deva-extra fonts-gargi fonts-gubbi fonts-gujr fonts-gujr-extra fonts-guru fonts-guru-extra fonts-knda fonts-lohit-beng-assamese fonts-lohit-beng-bengali fonts-lohit-deva fonts-lohit-gujr fonts-lohit-guru fonts-lohit-knda fonts-lohit-mlym fonts-lohit-orya fonts-lohit-taml fonts-lohit-taml-classical fonts-lohit-telu fonts-nakula fonts-navilu fonts-orya fonts-orya-extra fonts-pagul fonts-sahadeva fonts-samyak-deva fonts-samyak-gujr fonts-samyak-mlym fonts-samyak-taml fonts-smc fonts-smc-anjalioldlipi fonts-smc-chilanka fonts-smc-dyuthi fonts-smc-gayathri fonts-smc-karumbi fonts-smc-keraleeyam fonts-smc-manjari fonts-smc-meera fonts-smc-rachana fonts-smc-raghumalayalamsans fonts-smc-suruma fonts-smc-uroob fonts-telu fonts-telu-extra fonts-teluguvijayam fonts-kalapi fonts-lao fonts-lklug-sinhala fonts-tibetan-machine fonts-thai-tlwg fonts-cantarell fonts-dejavu-core fonts-droid-fallback fonts-firacode fonts-freefont-ttf fonts-indic fonts-jetbrains-mono fonts-kacst fonts-kacst-one fonts-liberation fonts-liberation2 fonts-mathjax fonts-noto fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji fonts-noto-extra fonts-noto-mono fonts-noto-ui-core fonts-noto-ui-extra fonts-opensymbol fonts-sil-abyssinica fonts-sil-annapurna fonts-sil-padauk fonts-ubuntu fonts-urw-base35 fonts-yrsa-rasa fonts-tlwg-garuda fonts-tlwg-garuda-ttf fonts-tlwg-kinnari fonts-tlwg-kinnari-ttf fonts-tlwg-laksaman fonts-tlwg-laksaman-ttf fonts-tlwg-loma fonts-tlwg-loma-ttf fonts-tlwg-mono fonts-tlwg-mono-ttf fonts-tlwg-norasi fonts-tlwg-norasi-ttf fonts-tlwg-purisa fonts-tlwg-purisa-ttf fonts-tlwg-sawasdee fonts-tlwg-sawasdee-ttf fonts-tlwg-typewriter fonts-tlwg-typewriter-ttf fonts-tlwg-typist fonts-tlwg-typist-ttf fonts-tlwg-typo fonts-tlwg-typo-ttf fonts-tlwg-umpush fonts-tlwg-umpush-ttf fonts-tlwg-waree fonts-tlwg-waree-ttf'
BUILD_TOOLS='build-essential'
VERSION_CONTROL='git git-lfs'
TERMINAL_UTILITIES='tmux tmux-plugin-manager ripgrep zoxide exa fd-find bat fzf xclip trash-cli neofetch wget tldr man-db scdoc stow dconf-cli gettext unrar unzip zip xz-utils'
DESKTOP_TOOLS='cinnamon-core lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings'
THEMES_AND_ICONS='papirus-icon-theme'
WEB_BROWSERS='brave-browser speech-dispatcher'
EDITORS='vim-gtk3'
OFFICE_AND_DOCUMENT_TOOLS='evince qalculate-gtk'
TERMINALS='kitty'

###########################################################
# INSTALL
###########################################################

echo -e "\e[32mUpgrading system...\e[0m"

sudo nala upgrade -y

echo -e "\e[32mInstalling Packages...\e[0m"

sudo nala install -y $FONTS $BUILD_TOOLS  $VERSION_CONTROL \
	$TERMINAL_UTILITIES $DESKTOP_TOOLS $THEMES_AND_ICONS $WEB_BROWSERS \
	$EDITORS $OFFICE_AND_DOCUMENT_TOOLS $TERMINALS

sudo nala remove -y zutty gnome-terminal &>/dev/null

###########################################################
# CINNAMON
###########################################################

echo -e "\e[32mConfiguring Cinnamon defaults...\e[0m"

sudo update-alternatives --install /usr/bin/xterm xterm /usr/bin/kitty 50

dconf write /org/cinnamon/theme/name "'Mint-L-Dark-Grey'"
dconf write /org/cinnamon/desktop/interface/gtk-theme "'Mint-L-Dark-Grey'"
dconf write /org/cinnamon/desktop/interface/icon-theme "'Papirus-Dark'"
dconf write /org/cinnamon/desktop/interface/cursor-theme "'Adwaita'"
dconf write /org/cinnamon/desktop/interface/font-name "'JetBrains Mono Medium 10'"
dconf write /org/cinnamon/desktop/wm/preferences/titlebar-font "'JetBrains Mono Medium 10'"
dconf write /org/cinnamon/desktop/wm/preferences/theme "'Mint-L-Dark-Grey'"

dconf write /x/dm/slick-greeter/cursor-theme-name "'Adwaita'"
dconf write /x/dm/slick-greeter/icon-theme-name "'Mint-L-Dark-Grey'"
dconf write /x/dm/slick-greeter/theme-name "'Mint-L-Dark-Grey'"
dconf write /x/dm/slick-greeter/font-name "'JetBrains Mono Medium 10'"
    
dconf write /org/gnome/desktop/interface/font-name "'JetBrains Mono Medium 10'"
dconf write /org/gnome/desktop/interface/document-font-name "'JetBrains Mono Medium 10'"
dconf write /org/gnome/desktop/interface/monospace-font-name "'JetBrains Mono Medium 10'"
dconf write /org/nemo/desktop/font "'JetBrains Mono Medium 10'"
dconf write /org/x/apps/portal/color-scheme "'prefer-dark'"
dconf write /org/cinnamon/desktop/wm/preferences/button-layout "':minimize,maximize,close'"
dconf write /org/cinnamon/hotcorner-layout "['expo:true:0', 'scale:true:0', 'scale:false:0', 'desktop:true:0']"
dconf write /org/cinnamon/desktop/background/picture-uri "'file:///usr/share/desktop-base/emerald-theme/wallpaper/contents/images/1920x1080.svg'"
dconf write /org/cinnamon/enabled-applets "['panel1:left:0:menu@cinnamon.org:0', 'panel1:left:1:separator@cinnamon.org:1', 'panel1:left:4:grouped-window-list@cinnamon.org:2', 'panel1:right:4:systray@cinnamon.org:3', 'panel1:right:5:xapp-status@cinnamon.org:4', 'panel1:right:7:notifications@cinnamon.org:5', 'panel1:right:8:printers@cinnamon.org:6', 'panel1:right:9:keyboard@cinnamon.org:8', 'panel1:right:10:favorites@cinnamon.org:9', 'panel1:right:11:network@cinnamon.org:10', 'panel1:right:12:sound@cinnamon.org:11', 'panel1:right:13:power@cinnamon.org:12', 'panel1:right:15:calendar@cinnamon.org:13', 'panel1:right:16:cornerbar@cinnamon.org:14', 'panel1:left:2:workspace-switcher@cinnamon.org:15', 'panel1:right:6:separator@cinnamon.org:15', 'panel1:right:3:separator@cinnamon.org:16', 'panel1:right:14:separator@cinnamon.org:17', 'panel1:left:3:separator@cinnamon.org:18']"

dconf write /org/cinnamon/desktop/applications/terminal/exec "'kitty'"
dconf write /org/cinnamon/desktop/applications/terminal/exec-arg "'--working-directory'"

dconf write /org/cinnamon/panel-zone-symbolic-icon-sizes "'[{\"panelId\": 1, \"left\": 28, \"center\": 28, \"right\": 16}]'"
dconf write /org/cinnamon/panel-zone-icon-sizes "'[{\"panelId\": 1, \"left\": 0, \"center\": 0, \"right\": 16}]'"

cinnamon --replace >/dev/null 2>&1 &
disown

###########################################################
# LIGHTDM
###########################################################

echo -e "\e[32mSetting LightDM config...\e[0m"
echo -e "$(
	cat <<-EOF
		[greeter]\n
		background = /usr/share/desktop-base/emerald-theme/wallpaper/contents/images/1920x1080.svg\n
		theme-name = Mint-L-Dark-Grey\n
		icon-theme-name = Papirus-Dark\n
		font-name = JetBrains Mono Medium 10
	EOF
)" | sudo tee /etc/lightdm/lightdm-gtk-greeter.conf &>/dev/null

###########################################################
# UPDATE DESKTOP NAMES 
###########################################################

echo -e "\e[32mUpdatting .desktop...\e[0m"

sudo sed -i 's/^Name=kitty$/Name=Kitty/' /usr/share/applications/kitty.desktop

###########################################################
# CREATE LINKS
###########################################################

echo -e "\e[32mStowing config folders...\e[0m"

rm -rf \
	"$HOME/.vimrc" \
	"$HOME/.bashrc" \
	"$HOME/.bash_aliases" \
	"$HOME/.profile" \
	"$HOME/.config/bat" \
	"$HOME/.config/kitty" \
	"$HOME/.config/tmux"

stow -d "$DIR/config" -t $HOME \
	-S bat \
	-S kitty \
	-S tmux

stow -d "$DIR/home" -t $HOME \
	-S bash \
	-S vim
