{ pkgs, theme, ... }:

{
  imports = [
    (import ./swayidle.nix { inherit pkgs; })
    (import ./mako.nix { inherit pkgs theme; })
  ];
}
