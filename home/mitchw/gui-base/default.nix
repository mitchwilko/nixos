# home/mitchw/packages.nix

{ pkgs, ... }:

{
  imports = [
    ./alacritty
    ./i3
    ./sway
  ];

  home.packages = with pkgs; [
    firefox
    remmina
  ];
}
