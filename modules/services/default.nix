{ pkgs, ... }:

{
  imports = [
    (import ./libinput.nix)
    (import ./openssh.nix)
    (import ./pipewire.nix)
    (import ./printing.nix)
    (import ./pulseaudio.nix)
    (import ./xserver.nix { inherit pkgs; })
  ];
}
