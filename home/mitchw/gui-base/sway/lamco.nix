
{ config, pkgs, ... }:

{
  systemd.services.lamco-rdp-server = {
    description = "Lamco Wayland RDP server";
  
    after = [
      "graphical.target"
    ];
  
    wantedBy = [
      "graphical.target"
    ];
  
    serviceConfig = {
      User = "mitch";
      Group = "users";
  
      ExecStart =
        "${lamco-rdp-server}/bin/lamco-rdp-server " +
        "--config /etc/lamco-rdp-server/config.toml";
  
      Restart = "on-failure";
      RestartSec = 5;
  
      Environment = [
        "XDG_RUNTIME_DIR=/run/user/1000"
      ];
    };
  };
}
