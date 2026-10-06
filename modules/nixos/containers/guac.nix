{ config, pkgs, ... }:

{
  containers.guac = {
    autoStart = true;

    privateNetwork = true;

    hostAddress = "192.168.100.1";
    localAddress = "192.168.100.5";

    config = { config, pkgs, ... }: {
      services.guacamole-server = {
        enable = true;

        host = "192.168.100.5";
        port = 4822;

        userMappingXml = pkgs.writeText "user-mapping.xml" ''
          <user-mapping>

            <authorize username="mitchw"
                       password="temp-pw">

              <connection name="Home Workstation">
                <protocol>rdp</protocol>

                <param name="hostname">thedawn.bream-betta.ts.net</param>
                <param name="port">3389</param>

                <param name="username">mitchw</param>
                <param name="ignore-cert">true</param>

                <param name="enable-drive">true</param>
                <param name="drive-path">/tmp/guacamole-drive</param>

                <param name="create-drive-path">true</param>

              </connection>

            </authorize>

          </user-mapping.xml>
        '';
      };

      services.guacamole-client = {
        enable = true;

        enableWebserver = true;

        settings = {
          guacd-hostname = "192.168.100.5";
          guacd-port = 4822;
        };
      };

      services.tailscale.enable = true;
      networking.nftables.enable = true;
      networking.firewall = {
        enable = true;
        trustedInterfaces = [ config.services.tailscale.interfaceName ];
        allowedTCPPorts = [
          8080
        ];
      };

      # Guacamole needs to reach the RDP machine.
      networking.firewall.extraCommands = ''
        iptables -A OUTPUT -p tcp -d thedawn.bream-betta.ts.net --dport 3389 -j ACCEPT
      '';

      environment.systemPackages = with pkgs; [
        curl
        iproute2
        inetutils
      ];

      system.stateVersion = "26.05";
    };
  };
}
