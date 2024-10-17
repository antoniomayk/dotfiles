#!/bin/bash

#------------------------------------------------------------
# FUNCTIONS
#------------------------------------------------------------

has_command() {
	command -v "$1" >/dev/null 2>&1
}

is_nvidia() {
	lspci | grep -I "NVIDIA" >/dev/null 2>&1
}

#------------------------------------------------------------
# YAY
#------------------------------------------------------------

URL_PIKAUR="https://aur.archlinux.org/pikaur.git"

if ! has_command pikaur; then
	cd "$(mktemp -d)" &&
		sudo pacman -S --needed base-devel git &&
		git clone $URL_PIKAUR &&
		cd pikaur &&
		makepkg -fsri &&
		cd "$HOME"
fi

pikaur -S --needed \
	adw-gtk-theme alacritty alsa-utils android-emulator android-sdk-build-tools android-sdk-cmdline-tools-latest \
	android-sdk-platform-tools android-udev base-devel bat bluez bluez-utils bottom brave-bin cbindgen \
	clang cmake cmus conky coursier cuda-tools dart-sass dbus deno dmidecode dnsmasq docker docker-compose \
	edk2-shell epiphany exa fd feh fish flameshot flutter gdb git glslang graphviz helix image-roll inetutils \
	inkscape insomnia-bin iw jdk11-openjdk jdk17-openjdk krita lazydocker lazygit less libclc lightdm-gtk-greeter-settings \
	llvm lsb-release lxappearance lxsession man meson nemo nemo-preview neofetch neovide neovim net-tools ninja nitrogen \
	nordvpn-bin noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra nvidia-settings nvme-cli obsidian obs-studio \
	papirus-icon-theme pavucontrol pciutils pfetch picom playerctl pulsemixer python-dbus-next python-distutils-extra \
	python-iwlib python-mako python-mpd2 python-packaging python-ply python-psutil python-setuptools python-yaml qemu-full \
	qtile-extras-git ranger ripgrep rust-bindgen sbctl spirv-llvm-translator subversion taplo-cli thunar tk tmux \
	tmux-plugin-manager trash trash-cli tree ttf-cascadia-code-nerd ttf-droid ttf-firacode-nerd ttf-fira-sans \
	ttf-jetbrains-mono-nerd ttf-liberation ttf-monaco ueberzug unrar unzip usbutils uthash v4l-utils virt-manager \
	visual-studio-code-bin vivaldi vlc wmctrl xclip xdg-user-dirs xdotool xorg-xmessage xtrans \
	yaru-colors-gtk-theme youtube-music-bin zig zip zls

if has_command flutter; then
	sudo chown -R "$USER:$USER" /opt/android-sdk
	sudo chmod -R g+rw /opt/android-sdk/

	echo "fish_add_path /opt/android-sdk/emulator/" | fish -c "source -"
	echo "fish_add_path /opt/android-sdk/platform-tools/" | fish -c "source -"
	echo "fish_add_path /opt/android-sdk/cmdline-tools/latest/bin/" | fish -c "source -"
fi

if has_command coursier; then
	coursier install sbt
	coursier install bloop --only-prebuilt=true

	echo "fish_add_path $HOME/.local/share/coursier/bin/" | fish -c "source -"
fi

if has_command iwctl; then
	sudo systemctl start iwd.service
	sudo systemctl enable iwd.service
fi

if has_command bluetoothctl; then
	sudo systemctl enable bluetooth.service
	sudo systemctl start bluetooth.service
fi

if is_nvidia; then
	sudo pacman -S --needed --noconfirm nvidia nvidia-utils && sudo mkinitcpio -p linux
fi

if has_command nvidia-xconfig; then
	sudo mkinitcpio -p linux
fi

if has_command nordvpn; then
	sudo groupadd -r nordvpn
	sudo gpasswd -a "$USER" nordvpn
	sudo usermod -aG nordvpn "$USER"
	sudo systemctl enable nordvpnd
fi

if has_command docker; then
	sudo usermod -aG docker "$USER"
	sudo systemctl enable docker.service docker.socket
fi

if has_command virt-manager; then
	sudo usermod -aG libvirt "$USER"
	sudo virsh net-start default
	sudo systemctl enable libvirtd
	sudo systemctl start libvirtd
