{ config, pkgs, lib, ... }:

{
  containers.guac = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.1";
    localAddress = "192.168.100.5";

    bindMounts = {
      "/var/lib/postgresql" = {
        hostPath = "/var/lib/guacamole-postgresql";
        isReadOnly = false;
      };

      "/var/secrets/tailscale-guac.key" = {
        hostPath = "/var/secrets/tailscale-guac.key";
        isReadOnly = true;
      };
    };

    allowedDevices = [
      {
        node = "/dev/net/tun";
        modifier = "rw";
      }
    ];

    config = { config, pkgs, lib, ... }:
      let
        jdbcRelease = pkgs.fetchurl {
          url = "https://archive.apache.org/dist/guacamole/1.6.0/binary/guacamole-auth-jdbc-1.6.0.tar.gz";
          hash = "sha256-l7xf09Z9JcDpikddHf0wigN4WfVJ+sRxcccjt6cDk2Y=";
        };

        jdbcUnpacked = pkgs.runCommand "guacamole-jdbc-unpacked" { } ''
          mkdir -p $out unpack
          tar xzf ${jdbcRelease} -C unpack
          cp -r unpack/*/postgresql $out/postgresql
        '';

        pgJdbc = pkgs.runCommand "pg-jdbc-jar" { } ''
          mkdir -p $out
          cp ${pkgs.postgresql_jdbc}/share/java/postgresql*.jar $out/postgresql.jar
        '';

        schemaDir = "${jdbcUnpacked}/postgresql/schema";
      in
      {
        # ---------------- Tailscale ----------------
        services.tailscale = {
          enable = true;
          # authKeyFile = "/var/secrets/tailscale-guac.key";
        };

        networking.nftables.enable = true;
        networking.firewall = {
          enable = true;
          trustedInterfaces = [ config.services.tailscale.interfaceName ];
          allowedTCPPorts = [
            8080
          ];
        };

        networking.useHostResolvConf = lib.mkForce false;
        networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];

        services.resolved.enable = true;
        services.resolved.settings.Resolve.fallbackDns = [ "1.1.1.1" "9.9.9.9" ];

        # ---------------- Postgres ----------------
        services.postgresql = {
          enable = true;
          ensureDatabases = [ "guacamole" ];
          ensureUsers = [{ name = "guacamole"; ensureDBOwnership = true; }];
          # Loopback-only, inside a private container.
          authentication = lib.mkForce ''
            local all all peer
            host  all all 127.0.0.1/32 trust
            host  all all ::1/128      trust
          '';
        };

        # ---------------- Guacamole ----------------
        services.guacamole-server = {
          enable = true;
          host = "127.0.0.1";
          port = 4822;
          package = pkgs.guacamole-server.override {
            freerdp = pkgs.freerdp.overrideAttrs (old: rec {
              version = "3.16.0"; # roughly contemporary with the guacd snapshot
              src = pkgs.fetchFromGitHub {
                owner = "FreeRDP";
                repo = "FreeRDP";
                tag = version;
                hash = "sha256-HF4Is3ak2nYD2Fq6HGHwyM5OTBVqYqbB22otOprzfiQ=";
              };
            });
          };
        };

        services.guacamole-client = {
          enable = true;
          enableWebserver = true;
          settings = {
            guacd-hostname = "127.0.0.1";
            guacd-port = 4822;
            postgresql-hostname = "127.0.0.1";
            postgresql-port = 5432;
            postgresql-database = "guacamole";
            postgresql-username = "guacamole";
            # Guacamole requires this property to be set, but trust auth ignores it.
            postgresql-password = "unused";
          };
        };

        # One-shot: load the schema on first boot.
        systemd.services.guacamole-db-init = {
          wantedBy = [ "multi-user.target" "tomcat.service" ];
          after = [ "postgresql.service" ];
          requires = [ "postgresql.service" ];
          before = [ "tomcat.service" ];
          path = [ config.services.postgresql.package ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            User = "postgres";
          };
          script = ''
            set -euo pipefail
            if ! psql -d guacamole -tAc \
                "SELECT 1 FROM information_schema.tables WHERE table_name='guacamole_user'" \
                | grep -q 1; then
              { echo "SET ROLE guacamole;"; cat ${schemaDir}/*.sql; } \
                | psql -d guacamole -v ON_ERROR_STOP=1
            fi
          '';
        };

        fonts.packages = [ pkgs.nerd-fonts.fira-code ];

        # Load the PostgreSQL auth extension and its JDBC driver.
        environment.etc."guacamole/extensions/guacamole-auth-jdbc-postgresql.jar".source =
          "${jdbcUnpacked}/postgresql/guacamole-auth-jdbc-postgresql-1.6.0.jar";
        
        environment.etc."guacamole/lib/postgresql.jar".source = "${pgJdbc}/postgresql.jar";

        system.stateVersion = "26.05"; # match your host
      };
  };
}
