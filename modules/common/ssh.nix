# modules/common/ssh.nix

{ ... }:

{
  
  # Enable the ssh server
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      MaxAuthTries = 3;
      PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
    };
  };

  # Authorized ssh keys
  users.users.mitchw.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGfB3UA0dR3neQQGyzwPT/JvQ2upFMJ0UXpQFSscgrK1 mitchw@Mitchells-MacBook-Air.local"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJxRaDdaE4K4Y4jNG6/MWXXz6C+wEHSXuyuLOxjLQ7MY"
  ];
}
