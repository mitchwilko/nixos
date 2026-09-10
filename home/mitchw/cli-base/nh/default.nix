# modules/common/packages.nix

{ config, ... }:

{
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/nixos";
  };
}
