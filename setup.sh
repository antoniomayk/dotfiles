#!/usr/bin/env bash

###########################################################
# HELPERS
###########################################################

is_nvidia() {
	lspci | grep -I "NVIDIA" >/dev/null 2>&1
}

is_physical() {
	$(sudo imvirt) == 'Physical'
}

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

DEBIAN_FRONTEND=noninteractive

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

echo 'deb https://download.vscodium.com/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
curl -fsSL 'https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg >/dev/null

echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google.list
curl -fsSL 'https://dl-ssl.google.com/linux/linux_signing_key.pub' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/google-keyring.gpg >/dev/null

echo -e "\e[32mUpdating latests packages information...\e[0m"

sudo nala update

echo -e "\e[32mUpgrading system...\e[0m"

sudo nala upgrade -y

###########################################################
# PKGs
###########################################################

PROGRAMMING_LANGUAGES_AND_TOOLS='build-essential clang cmake ninja-build'
VESION_CONTROL='git git-lfs'
TERMINAL_UTILITIES='fish tmux tmux-plugin-manager bat fd-find exa xclip trash-cli neofetch fzf zoxide tree curl wget tldr man-db scdoc ripgrep imvirt stow'
INDIC_FONTS='fonts-beng fonts-beng-extra fonts-deva fonts-deva-extra fonts-gargi fonts-gubbi fonts-gujr fonts-gujr-extra fonts-guru fonts-guru-extra fonts-knda fonts-lohit-beng-assamese fonts-lohit-beng-bengali fonts-lohit-deva fonts-lohit-gujr fonts-lohit-guru fonts-lohit-knda fonts-lohit-mlym fonts-lohit-orya fonts-lohit-taml fonts-lohit-taml-classical fonts-lohit-telu fonts-nakula fonts-navilu fonts-orya fonts-orya-extra fonts-pagul fonts-sahadeva fonts-samyak-deva fonts-samyak-gujr fonts-samyak-mlym fonts-samyak-taml fonts-smc fonts-smc-anjalioldlipi fonts-smc-chilanka fonts-smc-dyuthi fonts-smc-gayathri fonts-smc-karumbi fonts-smc-keraleeyam fonts-smc-manjari fonts-smc-meera fonts-smc-rachana fonts-smc-raghumalayalamsans fonts-smc-suruma fonts-smc-uroob fonts-telu fonts-telu-extra fonts-teluguvijayam'
OTHER_REGIONAL_FONTS='fonts-kalapi fonts-lao fonts-lklug-sinhala fonts-tibetan-machine fonts-thai-tlwg'
GENERAL_FONTS='fonts-cantarell fonts-dejavu-core fonts-droid-fallback fonts-firacode fonts-freefont-ttf fonts-indic fonts-jetbrains-mono fonts-kacst fonts-kacst-one fonts-liberation fonts-liberation2 fonts-mathjax fonts-noto fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji fonts-noto-extra fonts-noto-mono fonts-noto-ui-core fonts-noto-ui-extra fonts-opensymbol fonts-sil-abyssinica fonts-sil-annapurna fonts-sil-padauk fonts-ubuntu fonts-urw-base35 fonts-yrsa-rasa'
THAI_FONTS='fonts-tlwg-garuda fonts-tlwg-garuda-ttf fonts-tlwg-kinnari fonts-tlwg-kinnari-ttf fonts-tlwg-laksaman fonts-tlwg-laksaman-ttf fonts-tlwg-loma fonts-tlwg-loma-ttf fonts-tlwg-mono fonts-tlwg-mono-ttf fonts-tlwg-norasi fonts-tlwg-norasi-ttf fonts-tlwg-purisa fonts-tlwg-purisa-ttf fonts-tlwg-sawasdee fonts-tlwg-sawasdee-ttf fonts-tlwg-typewriter fonts-tlwg-typewriter-ttf fonts-tlwg-typist fonts-tlwg-typist-ttf fonts-tlwg-typo fonts-tlwg-typo-ttf fonts-tlwg-umpush fonts-tlwg-umpush-ttf fonts-tlwg-waree fonts-tlwg-waree-ttf'
UTILITIES='dconf-cli gettext gnome-screenshot'
FILE_MANAGMENT='unrar unzip zip xz-utils'
DESKTOP_TOOLS='cinnamon-core lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings'
THEMES_AND_ICONS='papirus-icon-theme'
TERMINALS='kitty'
WEB_BROWSERS='firefox-esr'

if is_nvidia; then
	NVIDIA='nvidia-driver firmware-misc-nonfree nvidia-cuda-dev nvidia-cuda-toolkit'
fi

###########################################################
# INSTALL
###########################################################

echo -e "\e[32mInstalling Packages...\e[0m"

sudo nala install -y $PROGRAMMING_LANGUAGES_AND_TOOLS $VESION_CONTROL \
	$TERMINAL_UTILITIES $INDIC_FONTS $OTHER_REGIONAL_FONTS $GENERAL_FONTS \
	$THAI_FONTS $UTILITIES $FILE_MANAGMENT $DESKTOP_TOOLS $THEMES_AND_ICONS \
	$SECURITY_TOOLS $TERMINALS $CODE_EDITORS $PACKAGE_MANAGEMENT $FLUTTER \
	$NVIDIA $VIRTBOX $WEB_BROWSERS

