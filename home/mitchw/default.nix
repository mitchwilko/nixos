# home/mitch/default.nix

{ ... }:

{
  imports = [
    ./common
  ];

  home.username = "mitchw";
  home.homeDirectory = "/home/mitchw";

  home.stateVersion = "26.05";
}
