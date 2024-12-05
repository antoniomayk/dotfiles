#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive

###########################################################
# NETWORK
###########################################################

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

sudo apt install -y nala curl gnupg

sudo nala install -y fasttrack-archive-keyring

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
)" | sudo tee /etc/apt/sources.list &>/dev/null

echo 'deb https://download.vscodium.com/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
curl -fsSL 'https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/vscodium-archive-keyring.gpg >/dev/null

sudo nala update

###########################################################
# PKGs
###########################################################

PROGRAMMING_LANGUAGES_AND_TOOLS='openjdk-17-jdk maven nodejs npm python3-venv build-essential clang cmake ninja-build ccache docker docker-compose golang'
VESION_CONTROL='git git-lfs'
TERMINAL_UTILITIES='fish tmux tmux-plugin-manager dconf-cli gettext bat fd-find exa xclip trash-cli neofetch fzf zoxide tree curl wget tldr man-db scdoc ripgrep imvirt'
INDIC_FONTS='fonts-beng fonts-beng-extra fonts-deva fonts-deva-extra fonts-gargi fonts-gubbi fonts-gujr fonts-gujr-extra fonts-guru fonts-guru-extra fonts-knda fonts-lohit-beng-assamese fonts-lohit-beng-bengali fonts-lohit-deva fonts-lohit-gujr fonts-lohit-guru fonts-lohit-knda fonts-lohit-mlym fonts-lohit-orya fonts-lohit-taml fonts-lohit-taml-classical fonts-lohit-telu fonts-nakula fonts-navilu fonts-orya fonts-orya-extra fonts-pagul fonts-sahadeva fonts-samyak-deva fonts-samyak-gujr fonts-samyak-mlym fonts-samyak-taml fonts-smc fonts-smc-anjalioldlipi fonts-smc-chilanka fonts-smc-dyuthi fonts-smc-gayathri fonts-smc-karumbi fonts-smc-keraleeyam fonts-smc-manjari fonts-smc-meera fonts-smc-rachana fonts-smc-raghumalayalamsans fonts-smc-suruma fonts-smc-uroob fonts-telu fonts-telu-extra fonts-teluguvijayam'
OTHER_REGIONAL_FONTS='fonts-kalapi fonts-lao fonts-lklug-sinhala fonts-tibetan-machine fonts-thai-tlwg'
GENERAL_FONTS='fonts-cantarell fonts-dejavu-core fonts-droid-fallback fonts-firacode fonts-freefont-ttf fonts-indic fonts-jetbrains-mono fonts-kacst fonts-kacst-one fonts-liberation fonts-liberation2 fonts-mathjax fonts-noto fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji fonts-noto-extra fonts-noto-mono fonts-noto-ui-core fonts-noto-ui-extra fonts-opensymbol fonts-sil-abyssinica fonts-sil-annapurna fonts-sil-padauk fonts-ubuntu fonts-urw-base35 fonts-yrsa-rasa'
THAI_FONTS='fonts-tlwg-garuda fonts-tlwg-garuda-ttf fonts-tlwg-kinnari fonts-tlwg-kinnari-ttf fonts-tlwg-laksaman fonts-tlwg-laksaman-ttf fonts-tlwg-loma fonts-tlwg-loma-ttf fonts-tlwg-mono fonts-tlwg-mono-ttf fonts-tlwg-norasi fonts-tlwg-norasi-ttf fonts-tlwg-purisa fonts-tlwg-purisa-ttf fonts-tlwg-sawasdee fonts-tlwg-sawasdee-ttf fonts-tlwg-typewriter fonts-tlwg-typewriter-ttf fonts-tlwg-typist fonts-tlwg-typist-ttf fonts-tlwg-typo fonts-tlwg-typo-ttf fonts-tlwg-umpush fonts-tlwg-umpush-ttf fonts-tlwg-waree fonts-tlwg-waree-ttf'
UTILITIES='dconf-cli gettext gnome-screenshot'
FILE_MANAGMENT='unrar unzip zip'
DESKTOP_TOOLS='cinnamon-core lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings'
THEMES_AND_ICONS='papirus-icon-theme'
TERMINALS='alacritty'
PACKAGE_MANAGEMENT='flatpak'
CODE_EDITORS='codium'

###########################################################
# APT
###########################################################

sudo nala install -y $PROGRAMMING_LANGUAGES_AND_TOOLS $VESION_CONTROL $TERMINAL_UTILITIES $INDIC_FONTS $OTHER_REGIONAL_FONTS $GENERAL_FONTS $THAI_FONTS $UTILITIES $FILE_MANAGMENT $DESKTOP_TOOLS $THEMES_AND_ICONS $SECURITY_TOOLS $TERMINALS $CODE_EDITORS $PACKAGE_MANAGEMENT

sudo nala remove -y zutty gnome-terminal

sudo nala upgrade -y

###########################################################
# VIRTUALIZATION
###########################################################

