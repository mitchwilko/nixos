# hom/mitchw/common/default.nix

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
}
