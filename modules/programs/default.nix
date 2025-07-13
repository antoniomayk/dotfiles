{ pkgs, ... }:

{
  imports = [
    (import ./gnupg.nix { inherit pkgs; })
    (import ./neovim.nix)
  ];
}
