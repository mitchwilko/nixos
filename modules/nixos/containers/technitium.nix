{ config, pkgs, ... }:

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
    services.tailscale.enable = true;

    services.technitium-dns-server = {
      enable = true;
      openFirewall = true;
    };

    system.stateVersion = "26.05";
  };
};
