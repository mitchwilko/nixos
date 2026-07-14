# home/mitch/default.nix

{ ... }:

{
  imports = [
    ./packages.nix
    ./ssh.nix
    ./zsh
    ./bash
    ./tmux
    ./nvim
    ./yazi
    ./alacritty
    ./fastfetch
  ];

  home.username = "mitchw";
  home.homeDirectory = "/home/mitchw";

  home.stateVersion = "26.05";
}
