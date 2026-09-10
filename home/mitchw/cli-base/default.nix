# hom/mitchw/common/default.nix

{ pkgs, ... }:

{
  imports = [
    ./ssh.nix
    ./zsh
    ./bash
    ./tmux
    ./nvim
    ./fastfetch
    ./nh
  ];

  home.packages = with pkgs; [
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
