# home/mitch/default.nix

{ ... }:

{
  imports = [
    ./ssh.nix
    ./zsh
    ./bash
    ./tmux
    ./nvim
    # ./yazi
    ./fastfetch
    ./vifm
  ];

  home.username = "mitchw";
  home.homeDirectory = "/home/mitchw";

  home.stateVersion = "26.05";
}