if [[ $(sudo imvirt) == 'Physical' ]]; then
	sudo nala install -y virtualbox
else
	sudo nala install -y virtualbox-guest-x11 virtualbox-guest-utils
fi

###########################################################
# CUSTOM PACKAGES
###########################################################

CWD=$(pwd)

if ! [[ $(rust --version) ]]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

	cargo install --git https://github.com/neovide/neovide
	cargo install --git https://github.com/ClementTsang/bottom
fi

if ! [[ $(go --version) ]]; then
	go install github.com/jesseduffield/lazydocker@v0.19.0
	go install github.com/jesseduffield/lazygit@v0.39.4
fi

if [[ $(nvim --version | head -n 1 | awk '{print $2}') != "v0.10.2" ]]; then
	cd $(mktemp -d) &&
		git clone --depth 1 --branch v0.10.2 https://github.com/neovim/neovim . &&
		make CMAKE_BUILD_TYPE=RelWithDebInfo &&
		cd build &&
		cpack -G DEB &&
		sudo dpkg -i nvim-linux64.deb
fi

if ! [[ $(fc-list | grep 'JetBrainsMonoNL') ]]; then
	JETBRAINS_MONO=$(mktemp)

	curl -Lo $JETBRAINS_MONO "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip" &&
		mkdir -p ~/.local/share/fonts &&
		unzip $JETBRAINS_MONO -d ~/.local/share/fonts &&
		fc-cache -fv
fi

if ! [[ $(dpkg-query -W mint-l-icons) ]]; then
	MINT_L_ICONS=$(mktemp)

	curl -Lo $MINT_L_ICONS "http://packages.linuxmint.com/pool/main/m/mint-l-icons/mint-l-icons_1.7.2_all.deb" &&
		sudo dpkg -i $MINT_L_ICONS
fi

if ! [[ $(dpkg-query -W mint-l-theme) ]]; then
	MINT_L_THEME=$(mktemp)

	curl -Lo $MINT_L_THEME "http://packages.linuxmint.com/pool/main/m/mint-l-theme/mint-l-theme_1.9.8_all.deb" &&
		sudo dpkg -i $MINT_L_THEME
fi

if ! [[ $(dpkg-query -W mint-cursor-themes) ]]; then
	MINT_CURSOR_THEME=$(mktemp)

	curl -Lo $MINT_CURSOR_THEME "http://packages.linuxmint.com/pool/main/m/mint-cursor-themes/mint-cursor-themes_1.0.2_all.deb" &&
		sudo dpkg -i $MINT_CURSOR_THEME
fi

if ! [[ $(dpkg-query -W mint-backgrounds-wilma) ]]; then
	MINT_BACKGROUNDS_WILMA=$(mktemp)

	curl -Lo $MINT_BACKGROUNDS_WILMA "http://packages.linuxmint.com/pool/main/m/mint-backgrounds-wilma/mint-backgrounds-wilma_1.1_all.deb" &&
		sudo dpkg -i $MINT_BACKGROUNDS_WILMA
fi

cd $CWD

###########################################################
# CINNAMON
###########################################################

sudo update-alternatives --install /usr/bin/xterm xterm /usr/bin/alacritty 50

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

dconf write /org/cinnamon/desktop/applications/terminal/exec "'alacritty'"
dconf write /org/cinnamon/desktop/applications/terminal/exec-arg "'--working-directory'"

cinnamon --replace >/dev/null 2>&1 &
disown

###########################################################
# FLATPAK
###########################################################

NETWORKING='org.mozilla.firefox com.google.Chrome com.discordapp.Discord'
AUDIO_AND_VIDEO='org.videolan.VLC org.gnome.Rhythmbox3 com.obsproject.Studio'
PRODUCTIVITY='md.obsidian.Obsidian org.libreoffice.LibreOffice'
GRAPHICS_AND_PHOTOGRAPHY='org.inkscape.Inkscape org.kde.krita org.gnome.Evince'
SCIENCE='io.github.Qalculate'

