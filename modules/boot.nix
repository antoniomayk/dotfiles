{ ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      kernelModules = [
        "nvidia"
        "i915"
        "nvidia_modeset"
        "nvidia_drm"
      ];
    };
  };
}
