{ ... }:

{
  users.groups.libvirtd.members = [ "mayk" ];
  users.users.mayk = {
    isNormalUser = true;
    description = "Antonio Mayk";
    extraGroups = [
      "docker"
      "libvirtd"
      "networkmanager"
      "wheel"
    ];
  };
}
