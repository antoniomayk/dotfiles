{ pkgs, ... }:

{
  imports = [
    (import ./gnupg.nix { inherit pkgs; })
    (import ./neovim.nix)
    (import ./sway.nix { inherit pkgs; })
  ];
}
