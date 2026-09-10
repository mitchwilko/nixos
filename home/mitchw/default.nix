# home/mitch/default.nix

{ pkgs, ... }:

let
  homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/mitchw"
    else "/home/mitchw";
in
{
  imports = [
    ./cli-base
  ];

  home.username = "mitchw";
  home.homeDirectory = homeDirectory;

  home.stateVersion = "26.05";
}
