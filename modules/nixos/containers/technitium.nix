{ config, pkgs, ... }:

{
  containers.technitium = {
    autoStart = true;
  
    privateNetwork = true;
  
    hostAddress = "192.168.100.1";
    localAddress = "192.168.100.2";
  
    allowedDevices = [
      {
        node = "/dev/net/tun";
        modifier = "rw";
      }
    ];
  
    config = { config, pkgs, ... }: {
      services.technitium-dns-server = {
        enable = true;
        openFirewall = true;
      };

      services.tailscale.enable = true;
      networking.nftables.enable = true;
      networking.firewall = {
        enable = true;
        trustedInterfaces = [ config.services.tailscale.interfaceName ];
      };
  
      system.stateVersion = "26.05";
    };
  };
}
