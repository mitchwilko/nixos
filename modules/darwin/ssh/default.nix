# darwin/ssh module

{ pkgs, ... }:

{
  # Enable the ssh server
  services.openssh = {
    enable = true;
    openFirewall = true;
    ports = [ 20273 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      MaxAuthTries = 3;
      PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
    };
  };

  users.users.mitchw.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP8i6nY1QpPjKrO3MPRD+v2F+Hwk780MifnSydfuG1JC mitchell01wilkinson@gmail.com"
  ];
}
