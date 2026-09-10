# home/mitchw/packages.nix

{ pkgs, ... }:

{
  imports = [
    ./zarthura
  ];

  home.packages = with pkgs; [
    zotero
    libreoffice
  ];
}
