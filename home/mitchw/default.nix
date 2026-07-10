# home/mitch/default.nix

{ ... }:

{
  imports = [
    ./packages.nix
    ./bash
    ./tmux
    ./nvim
    ./yazi
  ];

  home.username = "mitchw";
  home.homeDirectory = "/home/mitchw";

  home.stateVersion = "26.05";
}
