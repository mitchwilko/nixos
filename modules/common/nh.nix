# modules/common/packages.nix

{ pkgs, ... }:

{
  programs.nh = {
    enable = true;
    flake = "/home/mitchw/nixos";
  };
}

