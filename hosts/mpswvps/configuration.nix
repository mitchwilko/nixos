{ pkgs, ... }: {
  system.stateVersion = "26.05";

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGfB3UA0dR3neQQGyzwPT/JvQ2upFMJ0UXpQFSscgrK1 mitchw@Mitchells-MacBook-Air.local"
  ];
}
