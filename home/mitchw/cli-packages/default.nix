# home/mitchw/packages.nix

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bzip2
  ];
}
