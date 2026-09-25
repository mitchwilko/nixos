{ config, pkgs, ... }:

{
  containers.caddy = {
    autoStart = true;

    privateNetwork = true;

    hostAddress = "192.168.100.1";
    localAddress = "192.168.100.3";

    config = { config, pkgs, ... }: {
      services.caddy = {
        enable = true;

        virtualHosts = {
          "example.samwilko.com" = {
            extraConfig = ''
              reverse_proxy 192.168.100.4:8000
            '';
          };
        };
      };

      services.tailscale = {
        enable = true;
      };

      networking.firewall = {
        allowedTCPPorts = [
          80
          443
        ];
      };

      system.stateVersion = "26.05";
    };
  };
}
