{ config, pkgs, ... }:

let
  lamco-rdp-server = pkgs.callPackage ../../../../pkgs/lamco-rdp-server/package.nix {};
in
{
  systemd.user.services.lamco-rdp-server = {
    Unit = {
      Description = "Lamco RDP server";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart =
        "${lamco-rdp-server}/bin/lamco-rdp-server " +
        "--config /etc/lamco-rdp-server/config.toml";

      Restart = "on-failure";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
