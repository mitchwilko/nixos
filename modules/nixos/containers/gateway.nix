{ config, pkgs, lib, ... }:

{
  containers.gateway = {
    autoStart = true;

    privateNetwork = true;

    hostAddress = "192.168.100.1";
    localAddress = "192.168.100.4";

    # No forwardPorts required.
    #
    # Cloudflared establishes an outbound connection to Cloudflare,
    # then forwards requests to Caddy on localhost:80.

    bindMounts."/run/secrets/cloudflare-tunnel-token" = {
      hostPath = "/var/lib/cloudflare-secrets/external-tunnel-token";
      isReadOnly = true;
    };

    allowedDevices = [
      {
        node = "/dev/net/tun";
        modifier = "rw";
      }
    ];

    config = { config, pkgs, lib, ... }: {

      # ------------------------------------------------------------
      # Tailscale
      #
      # Caddy uses the tailnet to reach the actual services.
      # ------------------------------------------------------------

      services.tailscale.enable = true;

      systemd.services.tailscaled.serviceConfig.Environment = [
        "TS_DEBUG_FIREWALL_MODE=nftables"
      ];

      # ------------------------------------------------------------
      # External Caddy
      #
      # Cloudflare terminates HTTPS. Caddy only needs HTTP on
      # localhost:80.
      # ------------------------------------------------------------

      services.caddy = {
        enable = true;

        configFile = pkgs.writeText "external-Caddyfile" ''
          {
            auto_https off
          }

          http://mpswiki2.samwilko.com {
            reverse_proxy forge.bream-betta.ts.net:8888
          }

          http://thedawn.samwilko.com {
            reverse_proxy guac.bream-betta.ts.net:8080
          }

          http://mpswgit.samwilko.com {
            reverse_proxy forge.bream-betta.ts.net:3000
          }

          http://stirlingpdf.samwilko.com {
            reverse_proxy forge.bream-betta.ts.net:8083
          }

          :80 {
            respond "Not Found" 404
          }
        '';
      };

      # ------------------------------------------------------------
      # Cloudflare Tunnel
      #
      # The token is stored outside the Nix store:
      #
      # /var/lib/cloudflare-secrets/external-tunnel-token
      #
      # The file should contain ONLY the tunnel token.
      # ------------------------------------------------------------

      environment.systemPackages = [
        pkgs.cloudflared
      ];

      systemd.services.cloudflared = {
        description = "Cloudflare Tunnel";

        wantedBy = [ "multi-user.target" ];

        after = [
          "network-online.target"
          "caddy.service"
        ];

        wants = [
          "network-online.target"
        ];

        requires = [
          "caddy.service"
        ];

        serviceConfig = {
          Type = "simple";

          ExecStart = pkgs.writeShellScript "run-cloudflared" ''
            exec ${pkgs.cloudflared}/bin/cloudflared \
              tunnel run \
              --token "$(cat /run/secrets/cloudflare-tunnel-token)"
          '';

          Restart = "always";
          RestartSec = "5s";
        };
      };

      # ------------------------------------------------------------
      # Networking
      # ------------------------------------------------------------

      networking.nftables.enable = true;

      networking.firewall = {
        enable = true;

        # Caddy receives traffic locally from cloudflared.
        #
        # No public host port is forwarded.
        allowedTCPPorts = [
          80
        ];

        # Tailscale.
        allowedUDPPorts = [
          config.services.tailscale.port
        ];

        trustedInterfaces = [
          config.services.tailscale.interfaceName
        ];
      };

      networking.nameservers = [
        "1.1.1.1"
        "9.9.9.9"
      ];

      networking.useHostResolvConf = lib.mkForce false;

      system.stateVersion = "26.05";
    };
  };
}
