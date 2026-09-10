# home/mitch/default.nix

{ ... }:

{
  imports = [
    ./cli-base
  ];

  home.username = "mitchw";
  home.homeDirectory = "/home/mitchw";

  home.stateVersion = "26.05";
}
