# home/mitchw/packages.nix

{ pkgs, ... }:

{
  imports = [
    # ./yazi
    ./vifm
  ];

  home.packages = with pkgs; [
    bzip2
  ];
}
