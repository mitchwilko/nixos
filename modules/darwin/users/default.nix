# modules/users.nix

{ pkgs, ... }:

{
  # Needed if any of the users will be using zsh
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  system.primaryUser = "mitchw";
  users.users.mitchw = {
    home = "/Users/mitchw";
  };
}