sudo nala remove -y zutty gnome-terminal &>/dev/null

###########################################################
# .DEB PACKAGES
###########################################################

if ! dpkg-query -W mint-l-icons >/dev/null; then
	echo -e "\e[32mInstalling [mint-l-icons]...\e[0m"

	MINT_L_ICONS=$(mktemp)

	curl -Lo $MINT_L_ICONS "http://packages.linuxmint.com/pool/main/m/mint-l-icons/mint-l-icons_1.7.2_all.deb" &&
		sudo dpkg -i $MINT_L_ICONS
fi

if ! dpkg-query -W mint-l-theme >/dev/null; then
	echo -e "\e[32mInstalling [mint-l-theme]...\e[0m"

	MINT_L_THEME=$(mktemp)

	curl -Lo $MINT_L_THEME "http://packages.linuxmint.com/pool/main/m/mint-l-theme/mint-l-theme_1.9.8_all.deb" &&
		sudo dpkg -i $MINT_L_THEME
fi

if ! dpkg-query -W mint-cursor-themes >/dev/null; then
	echo -e "\e[32mInstalling [mint-cursor-themes]...\e[0m"

	MINT_CURSOR_THEME=$(mktemp)

	curl -Lo $MINT_CURSOR_THEME "http://packages.linuxmint.com/pool/main/m/mint-cursor-themes/mint-cursor-themes_1.0.2_all.deb" &&
		sudo dpkg -i $MINT_CURSOR_THEME
fi

if ! dpkg-query -W mint-backgrounds-wilma >/dev/null; then
	echo -e "\e[32mInstalling [mint-backgrounds-wilma]...\e[0m"

	MINT_BACKGROUNDS_WILMA=$(mktemp)

	curl -Lo $MINT_BACKGROUNDS_WILMA "http://packages.linuxmint.com/pool/main/m/mint-backgrounds-wilma/mint-backgrounds-wilma_1.1_all.deb" &&
		sudo dpkg -i $MINT_BACKGROUNDS_WILMA
fi

###########################################################
# CINNAMON
###########################################################

echo -e "\e[32mConfiguring Cinnamon defaults...\e[0m"

sudo update-alternatives --install /usr/bin/xterm xterm /usr/bin/kitty 50

dconf write /org/cinnamon/theme/name "'Mint-L-Dark-Grey'"
dconf write /org/cinnamon/desktop/interface/gtk-theme "'Mint-L-Dark-Grey'"
dconf write /org/cinnamon/desktop/interface/icon-theme "'Papirus-Dark'"
dconf write /org/cinnamon/desktop/interface/cursor-theme "'Bibata-Modern-Classic'"
dconf write /org/cinnamon/desktop/interface/font-name "'JetBrains Mono Medium 10'"
dconf write /org/cinnamon/desktop/wm/preferences/titlebar-font "'JetBrains Mono Medium 10'"
dconf write /org/cinnamon/desktop/wm/preferences/theme "'Mint-L-Dark-Grey'"

dconf write /x/dm/slick-greeter/cursor-theme-name "'Bibata-Modern-Classic'"
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

dconf write /org/cinnamon/desktop/background/picture-uri "'file:///usr/share/backgrounds/linuxmint-wilma/meiying_body_of_water.jpg'"
dconf write /org/cinnamon/enabled-applets "['panel1:left:0:menu@cinnamon.org:0', 'panel1:left:1:separator@cinnamon.org:1', 'panel1:left:4:grouped-window-list@cinnamon.org:2', 'panel1:right:4:systray@cinnamon.org:3', 'panel1:right:5:xapp-status@cinnamon.org:4', 'panel1:right:7:notifications@cinnamon.org:5', 'panel1:right:8:printers@cinnamon.org:6', 'panel1:right:9:keyboard@cinnamon.org:8', 'panel1:right:10:favorites@cinnamon.org:9', 'panel1:right:11:network@cinnamon.org:10', 'panel1:right:12:sound@cinnamon.org:11', 'panel1:right:13:power@cinnamon.org:12', 'panel1:right:15:calendar@cinnamon.org:13', 'panel1:right:16:cornerbar@cinnamon.org:14', 'panel1:left:2:workspace-switcher@cinnamon.org:15', 'panel1:right:6:separator@cinnamon.org:15', 'panel1:right:3:separator@cinnamon.org:16', 'panel1:right:14:separator@cinnamon.org:17', 'panel1:left:3:separator@cinnamon.org:18']"

dconf write /org/cinnamon/desktop/applications/terminal/exec "'kitty'"
dconf write /org/cinnamon/desktop/applications/terminal/exec-arg "'--working-directory'"

dconf write /org/cinnamon/panel-zone-symbolic-icon-sizes "'[{\"panelId\": 1, \"left\": 28, \"center\": 28, \"right\": 16}]'"
dconf write /org/cinnamon/panel-zone-icon-sizes "'[{\"panelId\": 1, \"left\": 0, \"center\": 0, \"right\": 16}]'"

