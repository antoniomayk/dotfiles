{ ... }:

{
  networking = {
    hostName = "nixosh";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ ];
    firewall.allowedUDPPorts = [ ];
    firewall.enable = true;
  };
}
