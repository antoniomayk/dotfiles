{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/enviroment.nix
    ./modules/hardware.nix
    ./modules/home-manager
    ./modules/i18n.nix
    ./modules/networking.nix
    ./modules/programs
    ./modules/security.nix
    ./modules/services
    ./modules/time.nix
    ./modules/users.nix
    ./modules/virtualisation.nix
    ./modules/xdg.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.cudaSupport = true;

  system.stateVersion = "25.05";
}