cinnamon --replace >/dev/null 2>&1 &
disown

###########################################################
# PAPIRUS ICON THEME
###########################################################

echo -e "\e[32mCopying Zen-Browser icons...\e[0m"

# Adds Zen Browser Icons

sudo cp $DIR/.icons/Papirus/16x16/apps/zen-browser.svg /usr/share/icons/Papirus/16x16/apps/zen-browser.svg
sudo cp $DIR/.icons/Papirus/22x22/apps/zen-browser.svg /usr/share/icons/Papirus/22x22/apps/zen-browser.svg
sudo cp $DIR/.icons/Papirus/24x24/apps/zen-browser.svg /usr/share/icons/Papirus/24x24/apps/zen-browser.svg
sudo cp $DIR/.icons/Papirus/32x32/apps/zen-browser.svg /usr/share/icons/Papirus/32x32/apps/zen-browser.svg
sudo cp $DIR/.icons/Papirus/48x48/apps/zen-browser.svg /usr/share/icons/Papirus/48x48/apps/zen-browser.svg
sudo cp $DIR/.icons/Papirus/64x64/apps/zen-browser.svg /usr/share/icons/Papirus/64x64/apps/zen-browser.svg

sudo ln -fs /usr/share/icons/Papirus/16x16/apps/zen-browser.svg /usr/share/icons/Papirus/16x16/apps/io.github.zen_browser.zen.svg
sudo ln -fs /usr/share/icons/Papirus/22x22/apps/zen-browser.svg /usr/share/icons/Papirus/22x22/apps/io.github.zen_browser.zen.svg
sudo ln -fs /usr/share/icons/Papirus/24x24/apps/zen-browser.svg /usr/share/icons/Papirus/24x24/apps/io.github.zen_browser.zen.svg
sudo ln -fs /usr/share/icons/Papirus/32x32/apps/zen-browser.svg /usr/share/icons/Papirus/32x32/apps/io.github.zen_browser.zen.svg
sudo ln -fs /usr/share/icons/Papirus/48x48/apps/zen-browser.svg /usr/share/icons/Papirus/48x48/apps/io.github.zen_browser.zen.svg
sudo ln -fs /usr/share/icons/Papirus/64x64/apps/zen-browser.svg /usr/share/icons/Papirus/64x64/apps/io.github.zen_browser.zen.svg

# Refresh Icons cache

echo -e "\e[32mUpdating GTK icons cache...\e[0m"

sudo gtk-update-icon-cache -q /usr/share/icons/Papirus-Dark/

###########################################################
# LIGHTDM
###########################################################

echo -e "\e[32mSetting LightDM config...\e[0m"

echo -e "$(
	cat <<-EOF
		[greeter]\n
		background = /usr/share/backgrounds/linuxmint-wilma/meiying_body_of_water.jpg\n
		theme-name = Mint-L-Dark-Grey\n
		icon-theme-name = Papirus-Dark\n
		font-name = JetBrains Mono Medium 10
	EOF
)" | sudo tee /etc/lightdm/lightdm-gtk-greeter.conf &>/dev/null

###########################################################
# FISH CONFIG
###########################################################

echo -e "\e[32mSetting Fish colors...\e[0m"

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
)" | fish -c "source -" &>/dev/null

echo -e "\e[32mSetting Fish aliases...\e[0m"

echo "$(
	cat <<-EOF
		alias -s b   "batcat"
		alias -s l   "exa"
		alias -s la  "exa -a"
		alias -s ll  "exa -l"
		alias -s lla "exa -la"
		alias -s r   "rm -r"
		alias -s rf  "rm -rf"
		alias -s c   "clear && rm -f $HOME/.bash_history && builtin history clear && history -c && printf '\033[2J\033[3J\033[1;1H'"
	EOF
)" | fish -c "source -" &>/dev/null

###########################################################
# UPDATE DESKTOP NAMES 
###########################################################

echo -e "\e[32mUpdatting .desktop...\e[0m"

sudo sed -i 's/^Name=fish$/Name=Fish/' /usr/share/applications/fish.desktop
sudo sed -i 's/^Name=kitty$/Name=Kitty/' /usr/share/applications/kitty.desktop

###########################################################
# CREATE LINKS
###########################################################

echo -e "\e[32mStowing config folders...\e[0m"

rm -rf \
	"$HOME/.config/alacritty" \
	"$HOME/.config/bat" \
	"$HOME/.config/fish/config.fish" \
	"$HOME/.config/kitty" \
	"$HOME/.config/nvim" \
	"$HOME/.config/neovide" \
	"$HOME/.config/tmux" \
	"$HOME/.config/VSCodium/User"

stow -d "$DIR" -t $HOME \
	-S alacritty \
	-S bat \
	-S kitty \
	-S neovide \
	-S nvim \
	-S vim \
	-S tmux

stow --no-folding -d "$DIR" -t $HOME \
	-S codium \
	-S fish