# home/mitch/default.nix

{ ... }:

{
  imports = [
    ./packages.nix
    ./ssh.nix
    ./bash
    ./tmux
    ./nvim
    ./yazi
    ./alacritty
  ];

  home.username = "mitchw";
  home.homeDirectory = "/home/mitchw";

  home.stateVersion = "26.05";
}
