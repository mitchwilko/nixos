# modules/zsh

{ config, pkgs, ... }:

{
  programs.zsh.enable = true;

  home.file.".zshrc".source = ./zshrc;
}
