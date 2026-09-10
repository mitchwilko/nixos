# hom/mitchw/common/default.nix

{ ... }:

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
