{ config, pkgs, lib, ... }:

{
  containers.caddy = {
    autoStart = true;

    privateNetwork = true;

    hostAddress = "192.168.100.1";
    localAddress = "192.168.100.3";

    forwardPorts = [
      { containerPort = 80; hostPort = 80; protocol = "tcp"; }
      { containerPort = 443; hostPort = 443; protocol = "tcp"; }
      { containerPort = 443; hostPort = 443; protocol = "udp"; } # HTTP/3
      { containerPort = 8053; hostPort = 8053; protocol = "tcp"; }
    ];

    bindMounts."/run/secrets/caddy-cloudflare" = {
      hostPath = "/var/lib/caddy-secrets/cloudflare.env";
      isReadOnly = true;
    };

    allowedDevices = [
      {
        node = "/dev/net/tun";
        modifier = "rw";
      }
    ];

    config = {config, pkgs, lib, ... }: {
      services.caddy = {
        enable = true;

        # Caddy needs the Cloudflare DNS plugin for:
        #   acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
        package = pkgs.caddy.withPlugins {
          plugins = [
            "github.com/caddy-dns/cloudflare@v0.2.4"
          ];
          hash = "sha256-dQvk6ezY6TQ1J7PjhCXnThF/SqVgPwBO8/RXzHCY+js=";
        };

        configFile = pkgs.writeText "Caddyfile" ''
          {
            acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
          }

          technitium.samwilko.com {
            @dns path /dns-query*
            reverse_proxy @dns technitium.bream-betta.ts.net:5380

            reverse_proxy technitium.bream-betta.ts.net:5380
          }

          mpswiki.samwilko.com {
            reverse_proxy forge.bream-betta.ts.net:8888
          }

          mpswgit.samwilko.com {
            reverse_proxy forge.bream-betta.ts.net:3000
          }

          stirlingpdf.samwilko.com {
            reverse_proxy forge.bream-betta.ts.net:8083
          }

          zftpgo.samwilko.com {
            reverse_proxy forge.bream-betta.ts.net:8080 {
              transport http {
                tls_insecure_skip_verify
              }
            }
          }

          zftpgowd.samwilko.com {
            reverse_proxy forge.bream-betta.ts.net:5006 {
              transport http {
                tls_insecure_skip_verify
              }
            }
          }

          pyhttp.samwilko.com {
            reverse_proxy thedawn.bream-betta.ts.net:8082
          }

          jupyter.samwilko.com {
            reverse_proxy thedawn.bream-betta.ts.net:8084
          }
        '';
      };

      services.tailscale.enable = true;
      networking.nftables.enable = true;
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [
          80
          443
          8053
        ];
        allowedUDPPorts = [
          443
          config.services.tailscale.port
        ];
        trustedInterfaces = [ config.services.tailscale.interfaceName ];
      };

      systemd.services.tailscaled.serviceConfig.Environment = [ 
        "TS_DEBUG_FIREWALL_MODE=nftables" 
      ];

      networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
      networking.useHostResolvConf = lib.mkForce false;

      systemd.services.caddy = {
        serviceConfig.EnvironmentFile =
          "/run/secrets/caddy-cloudflare";

        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
      };

      system.stateVersion = "26.05";
    };
  };
}
