# home/mitchw/packages.nix

{ pkgs, ... }:

{
  imports = [
    ./alacritty
    ./i3
  ];

  home.packages = with pkgs; [
    firefox
    remmina
  ];
}