cp -r /usr/share/themes/* $HOME/.themes/
cp -r /usr/share/icons/* $HOME/.icons/

flatpak override --user --filesystem=xdg-config/gtk-3.0:ro
sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --filesystem=$HOME/.icons

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y --noninteractive runtime/org.gnome.Platform/x86_64/3.24
flatpak install -y --noninteractive flathub $NETWORKING $AUDIO_AND_VIDEO $PRODUCTIVITY $GRAPHICS_AND_PHOTOGRAPHY $SCIENCE

###########################################################
# PAPIRUS ICON THEME
###########################################################

# Adds Zen Browser Icons

sudo cp $HOME/Projects/dotfiles/.icons/Papirus/16x16/apps/zen-browser.svg /usr/share/icons/Papirus/16x16/apps/zen-browser.svg
sudo cp $HOME/Projects/dotfiles/.icons/Papirus/22x22/apps/zen-browser.svg /usr/share/icons/Papirus/22x22/apps/zen-browser.svg
sudo cp $HOME/Projects/dotfiles/.icons/Papirus/24x24/apps/zen-browser.svg /usr/share/icons/Papirus/24x24/apps/zen-browser.svg
sudo cp $HOME/Projects/dotfiles/.icons/Papirus/32x32/apps/zen-browser.svg /usr/share/icons/Papirus/32x32/apps/zen-browser.svg
sudo cp $HOME/Projects/dotfiles/.icons/Papirus/48x48/apps/zen-browser.svg /usr/share/icons/Papirus/48x48/apps/zen-browser.svg
sudo cp $HOME/Projects/dotfiles/.icons/Papirus/64x64/apps/zen-browser.svg /usr/share/icons/Papirus/64x64/apps/zen-browser.svg

sudo ln -s /usr/share/icons/Papirus/16x16/apps/zen-browser.svg /usr/share/icons/Papirus/16x16/apps/io.github.zen_browser.zen.svg
sudo ln -s /usr/share/icons/Papirus/22x22/apps/zen-browser.svg /usr/share/icons/Papirus/22x22/apps/io.github.zen_browser.zen.svg
sudo ln -s /usr/share/icons/Papirus/24x24/apps/zen-browser.svg /usr/share/icons/Papirus/24x24/apps/io.github.zen_browser.zen.svg
sudo ln -s /usr/share/icons/Papirus/32x32/apps/zen-browser.svg /usr/share/icons/Papirus/32x32/apps/io.github.zen_browser.zen.svg
sudo ln -s /usr/share/icons/Papirus/48x48/apps/zen-browser.svg /usr/share/icons/Papirus/48x48/apps/io.github.zen_browser.zen.svg
sudo ln -s /usr/share/icons/Papirus/64x64/apps/zen-browser.svg /usr/share/icons/Papirus/64x64/apps/io.github.zen_browser.zen.svg

# Refresh Icons cache

sudo gtk-update-icon-cache -q /usr/share/icons/Papirus-Dark/

###########################################################
# PAPIRUS ICON FOLDER
###########################################################

wget -qO- https://git.io/papirus-folders-install | sh

papirus-folders -C grey

###########################################################
# LIGHTDM
###########################################################

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
# USER .DESKTOPS
###########################################################

mkdir -p $HOME/.local/share/applications

echo -e "$(
	cat <<-EOF
		[Desktop Entry]
		Name=Neovide
		GenericName=Text Editor
		Comment=Edit text files
		TryExec=neovide
		Exec=neovide %F
		Terminal=false
		Type=Application
		Keywords=Text;editor;
		Icon=nvim
		Categories=Utility;TextEditor;
		StartupNotify=false
		MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
	EOF
)" | tee $HOME/.local/share/application/neovide.desktop &>/dev/null

###########################################################
# ALIASES
###########################################################

echo "$(
	cat <<-EOF
		alias -s b   "bat"
		alias -s l   "exa"
		alias -s la  "exa -a"
		alias -s ll  "exa -l"
		alias -s lla "exa -la"
		alias -s r   "rm -r"
		alias -s rf  "rm -rf"
		alias -s c   "clear && rm $HOME/.bash_history && builtin history clear && history -c && printf '\033[2J\033[3J\033[1;1H'"
	EOF
)" | fish -c "source -" &>/dev/null

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
)" | fish -c "source -" &>/dev/null

#------------------------------------------------------------
# FISH CONFIG
#------------------------------------------------------------

echo -e "$(
	cat <<-EOF
		if status is-interactive
		    # Commands to run in interactive sessions can go here
		end

		zoxide init fish | source

		if not contains "\$HOME/.cargo/bin" \$PATH
		    set -x PATH "\$HOME/.cargo/bin" \$PATH
		end

		set -Ux GOPATH \$HOME/.go

		go env -w GOPATH=\$HOME/.go

		if not contains "\$HOME/.go/bin" \$PATH
		    set -x PATH "\$HOME/.go/bin" \$PATH
		end
	EOF
)" | tee $HOME/.config/fish/config.fish &>/dev/null

sudo sed -i 's/^Name=fish$/Name=Fish/' /usr/share/applications/fish.desktop

#------------------------------------------------------------
# CREATE CONFIG FOLDERS
#------------------------------------------------------------

rm -rf "$HOME/.config/bat" && ln -s "$HOME/Projects/dotfiles/bat" "$HOME/.config/bat"
rm -rf "$HOME/.config/alacritty" && ln -s "$HOME/Projects/dotfiles/alacritty" "$HOME/.config/alacritty"
rm -rf "$HOME/.config/nvim" && ln -s "$HOME/Projects/dotfiles/nvim" "$HOME/.config/nvim"
rm -rf "$HOME/.config/tmux" && ln -s "$HOME/Projects/dotfiles/tmux" "$HOME/.config/tmux"
