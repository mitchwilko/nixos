# Vifm config manager

{ pkgs, ... }:

{
  programs.vifm = {
    enable = true;
  };

  xdg.configFile."vifm/vifmrc".source = ./vifmrc;

  # xdg.configFile."vifm/colors/myscheme.vifm".source = ./vifm-colors/myscheme.vifm;
}
