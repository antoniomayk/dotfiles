{ lib, ... }:

let
  theme = import ./theme.nix;
  palette = theme.palette;
in
{
  home-manager.users.mayk =
    { pkgs, ... }:
    {
      imports = [
        (import ./dconf.nix { inherit pkgs theme; })
        (import ./gtk.nix { inherit lib pkgs theme; })
        (import ./packages.nix { inherit pkgs; })
        (import ./programs {
          inherit
            pkgs
            theme
            palette
            ;
        })
        (import ./services { inherit pkgs theme; })
        (import ./sway.nix { inherit pkgs theme; })
        (import ./systemd.nix { inherit pkgs; })
        (import ./xdg.nix)
      ];

      home.stateVersion = "25.05";
    };
}
