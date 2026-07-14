# modules/common/ssh.nix

{ ... }:

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

  services.openssh.settings.Macs = [
    "hmac-sha2-512-etm@openssh.com"
    "hmac-sha2-256-etm@openssh.com"
    "umac-128-etm@openssh.com"
  
    # Compatibility for X2Go
    "hmac-sha2-256"
  ];

  # Authorized ssh keys
  users.users.mitchw.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGfB3UA0dR3neQQGyzwPT/JvQ2upFMJ0UXpQFSscgrK1 mitchw@Mitchells-MacBook-Air.local"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJxRaDdaE4K4Y4jNG6/MWXXz6C+wEHSXuyuLOxjLQ7MY"
  ];
}
