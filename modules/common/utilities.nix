# modules/common/packages.nix

{ pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    htop
    btop
    ncdu
    ripgrep
    fd
    fzf
  ];
}