fi

#------------------------------------------------------------
# EDK2 SHELL
#------------------------------------------------------------

if [ -e "/usr/share/edk2-shell/x64/Shell.efi" ]; then
	sudo cp /usr/share/edk2-shell/x64/Shell.efi /boot/shellx64.efi
fi

#------------------------------------------------------------
# OH MY FISH
#------------------------------------------------------------

URL_OMF="https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install"

if ! has_command omf; then
	curl -Lfs $URL_OMF | fish -c "source - --noninteractive --yes" &&
		fish -c "omf install sdk nvm pure ghcup rustup"
fi

#------------------------------------------------------------
# VERSION MANAGER
#------------------------------------------------------------

URL_GHCUP="https://get-ghcup.haskell.org"
URL_RUSTUP="https://sh.rustup.rs"
URL_SDKMAN="https://get.sdkman.io"
URL_NVM="https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh"

curl -Lfs $URL_GHCUP | BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
	BOOTSTRAP_HASKELL_ADJUST_BASHRC=1 \
	BOOTSTRAP_HASKELL_INSTALL_HLS=1 \
	bash
curl -Lfs $URL_RUSTUP | bash -s -- -y
curl -Lfs $URL_SDKMAN | bash
curl -Lfs $URL_NVM | bash

echo "$(
	cat <<-EOF
		sdk install gradle
		sdk install java 17.0.12-tem

		nvm install node

		cabal update
		cabal install bhoogle
		cabal install fast-tags
		cabal install cabal-gild
		cabal install stylish-haskell
		cabal install fourmolu
		cabal install cabal-gild
		cabal install hoogle
		cabal install htlint
		cabal install haskell-debug-adapter
		cabal install ghci-dap

		hoogle generate

		cargo install cargo-binstall
		cargo binstall cargo-nextest --secure
		cargo install tree-sitter-cli
		cargo install bluetui

		rustup component add rust-analyzer
	EOF
)" | fish -c "source -"

#------------------------------------------------------------
# FISH CONFIG
#------------------------------------------------------------

# SHELL VARIABLES

if is_nvidia; then
	echo "set -Ux LD_LIBRARY_PATH /opt/cuda/lib64" | fish -c "source -"
fi

# SHELL PATH

if is_nvidia; then
	echo "fish_add_path /opt/cuda/bin" | fish -c "source -"
fi

# KORA

mkdir -p "$HOME/.local/bin"

echo "$(
	cat <<-EOF
		#!/bin/sh

		rm -rf ~/.bash_history
		rm -rf ~/.lesshst
		rm -rf ~/.profile
		rm -rf ~/.python_history
	EOF
)" >"$HOME/.local/bin/kora"

echo "$(
	cat <<-EOF
		fish_add_path $HOME/.local/bin
	EOF
)" | fish -c "source -"

chmod +x $HOME/.local/bin/*

# ALIASES

echo "$(
	cat <<-EOF
		alias -s b   "bat"
		alias -s c   "builtin history clear && history -c && kora && printf '\033[2J\033[3J\033[1;1H'"
		alias -s l   "exa"
		alias -s la  "exa -a"
		alias -s ll  "exa -l"
		alias -s lla "exa -la"
		alias -s r   "rm -r"
		alias -s rf  "rm -rf"
		alias -s hx  "helix"
		alias -s nv  "neovide --fork"
	EOF
)" | fish -c "source -"

# FISH COLORS

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

ln -s "$HOME/Projects/dotfiles/tmux" "$HOME/.config/tmux"
ln -s "$HOME/Projects/dotfiles/nvim" "$HOME/.config/nvim"
ln -s "$HOME/Projects/dotfiles/helix" "$HOME/.config/helix"
ln -s "$HOME/Projects/dotfiles/bottom" "$HOME/.config/bottom"
ln -s "$HOME/Projects/dotfiles/bat" "$HOME/.config/bat"
ln -s "$HOME/Projects/dotfiles/alacritty" "$HOME/.config/alacritty"
ln -s "$HOME/Projects/dotfiles/qtile" "$HOME/.config/qtile"
ln -s "$HOME/Projects/dotfiles/picom" "$HOME/.config/picom"
ln -s "$HOME/Projects/dotfiles/conky" "$HOME/.config/conky"
