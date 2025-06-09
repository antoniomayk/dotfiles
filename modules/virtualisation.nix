{ ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };
  virtualisation.podman = {
    enable = true;
  };
  virtualisation.libvirtd = {
    enable = true;
  };
  virtualisation.spiceUSBRedirection.enable = true;
}
